Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010049.outbound.protection.outlook.com [52.101.61.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0894635F5E8;
	Wed, 18 Mar 2026 12:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773836710; cv=fail; b=KXGtJtNd6SlxZVbyMtMnPHUsR5pdVIJ7MkyIduBd8vcTCRdpxvbC7LJAmormjT8UfnS1Fmx3HiFuqNAv557j1bqCYwRMT41KeiwgwAnTNl1o2J3PbNkoGX10jewGdXdbbO/TT0W12rFixPj3c/QoIGSNLsIEXQ9fauG6jcC0H7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773836710; c=relaxed/simple;
	bh=94XllczZycS+L1f5KCBlH/QLrE9yPCKKcHMR2zfWsdI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ukLngMXiwdszwZoxeiwH3f86TXKv2XvfV8YQR57dymJ/I68ka6Faz0wMlTWUKV0hNyx3s+J1NiXWyv/7XK2BfsfcKAIayqDUUnBcaqOF588m3ZbUDk4QB6Agjymks8KnC4lfY+uSrpi0jArrd6/FTDKgxf8ysaYPDINzBKEFnvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2sJu1tJa; arc=fail smtp.client-ip=52.101.61.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2sJu1tJa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v4myx0BdARe6ldWAuLma3ijY4P29ox9Yx47PFZlAInebogLD5Qc6T7k9NwDf1c1T/vRbrFZgnKWX9i+MeLjZ+qEJyv4SCL2mK60kS/Vo4gL3108QWyv5qyiCfdtbOZN3XLuZ/aN5Fb6pZY069Ik6TLL1D7EJGn1VQ/yGSOTlOIcgedT63iwfehrlTKyhlPbZG0GkdHwR0MJzkepyrpymDgJ0Jb5cqn0f9r90m1ljtYaNkZQNrmbQthdTvOn7PsnBG/KYg15HvyIe8KtPZDAq5b4QGi6UUqAP2Oj0yLRtp4BHiGhjHnloVy6R86QDKO35m1xotTOV/mFSnWdVrX9kRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBmAGn1DGDc1pmKpFrKyqCSMFBzu5n6XlM7McItMrFM=;
 b=bOrfwni3IWrM6pSBO3iCP0hjcs4eXKhhD1JAvaXXPqeRszQLcr+kd7DrR8gR0kqKPqEWn9tsYbdWi591FfzE+tWKNoMIgvJGpZ/b7PiULf/4tfcAMD2fIG3w3atPGA7dwf4CCqvshbvXOjjA2cBaXRaUu1MgFAMw2m2z9riTX5mRZggxbM3KsLs5mVnkz1TKUtTIwAeqlPw+ZXdA73ucIl6UzSintc5Y32HDJqhf9yRkq7LhFRyeMA/Pbr0fwYVvxnLVMYRFdgPjqnl6By1tmuSADTW+NpvN6cY6ryeHAC7yRCQ5b0xjR0xJx1YfiX2uOo7zdZ/BJniIi2Y3hkxE6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBmAGn1DGDc1pmKpFrKyqCSMFBzu5n6XlM7McItMrFM=;
 b=2sJu1tJa2GkUseVxc9Gf1nxoslmzSsInBm/UhJSHfrKs2oYlDsJu7PuJuekF3kg5sM6JJ5A2D8/jkWuc8wwvhiNKhqEXWMyqPvHdeVdT0i9nbmKvMD/23aG3bIBqWyoI9SsboSRFuanqo1/CWVEIFBHFggQbvejJnXX2OMFMvGo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB9501.namprd12.prod.outlook.com (2603:10b6:8:250::17)
 by IA0PR12MB7626.namprd12.prod.outlook.com (2603:10b6:208:438::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 12:25:05 +0000
Received: from DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::4564:457c:524b:6b96]) by DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::4564:457c:524b:6b96%4]) with mapi id 15.20.9723.014; Wed, 18 Mar 2026
 12:25:04 +0000
Message-ID: <fbbb22cf-bbf4-41a0-9146-3da850318b86@amd.com>
Date: Wed, 18 Mar 2026 08:25:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: bus: Fix MFD child automatic modprobe issue
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>
Cc: lenb@kernel.org, mlimonci@amd.com, bin.du@amd.com,
 alexander.deucher@amd.com, benjamin.chan@amd.com, king.li@amd.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260318034842.1216536-1-pratap.nirujogi@amd.com>
 <CAJZ5v0hhVv5mpoUYx21LcTk=gAtn=HgWB-6zvAvzXmTrPng4Bg@mail.gmail.com>
Content-Language: en-GB
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <CAJZ5v0hhVv5mpoUYx21LcTk=gAtn=HgWB-6zvAvzXmTrPng4Bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR15CA0027.namprd15.prod.outlook.com
 (2603:10b6:610:51::37) To DS7PR12MB9501.namprd12.prod.outlook.com
 (2603:10b6:8:250::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9501:EE_|IA0PR12MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: e1cce41d-d377-4eae-021a-08de84e96243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	cGVEYPeOHgOi0/D7ptsSJye3VQ63fjBrUX1DCOIF72+6s3lz9UonyrmorebIbHC0WfQvwSNbYjaykVNUhkChSjcwI1SMdvRMfHB/qi1aDUYxkKQ3D2+YGsziL9MN2phxFoZHY3AXPlFskBsUzZHOj3tPLcaazGzswR0lKA0H0WY/nMsZuTlMiKvk+xtzje3fsHMAsxoD4F1yHjqiKCd9de8iV99VJPogOgI01LhtEgIZS1DOd5FPr3S7NfOsZjDu2CwVJyKyKT1ZmxsTlP7kxEGEzhC6qVXSURE5jxAto1OrqzYqtpu1OUkx0sM/xOfhhE4Sn4C1IFzvWFFh+oMOr6N2p5+N8tfCMwSABVHqGW/1NNnmNLlJBjjjI/95VVaIIDRlFrYm0iwv9zyiW692y5+AtzqIQW6ZJYQ2UBamFFQ3H8m5iE0LxYMszrpgXTiOmR0ImC+M21VS49k3ErX8+0HDdDV+QhDlY21a6l3ohaCTcPrprt3RtRkBsvaUk44kfkVqzSyPwX/d4urpR7thdiZPfa8UeuprI3gcGwl5IMDagwu4mRAY9caZSXT4974FhfqmBadiMKdUHKvHm5lSGIlwlNz4XoGMyJRABhLiaqYPsynJpBOhBk8vAwmO+KqPUwxCiTkPqsz8TVlMo9HhvM4Kqib6EFbVb7IBfimfhlcJSFzG70n23Pf6+bVB57DghkbRu9hQ315RoiAcJ4bf1ep5sRsph9Et6TcJV0z9W9Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9501.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3JnZ2o0NG1zV2xnaE45TElITE0rdWdYUVQ1dE93aWpsYk1lMGpMZCtCQ2Jm?=
 =?utf-8?B?cWhFSWFrT3NGSnMrWFhCVWN3Z1RZRE9zblo5ZitoYkR3SEVNNC9ZUXhNL1Ba?=
 =?utf-8?B?SjlGdFpsQzQzTE9CcUtmajhKN056OVRiVHp5R05FQWdXejBnTXdZV2RJS2cx?=
 =?utf-8?B?RmtiWGdPNUduS0xsRm1pdzBtYnI3STdVOXNUb1plUS9OeEU4elpER2kycmVZ?=
 =?utf-8?B?c0FPUFN5YktsZkJ6NkM3L0x2RWRaY3dpZzBMcTUraWxJcC9GbWNrbDVDSk5R?=
 =?utf-8?B?cXB5VkVUbERqTHZUR0VCczhBWkVLTm5kQlhUanc1eXliQnlWVGVjQkZvOXBy?=
 =?utf-8?B?bEVPazlDREQ3OXh3TG1yWjdvcDFVaGJDODRhNUVNZzUxV1piVzFoTnJTVTcx?=
 =?utf-8?B?YmgxSkF4SFlXQ3BxK2dFbUlrMGdyYjZUNlEybnpFK3c5UW8rc0hpUm5Edzg3?=
 =?utf-8?B?RmVhYW82MkptN3hoQVJYU1FKc2IyY3grNFhiL2syS0hMenZaQUsyMUdQVW5h?=
 =?utf-8?B?T1B5bjk0aDd0RGZGaDRjK3VIaW9TQTRoS2YzRi9EWWw0YVAzUXFKSnRjaEl3?=
 =?utf-8?B?VEM2azlDbE9PRTNveTNmeHNZaWo4UXR5ckZHTStYOXZjM3RjKytIUldaZGw5?=
 =?utf-8?B?eko3dDQxZ0pxVzBLa2lNUEUvNlJ4elQ0L2RmK1JwT01YWE5DczhjRFFBMDl2?=
 =?utf-8?B?bVRiczV3Q3YvbmpRRlNOS0wrVmFlVEpEWGVqRHFVbHZiaHF4UlhpYWJ1L3JS?=
 =?utf-8?B?bmwvcGdDTG1qR3VGN1JQRGY0dWFWdGtYMlUwYjRXajVpRXVWbXNEc2lpdnE1?=
 =?utf-8?B?a0U0ajVEamhNMU5tYWI4bmZtQW42bGNaTlpUb1lJUFU1cnlBQkVxTGgvTCt1?=
 =?utf-8?B?RjVKamgvcUgzWHhmRzFiNDAwaFM5QldkYXVzT3JLTWdmcXpML00vaVpKTlRW?=
 =?utf-8?B?Z0gxQi8vZFBhMjZPbWM2Wklpd2xLcXdudFBuRDZWNzlTNmhmaHI4S1I1ZjZB?=
 =?utf-8?B?Sm5VZE81N2s4YlNwYm5PamVQMGt4ZUlETmJxZFdPVlRIRTFFdU5yQUJGd1lQ?=
 =?utf-8?B?WGdqcW9uWnJac3VZZmhSbW5PK251aEhtbFVzcVpPaHF2TzV3UVIyVTFCRXdp?=
 =?utf-8?B?bHVTNmdZMnhPWDZOTjV4ZFdjZmErUUtMYjI5eGN2UWUxY3o0N3hoOTdvOGNq?=
 =?utf-8?B?MEE1NGVIRHRRMXBzeVVnNGVFYVN4ckIvVTBmSUF3SjhaazFoZ3NlRmU1Q0Z5?=
 =?utf-8?B?aDU3L3hOR1ZkNzZvWWY3dlNHUnpmc2tPeGx5T3lQRHpVeW5WOWlSTHZiQ2dM?=
 =?utf-8?B?cGNvQkErT01rZ2VhVWVRdmhMWVF5YVViSzNiK05saW83Z2thTFZ2c0FXaVY1?=
 =?utf-8?B?cnhrQkFKclhaR3pKUTRXNzZHTkhGcENKZUNHaldpMDZpZnRRTEloUEhLYVkz?=
 =?utf-8?B?Mjh2VzNyQTVaanpwRXJNdzA3YnZFSXY5MTdlS1J5MldTQTFHdWRpSGtpZkJ3?=
 =?utf-8?B?bUZ4RXNQdVQ5WGpDRkIwakVFOGQ1eDlXdWtiMW5vVk9HWFFyNTBaVUdJRmhQ?=
 =?utf-8?B?c0FPR3VDMFZVUzJpMGF1OWVWN0pBRGg3NHg1NVlGUSttZGptYXNPVmxYQThB?=
 =?utf-8?B?bGtydXhFV3FGVzNGdDduRm4zQXlaV3dmY2h2dzlNNm1SL0c5THB2MUJxOWhM?=
 =?utf-8?B?bXVOcGhQUTBpUi9uRVQyLzhGMFR2alNnYXJ2aWNYYTlwWlVvTWZaYmJDanNJ?=
 =?utf-8?B?ZW5BVWVUVUpoY0lNSHdENlJjTHNzc2djczRuYlh2U1VwbTZCTndNdmNUaXVT?=
 =?utf-8?B?K3hoMW5FT2RBZnZ2WTJwL1c1Y3daTVVmSHR2OGFIS3dBclVoQWZwZTFlWGpv?=
 =?utf-8?B?WWN6RGhjVHJNN2JuUSsyNHY0YzhSVG1TamJFaTVJNzAvc1ZxcE5qUEtmbUpH?=
 =?utf-8?B?QUZXMEJVQkh2L1pRZ0hNNnArZ0FJMFhucWxmakE5TEQ4N2xHT0tIN2V5RW8w?=
 =?utf-8?B?Wmk5VEJtaTg3bGtJMUx3QU5TbWQ2Z1BYdUVzYXk2U29NSEZaZ3lGNU52cktp?=
 =?utf-8?B?ckdMZDMwOGV3QnlxY1ZQTkYrL0dlZzkwYkJVTW9Ec2JpVHAvTXRlcjdxenVG?=
 =?utf-8?B?Q2ZNZHpqc2M5R3BwMHZVK1EyZ2tSNVNOY2pqOU05akxQd1IzZ2pUTndONVpw?=
 =?utf-8?B?ZTN0R2VnNVJOemc5c3Q5VEJQeWRubjB4bW1lc3B6UHMwemtGRVA5a211cFVP?=
 =?utf-8?B?b01MUUNjaGlLRWtVTVZFZm9aQVdIOUhHRGY2RUk0bjU4RDQ3a0xxYXZ2U2dM?=
 =?utf-8?B?MXhvMWJXNG9aeHVwMnhXV21XU0J2MUttQjltNDNIRG9IeE5qZC9EUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1cce41d-d377-4eae-021a-08de84e96243
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9501.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 12:25:04.5565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y26ZBz9tCYcO60kimdFOca4S3X8pc4f0P1isWAuYDk5umoZblDFTh2b13eDI4Sm8uVO0Ti8NpOdE/xHGr3V23A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7626



On 3/18/2026 7:02 AM, Rafael J. Wysocki wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Wed, Mar 18, 2026 at 4:49 AM Pratap Nirujogi <pratap.nirujogi@amd.com> wrote:
>>
>> MFD child devices sharing parent's ACPI Companion fails to probe as
>> acpi_companion_match() returns incompatible ACPI Companion handle for
>> binding with the check for pnp.type.backlight added recently. Remove this
>> pnp.type.backlight check in acpi_companion_match() to fix the automatic
>> modprobe issue.
>>
>> Fixes: 7a7a7ed5f8bdb ("ACPI: scan: Register platform devices for backlight device objects")
>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>> ---
>>   drivers/acpi/bus.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index f6707325f5821..2ec095e2009e4 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -818,9 +818,6 @@ const struct acpi_device *acpi_companion_match(const struct device *dev)
>>          if (list_empty(&adev->pnp.ids))
>>                  return NULL;
>>
>> -       if (adev->pnp.type.backlight)
>> -               return adev;
>> -
> 
> Good catch!
> 
> I forgot to remove this in
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=acpi-7.0-rc4&id=6ab3532b4c98f4e51969f0e5f3fc919c535f3ce1
> 
>>          return acpi_primary_dev_companion(adev, dev);
>>   }
>>
>> --
> 
> So applied as 7.0-rc material, thanks!

Thanks, Rafael.

