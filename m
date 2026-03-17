Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011030.outbound.protection.outlook.com [40.93.194.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5676B38F620;
	Tue, 17 Mar 2026 13:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752987; cv=fail; b=J0zWRzAu+YyU3vd8INY9tuzMMzgr7uRjfQMqkq34F7Ox6lBo9O5ivkIhmXJ6OQwtV5hXoA6IlYG2roHaQqG7eWZpUbDFAcxEdwI+xgfEoHaTrl8uab3APigozAEUokbudnvQg/HVDcX4Tsypp77JCR8b4bHA8FeSRViZovGcRdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752987; c=relaxed/simple;
	bh=w50jTRDny+d7tKuFASTo4YUIHJmaKlvBYciQYpo3R30=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o7Fj+hOCvYO63O3Zd60NNbRyF8t6/s+ICmw5N7ElOPpSO5Ko3TLsKGOhvNfY+uqFMQUYnCcsK96qsPeBCd20/HvJBTdyL/u+4FJ2z461vCQ4lhfnD51XRpTlbK5cHX3nHsqo12pF/9FTxC1vdf/6MybcRVw4grm68xLom61e+ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IfTjTgFz; arc=fail smtp.client-ip=40.93.194.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IfTjTgFz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtAsP8GkcEDvX2hf92ynE28K4hkazqFdMTbI6pcbBExYupOLFETXYDUNBNo9HRd7+ZjnnNdTOa2MQzjQC9nF9eXyYi3HnrXpNNTEiOcezNCzwgLCEmH7JvdOV/oSGAzjhKqq9w8qP7zWfPAb8keZUQm8UF9FLoNK/W6sNERQhscwk8QrY0ofrNfLBRMT/Eq2e1QxtpOqsKz4AAi7BZdxJc9Ce+eIZHtu/OT7OOaT3tLYH45VG9njH8a4WNgB7PS3bZhv3O6visDCUfL2OgIgriX3enT56OB4nkvK3xxc1EhScJv7PxUqR/Qsy57XWXEA7PQLAUaaR7RNj5LB3c23EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbL1M+ERi4o3YaVaFCmjV7CPQwfROX8SYdDKOPh60p8=;
 b=XfCnFiLdF81HV2V647TMVY1kLgYhVM/M4+IdmnrPXG/Ym63lf5RP9t8lo6r0LjkGQRFWWQs5otE1WW1HZszTsz+wXpSo171OHH0zVvt0ecCehVF21Q5eamCq7Ht+qVgjeXVg1jPMbTG6x1TN4Ab7hGupOrWKeaesbDMy/McZIlbskmSc/h1Z1Pfy5YlhX7okZ1TBLDLIW9xShkljZiIs0u60qBQ8hM2polpFNVqdSsK4jayZo6aQkeDY7NyhhNsvW/xeYMFqzLO845B3w1YZsJ3zvNY2gy9q+QUhL651m8BPMnpZgwxoEEYpKTkKZMfnDPtWeVu0kw60EO9RU5mi0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbL1M+ERi4o3YaVaFCmjV7CPQwfROX8SYdDKOPh60p8=;
 b=IfTjTgFzmcxVYzVBD2nmiikiOoswx42dF2B+mAG1S7OjqwV2QUiGuYqhHGH/tAedXOlG/0m/HBXbgbWGq8ThuNNdoCHgKTy2NDbfSiox3HMQLppPxpXCEJAj3Acu5kLWWO0wdWGnolCF5+v+Du3HObY2qcpUMoy9PMkHJorO3A0bECoxBJ+ez3tBZOUa4XVv0tK5v5+SeRhlHupVxYPdJ/Ntr8sKSJBA5dOi2J+lXGV9qi5n6W3kPDNvl5DYv5XQ2bKlpvOIZ+2ExIqSWc7cBroATev6wuTQEJix0JWtIPw1g8T+77NmXZVWwRCgKEyhE3U5wgSU6cZSNWdWX7efNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by SN7PR12MB8057.namprd12.prod.outlook.com (2603:10b6:806:34a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 13:09:40 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::d390:582:5536:40ad]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::d390:582:5536:40ad%5]) with mapi id 15.20.9723.013; Tue, 17 Mar 2026
 13:09:40 +0000
Message-ID: <b5bbe411-5786-4fa2-88ba-c26c7baeb419@nvidia.com>
Date: Tue, 17 Mar 2026 21:09:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] acpi/apei: Add NVIDIA GHES vendor CPER record handler
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: rafael@kernel.org, Shiju Jose <shiju.jose@huawei.com>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Len Brown <lenb@kernel.org>, Huang Yiwei <quic_hyiwei@quicinc.com>,
 Will Deacon <will@kernel.org>, Gavin Shan <gshan@redhat.com>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20260316105056.28146-1-kaihengf@nvidia.com>
 <20260316170720.00004e66@huawei.com>
Content-Language: en-US
From: Kai-Heng Feng <kaihengf@nvidia.com>
In-Reply-To: <20260316170720.00004e66@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0149.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::29) To PH7PR12MB7914.namprd12.prod.outlook.com
 (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|SN7PR12MB8057:EE_
X-MS-Office365-Filtering-Correlation-Id: 00596e40-00aa-459c-fc9b-08de842672a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wB4FBZSEuaz8dZydZ8XkHdXl0omYDFVe9+YRHuC7t9X7kHLNOluzA/VznqTPRNmAIP6W7QvIHxOzMhuCKUHN+m/5DZV8ojMybz8oznUdNfr13+3VnYrYzr0/aSwmWpDj3QmqLlbU6IrAmKfqA2SBVAOQ11Hd7uBI8YqUFQ0ars25y1UZjyF1jJSmaQhO0xALfc4PDTMa42X3Zzn1cN4W8TlTjc6BsAmWPKv/9TCdNzQx71pBXvV6CUmkIP+rlXzzKu8kz831HFTmflodgt9MOccv4LogFiUxIcDtZmbs7d5u3cqs28d/zXgIbWvYtWujUV7GF+c3V2ktlnOzFQ4/WuDNCpfo4w7pshZWOX8BNHpo0WLXR/WoAfbKqe4woV6SMqwUBsQE7mDfGXA56h3cCkBtv2UhyRKktAwfH61sQd1Q9pJnvWfF8zRpARHIQvSUDyyGbb64q/3Onin9IruzYeKPDH1V6MMRTO9vxpBAsPTAe7t9ifS5EVRZCUc1LVyAzyU4+XAEO71PXpIITJQMS656z0W19VAsM5cI8Aaa3OWIabwTwH2VEezBi/2w+Mx94iy+ZBmiz71o6TliHZvcNKkw+y8WMq3g4e+pJ+eYGcuqMn6gvlGq1xxYb0EEArddEereZgQWplpYgDsIaiywrTeZQZwC/MpKdfdpIom06aaM9Qe+5elZI40BXP8hc1k5H3nOWBCKL50TWe7Nmc8VvhVOCCy4m71IqsnB2Dz+JtDxCwLfEG06z+Ws0++XPYgx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjg1VTlRTWp2N2pkWVFCYlBha2VQcjA2Wk1pOURpaS9KMmlYeWFteHR1Y01p?=
 =?utf-8?B?UUtFMFBMVi94TVdnazIrNHF4NzE1N2k1M0FIQThRSHhVMHlvc3RHcVl2dEpH?=
 =?utf-8?B?cEtlR1kveWI2MCtqTDJXZktlbmVxNzdPYlFnQ3QxY3d2alNNY0FmaDhrNUl6?=
 =?utf-8?B?WEZ3bzF2TVVGTmozc0paN1QzVWhIS2cweFhHN3VaOFlyM1pibWlhdExtSEF0?=
 =?utf-8?B?T3Fva1dYZC9BNWMvODNXd3VwK3diREdibmZXZjBRZXpyNEVHWWw5eUt6SGNa?=
 =?utf-8?B?UDN2c0RzNE5ZM1I3d0NMODExa0U1Y0tPRnE4Rklnc3NYV1BGK3owT1p0ZGJQ?=
 =?utf-8?B?OUR6WFhQNVI5VEFRUW1DRmdGUHg1NXdTd0ZXWVA2R2M1ZkM2VlJDN01jK0k3?=
 =?utf-8?B?NWUxbnNjb0pBejJJMXBvczAveXlkTHA5bnBRT0FKa29YVWN6S1F0S3V2WnAw?=
 =?utf-8?B?OEdJQ0ZyRWFwa21UTmV6VmtVR1Bob0JIc0x2QXh2dmlWTEZtQmpDVU1KajZI?=
 =?utf-8?B?VlQrSDZsVVdIRm1ZOVZ5M0ZhL2NWUFBCeGZzaXRVZlh6UkRHTTdYYmoraWIr?=
 =?utf-8?B?THNwbUZkdHdwbHdZWXkvV1dORERBWjFDbU95UnU4dE9TUjJTeHpnQVVSU015?=
 =?utf-8?B?ejB6bi8rZzQzSG84ZWpXbUpEdUJXMTZsb0dkc1dvMWxRUWswN215TXdOSHBp?=
 =?utf-8?B?YkFVQWgyKy81Z0dCSVphV3dIYmM4MiswR3dpekt0UHE1aWppTVpQVCtzcjll?=
 =?utf-8?B?MlNZY21ZbFhIVk0zOCttd3dWdGxoaVYrZUlXOVBCdTRJZTRJZXZiYjJSU1N6?=
 =?utf-8?B?U1VINmpsY2J5OFVoQlYwcDlERmh0TU9DWS95YmdpY2tYbU9QdWhxN09oajNr?=
 =?utf-8?B?UzNwVXJkR0l3OGM3cCtycDhNK1NzME8zb3UrbWJla2NVZTkxY2JEMmJNQnBi?=
 =?utf-8?B?bmx6SnhNdkhabHZDSU5IeERicGRmMHFkMjNTNDdKb2tMdXlVczcxZmhjMDVi?=
 =?utf-8?B?NTVsTUJIK1d0clFGWkpZUTlSUU95NjM0Nm1OWEVBbk5vMHkwcEtSQVVCR2NL?=
 =?utf-8?B?OXdnaTlmR0x5L3BlK29nNVp0UVpMUGtLS2Z2VHJvODBSM0VPeFEvWjlMNzIz?=
 =?utf-8?B?TDh3SGJvWnRRYWVNL2U4a1BKNFJFTWNWYTZ5SStzZEExaVBZbkVEa1F0UTU4?=
 =?utf-8?B?RXZaZFBFdUYwbkw5aUJwRjhWQjZNb0xlU3l4WGU3ZVJaU010UUlpTW5sVzgr?=
 =?utf-8?B?MGdSMEVUdmk3R0pINldnMWF1N1E4YktNNUNiWFkyUDRPVkdYdm9PYzFleUtH?=
 =?utf-8?B?TDdjaHJGNndwYndHYU1NUndNbk5Hcm43Y1IzUUhkWTZNNHN4N1duNHpTRzRV?=
 =?utf-8?B?ZWpNeDM2OGxjUVNDWUJETWY5UHdyZ00yMzZqaEhQY2FCSjdHd3JMN2wxL2Yy?=
 =?utf-8?B?UkxsN20zQnVLbHhSYjE4RkF2Mjd4ZVJXOWNvVGJOMkhWeTlXbnFwRnhVSkY4?=
 =?utf-8?B?NVk1WGU3S0xnbzJMa3JXNXo1WTAvNk1yM0o5NU9JZGRNZHQzUk5DeEo2dkdP?=
 =?utf-8?B?SXlITHp5eXBPTmtjRkRaRE54ajNYeUdrZ0R2RFJ6VER2V0pTVjhRUFhHUkp2?=
 =?utf-8?B?RVJYcEMydkJRd3JzclpmVHVJNWRjeW5DUHRjblhySVp6aHQ5Ym1MOUJtd3V5?=
 =?utf-8?B?dmo4SHBMVFFmS1pobE1scnhibnBUd09FeC92d2NJMjFzaU00NHA2L0t5SE4v?=
 =?utf-8?B?UWRCTTZxUkR0QjlScUhQaHdVMldUNTNmWjUxcHNlUHlIMDNqbWhBTDV0eDdi?=
 =?utf-8?B?NGI0aDF2YVltTktFNkV2aFpNelBTbXpicnRqdmx6ajBoWGFUeElFT0o0SDE4?=
 =?utf-8?B?NUpDZm9BMm02WmpMazVHaklmS1VsckNEV2dBZzJUZEhxMjFrUVR3QUorM0xW?=
 =?utf-8?B?ajRkNm5KbXIrSmRjL2FwTzVjMG5CejR2bXBzU2NmNW52akFrMEtZVzZPQSs0?=
 =?utf-8?B?S2V3RFUyRlNHZ1Z3bXFHOWNlOXJ2WkxFQkJXZFpHUGNxQnJSdmVmNWxSSzRB?=
 =?utf-8?B?NEtuc0k1K3hKNnkyRGR6dWZ0WkorQVdWSkwxOVVKUDluTzJhM3QrbFBvL0Q3?=
 =?utf-8?B?ZGVzQk55TEFGNFEwNjFDU05xc3B1UXNZeVRlOWYrS0RRcE5yVCt0d2t4dm80?=
 =?utf-8?B?bjhIYXJUQWU0YytnYlc1QThMY043M0JLMjU4cEZ4b3dxZkp6SUJ1R3Zkazdk?=
 =?utf-8?B?b3lFZXlMeERPUTBCZzAvY2hBbWhBTU90UkE2TjRUNHZ5TnpPRzlCMzJyU2ky?=
 =?utf-8?B?NDVaWXhzOHNIQ21oZXRrNTNaZWFUUmo3b2FHOWM5bVJpRnRobExwUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00596e40-00aa-459c-fc9b-08de842672a4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 13:09:40.1983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JyRApd/uXGp1uc1If7hGtIECJroRfL5Uj/T7baWwOFoFvDD9NXFrVF9Byuro+MeLs6CJsIE+hT0ObiiiHFiy4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8057



On 2026/3/17 1:07 AM, Jonathan Cameron wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Mon, 16 Mar 2026 18:50:50 +0800
> Kai-Heng Feng <kaihengf@nvidia.com> wrote:
> 
>> Add support for decoding NVIDIA-specific CPER sections delivered via
>> the APEI GHES vendor record notifier chain. NVIDIA hardware generates
>> vendor-specific CPER sections containing error signatures and diagnostic
>> register dumps. This implementation registers a notifier_block with the
>> GHES vendor record notifier and decodes these sections, printing error
>> details via dev_info().
>>
>> The driver binds to ACPI device NVDA2012, present on NVIDIA server
>> platforms. The NVIDIA CPER section contains a fixed header with error
>> metadata (signature, error type, severity, socket) followed by
>> variable-length register address-value pairs for hardware diagnostics.
>>
>> This work is based on libcper [0].
>>
>> Example output:
>> nvidia-ghes NVDA2012:00: NVIDIA CPER section, error_data_length: 544
>> nvidia-ghes NVDA2012:00: signature: CMET-INFO
>> nvidia-ghes NVDA2012:00: error_type: 0
>> nvidia-ghes NVDA2012:00: error_instance: 0
>> nvidia-ghes NVDA2012:00: severity: 3
>> nvidia-ghes NVDA2012:00: socket: 0
>> nvidia-ghes NVDA2012:00: number_regs: 32
>> nvidia-ghes NVDA2012:00: instance_base: 0x0000000000000000
>> nvidia-ghes NVDA2012:00: register[0]: address=0x8000000100000000 value=0x0000000100000000
>>
>> [0] https://github.com/openbmc/libcper/commit/683e055061ce
>> Cc: Shiju Jose <shiju.jose@huawei.com>
>> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
> 
> Hi Kai-Heng Feng,
> 
> Looks pretty good to me.  A few suggestions inline.
> The devm one probably wants input from Rafael and maybe others.
> 
> Jonathan
> 
> 
> 
>> diff --git a/drivers/acpi/apei/nvidia-ghes.c b/drivers/acpi/apei/nvidia-ghes.c
>> new file mode 100644
>> index 000000000000..0e866f536a7a
>> --- /dev/null
>> +++ b/drivers/acpi/apei/nvidia-ghes.c
>> @@ -0,0 +1,168 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * NVIDIA GHES vendor record handler
>> + *
>> + * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/kernel.h>
> 
> Generally avoid including kernel.h in new code. There are normally
> a small number of more appropriate specific headers that should be included
> instead.

Will change in next revision.

> 
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/unaligned.h>
> 
> See below - may be fine to drop this as I think they are all aligned.


Will change in next revision.

> 
>> +#include <acpi/ghes.h>
> 
> Expect to see at least
> linux/uuid.h and linux/types.h (for the endian types)
> here.  Maybe others. I didn't check closely.


Will change in next revision.

> 
>> +
>> +static const guid_t nvidia_sec_guid =
>> +     GUID_INIT(0x6d5244f2, 0x2712, 0x11ec,
>> +               0xbe, 0xa7, 0xcb, 0x3f, 0xdb, 0x95, 0xc7, 0x86);
>> +
>> +#define NVIDIA_CPER_REG_PAIR_SIZE    16      /* address + value, each u64 */
> 
> See structure definition below. I think you can make this all nice and explicit.
> If you do keep this they are __le64 not u64 I think.

Will embed this in the struct to make it more explicit.

> 
>> +
>> +struct cper_sec_nvidia {
>> +     char    signature[16];
>> +     __le16  error_type;
>> +     __le16  error_instance;
>> +     u8      severity;
>> +     u8      socket;
>> +     u8      number_regs;
>> +     u8      reserved;
>> +     __le64  instance_base;
> Could do something like
>          struct {
>                  __le64 addr;
>                  __le64 val;
>          } regs[] __counted_by(number_regs);
> to constraint remaining elements.

OK, will do in next revision.

>> +} __packed;
> 
> Given you have code that assumes aligned instance_base etc, can we actually
> be sure this is aligned and given the content also that we can drop the __packed?

The original libcper implementation does suggest that.
I'll drop the __packed in next revision.

> 
>> +
>> +struct nvidia_ghes_private {
>> +     struct notifier_block   nb;
>> +     struct device           *dev;
>> +};
>> +
>> +static void nvidia_ghes_print_error(struct device *dev,
>> +                                 const struct cper_sec_nvidia *nvidia_err,
>> +                                 size_t error_data_length, bool fatal)
>> +{
>> +     const char *level = fatal ? KERN_ERR : KERN_INFO;
>> +     const u8 *reg_data;
>> +     size_t min_size;
>> +     int i;
>> +
>> +     dev_printk(level, dev, "signature: %.16s\n", nvidia_err->signature);
>> +     dev_printk(level, dev, "error_type: %u\n", le16_to_cpu(nvidia_err->error_type));
>> +     dev_printk(level, dev, "error_instance: %u\n", le16_to_cpu(nvidia_err->error_instance));
>> +     dev_printk(level, dev, "severity: %u\n", nvidia_err->severity);
>> +     dev_printk(level, dev, "socket: %u\n", nvidia_err->socket);
>> +     dev_printk(level, dev, "number_regs: %u\n", nvidia_err->number_regs);
>> +     dev_printk(level, dev, "instance_base: 0x%016llx\n",
>> +                (unsigned long long)le64_to_cpu(nvidia_err->instance_base));
> So you are assume instance_base is aligned, but not what follows it
> (which are all the same type?)

Yes the following should be treated the same.

>> +
>> +     if (nvidia_err->number_regs == 0)
>> +             return;
>> +
>> +     /*
>> +      * Validate that all registers fit within error_data_length.
>> +      * Each register pair is NVIDIA_CPER_REG_PAIR_SIZE bytes (two u64s).
>> +      */
>> +     min_size = sizeof(struct cper_sec_nvidia) +
>> +                (size_t)nvidia_err->number_regs * NVIDIA_CPER_REG_PAIR_SIZE;
>> +     if (error_data_length < min_size) {
>> +             dev_err(dev, "Invalid number_regs %u (section size %zu, need %zu)\n",
>> +                     nvidia_err->number_regs, error_data_length, min_size);
>> +             return;
>> +     }
>> +
>> +     /*
>> +      * Registers are stored as address-value pairs immediately
>> +      * following the fixed header.  Each pair is two little-endian u64s.
>> +      */
>> +     reg_data = (const u8 *)(nvidia_err + 1);
>> +     for (i = 0; i < nvidia_err->number_regs; i++) {
>> +             u64 addr = get_unaligned_le64(reg_data + i * NVIDIA_CPER_REG_PAIR_SIZE);
>> +             u64 val = get_unaligned_le64(reg_data + i * NVIDIA_CPER_REG_PAIR_SIZE + 8);
> 
> See above for a suggestion on how to make this all explicit in the structure
> definition, making for easier to read code.
> 
>> +
>> +             dev_printk(level, dev, "register[%d]: address=0x%016llx value=0x%016llx\n",
>> +                        i, (unsigned long long)addr, (unsigned long long)val);
> Shouldn't need the casts I think
> https://www.kernel.org/doc/html/v5.14/core-api/printk-formats.html#integer-types

OK, will change.

> 
> 
>> +     }
>> +}
>> +
>> +static int nvidia_ghes_notify(struct notifier_block *nb,
>> +                           unsigned long event, void *data)
>> +{
>> +     struct acpi_hest_generic_data *gdata = data;
>> +     struct nvidia_ghes_private *priv;
>> +     const struct cper_sec_nvidia *nvidia_err;
>> +     guid_t sec_guid;
>> +
>> +     import_guid(&sec_guid, gdata->section_type);
>> +     if (!guid_equal(&sec_guid, &nvidia_sec_guid))
>> +             return NOTIFY_DONE;
>> +
>> +     priv = container_of(nb, struct nvidia_ghes_private, nb);
>> +
>> +     if (acpi_hest_get_error_length(gdata) < sizeof(struct cper_sec_nvidia)) {
> 
> Given you are about to use it for assignment I'd make the association
> more explicit and use sizeof(*nvidia_err) here and in the print.

OK.

> 
>> +             dev_err(priv->dev, "Section too small (%u < %zu)\n",
>> +                     acpi_hest_get_error_length(gdata), sizeof(struct cper_sec_nvidia));
>> +             return NOTIFY_OK;
>> +     }
>> +
>> +     nvidia_err = acpi_hest_get_payload(gdata);
>> +
>> +     if (event >= GHES_SEV_RECOVERABLE)
>> +             dev_err(priv->dev, "NVIDIA CPER section, error_data_length: %u\n",
>> +                     acpi_hest_get_error_length(gdata));
>> +     else
>> +             dev_info(priv->dev, "NVIDIA CPER section, error_data_length: %u\n",
>> +                      acpi_hest_get_error_length(gdata));
>> +
>> +     nvidia_ghes_print_error(priv->dev, nvidia_err, acpi_hest_get_error_length(gdata),
>> +                             event >= GHES_SEV_RECOVERABLE);
>> +
>> +     return NOTIFY_OK;
>> +}
>> +
>> +static int nvidia_ghes_probe(struct platform_device *pdev)
>> +{
>> +     struct nvidia_ghes_private *priv;
>> +     int ret;
>> +
>> +     priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> Could make this devm_kmalloc and use
>> +     if (!priv)
>> +             return -ENOMEM;
>> +
>          *priv = (struct nvidia_ghes_private) {
>                  .nb.notifier_call = nvidia_ghes_notify,
>                  .dev = &pdev->dev,
>          };
> 
> It's a little borderline on whether that really helps readability though
> so up to you.

I think I'll stick to the "conventional" one.
> 
>> +     priv->nb.notifier_call = nvidia_ghes_notify;
>> +     priv->dev = &pdev->dev;
>> +
>> +     ret = ghes_register_vendor_record_notifier(&priv->nb);
>> +     if (ret) {
> Given it's in probe.
>                  return dev_err_probe(&pdev->dev,
>                                       "Failed to register NVIDIA GHES vendor record notifier");
> which is both shorter and pretty prints ret for you.

OK.

> + hides it in cases we don't want to print such -ENOMEM.
> 
>> +             dev_err(&pdev->dev,
>> +                     "Failed to register NVIDIA GHES vendor record notifier: %d\n", ret);
>> +             return ret;
>> +     }
>> +
>> +     platform_set_drvdata(pdev, priv);
>> +
>> +     return 0;
>> +}
>> +
>> +static void nvidia_ghes_remove(struct platform_device *pdev)
>> +{
>> +     struct nvidia_ghes_private *priv = platform_get_drvdata(pdev);
>> +
>> +     ghes_unregister_vendor_record_notifier(&priv->nb);
> 
> So we have two copies of this cleanup (here and in the pcie-hisi-error.c that
> used this infrastructure in the past).
> Both are in drivers that otherwise use devm_ based cleanup. Maybe we
> should just have
> 
> static void ghes_record_notifier_destroy(void *nb)
> {
>          ghes_unregister_vendor_record_notifier(nb);
> }
> 
> int devm_ghes_record_vendor_notifier(struct device *dev,
>                                       struct notifier_block *nb)
> {
>          int ret;
> 
>          ret = ghes_regiter_notifier(&priv->nb);
>          if (ret)
>                  return ret;
> 
>          return devm_add_action_or_reset(dev, ghes_record_notifier_destroy,
>                                          &priv->nb);
> }
> 
> then we can just use that prove and drop the remove entirely.

OK, I can add the change and let Rafael and Shiju review it.

> 
> 
> Rafael, Shiju - would this be acceptable? If we are going to see more
> of these drivers it'll probably make them in general simpler.
> Only two instances today though.
> 
> 
>> +}
>> +
>> +static const struct acpi_device_id nvidia_ghes_acpi_match[] = {
>> +     { "NVDA2012", 0 },
>          { "NVDA2012" },
> 
> I'm not sure why people feel the 0 should be there - though it is
> quite common!

Will drop it.

Kai-Heng

> 
>> +     { }
>> +};
>> +MODULE_DEVICE_TABLE(acpi, nvidia_ghes_acpi_match);
>> +
>> +static struct platform_driver nvidia_ghes_driver = {
>> +     .driver = {
>> +             .name           = "nvidia-ghes",
>> +             .acpi_match_table = nvidia_ghes_acpi_match,
>> +     },
>> +     .probe  = nvidia_ghes_probe,
>> +     .remove = nvidia_ghes_remove,
>> +};
>> +module_platform_driver(nvidia_ghes_driver);
>> +
>> +MODULE_AUTHOR("Kai-Heng Feng <kaihengf@nvidia.com>");
>> +MODULE_DESCRIPTION("NVIDIA GHES vendor CPER record handler");
>> +MODULE_LICENSE("GPL");
> 

