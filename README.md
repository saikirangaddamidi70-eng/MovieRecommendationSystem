# 🎬 Movie Recommendation System

An end-to-end Movie Recommendation System built using Python, SQL, Machine Learning, and Streamlit. The system recommends movies based on movie characteristics and user preferences using a Content-Based Recommendation approach, with the project designed to be extended into a hybrid recommendation system.

The final application provides a simple and interactive web interface where users can select a movie and receive visually presented movie recommendations.

---

## 📌 Project Overview

With thousands of movies available across different platforms, finding a movie that matches a user's interests can be difficult.

This project aims to solve that problem by developing a recommendation system that analyzes movie information such as:

- Genres
- Keywords
- Director
- Cast
- Language
- Release year
- Runtime
- Popularity
- Ratings
- Vote count
- Revenue

The system identifies movies with similar characteristics and recommends the most relevant movies to the user.

---

## 🎯 Project Objectives

- Build an end-to-end movie recommendation system.
- Perform data cleaning and data quality validation.
- Analyze movie and user-rating data.
- Perform exploratory data analysis (EDA).
- Engineer useful features for recommendation.
- Build a Content-Based Recommendation System.
- Use text-based movie features to calculate similarity.
- Rank similar movies.
- Evaluate recommendation quality.
- Build an interactive Streamlit web application.
- Display movie recommendations with posters and details.
- Deploy the application for public access.
- Document the complete project on GitHub.

---

## 🛠️ Technology Stack

Programming

- Python

Data Analysis

- Pandas
- NumPy

Data Visualization

- Matplotlib
- Seaborn

Machine Learning

- Scikit-learn

Database

- MySQL
- SQL

Web Application

- Streamlit

Model Serialization

- Joblib / Pickle

Dashboard

- Power BI
- DAX

Version Control

- Git
- GitHub

---

## 🔄 Project Workflow

Raw CSV Files
      ↓
Data Loading
      ↓
Data Validation
      ↓
Data Quality Analysis
      ↓
SQL / Data Engineering
      ↓
Data Integration
      ↓
Data Cleaning
      ↓
Exploratory Data Analysis
      ↓
Feature Engineering
      ↓
Content-Based Recommendation
      ↓
Similarity Calculation
      ↓
Recommendation Ranking
      ↓
Model Evaluation
      ↓
Streamlit Web Application
      ↓
Movie Posters & Details
      ↓
Deployment
      ↓
GitHub Portfolio

---

## 📊 Exploratory Data Analysis

The project performs analysis on different aspects of the movie dataset.

Movie Analysis

- Movies released by year
- Genre distribution
- Language distribution
- Runtime distribution
- Most common directors
- Production companies
- Popular keywords

Rating Analysis

- Rating distribution
- Average movie rating
- Most-rated movies
- Rating count per movie
- User rating behavior

Financial Analysis

- Budget distribution
- Revenue distribution
- Budget vs Revenue
- Highest-revenue movies
- Return on Investment

Popularity Analysis

- Popularity distribution
- Popularity vs ratings
- Popularity vs vote count
- Popularity vs revenue

---

## 🤖 Recommendation System

Content-Based Recommendation

The main recommendation engine uses a Content-Based approach.

The system creates a movie profile using features such as:

Genres
+
Keywords
+
Director
+
Cast
+
Language
+
Other movie attributes

These features are transformed into numerical representations and compared using similarity measures.

Recommendation Process

User selects a movie
        ↓
Find selected movie
        ↓
Create movie feature representation
        ↓
Calculate similarity with other movies
        ↓
Rank movies by similarity
        ↓
Select Top-N movies
        ↓
Display recommendations

---

## 📐 Similarity

The project can use TF-IDF to represent textual movie features.

Movie Metadata
      ↓
Text Processing
      ↓
TF-IDF Vectorization
      ↓
Movie Vectors
      ↓
Cosine Similarity
      ↓
Similar Movies

Cosine similarity measures how similar two movie feature vectors are.

---

## 🎬 Web Application

The project includes an interactive Streamlit web application.

The application allows users to:

1. Select a movie.
2. Click the recommendation button.
3. Receive recommended movies.
4. View movie posters.
5. View movie titles and relevant information.

Application Flow

          🎬 Movie Recommender

                Select Movie
                     ↓
              [ Recommend ]
                     ↓
           Recommendation Model
                     ↓
          ┌──────┬──────┬──────┐
          ↓      ↓      ↓      ↓
        Movie  Movie  Movie  Movie

---

## 🖥️ Application Features

- Interactive movie selection
- Movie recommendation
- Top-N similar movies
- Movie posters
- Movie titles
- Movie information
- Simple and user-friendly interface
- Streamlit-based web application

---

📁 Project Structure

Movie-Recommendation-System/
│
├── data/
│   ├── movies.csv
│   ├── ratings.csv
│   └── movie_revenue.csv
│
├── notebook/
│   ├── Movie_Recommendation.ipynb
│
├── models/
│   ├── tfidf_vectorizer.pkl
│   ├── similarity.pkl
│   └── movie_data.pkl
│
├── sql/
│   └── movie_analysis.sql
│
├── powerbi/
│   └── movie_dashboard.pbix
│
├── app.py
├── .gitignore
└── README.md

«The exact model files may change depending on the final implementation.»

---

## 📈 Model Evaluation

The recommendation system can be evaluated using recommendation-system metrics such as:

- Precision@K
- Recall@K
- Hit Rate
- NDCG@K

The evaluation helps determine how effectively the system recommends relevant movies.

---

## 📊 Power BI Dashboard

A Power BI dashboard is included as part of the overall project.

Dashboard sections

<img width="1365" height="767" alt="Screenshot 2026-09-25 121530" src="https://github.com/user-attachments/assets/980386f5-e3b0-4d47-8918-72d2f7a9f213" />
<img width="1357" height="765" alt="Screenshot 2026-09-25 121511" src="https://github.com/user-attachments/assets/f552d67f-d9e7-4b34-816b-04e64d1aca8c" />


Movie Overview

- Total movies
- Total users
- Total ratings
- Average rating
- Total revenue
- Popular genres

Movie Analytics

- Movies by year
- Genre analysis
- Rating analysis
- Revenue analysis
- Popularity analysis

---

## 🚀 Installation

Clone the repository:

git clone https://github.com/YOUR_USERNAME/Movie-Recommendation-System.git

Move into the project directory:

cd Movie-Recommendation-System

Create a virtual environment:

python -m venv venv

Activate the virtual environment.

Windows

venv\Scripts\activate

macOS / Linux

source venv/bin/activate

Install dependencies:

pip install -r requirements.txt

---

## ▶️ Run the Application

Run the Streamlit application:

streamlit run app.py

The application will open in your browser.

---

## 🌐 Deployment

The Streamlit application can be deployed using a cloud hosting platform that supports Streamlit applications.

Deployment workflow:

GitHub Repository
       ↓
Application Code
       ↓
requirements.txt
       ↓
Saved Model Files
       ↓
Cloud Deployment
       ↓
Live Web Application

<img width="1797" height="991" alt="Screenshot 2026-09-25 190811" src="https://github.com/user-attachments/assets/36f1e968-0e54-47ad-a3fc-861c2dccbc02" />
<img width="1587" height="981" alt="Screenshot 2026-09-25 190831" src="https://github.com/user-attachments/assets/1de1f091-eadc-4791-a156-9019bbeed60c" />


---


## 👨‍💻 Author

# GADDAMIDI SAI KIRAN

### Data Science / Machine Learning Enthusiast

Skills Demonstrated

"Python" "SQL" "Pandas" "NumPy" "Scikit-learn" "Machine Learning" "Recommendation Systems" "Power BI" "Streamlit" "Git" "GitHub"

