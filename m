Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010027.outbound.protection.outlook.com [52.101.193.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23533BADAA;
	Mon, 11 May 2026 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778491219; cv=fail; b=EtX/HlIaw+v+4G5q24koFjyHEmMfr/xbwbdxwSp35jCZUW1qJ2Zx2VFfazL2weqFetwHQ832QctI/g6hGinM9NST19g5sDS7xYDEHmEqkjw8KhEseBnU6TnDRS1fTs7feSL89TiHoYkujuAI9BTQvJ5L4BkfmDeoqn2Mel6ynuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778491219; c=relaxed/simple;
	bh=a+EU8MOlc3Yjh/xx9/DTKySNP/qOWken7AYJwIBm9gM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bRu5w6TazW49EceAYFhxnzu+lWGsvMS1gDq2roZd3SMW3qjRNxCQM/8bknL7eXfdQlpCdSIvkBXd9PYI1m++TtGmAf56MAOFfIf6QTtesTjXcO5KE8e/mz7AVotlbIip4K0cXPBKVIeWdycaogsGGtu/+Gw48wL5NoXU5KzoIZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tDJ+7yS7; arc=fail smtp.client-ip=52.101.193.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tDJ+7yS7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uItISJFwWyjmY2Y0yX3//CCHfi6sioSQ9In92QEDer4Wd3Uo1CFhYNyckf6DA3LVwLWlsIg/O+fMLc91zq4p8tj5uwx+qDq69UQv0YJBTLHwByw7NKcHqpN6TD35aVOv9BqULG/dgRlSrY4Nw1mwdxGDWv7coHpJ162zPq0gOlQu3ApZlGO2OUgMU3G9ggmV8evuF60Xf3xVDGEQFBVmIkeTfKIyaLq8e8IvrwrSbxDD3uHRCMp5pLGVtVeuBnmyrO3X/+YeGiqnOxNzjREAacyq9402s8oDIWYngVyI0Vkc2wNmmM8H0ZWZ0TdNQ45DTVtsx2wlv67NkSnYUob+AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7X8n4tj5VbKr22N+CY+oyJWxcRnzgyUZr6TuxWV1c0=;
 b=a4Cxzlg+JKeYBbI3rGoxMtbp/pxaUIwdoLBp/8z8KERsnZrBbnjNrykO2mgeMaX6Tw3wj4S+a2Gwe5O53eIyUZb3jJ9k92xMoBeMQROfOT5zEJMg5DGQ552usLEXdV1uqLJ7kMaZA8KnUVpICqrSnWbhg9krLLANeGDFxDoGkdvGy6nh/0dzUrPvPdiIuFyFx0EnhcW7xiUkurwn4mX/KQGxQ7JxCyohxXRAloPNElhduv/mQXXnAs9K4Ck0IfCWQxN19ZRUutbWb+g2hGPNFuSEEzkjUjDsDOV2Rzxs6uJWo39E7UV9mnSx86EfWnzwktm75ZXbGeSKJsYVjJcqqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7X8n4tj5VbKr22N+CY+oyJWxcRnzgyUZr6TuxWV1c0=;
 b=tDJ+7yS7hS8JYjyBjTm/cgZF4XwBMb2AuT/mXIPskZiGX+qwuXIn9r08jx61yurBuuc9HUP8PNWhsDVrYH9UO6rmpVpJ5Fh9CH+MawwL3FPcah+iqR9+v56CqroGQ4DOwOXXMgMz8aEWC4DabK1nN4OzaG7eE4qw7pmjLUrX6NQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DS0PR12MB8043.namprd12.prod.outlook.com (2603:10b6:8:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 09:20:13 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 09:20:13 +0000
Message-ID: <9947ce18-34e1-470a-9caf-d5bed98b25b3@amd.com>
Date: Mon, 11 May 2026 11:19:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/16] arm64: dts: xilinx: Add EL2 virtual timer interrupt
To: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Ge Gordon <gordon.ge@bst.ai>,
 BST Linux Kernel Upstream Group <bst-upstream@bstai.top>,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Lars Persson <lars.persson@axis.com>, Alim Akhtar <alim.akhtar@samsung.com>,
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>, Heiko Stuebner <heiko@sntech.de>,
 Shawn Lin <shawn.lin@rock-chips.com>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
References: <20260507125544.2903406-1-maz@kernel.org>
 <20260507125544.2903406-17-maz@kernel.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260507125544.2903406-17-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0141.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::26) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DS0PR12MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: 7acdc039-1069-4492-e369-08deaf3e81ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wZDGU2kzaQPbjro+X3F4EAJbqR8J9LyWEGyU7TJgN3mKS8yzivt9/KY4VfD2+39NjHgoVzJ9KX9Sw10VCgFfzJ0Bzw+78HAsU46Q6F3HVGNFPd5ta8N+kUg1k3uY0KofAZHNNO1Hqf2F7eLUSLcdS9jFTYMNh6FXI02j3fKrsPBOsVwwB8n+PLkIBF5JvIhpJQkCeRpMMzNAxNYMCHrRMMa3/ogEKgkHgiNs6H9KDiI4wwwRnm4xJ+37Z9ad04WpAIQuNv83EBQ3D1cjPuHCht0a90klNheIgvRDAqMyw8Zle7CyXS9ld9V28/wnkRmAIE4pDmIo5maHIhcD9xYvL3FzBBZke3jZIL9zdhsjqwoopjwZPRVdJ0CJu/3YOrqhZ2tG6SBEgqigy1p7arplfsa5gnReJbmauukt1//ZdiSJE5bV3cZNdQXHFMSS7ZA2RXDikx3Uu4ZX5Wv/S+z9FHm9lNAId2b5PRKDHeQ2yNoAUESC5HBCeD1ZzgjZ+J6Ihgz91+iA4O9W2yUDJGnW0SeNn8U0XNIom/IyHVaXefb/bnzOifQVw7in6bLtkM0zC+HwJHYrADTgIOHf6q48KBbrYzh1QS1kwwMky8ltr+0z/DBnbzSjnaLqI2f4EtDFeSrWmxeDYyRxxELXDcB/cHMrpbwAVW23/OebDyaDqOIeT5yG2F8I09jD8IH/tp8m
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enNQZ245czNtRHRhd0kzWDJHcVVsYk5QMk01dFVNdm83eHBETmxJMUVCMXd3?=
 =?utf-8?B?eUljMVo1eVhRcnZvam9GK2xzdG5uVVg5Uy9rVTltRkgvN1IvbzMraGs2VGZx?=
 =?utf-8?B?enZLQWxCRU5LS3czMlZxdjN4WnJzbUlnUlNEbUY0Q2FjRkl0NHlsWmUvWmty?=
 =?utf-8?B?Vk52bEVWanVwTnE0TlRGUVM1U3hOSTNuZG1xRWN3RzZBaWJnL2ZXbnVldHNt?=
 =?utf-8?B?dTNqdHQvSGo5cklGV2hPSFJUSkRPVjQ2S3F6YncyNDl4WVNtSFNlOFJiYjRq?=
 =?utf-8?B?TjdwMGZSajZSZFlWNXkreGtJdFl4Z1lRbTZxU0tIUHRoVUZKbnJtdmZVQXNu?=
 =?utf-8?B?WDR3MGlEbGdvcXgzK0kyeW9SMnlCVzh1OUNHVHQ1U2w3akI5Uy8wTzFTN01p?=
 =?utf-8?B?a2JOSHJsM05ydkp4YnhNaTl4cmxmdTljYXJ1bi9ZaEErWW43UmtjTFFxNjZk?=
 =?utf-8?B?QlV4ODdENUhiY09yOUZIbkFuSTJ3cFFrRzd4M3B2VjJlZzY4cFhrbmp6MTFh?=
 =?utf-8?B?aDZSY3IwZnN1bUlLbVpGMG9PVWhDKzNPbHlGTmJGcXg5NmtFdFB6c3NVVWYy?=
 =?utf-8?B?aFZXRmZEWDRWbGJQSUhmNG56ZWZRTkJhT080dllJTWtNa21nSStlSDFsRm14?=
 =?utf-8?B?Mm1WM3JHcER4OWVCTDhRY0kraklRUVQxQ1c3anRWU2RCcGtNdkRGL1NQUVBi?=
 =?utf-8?B?Qy9NWkNSSkFodnFQYS8zM0NmMDc2dmxTUWttV3dSUFpQenpkdmh0YnFLVVlN?=
 =?utf-8?B?NHpQQWZYeGtvK252TFJxOXBaMDFnRUNYaFk5blRrM0l0YkNYSUZYTzJRLzhE?=
 =?utf-8?B?YkdlYXNDNCtsR1hOd1N5Z1gydi9CQm8rM3lLdmJGNUN2WEZUWGdIN2R5dDkw?=
 =?utf-8?B?a2RMOXRhQy9iaVRmUXVXN3djVlZtYm40NWdwaTM4SWZOY0N1VzZjRm5YUXlW?=
 =?utf-8?B?SjhkNWM1Z2p1bWgzdWFISHdvbVQ3Uzc2UFFGZE5zb3RpRVBYNll1ZHRnWGRs?=
 =?utf-8?B?UTVDa2NzNmFjNXZjSjZDMXNBdXc3V05WWk1IMkhGeEFyd2J1bFJKSEVGTzhP?=
 =?utf-8?B?ZGFucW1wZmcvakl1OEhCelZmZWpaaktZRWhlYVAwK0VqMUlFMEY5cEkwQjE3?=
 =?utf-8?B?THo1M1J1OXZiY3lHcXYzRWFPT210YlJUVktvVi9CNUxBcmdEZXJYd0Z4U0tt?=
 =?utf-8?B?T1UyU1kva1I5TkRwMTZnVGdDOHpnRmdLQU9tcjg5Vlp6cUpJREs3S2xPRTN2?=
 =?utf-8?B?ZmpzYWNuSnJQd0ZDSVdKbGF6SmJjS1M2RlhCTjUvRnNVelAyOENCbkpaNVk2?=
 =?utf-8?B?RWlhazBMQW9sUWhMRGNndXpOT1M0cWw1SFppdGFVMDFqLzFlZUFCdEpGbHFS?=
 =?utf-8?B?WHV5UVc3TVVLdEEyZnk4MnlHOTdHR21Cc3kwVGdGRkdUUUpQclhkc3ErN1J2?=
 =?utf-8?B?U1FkT2RyMTNMeGFGek1HM1pvY1RXaGcxeFF0R3owNG9LZGVKNkszK2JDL3ho?=
 =?utf-8?B?VVJZK2RFbXJ3SmNJbGRRUTFtSzVyNjJrc0xhMzFBWUoxeU9vZ0JMdHpvT0Qx?=
 =?utf-8?B?dkp1UHlTM1dVeFhzQjZoZHhhdXJkclFidWhJcmxObWxpaGMrbmc4bkZIV1ZR?=
 =?utf-8?B?NTR4UU5EK2RGSUZlZkNPK2tHZlJSV2xkKzQ4MVgrNXgybFpVT2NZQ3VKVHhs?=
 =?utf-8?B?VkdObEpZTytqb2FQS1hUWDJhalVTKzFxc0tiMnJTQ21QNDNtbCsxZkhleXBp?=
 =?utf-8?B?aW5aL0xnQzhvT1FQc1dkSmRGdktMdmtUN21BcU4vKzlBQWp5SG1oUnB1Yk5s?=
 =?utf-8?B?UWFQMVpXRksrVnhxd1k1SW9IYVhvZUdRYm5RK2ZjRVVaditRWVJXd0toSU0x?=
 =?utf-8?B?bWswOTJ5dW8rSUkrcUlhc05idWUwQzRjY3lHNjhscnZvNUMydGpYQzRIVUhC?=
 =?utf-8?B?dTVMZWxaVzF0ZWExUVZoRmRncXl0a0d1K1JkeFlkNU5QTG91N3VMQ3FOclIv?=
 =?utf-8?B?WnNiSUxRRFg0YS91aElzSFhrcUhvU3JKT3hYZjREdzZXdzFiVFRTWHdydVkw?=
 =?utf-8?B?NGw3UHJuOTkwUHMvS2QzYlF5cUFxWE9mTUR2UThXamNwQ2p6VTlWMG5FTWsz?=
 =?utf-8?B?UHZkK3NOd3k5YjlEVndDL2ZmSEt6SHFWTWt4MkZEUUFITWJEbTVDRnk3Tkdv?=
 =?utf-8?B?Yy9vbkRSb3hnTTl3TklUL2I3ZFhFU25qTU0xSXBJcXFWd3F4cXF6WDZBZTdw?=
 =?utf-8?B?TlF3V0E1dXdWaXJWTkJQcUt6TEtBNjFxQmtmRFQxRXZVSEZ5aWJSMVR4bDBv?=
 =?utf-8?B?SWRXMlNaY3hoS08vUjd5Tk4ySEEyWE82L0lhTEk5YVpmUzdSaERqdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7acdc039-1069-4492-e369-08deaf3e81ab
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 09:20:13.2934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Xlh3eC+2GLuDlim9sqcAAQ32GLij/zgZpszTENqQppPq1AvLmbBNMz5HwddcCK4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8043



On 5/7/26 14:55, Marc Zyngier wrote:
> The ARMv8.2 based CPUs used in the versal SoC are missing the EL2 virtual
> timer interrupt. Add it.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>   arch/arm64/boot/dts/xilinx/versal-net.dtsi | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/versal-net.dtsi b/arch/arm64/boot/dts/xilinx/versal-net.dtsi
> index 15f767608e67f..0aac93675ad77 100644
> --- a/arch/arm64/boot/dts/xilinx/versal-net.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/versal-net.dtsi
> @@ -728,7 +728,8 @@ fpga: fpga-region {
>   
>   	timer: timer {
>   		compatible = "arm,armv8-timer";
> -		interrupts = <1 13 4>, <1 14 4>, <1 11 4>, <1 10 4>;
> +		interrupts = <1 13 4>, <1 14 4>, <1 11 4>, <1 10 4>,
> +			     <1 12 4>;
>   	};
>   
>   	versal_fpga: versal-fpga {

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
