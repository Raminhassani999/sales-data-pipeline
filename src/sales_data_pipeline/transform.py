import pandas as pd


def transform_sales_data(df: pd.DataFrame) -> pd.DataFrame:
    df["order_date"] = pd.to_datetime(df["order_date"])

    df["total_amount"] = df["quantity"] * df["price"]

    return df


if __name__ == "__main__":
    df = pd.read_csv("extracted_sales.csv")

    df = transform_sales_data(df)

    df.to_csv("transformed_sales.csv", index=False)

    print("Sales data transformed successfully!")