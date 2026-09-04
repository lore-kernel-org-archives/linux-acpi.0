Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011021.outbound.protection.outlook.com [52.101.62.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF2650EC11
	for <linux-acpi@vger.kernel.org>; Fri,  4 Sep 2026 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788543179; cv=fail; b=MAWhNFyGK5TwM80qrviKrRDOcEFwJOGz1hqKT6+aDdN0us45PCUrRPu39Z04q0uK5228Tgcn6mRhiWve6zU87GBhXUfXs9O7wR0VNf91ayvfDrJFgR/5/XHIMwDi9pkGVxGkDguRLg7mDcmXHjOmyPtl0C+rqVHFzvxVqxWHmDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788543179; c=relaxed/simple;
	bh=EdailqsUDeTpqepqCZ4m09TowIe6U8Cgtl6D8bOvDCM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZhVhLpIMWw1Lx8NlnyW16NTGyIMiQk/oYi7RjwJRXRxhpqhsRiC+pHn3//tRIpUaEYg89HoOB5XZ8mPhS0LstLx8+X0ofFHPZB8zM/wuoj6TZVhZhwOgmHdYvMynjJWZ+/atdUH+lp0i2ex71HpYsDNiBIzHttT0Zlcts0MwFDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rYlbAdhX; arc=fail smtp.client-ip=52.101.62.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rYlbAdhX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0Zwsh6skPslYCL0xb0/utgjIofnWp07JK22mgG1rM9f9BENoxMS8F1zs2ilDNWxlfb9uK4Kh5qfN1zKdgf8yN3FRbSSpjOgL/zi9eq2lLWC7PbTQDSlZ92wtZJTigvmEsC7ZB7lMRvpeZQ9FH22GvNVKP8GeHqFsSp1ChQ76EqXnv917mjlw/p7Ne3eHgXnwVEflJGZ8VUyFSZbcZE6MdsSKjVhvaoY0lUvTtEBPtqkTu1amuP8EayHV2v5rs+NN6BLXdIPK8r1FwEgJuKET3nRzagMSCW5OydoDMnD8Lh6yjvTN0I9x4woJjv86ogz6Cz5wkdwGbyc4TL9uOQ3Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVcPN8g0wDYvLbyuHCjwmMUJXLivTm82n6f4LpBQb/g=;
 b=U+WF61l9FVE7f4WT6f/4rNyrjb60PkjIwV2IcR20wtqzA2cITnJ5sujH7WxZciWbYW+JNZuqhSkOtNWIMOPrgt7tfcnM5A04DBgLJ0kyuL06L9euI2ieprOxlgXxSPp+DDGyTS3+4IISyfxc6abp60I9GnGHCZlnYgHHbDB65BqrSqRAA6vfLUislQxWCP2griKg/Hy5wSE04FlfqSi1wb+D1Yh3zW0+f29HNrM/AF+Fi9lDNsE8H7BUlwpktGYYukovVEfsuTDXiyYUfhWNU0LV4ou2cOa/mOHB/aLOXyU3QJJm+fQ1WYK1sA/bY2FHPkHUcHdaCVICWbXP5o9psQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVcPN8g0wDYvLbyuHCjwmMUJXLivTm82n6f4LpBQb/g=;
 b=rYlbAdhXnKKC7HSO/9aAUvT+hcIyVJ6DHGC2ANd5V/wETHEkIPwDLcUzjrwHihkCoOn1kCOZdmm41r7YQ9gc17454FCvL2mKOwcg4G/UkFlSKXmdvKpERavLUd32+qee7u7QgkrKgWjhin7kyoi0J60F+zirCoU1FwGJPTuJbQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SA3PR12MB7784.namprd12.prod.outlook.com (2603:10b6:806:317::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 17:32:53 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 17:32:53 +0000
Message-ID: <7f86bfc7-efda-4719-a0c2-fab04fba532f@amd.com>
Date: Fri, 4 Sep 2026 12:32:50 -0500
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] ACPI: utils: Ignore leading root scope prefix in string
 _UID match
Content-Language: en-US
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: maciej.wieczor-retman@intel.com, pawel.chmielewski@intel.com,
 lenb@kernel.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
References: <20260831180214.2231161-1-mario.limonciello@amd.com>
 <CAJZ5v0hgn+_L_yvEg0yo0vPk9_brbxsywyu_77tEyww4nV+eUg@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0hgn+_L_yvEg0yo0vPk9_brbxsywyu_77tEyww4nV+eUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DSZP220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:5:280::13) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SA3PR12MB7784:EE_
X-MS-Office365-Filtering-Correlation-Id: f1f4744a-5fa9-4010-a7b7-08df0aaa8cab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|3023799007|22082099003|18002099003|56012099006|5023799004|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	HiGDk2m8EwfRcGA/7hXeQqL+VRuM2ACCG2Xx1tUKvuIoDOd9urq5Y3/Ub4cbTOyzcahnJonvF+iApsfK02vJQsqJPjLNyHc4p0HLxCLNmYAnWBxw93/kCejLTad0ZASS8lC6tmdIMrWehi8aqa70E/efrz2dd6ZjuEouLVIuaKQIlzgbqr3xLEklxOPnB6rGR6agdCIhZAK3DEM7ojmptW9MIWPmqst9GNJ/4eqGYehq80qeo2JW68pSrz4omZ49x/VRr83ZbAehzxQbs9f2sP+B7nSnD2QzEO954VuMRkxGi9wxaCCtCo6+f1fB2vjUVz6gFoRfwNrtamaEPEfd7yZAP7S69kXOrt+aaP49dEtZ8OYeby4HtTSQdcQEYRhuXWV0l73MCiz/EdXWIk8k/29gFJnkiAGqmHgWPWLTG85NWFiDss6fTq+diXw/PHTFgZUzquGdrGTPPQpg9dExEfmPjgWg4AnafHg3TxMKDuzRTqJZMk89YTy5vUU+ddLhjngxo5izVABnFhWnwTXKQctD8PTdzF5zmCxA3uZbeH03YOLQsnLokSj2XA88GKQC0KMpn133KK2swyM9KXTvy+IOlkBnWeQSdRmV82TeTyqW1uInPSXVGv2k9P56cXtmt0daMgi71QUMI3k++Y9oU5TnKcCP9DaZRdDAW7Zt8iY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(3023799007)(22082099003)(18002099003)(56012099006)(5023799004)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2NESThWK213SCtwcUhmc2hVL1hLR2lqT0tkTzQyallML2xnR0hvSVk1cDVX?=
 =?utf-8?B?R08vUHNEYW1Ha2V5L1VWZHhxSFRxYWI2aHhXdXRWdGNRV2MyVFhEWFk2dUlr?=
 =?utf-8?B?Y2J4cWtneVhzVS83NkNRNjJtRi9yaDh3dkYrOXB6SnRqWmZUZE1henEvTFRj?=
 =?utf-8?B?eHE1KzI4YVh5Wk5RdW5nMVFIQ2FVaWV2bDQ5ZlZCenpjemZKWFA3elhvbEZu?=
 =?utf-8?B?eHRidFNmbjdhc2l4clY0c0YrVVVjK21TYlQ0dXJ3dDM4MkNWQW5MRSs2V0Q1?=
 =?utf-8?B?SFJnZmFNZ0s5bW5jcllsc0h5WlVoRlU4UkFlZ1EvL1JZZGsrUWtIRVZPS1F1?=
 =?utf-8?B?L2RZd2VmSFI1TjJPVnBsODBpQW9MZWxyREplbWI0bjEycWpJTmJjS1ZUdnBn?=
 =?utf-8?B?Q21wVElPU2lWVFNCQ09YUmEvdFAzcDVESUpvdVFWaUlZRXdrS1VGRDBSenNq?=
 =?utf-8?B?bDhuUnkxVjhadEhwc2gwbktWSmlIcWhpREx2dWRrNmUwSFVXd25yVkdpZmJk?=
 =?utf-8?B?WEtQbEh2T3JKZ1drNGN5dFBqTEE2RXhWVys2R2cvRnRyMFBZNXdKdGxiK0dS?=
 =?utf-8?B?UmdaZ2xBYWtvdUxGN1RSSTQxUm1pT2lTbEFFUDBnY2ZCLy9LdGY1dTZwdTZz?=
 =?utf-8?B?YWIyV2wxWG1XRkZWczUxdExZWE5xZGllMXZxb0tWemVzd0h3eGxrQVljcTdI?=
 =?utf-8?B?bi9mMTlDb3FkZUsxaEx6UkJnZFArSDJCd3lBUjlWUXovYmRRL2tJRk55eW9J?=
 =?utf-8?B?QUJ2aUV3OUV4cUpvTzBBVGY1c1k3Q0tQRXA5c1RQZy8xaWNPRXk2bFdYRWFi?=
 =?utf-8?B?WTF4ejdRcytvVVdzak5FSXNVbERoamFuUjFmM0JrbGo5OTJaOGlDdU1YbHJn?=
 =?utf-8?B?aXdBMXR3RjFSamNoZEIxRDlWN0NWUXhSbkNKQVJWR3diWEZxaDdjTmFPVFpr?=
 =?utf-8?B?WUMvWW1GTEFpQ255SW53TmFsQVorZ3RFODh1REdkYWFibXVZZkRIcGwreDVS?=
 =?utf-8?B?alUvSjlTNGdEbW9FMGY4eE80NnoyQkNXTWMrQmtYR2I4NjVnZmNOR3RpZk9o?=
 =?utf-8?B?eWNjMVROVHhielRWalBnVE8wcjJERUxPRlppU1F6aGdPUjBzeSsybEpVRXNr?=
 =?utf-8?B?RUFSNWR6K0FWdktvay83R2xXaVpiQjVxZGxOeUdVaTNJeHhZTG5adkdEQ2k4?=
 =?utf-8?B?SWRKLzBLalpBK1JJUG8xbUN6NDBlNTNlVTZrSjJnOTFUVjRBN3BySWZFRE5N?=
 =?utf-8?B?WnNBRXVFM0Q1MnN5NTlwck5xeWFpVUdBWlNlOG9KRXdtaW1YZHNzU1RPcjM1?=
 =?utf-8?B?c0NjWTc3ZU5nY0hNeDNOeVJlMWJRV1UxRmQ1Q3hybFd5WStFZ2R1TUc0N2Y1?=
 =?utf-8?B?TGgrSGlHYUJmWjh1dE4ySkpJOEFSL3hUcm4yRmlSdkdhLytZQkViWDJuRXFG?=
 =?utf-8?B?QllCK21OVVM4Z0dYOVRTVmM2MlB6TWZyWmdSaktUL1ZwQlJ1QXgva2xITkQz?=
 =?utf-8?B?THc1QmdtTHp1Y2tONmZOemZaejVBS3lFbzNxNFcwbk9SYjZXc3pHZ2dabkQw?=
 =?utf-8?B?aHhKaHJlZHB3Zkl3eSs4YVYzZWE4Y1lBZFdXNElGYWlvY3FEQmdEd3V3U3pt?=
 =?utf-8?B?bVZiajM3cnlzMUR4Nkx2cWhEWFBDUytVeEhvcU9yV3puUVJTNnZvWlRjZXdk?=
 =?utf-8?B?RGdBcHYxN3ljRzJaNGswRUZ0QVBuRjJhVmdHYXFVM1FOLzBOUWJ3YUNIcUNW?=
 =?utf-8?B?ZXFaUk1XT1lORHIrY3R3aU9jbkIrZzRsOHVwd3pLbHA0OFB6YndOQ09oaHhF?=
 =?utf-8?B?dWg4NU81S29oTUVEWllyMnhzSk9IWWRvWG0rejJuUXRtUkNkeUQ0cTZBNUZI?=
 =?utf-8?B?b0tqQlBNbzlNS1kzZHBGNGI5MllBTnZFbERZOVQzQUZ4Qm56MTdLWjB2YmlY?=
 =?utf-8?B?emdZemtPVUNxQmJDcVFDeFIveVhhS3R3NGk4RzVpQWF5bU8vYktMdnJ4WFhG?=
 =?utf-8?B?SnNCWHpoK1RaUXkwU25xb2RQN2xlbk0yR24yTGtIaUdBeFVpSlF5Tyt5OXkw?=
 =?utf-8?B?VUdxcW1TckpBcXc1OEo0dHJXY3lMUEYwdTBUNHRsaEF5dGdMV2drYWdKUG5B?=
 =?utf-8?B?TmxXQU1xVjk0Y3g5K3gxWmh0RHlGWUxmcUZGVms3SExwVWN3VTFDMllzSjRR?=
 =?utf-8?B?ZVJDRXpnWExoT3dDMzEyV0xNdk1mR3NWUm1xU211Skx2RmRXRzdOVXk2TVhn?=
 =?utf-8?B?cnZwcTZIYmFEdHBOeWRlU3piZE1OWkZBRkw4eVUzSUtmTUNJWXhaV0lPTURK?=
 =?utf-8?Q?27BEFrJ3E68ZpyMSNB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f4744a-5fa9-4010-a7b7-08df0aaa8cab
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 17:32:53.2542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Of+4tlj99p4e3pMDtoc7FEMi0wJAxPMoocehNRWyc8Fw7o3pHBD57W+eGMe/7fP62AkODs2Qt7aQnWyNvLXEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7784



On 9/4/26 08:26, Rafael J. Wysocki (Intel) wrote:
> On Mon, Aug 31, 2026 at 8:02 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> Firmware may express an ACPI namespace path used as a _UID with or
>> without the leading root scope character ('\'). For example, an AMD
>> IVRS IVHD ACPI HID device entry may carry a character UID of
>> "\_SB.MHSP" while the corresponding device's _UID evaluates to
>> "_SB.MHSP" (or vice versa).  This semantic difference is due to how
>> Windows PnP enumerates and uses devices.
> 
> Can you please elaborate a bit more?
> 
> I would expect _UID to return the string without the leading
> backslash, so where does the other one come from, exactly?

It comes from the ACPI IVRS table.

https://docs.amd.com/v/u/en-US/48882_3.11_IOMMU_PUB

p306-307 talk about this field.

Here is a sample entry decoded with iasl -d
(from BIOS on an affected system)

[223h 0547 001h]               Subtable Type : F0 [Device Entry: ACPI 
HID Named Device]
[224h 0548 002h]                   Device ID : 0068
[226h 0550 001h] Data Setting (decoded below) : 40
                                     INITPass : 0
                                     EIntPass : 0
                                      NMIPass : 0
                                     Reserved : 0
                                  System MGMT : 0
                                   LINT0 Pass : 1
                                   LINT1 Pass : 0
[227h 0551 008h]                    ACPI HID : "MSFT0201"
[22Fh 0559 008h]                    ACPI CID : 0000000000000000
[237h 0567 001h]                  UID Format : 02
[238h 0568 001h]                  UID Length : 09
[239h 0569 009h]                         UID : "\_SB.XHSP"

Setting this field to _SB.XHSP does fix the issue for Linux, but this 
has problems on Windows.  So my hope was to let \_SB.XHSP work for Linux 
too.

> 
>> acpi_str_uid_match() compared the two strings verbatim, so such
>> entries failed to match on the UID even though they refer to the same
>> object. In the AMD IOMMU case (get_acpihid_device_id()) this caused
>> the exact HID+UID match to be missed and the code to fall through to
>> the HID-only path, spuriously raising a FW_BUG.
>>
>> Skip a single leading '\' on either string before comparing so that
>> paths that differ only by the root scope prefix are treated as a
>> match. The integer _UID path is unaffected.
> 
> But this sort of assumes that the string returned by _UID will always
> be a namespace path, but is that the case really?

For IVRS entries this would be true since this is what is in the spec:

 > If defined as a character string, the ACPI UID marks the instances of
 > DMA-capable devices with the defined DeviceID (e.g. IOMMU visible
 > Routing ID). It should match the ACPI device namespace strings with
 > unit number, but without a trailing \0 character (as the UID length
 > specifies the size of the string already).

But I don't know universally it would be true.

I suppose one possible modification could be to look for the length of 
the string being at least 2 on the string before incrementing the pointer.

> 
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   include/acpi/acpi_bus.h | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
>> index 1a45e0d521d8e..e0bec35953ef1 100644
>> --- a/include/acpi/acpi_bus.h
>> +++ b/include/acpi/acpi_bus.h
>> @@ -835,7 +835,15 @@ static inline bool acpi_str_uid_match(struct acpi_device *adev, const char *uid2
>>   {
>>          const char *uid1 = acpi_device_uid(adev);
>>
>> -       return uid1 && uid2 && !strcmp(uid1, uid2);
>> +       if (!uid1 || !uid2)
>> +               return false;
>> +
>> +       if (*uid1 == '\\')
>> +               uid1++;
>> +       if (*uid2 == '\\')
>> +               uid2++;
>> +
>> +       return !strcmp(uid1, uid2);
>>   }
>>
>>   static inline bool acpi_int_uid_match(struct acpi_device *adev, u64 uid2)
>> --
>> 2.43.0
>>

