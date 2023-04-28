# salesforceBucket-api
Mulesoft api with anypoint studio


                                                    Salesforce Bucket

You must export a financial report to a filesystem for a reporting software that will produce dashboards for the marketing department.
Reporting software expects a CSV.

The exercise is cut into steps A to F.

A. Retrieve a label from a sourceDimensionValue
  For each row of the CSV, you must lookup the label corresponding to the subType.
  A Salesforce bucket content matches label with subType where subType is one ofsourceDimensionValues.

Input
Var subType is InHouseServiceFee.

Var bucket is :

        [
          {
          "label":"Accrual",
          "rangeUpperBound":null,
          "sourceDimensionValues":[
            "EarningFromAProject",
            "ExpiringCredits",
            "Rollback"
            ]
          },
          {
          "label":"Sales",

          "rangeUpperBound":null,
          "sourceDimensionValues":[
            "BundleRefund",
            "BuyingACreditBundle"
            ]
          },
          {
          "label":"Accrual and Sales",
          "rangeUpperBound":null,
          "sourceDimensionValues":[
            "SubscriptionPrepayment",
            "InHouseServiceFee",
            "TechSubscriptionFee"
            ]
          },
          {
          "label":"Other",
          "rangeUpperBound":null,
            "sourceDimensionValues":[
            "AdminLevy",
            "AdminLoan",
            "AdminProjectLevy",
            "AdminProjectRefund",
            "AdminRefund",
            "BundleCancellation",
            "CancelingAProject",
            "CompletingAJob",
            "EarningFromReferredAuthor",
            "EarningFromReferredClient",
            "ExpiringWallet",
            "GivenByManager",
            "GivenToSubordinate",
            "LaunchingAProject",
            "ModeratingAnApplication",
            "RedeemingAPromoCode",
            "RepoDocWithCanceledProject",
            "WithdrawingMoney"
            ]
          }
        ]

Output
Payload is Accrual and Sales.

B. Make it a function
Extract the script from A. into dataweave function getLabel(subType).

C. In this list, add a subType label

Input
Payload is :

      [
        {
        "amount":-76.9,
        "type":"CreditPurchase",
        "subType":"ExpiringCredits"
        },
        {
        "amount":-0.36,
        "type":"CreditPurchase",
        "subType":"WithdrawingMoney"
        },
        {
        "amount":-568.23,
        "type":"CreditPurchase",
        "subType":"RepoDocWithCanceledProject"
        }
      ]

Output
Payload is :

      [
        {
        "amount":-76.9,
        "type":"CreditPurchase",
        "subType":"ExpiringCredits",
        "label":"Accrual"
        },
        {
        "amount":-0.36,
        "type":"CreditPurchase",
        "subType":"WithdrawingMoney",
        "label":"Other"
        },
        {
        "amount":-568.23,
        "type":"CreditPurchase",
        "subType":"RepoDocWithCanceledProject",
        "label":"Other"
        }
      ]

D. Improve getLabel function complexity
Your transformations will handle a large amount of entries. Your getLabel function is used on each item of the list. To comply with SLA, make
sure complexity of getLabel function does not exceed O(1).

Resources
To learn about time complexity, please browse the following articles:
https://en.wikipedia.org/wiki/Time_complexity
https://www.bigocheatsheet.com/

E. Output a CSV with all four properties
Generate the CSV file to be exported.

Input
Payload is: 

    [
      {
      "amount":-76.9,
      "type":"CreditPurchase",
      "subType":"ExpiringCredits"
      },
      {
      "amount":-0.36,
      "type":"CreditPurchase",
      "subType":"WithdrawingMoney"
      },
      {
      "amount":-568.23,
      "type":"CreditPurchase",
      "subType":"RepoDocWithCanceledProject"
      }
    ]

Var bucket is

      [
        {
        "label":"Accrual",
        "rangeUpperBound":null,
        "sourceDimensionValues":[
          "EarningFromAProject",
          "ExpiringCredits",
          "Rollback"
          ]
        },
        {
        "label":"Sales",
        "rangeUpperBound":null,
          "sourceDimensionValues":[
          "BundleRefund",
          "BuyingACreditBundle"
          ]
        },
        {
        "label":"Accrual and Sales",
        "rangeUpperBound":null,
          "sourceDimensionValues":[
          "SubscriptionPrepayment",
          "InHouseServiceFee",
          "TechSubscriptionFee"
          ]
        },
        {
        "label":"Other",
        "rangeUpperBound":null,
          "sourceDimensionValues":[
          "AdminLevy",
          "AdminLoan",
          "AdminProjectLevy",
          "AdminProjectRefund",
          "AdminRefund",
          "BundleCancellation",
          "CancelingAProject",
          "CompletingAJob",
          "EarningFromReferredAuthor",
          "EarningFromReferredClient",
          "ExpiringWallet",
          "GivenByManager",
          "GivenToSubordinate",
          "LaunchingAProject",
          "ModeratingAnApplication",
          "RedeemingAPromoCode",
          "RepoDocWithCanceledProject",
          "WithdrawingMoney"
          ]
        }
      ]

Output
Payload is :

    type,subType,amount,label
    CreditPurchase,ExpiringCredits,-76.9,Accrual
    CreditPurchase,WithdrawingMoney,-0.36,Other
    CreditPurchase,RepoDocWithCanceledProject,-568.23,Other

F. Add amount sum line at end of CSV

Input and ouput are the same as for E.

    type,subType,amount,label
    CreditPurchase,ExpiringCredits,-76.9,Accrual
    CreditPurchase,WithdrawingMoney,-0.36,Other
    CreditPurchase,RepoDocWithCanceledProject,-568.23,Other
    ,,-645.49,
