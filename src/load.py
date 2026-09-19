import pandas as pd
from sqlalchemy import create_engine

from extract import extract_sales_data
from transform import transform_sales_data


DATABASE_URL = (
    "postgresql+psycopg2://"
    "sales_user:sales_password@localhost:5433/sales_db"
)


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
    df = extract_sales_data("data/raw/sales.csv")

    df = transform_sales_data(df)

    load_sales_data(df)