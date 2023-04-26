%dw 2.0


fun getlabel(suBType) = bucket  
	flatMap ((bucket)-> bucket.sourceDimensionValues
	map ((item)-> {label: bucket.label, value: item}))
	filter ((item, index) -> item.value contains suBType)
	map((item,index)-> item.label)
	
	

var bucket = 
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