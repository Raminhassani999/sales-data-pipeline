import pandas as pd


def transform_sales_data(input_file: str) -> pd.DataFrame:
    df = pd.read_csv(input_file)

    df["order_date"] = pd.to_datetime(df["order_date"])

    df["total_amount"] = df["quantity"] * df["price"]

    return df


if __name__ == "__main__":
    input_file = "data/raw/sales.csv"

    df = transform_sales_data(input_file)

    print(df)