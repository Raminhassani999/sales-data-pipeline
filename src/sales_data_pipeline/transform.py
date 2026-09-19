import pandas as pd

from sales_data_pipeline.extract import extract_sales_data


def transform_sales_data(df: pd.DataFrame) -> pd.DataFrame:
    df["order_date"] = pd.to_datetime(df["order_date"])

    df["total_amount"] = df["quantity"] * df["price"]

    return df


if __name__ == "__main__":
    df = extract_sales_data("data/raw/sales.csv")

    df = transform_sales_data(df)

    print(df)