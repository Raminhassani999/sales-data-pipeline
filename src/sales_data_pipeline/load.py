import os

import pandas as pd
from sqlalchemy import create_engine


DATABASE_URL = os.getenv("DATABASE_URL")

if not DATABASE_URL:
    raise ValueError("DATABASE_URL environment variable is not set")


def load_sales_data(df: pd.DataFrame):
    engine = create_engine(DATABASE_URL)

    df.to_sql(
        "sales",
        engine,
        if_exists="replace",
        index=False
    )

    print("Sales data loaded successfully!")


if __name__ == "__main__":
    df = pd.read_csv("transformed_sales.csv")

    load_sales_data(df)