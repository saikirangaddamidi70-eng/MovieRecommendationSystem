import streamlit as st
import pandas as pd
import requests


# =========================================================
# PAGE CONFIGURATION
# =========================================================

st.set_page_config(
    page_title="Movie Recommender",
    page_icon="🎬",
    layout="wide"
)


# =========================================================
# CUSTOM CSS
# =========================================================

st.markdown("""
<style>

    .main {
        background-color: #0e1117;
    }

    .movie-title {
        font-size: 18px;
        font-weight: 700;
        margin-top: 8px;
    }

    .movie-info {
        color: #b0b0b0;
        font-size: 14px;
    }

    .rating {
        color: #FFD700;
        font-weight: bold;
    }

    .header-title {
        text-align: center;
        font-size: 45px;
        font-weight: 800;
        margin-bottom: 5px;
    }

    .header-subtitle {
        text-align: center;
        color: #aaaaaa;
        font-size: 18px;
        margin-bottom: 30px;
    }

    .section-title {
        font-size: 28px;
        font-weight: 700;
        margin-top: 30px;
        margin-bottom: 20px;
    }

</style>
""", unsafe_allow_html=True)


# =========================================================
# LOAD DATA
# =========================================================

@st.cache_data
def load_data():

    movies = pd.read_csv("data/movie_master.csv")

    return movies


movies = load_data()


# =========================================================
# HEADER
# =========================================================

st.markdown(
    '<div class="header-title">🎬 Movie Recommender</div>',
    unsafe_allow_html=True
)

st.markdown(
    '<div class="header-subtitle">'
    'Discover your next favorite movie'
    '</div>',
    unsafe_allow_html=True
)


# =========================================================
# MOVIE SELECTION
# =========================================================

st.markdown(
    '<div class="section-title">🔎 Select a Movie</div>',
    unsafe_allow_html=True
)

movie_titles = sorted(
    movies["Title"].dropna().unique().tolist()
)

selected_movie = st.selectbox(
    "Choose a movie",
    movie_titles
)


# =========================================================
# FILTERS
# =========================================================

col1, col2, col3 = st.columns(3)


with col1:

    genres = ["All"]

    if "Genres" in movies.columns:

        genre_values = (
            movies["Genres"]
            .dropna()
            .astype(str)
            .tolist()
        )

        unique_genres = set()

        for genre_string in genre_values:

            for genre in genre_string.split(","):

                unique_genres.add(genre.strip())

        genres += sorted(unique_genres)

    selected_genre = st.selectbox(
        "🎭 Genre",
        genres
    )


with col2:

    languages = ["All"]

    if "Language" in movies.columns:

        languages += sorted(
            movies["Language"]
            .dropna()
            .astype(str)
            .unique()
            .tolist()
        )

    selected_language = st.selectbox(
        "🌍 Language",
        languages
    )


with col3:

    number_of_movies = st.slider(
        "🎯 Number of Recommendations",
        min_value=5,
        max_value=20,
        value=10
    )


# =========================================================
# RECOMMEND BUTTON
# =========================================================

recommend_button = st.button(
    "🎯 Recommend Movies",
    use_container_width=True
)


# =========================================================
# RECOMMENDATION FUNCTION
# =========================================================

def recommend_movies(movie_title, number_of_movies=10):

    """
    Temporary recommendation function.

    Later this function will be replaced with
    your trained hybrid recommendation model.
    """

    selected_row = movies[
        movies["Title"] == movie_title
    ]

    if selected_row.empty:
        return pd.DataFrame()

    selected_movie_id = selected_row.iloc[0]["Movie_ID"]

    recommendations = movies[
        movies["Movie_ID"] != selected_movie_id
    ].copy()

    # -----------------------------------------------------
    # Example ranking using available movie information
    # -----------------------------------------------------

    if "Popularity" in recommendations.columns:

        recommendations = recommendations.sort_values(
            by="Popularity",
            ascending=False
        )

    return recommendations.head(number_of_movies)


# =========================================================
# DISPLAY RECOMMENDATIONS
# =========================================================

if recommend_button:

    recommendations = recommend_movies(
        selected_movie,
        number_of_movies
    )

    # -----------------------------------------------------
    # APPLY GENRE FILTER
    # -----------------------------------------------------

    if selected_genre != "All" and not recommendations.empty:

        recommendations = recommendations[
            recommendations["Genres"]
            .fillna("")
            .str.contains(
                selected_genre,
                case=False,
                na=False
            )
        ]


    # -----------------------------------------------------
    # APPLY LANGUAGE FILTER
    # -----------------------------------------------------

    if selected_language != "All" and not recommendations.empty:

        recommendations = recommendations[
            recommendations["Language"]
            .fillna("")
            .str.lower()
            ==
            selected_language.lower()
        ]


    # =====================================================
    # RESULTS
    # =====================================================

    st.markdown(
        '<div class="section-title">🍿 Recommended Movies</div>',
        unsafe_allow_html=True
    )


    if recommendations.empty:

        st.warning(
            "No movies found with the selected filters."
        )

    else:

        # Create rows of 5 movies

        movie_list = recommendations.to_dict("records")

        for i in range(0, len(movie_list), 5):

            row_movies = movie_list[i:i + 5]

            columns = st.columns(5)

            for column, movie in zip(columns, row_movies):

                with column:

                    # -------------------------------------
                    # POSTER
                    # -------------------------------------

                    if "Poster_URL" in movie:

                        poster_url = movie["Poster_URL"]

                        if pd.notna(poster_url):

                            st.image(
                                poster_url,
                                use_container_width=True
                            )

                    else:

                        st.image(
                            "https://via.placeholder.com/300x450"
                        )


                    # -------------------------------------
                    # TITLE
                    # -------------------------------------

                    st.markdown(
                        f"""
                        <div class="movie-title">
                            {movie.get("Title", "Unknown")}
                        </div>
                        """,
                        unsafe_allow_html=True
                    )


                    # -------------------------------------
                    # YEAR
                    # -------------------------------------

                    if "Release_Year" in movie:

                        st.markdown(
                            f"""
                            <div class="movie-info">
                                📅 {movie["Release_Year"]}
                            </div>
                            """,
                            unsafe_allow_html=True
                        )


                    # -------------------------------------
                    # RATING
                    # -------------------------------------

                    if "Average_Rating" in movie:

                        rating = movie["Average_Rating"]

                        if pd.notna(rating):

                            st.markdown(
                                f"""
                                <div class="rating">
                                    ⭐ {rating:.1f}
                                </div>
                                """,
                                unsafe_allow_html=True
                            )


                    # -------------------------------------
                    # GENRE
                    # -------------------------------------

                    if "Genres" in movie:

                        st.markdown(
                            f"""
                            <div class="movie-info">
                                🎭 {movie["Genres"]}
                            </div>
                            """,
                            unsafe_allow_html=True
                        )


# =========================================================
# SELECTED MOVIE DETAILS
# =========================================================

st.markdown(
    '<div class="section-title">🎥 Selected Movie Details</div>',
    unsafe_allow_html=True
)

selected_data = movies[
    movies["Title"] == selected_movie
]

if not selected_data.empty:

    movie = selected_data.iloc[0]

    detail_col1, detail_col2 = st.columns([1, 2])


    with detail_col1:

        if "Poster_URL" in movie.index:

            poster = movie["Poster_URL"]

            if pd.notna(poster):

                st.image(
                    poster,
                    use_container_width=True
                )


    with detail_col2:

        st.subheader(movie["Title"])

        if "Genres" in movie.index:
            st.write(
                f"🎭 **Genres:** {movie['Genres']}"
            )

        if "Release_Year" in movie.index:
            st.write(
                f"📅 **Release Year:** {movie['Release_Year']}"
            )

        if "Director" in movie.index:
            st.write(
                f"🎬 **Director:** {movie['Director']}"
            )

        if "Cast" in movie.index:
            st.write(
                f"👥 **Cast:** {movie['Cast']}"
            )

        if "Language" in movie.index:
            st.write(
                f"🌍 **Language:** {movie['Language']}"
            )

        if "Runtime" in movie.index:
            st.write(
                f"⏱️ **Runtime:** {movie['Runtime']} minutes"
            )

        if "Average_Rating" in movie.index:

            rating = movie["Average_Rating"]

            if pd.notna(rating):

                st.write(
                    f"⭐ **Average Rating:** {rating:.2f}"
                )

        if "Popularity" in movie.index:

            popularity = movie["Popularity"]

            if pd.notna(popularity):

                st.write(
                    f"🔥 **Popularity:** {popularity:.2f}"
                )

