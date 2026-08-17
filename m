Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020101.outbound.protection.outlook.com [52.101.201.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12DB456E00;
	Mon, 17 Aug 2026 16:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786985982; cv=fail; b=Iw9k+QvyiiDa0ilTSxZY3YPU7IFDg7K5NKF7+F6PITN2ecYzT5HlMPilI1k+AYY3SHuxhnO1puC0oVYcbCmbJY/p7fAgrtcQQl72R55MndqiO1JKlT2s1tAc9/phEPlY8wueWlYCqLaTuMHsQTqkrsK0gvH8weIkyOlYUersQUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786985982; c=relaxed/simple;
	bh=QUpXc7Az1+BoPwBnVsyv+5vz3DRd1mLBc/XV4Ir/VdQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ly9PBIZAnnQQFfyXHqgxm4gvHYhl0C21xPs6+zjlox3KvJjzLPfgoqr8WR0c8BD+od4myPYD85ofLirpZqSkguYIf4umw9EuxPcsB92zl2L7OBdLylNDwueAtyahqPlp1/obiJDFgRxy/rNpKK/zX6U9VJ4hn34GRzP/Ci0EiTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=57RSn5iJ reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.201.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="57RSn5iJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z5P68q2b+L00cLWcgmCs6V4dYUpshZ9gUGSQ67VrDTPAxFTdtmrjGyxj0r0sOSiwj9AWKM+bJd1GjfQy1ZjDW0Pn+4l0kbig9OW4GB/TQ7jflNQ6apWs9ydvrefsqVXBbiP4uWywsRWJk0xA2pJ2hUmbg8RD7/pLdIHva3ocmaRDTaDnwxFxekAvaGdw+uelo4+sfnC6HcLUtSGmrjdZoCLaLn//F4+vWmeMDG49mthV81kY8MWZ4LSErenBj4UiJ/r8Xw82ucFnewWFpN1JyUKEorBQLEje+O2A6sgSWQXsV1yR9I8CVgj21UXuV5EUkf3RGSsKWysHcXT1XKegug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siI9v+vqPVtI4NhL9667ZrkJXI3p85x1T5vBFXA07Cc=;
 b=uTAeUOggrb4+fDBCp47D6iybsCTapMIeKg2K4BmxvGG7TF+j+MULpt4LbtcNzaq9RzqI/mbxyrfabeTCiw87Zk0PB3Td5PZsX0V2VCO13Ej/8vsyoTgiYv1QQxOstAqS7g6sIp+Y0hUwstGXRqXndiDeHTjldgBPkqS9v3LM+1xbR5Qq7YfEvIWi7G5NIjV5EE1ZxVSasyxCqtmxBEGsgEkk4BzbJNIyptdDHGCNu2/u+EVcCPYpv4ctTXNst2b2dmaqVMarrN6he5FU+VSgd4Ad/LhlqU77S+96RMeRddNGNsLMSMM45JHGBvfXmMj2/WqKESApy7CotNFRe1dXdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siI9v+vqPVtI4NhL9667ZrkJXI3p85x1T5vBFXA07Cc=;
 b=57RSn5iJFd5ayoncYd6OfRh2ziBG/3FDt+5F49hYE5O/SZDR1HJOCmyBg51DLBzS5IPOqpysAEzSdAgzob33iteHB8j9ehfNDIBFAgdvr9hBjK2oLxRFIWzBpZEUuI3GWNbzwbX3JBWoT2vOul1HURpNxFa1hZJ46H347U3MaK0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 LV8PR01MB8678.prod.exchangelabs.com (2603:10b6:408:1ed::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.17; Mon, 17 Aug 2026 16:59:31 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 16:59:30 +0000
Message-ID: <d2daeeb0-1c8c-4318-b77a-9e9142313307@amperemail.onmicrosoft.com>
Date: Mon, 17 Aug 2026 12:59:28 -0400
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
X-ClientProxiedBy: YQBPR0101CA0085.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::18) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|LV8PR01MB8678:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e5be8a0-2c99-4898-cf38-08defc80e7a2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|23010399003|6133799003|10067099003|56012099006|4143699003|11063799006|5023799004|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8RyXGPzhVCGqxvHqzqQ3NsqWDBSSyqleffOYl0AWNwovMUx2FOHWik4vEPtQ3/EcerYi817U9/WABCEoYnrYJP+G3dSlGwArSbtTxAbeys+sIXFaRRGLJSNhCKjyk8lnr7RSD2Dhye7bNsxztPT0nQFwyB8FlwLMVCIp0va4U5z8s6NZUTyM2seKyUhDUdYf8AALVBPtfe6JixRUlFUgeVfVxxJZAQoRrIxT3vCZwYQjFfJyBKOt4jOk6qYT+F2zBRpiVsCXua2TWL4w2d2/XJXFTwQTH2wPFSiq+Zz44ZNBztlcetHq+DyILjz9nLXdfEKjWoASKCJ9KlFOnf0aWyaDwAFnG4ycH+51BgQiRwOkZ2CO92swxAWpfGuPquIPktekr6DlTgLKfoA9ggSVCvGfIYBh+LmqaZFkWJFAAyBKIMeeZMAiVKhvtJDBKQ5Tsw/9QMrdLz7UdEyUWyQndpuy+3xB1RlDWrJSpn+rAgUI3tkXnaacIFO2xYj7qlM5uWe0ekZnjDAJm547BqZJIu5YM5n+j9PLbJvnRLqpIdiDdWQSKZiSY/yZvl2aK+zr1JfMssQmoUAiUJVpQ4W09Bd48A69R4V36/FkuxkAIKwZR42TXz18i2JoXKow0Q8ojB8WCop+9JJLILdb/pZj6EDq/YWZJsY1ea71/NUO+WA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(23010399003)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(5023799004)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUhDaGNENGVzTERHV1JjWEZkZ0dXTS9Dd1JrWTdRSVFuRmp6Z05FRExhR0V4?=
 =?utf-8?B?OUxEa3lHR0pUYjdmUzZITXBXdmJXbVNmeXg4MWZVWWJBZjV5djFIM0RRbDBj?=
 =?utf-8?B?eTl0b3BMbHdocTY3dDNrUklBMXdKejY5ZWRWOGFjY29KbGkxSUphSjNiNS8w?=
 =?utf-8?B?TE1nQ3RLWEhuZjM1T2pUeEVZSjZCcDdlMnZWcDJiOUViVFFyZURTQXRpWWVQ?=
 =?utf-8?B?cWUwaks2cUs1K1ppSGRCVFlDblN1M1A0alIrclhBQWdoV1hHaThjVmJkT0ZQ?=
 =?utf-8?B?ZDB3elh6bkR5MlU1MXpLR0VESmFlcUlHOS9FK2FiQjBaV3FPUGZLNkFiVnhB?=
 =?utf-8?B?SnlIdmtlSElKcm9mMUNuYStzaE1QTmJGV2E4dDdCcnhLODRBMWk3YjBoOUJ1?=
 =?utf-8?B?cHkyT3hwU252NklUNXJURTNkRENGZjJIclhtaDA1U01sRmhGRW5ZY2xTTHE4?=
 =?utf-8?B?WCtnWHBRWFZCVWk4VXhQYU93S08wRFB2MDJFVEVIMkR4WXA3aHJXWlBBNEsw?=
 =?utf-8?B?anJ6RUpDd3ZObjgvRVBCdTJiYTBWRzF1dnZxZHAvYTNrYUNyMjFhcHE3anY3?=
 =?utf-8?B?U2Q5c2tuclJBOE95UE5FMEF2c3NuaWljUW1xcitRY2p4UWt2UWo0TWZGdWFZ?=
 =?utf-8?B?bDZTWlFIalZyYU92ZS92d3pIOHZOTmtiRE16QXNwYUJEZ3VCNm5hZk1UMklv?=
 =?utf-8?B?RG8rWEJ4dlk4aFFGZm9mU1o2a21FOGZ1cjJTQ21xSTdGdUNjTDVTWlFGWjNQ?=
 =?utf-8?B?YlExOGJxZTIzUTQ3WnBxWktib3hmY1gzdzlDYWNNNUw5TFhISTBXV04xNmN1?=
 =?utf-8?B?a3dZaEgyV1RTL1JPeFNCeFUzTnl6Yk5wWWhEWXJaNkZzUS8vaU1FekZUbHpw?=
 =?utf-8?B?dmFHTjdLYmlxenBCa0tLazdlR2N4ZzVqdVR2M29abE9iakEvUWY5VEVvbmdv?=
 =?utf-8?B?cTdEZGtwemUrUGF2RE82RXBPSzBKTGRoY1RWYmxQU2hMZnVRaXB5L0JCays4?=
 =?utf-8?B?SjVKM1Fob0U5QlBQbmpEdHcxNWhvOEw1dG5kTnNNZzkyWUNKWnVBMlgrZkNW?=
 =?utf-8?B?Rkd3bmtScG53RTR2ZU1FRmdmZGx4VEN6U3lmTWkyYlhQUURuWVBndCsxTXZa?=
 =?utf-8?B?NE1oZk9xbXo4bkRMWUJ5aysxVGJqNTJ3TXRLb1c4Z2gvakdqU2RIMGMvZm51?=
 =?utf-8?B?bzdUMlJ2Ty9QdEFYYTVyK2xKcmlCVS9udXVkei9QT1FnNmVRaGRlYnVGTXdU?=
 =?utf-8?B?aUlka0FqaG52UC8zUGdnK3FTWFp0YXdTem5oSG1qQUU5cFo5a0wzYUN2ckxk?=
 =?utf-8?B?UkplZlVPQ0l5M0lPTUFSTVFJeGRoSmI4S2pKbmZpRW5CWlRmMlV6WW5CeFJa?=
 =?utf-8?B?MVhIOGJtakYrSFVjQUNRbVlSMHBMdG4wQlJ2cktVQVJzM3hpTE0wUDB2MWVX?=
 =?utf-8?B?dE1xdVhFRTArMTJFc1ZBc2ZtZ3BFUG9FRXZ2emZkemhwMURiWW5yRHhhNkZ1?=
 =?utf-8?B?QjFkbUszNFZqWm94TjRvT2hORHdZajY4Z2RnaVE1UmFNcFlveC9ndVVWYzdq?=
 =?utf-8?B?QVdyTXQzajM1RjdaU0dONTcrbjRWcC9YN1Y4MlJQYlJzaVJBYk1GVlViN1JG?=
 =?utf-8?B?dkQrdmNZb2xsWkd2NDNaRUIyL2UvZk90Z0RTdHR5MlNyRHdqL3YyYzh3U2ZK?=
 =?utf-8?B?WlJYdS9Hb0FuN2F4TlRqUjAvSllCVDFaWUNhd3hIMnI4aWEvOG5HWUdyQUE0?=
 =?utf-8?B?U2RXdUNKZThVTjY5Z2FuQ1hwajh2UFlOaUJCS1lMRHFORHR5WjdpMldwSUgz?=
 =?utf-8?B?WVo4b05LUElzeFBzb3QzMGYreVkvc2Jjc1dIbjBENjI3QkNITjdKQVdvSGo5?=
 =?utf-8?B?c1VSRlljanhiVXV3VXBDMStVRUpNZWdVMDczOTRITmlYa1huNTFtOUtHY2Jz?=
 =?utf-8?B?SlJidGNMV2xEaWE5Vk1zaU9NNUNBYXNmV1Q0eTl4bWh1SXViNVFoVWRYd2Mw?=
 =?utf-8?B?aG1VVkEvMEx1QkhPRG8zTk1rdWhINUl6ZUl3cnZqbWRBV2tGcUtlR3p3WG9G?=
 =?utf-8?B?b0dtMmFKRXJTdVIyNkhrUFJKSU51d1BQU1VSMGpZYzJIQmxUVkpSQWtVMTZ6?=
 =?utf-8?B?ckx4VjYvL0dYaEUvSmhCZlpzVHZ2SWdpNnJHUUJJL0dVaWRYRlhwQVZId09k?=
 =?utf-8?B?WktFWEV5VnRVL29MTjNCSUlzTk14Rzd3c3JrbHBUUUdPNU53akJUblBIei9q?=
 =?utf-8?B?a3IvYWN3RXZtVC9HSWtKb0szZGRNbVNibTY2a0tTUTJYYk5iclhaMXhrM2Qr?=
 =?utf-8?B?WFl3aTl5YjBEdkZGWEU5T25hcWhvNjFIWWtzcGk0WGNWcEM1MFlLNHgzUVNZ?=
 =?utf-8?Q?P7mImBoKXaRyTtmRIxj2WTaQnGJhOY8RD0Forwzt4Z984?=
X-MS-Exchange-AntiSpam-MessageData-1:
	tFE4dhvitG7vYZAChb5B58/bmfhY4javKme6ojis7SwNpcT86UKkHiHz
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e5be8a0-2c99-4898-cf38-08defc80e7a2
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 16:59:30.7666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccY5wduxyO1rUZvo1jlRmt6/Kg8K+sVxWHlDIzoOAl9IJgKJslY1BSyWMWCMtiaWJNzlKXL+uKfs2SEWr/ZsNx89TmFgFhi7JiSvNBanyVRSwQkmP/wtnh8rZfbfBMiC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR01MB8678


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

Yes.  In order to get MCTP over PCC working, and get through both Human 
and now AI code review, the series has grown again.

The Race condition you see is solved by one of the patches in the 
series.  However, it moves the start up out of the PCC specific function 
and into the Mailbox start up and teardown.  You cannot deal with the 
race conditions without doing that.

I have been chasing PCC issues for a couple years now.  The Type 2 
drivers do not typically have the issues that the extended drivers have, 
as they typically deal with a minimal amount of memory, usually just a 
single atomic word that can be coupled with the doorbell.  Extended 
memory is much more likely to trigger hidden rac conditions as the 
amount of work done per doorbell-ring or message-send is non-atomic.  
THe cases include: a doorbell coming during start up or during tear down.

I am happy to resubmit any of the changes from that series in a differnt 
name/order to get them reviewed and merged.  However, previous patches I 
submited have gotten minimal review.  I put them all in one series as I 
need the Network reviewers to be able to sign off on the end-to-end of 
the MCTP over PCC patch.

So, I am very flexible as far as what to do with the patches, but lets 
not put in half-fixes that make that process harder.





