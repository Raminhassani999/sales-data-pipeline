import pandas as pd


def extract_sales_data(input_file: str) -> pd.DataFrame:
    return pd.read_csv(input_file)


if __name__ == "__main__":
    df = extract_sales_data("data/raw/sales.csv")

    df.to_csv("extracted_sales.csv", index=False)

    print("Sales data extracted successfully!")