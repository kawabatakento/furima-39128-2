const calculateFeesAndProfit = () => {
  const itemPriceInput = document.getElementById("item-price");
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  itemPriceInput.addEventListener("input", () => {
    const priceValue = itemPriceInput.value;
    if (300 <= priceValue && priceValue <= 9999999) {
      const fee = Math.floor(priceValue * 0.1);
      const profitValue = Math.floor(priceValue - fee);
      addTaxPrice.textContent = fee.toLocaleString();
      profit.textContent = profitValue.toLocaleString();
    } else {
      addTaxPrice.textContent = "";
      profit.textContent = "";
    }
  });
};

window.addEventListener("load", calculateFeesAndProfit);
