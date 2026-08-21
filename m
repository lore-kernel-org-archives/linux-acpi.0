Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012050.outbound.protection.outlook.com [52.101.48.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6ED30ACFB;
	Fri, 21 Aug 2026 20:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787345351; cv=fail; b=jC05A9Nd6qBsvM2z/lajHnDQVtMZtxDQl/uuGJLR6hejhYdYNWPGxz4vIfY5T0UoQgB6zkFnNsdZWy4hCFY4lbKb6xIDo9mcSPtyGUEm1kNI+LQ5zp8GWEFbVcDPbV0MphX/Xg+Qmlr48aUmNMdC5ojePUMLkTQQRVU5G1gM0Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787345351; c=relaxed/simple;
	bh=sgCxUf63+1Ah7Yz3y7fCFCi48zVyuq7pEu8Y5ENthBs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GchexyE2x9W3LuxlzoznL5AcOMF9iQqN4dtuq3h12ZMP9m99mL6LySqD4ZKJds6UJCUdwxvjMytW6fzds9GMIsgji4WVlgmHDqDOSf4bzjFr6py81wt6vOYSNCBqF0YqpQ6lV39ugw49x5e4DD4hrIJ6XLGmrbEdhxFZFyeRkb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l2Zz2djd; arc=fail smtp.client-ip=52.101.48.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l2Zz2djd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhTG8GrGzbmKFXH2cgM2N8JRku9L63rBtRHxPBo15jpgugLvPI4wG9c3r/3YWZh5B1inacV0yEyednPi5GMDy7RFfFvmS6gRe2qrmCcqkoxEonXmb2+lS5GuEgHEuygoBZ+HrnFPSMrdLSGp3kc57dItCE3b3gUsIz8SgNvkeCiaocW2MwPz0RZZosLLoEAMq2zyUEisknXe23zBk2JxQh0fJyyLwwNApNzwho6+tNgJ51uUQjgoyBgOussa7hRjPGX4XU6P0a/X4J8v66gKNQaxqEqSzPlBAN5AqVHdbmEiBIaZiwBkYoTk+sJE0mRrjvNnwqzxIu7WGONKHPUlKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfAgakeHzC7+c9TXnCAu7ZqtK7KNABT8wg6D8vJODwQ=;
 b=G3l+f+nWA/K4iPVdg1SjO3NGZjF09U/l5JkgjPW4ytaijZbTE2RQiqbR48tsMhF+HYxnNW5zF1wZWYzEhGtt63f1JGV6/2LPOlKsRYylaj2artTHz7MefEIbbmEJbVCvKWpdcHViANEt5WebJQS6/tIwr2PWnkpsOIQbmKWiSMa1awU3MrbzDVEap2RF1R0gct6sLQCxyWLKj/Zt52f7PbzJcI7NYaYMNEYCn8CfyCaV1eugSq33ZenMWow7gAtniAZEetIAvSaDx6cjQBNDdZANII9yLMtYOGRZ5eFZsVqgKk3m5BkytmZwjHtwKdiINQnn/511n9RX3pxB/Qdx/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfAgakeHzC7+c9TXnCAu7ZqtK7KNABT8wg6D8vJODwQ=;
 b=l2Zz2djdoMU6IG0G7PXh1FnfSlS2ttoyAzg9p/u0ueX/UFnsmHlUOnb87FJrRVYN/QbTqFkvNyWhmJQeP1bZ8GJZwR/H0KRV4R5JDHSqBboUVN9mjZTebAYJc6osfPS9xeeT/EX4NDUI/nZysDW7lj7tpOqYQahLHqLc2skghLk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by MN2PR12MB4158.namprd12.prod.outlook.com (2603:10b6:208:15f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 20:49:06 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0315.012; Fri, 21 Aug 2026
 20:49:06 +0000
Message-ID: <52e55283-f628-4a85-851b-fe33dcdd9c47@amd.com>
Date: Fri, 21 Aug 2026 15:49:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpiolib: acpi: Add ignore_wake quirk for ASUS ZenBook
 UX425UA_UM425UA
Content-Language: en-US
To: Kivan <vaknins33@gmail.com>, Mika Westerberg <westeri@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260821070651.39763-1-vaknins33@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260821070651.39763-1-vaknins33@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:223::17) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|MN2PR12MB4158:EE_
X-MS-Office365-Filtering-Correlation-Id: b24ebc79-8c9b-4caa-a276-08deffc5a43e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|56012099006|10067099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	WuEr3foJO4x95xrEOQk7HLh+4DZq6ZEft7s2DHRfZ+zWNth9Nx1XtT2r/amHgOb9gmS775t8l3rW6oMPQ+V5eVBTsnYWF406zC50ono4ziM7YDC7LfuFBXbrFN98W0zy0bQI6n+6Tb+vXA1oREr2LEPVjVzRMFxm0wFPR76GX69On4y45/8c9NjnNM8Oq+R6AMqMbC+dQaxCQq3OLkMv8n4kgVVRYfw20+fUzHokO1IEIjsTNzyzIlKwwhULnzOLa2DEKhVIfAuZ7gTLTPhZGqVfLtpsJv8wZBWYT/tfpjH24tC1P1nGQ5ZKwvVMrX5efmAFYGAIPFSfrlsavRLBGH73iWkSguuG2Je62Ff4xUp/kjMoPSS6L7pZsg4taDQzn7X3s2ev3SoubLruSlPCS71T3g+ijwzHinW2J0AU1nuV+HkzdtNbWipPzNzKwyHvyseXxWqJjbKaVgEyhOEQOI0g/xVLoWHwFm2epX1gUoRxJ6i0MW93cKG3BKIHzn8E5vQ7CdkrAZt20XgM8kvYF615a5F2Hcq7kjmZz6FXX/S7vhIvafoBb1//e2xHLi52jZAkeHoRdau5tqBFIWSJKdALxfrKniNhGrg73aNpRN8sVi5ezmRueF7gGupJ2VnNOjl3mS5wwfoRN4BWOKzuP3WbuAEyb0T7E1Ovb2DV+ec=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWJHZEFyMHhBdjdYUnRHWFA0Nm9nd2NyMVZWbzVRL2lCQkNvN09VK2UzdVYx?=
 =?utf-8?B?ais2ZGRXSzNCbm94Z3lSZld4ak1ZTTRYUlliYUtBQTVBQWJWYlNPUUYvcG9p?=
 =?utf-8?B?OUJGaVJRSmRNWmRBVmtKdVF5ajZrWTM0MzBwcjJUZE5OVTF6T0c2K0RFVjhD?=
 =?utf-8?B?d0JqQ2JNYVZWbDYwbE55VUNpSkduYThhYUJrcEdCRkUxQTJMakJLcEd6QXN6?=
 =?utf-8?B?WEFsTHZaSC9nKzM2bGZjQUlOWlIzQUpiNmh4VERqbm1BbS9NU1Z5UVpmS2N0?=
 =?utf-8?B?akRsakpnWnZaUzlFT3NBSkJKeUkxdmtpZTBDRk5qd3FsT2c2R1gzTUloblI4?=
 =?utf-8?B?N1gweTBNS1VsdGNRa1V6Z2J4YkV0TnRNdzZUQjA0bWZBL1hjdGl6OStyY3ZI?=
 =?utf-8?B?YXU5eGlucUtkSjBwZmRqOCtWcHZ1YWFNbG1zSFlreFR0bU9oQm1sZ096dEto?=
 =?utf-8?B?MlA3N3Q1LzZLVlE2TWkyc0dCQko2a3k1S1NtYlArMHBZbWpySGdJY3RYZ1lU?=
 =?utf-8?B?bWNZeGZKUElTZFMvTWVDY0w4TUZDV0Z1UU1oMkU1d3dSeSsvQzVCbnJ4ZzVI?=
 =?utf-8?B?L3RmV0ZhOWhocHNqdVFZWEZlbURWZ0ZSNnB6Q0FRamp0YmtlT3UzR3FnLzFL?=
 =?utf-8?B?K1N1YmtsN25GWTREelNBTDhWSlJ2bmRseW5YM3ZyTkl3QzM2LzJiZmVQMzYr?=
 =?utf-8?B?L1dlMWlLOS8wSnQ0SlNvQ2hGV1k4WGpRa0Zremgzd1l4cHNlQnZIL1VjdDNh?=
 =?utf-8?B?Q2w2S1JTckRERmIzWWdNSGlENVdyRG1kVnRqMEJRNmF2VFBQYi9uMXFvcWZN?=
 =?utf-8?B?L3h4Y1ozb2xmZkdQRUxCMEZCNlJ2YUdycHdnSnRxNGE4eE9UYktzeDdnR3lS?=
 =?utf-8?B?dFhONVlUVnhXNnJhOFQ5ZDBZb2MwK21NNHNuN3JKREpSVUIveFR3N2syeEg1?=
 =?utf-8?B?WkFUa2RSdWtkNGhuUjBOZHV4QmVpRUhTRE1YaUFkam9vYUljajJFaWVrM1Nm?=
 =?utf-8?B?M2RmcTNqLytYbVZrYjhwemNtMlRiVnNBRWQ3eU9ldmphY2Zkak5uYlhhOVEy?=
 =?utf-8?B?YlljZ0NEUHhGdzlDamx3RE15eFR1U283S2tRZlJyZkdtQTFVckczT3o3WU4w?=
 =?utf-8?B?YkNjcjlSWDQ2MlRoQVJUV2t3bDZEMlNtUVphTUkrUGJqVTJNLytQTUZnNjNv?=
 =?utf-8?B?QnFvUFBJVDJ1QSsyL3RJdFh0dkhNcG9NRDZINnNLSEZkT0czbWZtWjhLSWwy?=
 =?utf-8?B?R0ppa0JYWnBETUg0Y3NDRFFJTGhnZGoza1lwajAwOFBha1Z5ZWV4czAxVy9z?=
 =?utf-8?B?VU1QYmtaeEN1ekdGMTdiWmovV2IwRXJsZk1iczZsRy9OWUQwZDhxSTR2MTl0?=
 =?utf-8?B?VVBiSTh6NVk5dE9IYk8zaDllTWN1eGxzajRVWFduRzZQbERGeXp3OFFkWUhk?=
 =?utf-8?B?V2d3OHVYZDNqcUs2ZkRiVHBhL3A2K3VFcDgvZXJtbnBabkxwQmpNVGdxbGg2?=
 =?utf-8?B?eXRtVVh1bUtoeTZqMms2RnpRdlFyUmEzc0lKN3dZdGJXYUpVUldsZlUwbElW?=
 =?utf-8?B?bzZ3cWxZZzBqejRJeWRnektsS21vckpRbldmWHc5WndiRjNWcDZWTVVXNnF5?=
 =?utf-8?B?NkVGSElJZkVhS0FxRTFvQkdBSlFMa0tDZzU2RGZFeExnWnNRSHlZRHhXVVRp?=
 =?utf-8?B?OElBRC9BdnZqOWhmSlBBWng2ekhrQ3VPaWpPWGw4dGt2N1c5bk14MVIzZi9D?=
 =?utf-8?B?T2tFaWptcU9HNTFheVV2RVNCRjZEM1dVTy9vaU55eWQ1SXhTWWtIRnplSGE5?=
 =?utf-8?B?QXhjS2k2ZDZRV1FSZGc0YUtkbUczZkovNm1JZkhadlVmc3lYa1VEZ3E2bE9C?=
 =?utf-8?B?eWZweitYUExab3BIMGg4WURjY1Z0T3JRc1MyZDR1Q1R1MWpjTzZwcGpyVFpB?=
 =?utf-8?B?SzRUYnE2Y0NianFrSTFjbW9Xc0dQOXI1RTVyZUorSy9kM3o0elpkeFU0SDlZ?=
 =?utf-8?B?dzRNS280ZFFHZmIvc1VMM0Mzczk1YVFHbnR3NEZlVmZKN2pyZlZOZXFxVFV3?=
 =?utf-8?B?YjU4a0JGRmJIV25lcEVpcWdIMVdvcVJTei9takhDTkYyNXdkaDNsVmYvdmE0?=
 =?utf-8?B?Y05pUnc5NzZvK1JlMHhuUXBJbnVVSmxsQ2xLTE81cS95TFhBRTBhM0sxbzJL?=
 =?utf-8?B?aTFHcnRSMVBkREtpeVZYL0VGQmd0Z1JuRjZPL0N1eHpsMTZoZkpOdzlKOFcy?=
 =?utf-8?B?dmNUcnBJTm5kOGEvVHBHUFJVZ3dUdmtzQ3dPRHZRV0hpS2JTVjhKNFBSdnpl?=
 =?utf-8?B?K29uQ1lyMXdUUk0xQ2lRWVZuUy9Xb2h4QnNUQ3VGRnFoVkNGUlZxUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b24ebc79-8c9b-4caa-a276-08deffc5a43e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 20:49:06.3881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y2mqeYKoBqRB/HOz5EPrEuk8l0yCZLzd7ZHM6OTqtusB6OwayPakfjK2Mh0T6aNBZkpZOqY6qejjz/a+i64KBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4158

What is connected to this GPP3?

Can you please share your acpidump somewhere?

On 8/21/26 02:06, Kivan wrote:
> The ASUS ZenBook UX425UA_UM425UA (with AMD Ryzen 7 5700U SoC) fails
> to stay suspended in s2idle (Modern Standby), prematurely waking
> after 1-3 seconds with 0% hardware sleep achieved.
> 
> In the laptop's ACPI SSDT tables (SSDT15), GPIO Pin 24 (hex 0x18) is
> defined in _AEI as ExclusiveAndWake targeting the PCIe bridge device
> \_SB.PCI0.GPP3:
> 
>      GpioInt (Edge, ActiveLow, ExclusiveAndWake, PullNone, 0x0000,
>               "\\_SB.GPIO", ...) { 0x0018 }
> 
> When the SoC powers down PCIe root ports into low-power states during
> s2idle, an electrical edge transition triggers a spurious wake interrupt
> on GPIO Pin 24. This signals the AMD GPIO controller (AMDI0030:00 / IRQ 7
> via pinctrl_amd), aborting sleep across the system.
> 
> Booting with kernel parameter "gpiolib_acpi.ignore_wake=AMDI0030:00@24"
> completely resolves the issue: amd_gpio reports ignoring the wakeup on
> pin 24, and interrupt counts in /proc/interrupts remain at 0 during sleep
> cycles, allowing uninterrupted s2idle until intentionally woken by the
> user.
> 
> Add a DMI quirk entry to ignore wake events on AMDI0030:00@24 for this
> system.
> 
> Signed-off-by: Kivan <vaknins33@gmail.com>
> ---
>   drivers/gpio/gpiolib-acpi-quirks.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi-quirks.c
> index a0116f0..dd4db58 100644
> --- a/drivers/gpio/gpiolib-acpi-quirks.c
> +++ b/drivers/gpio/gpiolib-acpi-quirks.c
> @@ -392,6 +392,19 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
>   			.ignore_wake = "VEN_0488:00@355",
>   		},
>   	},
> +	{
> +		/*
> +		 * Spurious wakeups from GPP3 PCIe bridge interrupt
> +		 * Found in BIOS UX425UA.301
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "ZenBook UX425UA_UM425UA"),
> +		},
> +		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
> +			.ignore_wake = "AMDI0030:00@24",
> +		},
> +	},
>   	{} /* Terminating entry */
>   };
>   

