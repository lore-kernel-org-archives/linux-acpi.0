Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021119.outbound.protection.outlook.com [40.107.208.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D466B221F39;
	Mon, 17 Aug 2026 17:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786986404; cv=fail; b=MA8kYHS/2qSA12iXgJ7pUk25d6C5NZA7j9dO2+Jf0pIIlUsJvUYOxzZaUtY46g+8btGY1zxnpmNVI8iGgZ9rxZ4WvAoJRel2jAKwGZU2xoT+Vv4nqgBnexfPwEzEI1Fu95uIKW6j7ZjMRSQ2GFMKoEvkp8+9KBpRWbtmHxHWkQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786986404; c=relaxed/simple;
	bh=isyr4VPZi8W2DSvvBb5I7A4EXaLcy7cwYHdSaCP0y/o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EfPgyQZ1uds0raFBrBo2VhiPLcroETS84GEi+keKD+hE+C5zmBBtYS5ieOG6cMjjEu0DisxuvKgVq3an4fkvUJsGjmM8GiBEf6PMEoPPolGlDrZLdf4bZW/QRM7ACVzp9yS2VMitpoCqvXWKq4X1Z2KuHl9oU6vKswhLp9tBUsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=e9g2pnpc reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.208.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="e9g2pnpc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNGWbX2vCpm1R6JbCOXvbBX+IstpGvVzTei0XTi9fgkPcNs3TSYOXBkazjwkvNcGCIHEXEMZw9Nhv6tVBpiUst89L3eTnsVNQsgOUX5j0cydXteseaOVX9QSoZSl3lFiHKFsg9lc4jCTEx6ZI87S/fOycpY4byvc/7on0oeRJvd/T+oy0fsFXcc5c2xOK2FSibnjpCz8G8asGfPSjc5155hMWuZ8aQyynHpMdtm3oaD2XmhIFNhu6PWxMwCXHfImfnS5VuFg9T6yl3C4SFCNYlfrPbZzIDNxAOh+HkEjaI8A1wEbLLMqYF918RQWwfURi/ejNLuIK1FSYQknEcRSsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDfVliqRBftvabLtJ9BdvLdYGMJL8c2kXaNXBFiJVuA=;
 b=gEUSAjZXXjgJv/eFBtQ5rzdtZOaCP+G1Cla3qQ1BYMYmHxVBPoqMr+8dgi8NlDijDFCjXJ93FI10SKQyFWjn9sEFdbqL2BYJin/dEnqoXQy+kkotjc4W4khKNcnGemSy2FECj7Aw7qtBKQiYBQ2sN2CxvFscwVSw3n8SX4egBPudRZLWTMyF1e2z6deICAIXDPc6e+SaUMWWoZBz/C5nAO8Gazl9DOnW7f1GmW2ojuk+wrZT5AWjMZkHk0kAauYAmB/f3pjGsGajz2qTCTnQ3jraIouee8c20hy8xoyNylF2+aiXFDvbowUjxfoIkGVnZjLec4/WpHjrsXjmrHr+Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDfVliqRBftvabLtJ9BdvLdYGMJL8c2kXaNXBFiJVuA=;
 b=e9g2pnpc3+e+Mwln//EhI39pnt484gzNxIBBiPZBf01YH/XayZgItKwDx6hG6MMx3Bu3A4YK0hlC2R498xkDlqjrxcuxWAo28Y95VjWAxog6uXGhhu6osrjlb/+BXbKgE8c5cQ/l5Xz/1UomK0ey/rS0Ue6ThS0CQOVtxwA6Exo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 BL3PR01MB6932.prod.exchangelabs.com (2603:10b6:208:357::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.17; Mon, 17 Aug 2026 17:06:39 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 17:06:39 +0000
Message-ID: <6901c700-d19f-4e63-b23d-c5f746ec0898@amperemail.onmicrosoft.com>
Date: Mon, 17 Aug 2026 13:06:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailbox: pcc: Free the channel before unmapping the
 shared memory
To: Breno Leitao <leitao@debian.org>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Adam Young <admiyo@os.amperecomputing.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, rmikey@meta.com, kernel-team@meta.com
References: <20260812-pcc-v1-1-5a94d2cc26cc@debian.org>
 <1a2fb06b-a5e1-46e6-93d8-829b7419142d@amperemail.onmicrosoft.com>
 <aoLVnCqlj3ffTd-e@gmail.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <aoLVnCqlj3ffTd-e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0092.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::25) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|BL3PR01MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: 83bef88f-e567-4367-3feb-08defc81e6e6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|366016|1800799024|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	EvF2PkpxbdqqnBl6aGniZiiWoH6i1ufZ55eKEyIRmubcFpplebeLPCZ1mb9+ZvkIxMdCsA/Jmvf8mrkmeLU/aBBUeJ9bqKvBS71/UPOG8YkK4DKan0oOA4/kaG0evX7a1ZqtEYrPFrrAzKps/MBDWE2yhDMUyDaFsSlyvP5+zNNvXZO1bAJ96sWO4nL3iOiGAw+INJzq5ilxJTP1usH6M/Pjk7xL+XKMeqdfq3U/3U+pte/7SC2vPuIHdPDhQfZ/q0QvwMSKPm1WSC48mHYBCbo0dW2c549cyJi/xwG8rw8WscBp1Z0AwDEPUaS3+0eQaqqsIIw2p2q3LtfieeV8gO6sqDPAiDc6dZMDAQYap4v1kn4TUrXkE+LNFlVc5ifBswFVb2KK/y01KQxzVSZdgLk8VNX9lu6BZt07dno5MrljrI8V3N/4cyZu1nAr4omW7TgAsVQJQ8GOFG1i1AiNYDW2vv+ao+n9lgNrILtvsT6qhap88NUT5GLIkzezsKxYGPVjW0JfzjyhxmbYwhCj62lsvaMHzKkgm6Hv/obKIAIdLuoUbefO56WA2l5qMa3SEKIwXPazYcx9wRbdGzMGn4i0VY0nbWmwOJf0L0nZ3Ls7K5NfMJZ8g0HfGS6R0VItJn+2F0eEvGprc58Mh/KQc9qCzG+dp0c7xKXPO3zOCUg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Snc3RENNdjdqR0hpdEFRRkFZTHJSeU9Cd3hPNXVCWE5INEs4T0VKTVJSRVJq?=
 =?utf-8?B?dEVOc1QvQ2NJbVRmczlWU3hCRVJPQkoydGRsc2s4aDBuS3h0OEFUaklVWENW?=
 =?utf-8?B?U0RFTWV4VUQ3bk9Cd1NZWmhrbXhXMzh0L0hMMlVDdU54NmN0SHZpYXFDbXF5?=
 =?utf-8?B?VUNYbkJkQlBkQmJ6eWlCWkxnNzVpVkFSOWVOc2NHZWcyRzA5SVpTVDd6M2dM?=
 =?utf-8?B?ME1NbzRoaWh4d2lRdUJMc3RKTzlQcDZPZ3F0VVRQQ1BQVWo4eFZia0lGaDA4?=
 =?utf-8?B?Q3AzZkcrNnFIUlo4UWI3eFJFNFY5RVUrdWZPVS8wNHBQMDJyVWNxRStybnlM?=
 =?utf-8?B?aWo3eFBteGJQKzQ5R3dvSGJKaVlnOWtKMDg4cVgvNjFZSTVoc1ovQWZBMWUz?=
 =?utf-8?B?aXdkcXJDVDc4bWh4c0NidlpLU0o2OVAvK0tuWXhpN1N5U0FERnpsd0t4MTZ2?=
 =?utf-8?B?MllMV05sdnc0VEp1RStTZndpcmF4R0VVeTJNa1Zxb0FxRmQ0VlZTQVJhaFBK?=
 =?utf-8?B?UnhuYk1CZkh4WDJQQUdEMk5XMm1CaUpCWVZ3U1RMMHFrdVd5cmw3bGRXb09v?=
 =?utf-8?B?bXBnUUxsK2lnOEpsaHlxRXNpZG80YW9zZFV4cGo1bnlzN05oUElyOWYwa0Nw?=
 =?utf-8?B?a1VvU3hZZ1A2VTFOekYrWVNZWE16VlBOVEE1cHc0Nzg4a1FDRVFjazRtU0Vn?=
 =?utf-8?B?M0ExRzFZOE4xdSs0TEkxUkdnc3hNWWF0U2JickFvYXRIdU1CZ3ZtSUFURUMx?=
 =?utf-8?B?dC9XY1pSTmxFZ3BHU1NSOVFNNWU4NVE1QzU3Uk1vSVZUaDlRbWhnekpEYk9V?=
 =?utf-8?B?bVo3aklLeFF2UXFqMHBWcjhKYlcrV3E1ekVnUmYycHpaSHd5ajNkNzJBQ2Ir?=
 =?utf-8?B?Z0RwMlB1dEVOZzFucnJJOGR0VlpBclU1TVlYb21iRXV3b3RreHN4M0o5ZkI4?=
 =?utf-8?B?WEx4aittL1RtZVRuU0lFVVZ3dzdpdzBabk4wcnJZYmZ2YVBDQlFvWG1yOVQ1?=
 =?utf-8?B?ZG8wS3lJV1ZnQURWb1ZKZFlkRHZOQ2JvUXgvRWxsNy9tWll4TFMwYXhDVTZo?=
 =?utf-8?B?TlV3aitKdFdZb2dZMzVESFdTRFgzeTNxMTZCckQ2bWdPMHdSS0p2TDBSeDJq?=
 =?utf-8?B?eHNmM3BPeHl0d3M1SERWV1NMUnB6NGtoQ1RqUjllOWZNd2ZLOERFcDdyVjJq?=
 =?utf-8?B?QjAyNUNSWHdnSmlnNGYreUdaUUlVNUF4QVFMUFBLRnRFT1hGYm14NktYbzQ1?=
 =?utf-8?B?TE9BRk9DNlJqSjdKcU1HNTlwWG9odWFjY04ram9EeVZwNmFjRUhPanB4MEs5?=
 =?utf-8?B?OS8wK0w4S3NTQVJ1TGlHY1ZuOXJPcjZPaVRoV3RoODhMTmpnQTZvZzBTRGZG?=
 =?utf-8?B?amhhMGFnU3k4NEpLalFWWXBRalFDc2xGZGVLc0xlbm5LR29wZjdWRXlqZTFy?=
 =?utf-8?B?N0tjandSYkQrZkNkMHRvbEhkMitLcjloa1FYdjEvNWVESGNqdDFSM1ZiNHZv?=
 =?utf-8?B?akFTNnlBMUlibkJhSEJDL3VyYTIyY1daRndvNGFBK2pleWlOam51SWxnYklm?=
 =?utf-8?B?YnVheGRMZ2t1Z3F3c0taOC9qQnhJZDllWkFCelJpVnlPZFA4d3luOVNOL0ZY?=
 =?utf-8?B?R0hHa0U2d05QTjRkMzVYSkdHR3RWL29IMVZPYUFQbHRpekUvS1Y0dTRBcGpC?=
 =?utf-8?B?UkFBc0FqYjYybVF3ZGJDSjltSXpJemRGMnlsU2l4QlZNSENTTnBCMFV6Qzlm?=
 =?utf-8?B?UUE4ZWRkMU1yeFJzR0dHK1BKelViSTd0STg2UUhBVUJETWVZY1loY0RrdjVL?=
 =?utf-8?B?YmJBNklld1FMaU5tNlc3bitNcEU3aEdVaG0rQi9aRlpUMmhxTTg4MG9ZeFZ3?=
 =?utf-8?B?VnRsNXlHcFNybUo1UlJkM3JHRWdJVmpxOEwvSk1Jb1FnVEI3SmVoVlVyZXJ3?=
 =?utf-8?B?VE5ITU1zRHRDTjhNTFdQRUxEVjd3MmI0M3JaelBxZHB6RTN1OVVFa2F3cXlk?=
 =?utf-8?B?M3NJSXYvTjhEczJRdVo2ZkNFUDNNbDE2WEZ4WHRqblJpR0x3Y1pLWi94S2sy?=
 =?utf-8?B?a1dnWjZOd3lNb1Q4K2hPUG9pWkdYTzhMekdLZEd4ekNOazNyKy9Yd0ZPNDJH?=
 =?utf-8?B?dEY1dDVCdGEyZ21TNDJKck5jTi9BMWRqQzhKbXlmc0tNTFZJbDR4TGVOdWZv?=
 =?utf-8?B?aVZKejdJYU9FYWdqT3JCbWVmUXdnd0VnNGRJZU4wajBIMlVWaW9PdkFQRk9x?=
 =?utf-8?B?alpHMXRuUVZQUU56dXYvM3ZPOENSQ0dJV3RCV096Zm1ycnZXK3BYaXIwVFVm?=
 =?utf-8?B?YzJicU41UCtNZSt6d2JJaFd0bmlSZUxucG5rQUVFZWdNMnlFdERGaGN6ME1o?=
 =?utf-8?Q?lDYi10tlpLxV3mOWJKX8QTGbmRLZWorYKbwolb9XdSJPl?=
X-MS-Exchange-AntiSpam-MessageData-1:
	tnldYw5V3p3MXVIiP7NSL0LmaEVLcMVCrE4lv9Vo9GXF+hz465bpAAwZ
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83bef88f-e567-4367-3feb-08defc81e6e6
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 17:06:38.9579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x4t7H/B88wpbCcLAEx3xWf9OmRPaZS70kPM8ZACGTfiSjl8Z4iwJdk0B5KzW5Q6l8EGl9oooq127AKUVFOf/c8B8jNxLxq+Lhr9ayUvsNJk6s/5vpQds/9OM+M5KZr5z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB6932


On 8/17/26 05:42, Breno Leitao wrote:
> Hello Adam,
>
> On Sat, Aug 15, 2026 at 11:58:16PM -0400, Adam Young wrote:
>> On 8/12/26 08:36, Breno Leitao wrote:
>>> Free the channel first, before the memory unmap. mbox_free_channel()
>>> calls pcc_shutdown(), which frees the platform interrupt, and then unmap
>>> shared memory.
>> I posted a related fix undere the MCTP PCC Driver changes.
>>
>> This fix is necessary but not sufficient to deal with the race conditions.
>> Take a look at the series of patches under here:
>>
>> https://lore.kernel.org/all/20260721175258.87600-1-admiyo@os.amperecomputing.com/
> That looks like a much bigger series, with new features, open discussions,
> Nacks, and already 45 revisions.
>
> This curent fix is only meant to address a real problem (user after
> free) I am hitting in production systems.
>
> My suggestion is that we get this real issue unblocked, even if not
> complete, while you keep working on your larger series.
>
> Thanks,
> --breno

There are two patches that address this issue from that series:

This one is, I believe, a superset of the fix you put in.

https://lore.kernel.org/all/20260721175258.87600-2-admiyo@os.amperecomputing.com/

Note that the unmap is moved to the mailbox teardown function, which 
happens immediately after the IRQ unregister.  Those two operatations 
need to happen atomically to avoid the issue you saw. Thus, I think your 
patch is insufficient to actually deal with the race condition:  it 
needs to happen in pcc_shutdown.

