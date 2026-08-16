Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020108.outbound.protection.outlook.com [52.101.46.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7424A305678;
	Sun, 16 Aug 2026 03:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786852706; cv=fail; b=W+om4nBHXxv7yIQ8qA09O6HXMMswXR0u7/8TxSHMmeCmpdAmggAiMncWKaIFbeEsW75FFvssTqpd5p7cHdx8JezdvrOVLwfkrmg9jJP+jPX1yw4/qbOfuReeRQIJhkIfkTxqhIcgtOrgSu3KQD0bF4a0iaKEa9mJ2kA+htaSxII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786852706; c=relaxed/simple;
	bh=Hj0mATNOxpwhOdDBObU/m/J5r3wr9ooh11GWFsH6Ikw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i5mToUNEpHWRDo58QH/C5lxwb9tozCHm/HTJY27Y3xlwOnlYK8KRLfPEJHqW5nsdrxV5j9887aRbb5kDCHycpueQnINMMqAH5BNQnRdWddENX8Yd1QSr7qHvKVeulY8MueUVNmEh9ZOx8v6NKuMlXlM8IMP7+wKanXY6Aah7lec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=vcG9d87H reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.46.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="vcG9d87H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDXBVi/Cn839WlDyfOdwumJZkZaRX+apUARZK6phIDeVnr2Y2HJW36ea0mhaUnWsgCNA6zk6knogHRMPno/FGku0VkGkFvqUKUylRYzBddqzbPOjp2Q6u/HJ4lSy0hAm3fzNgu6rfUUum6AtrzNUZhJ1PEMtyMiT6BBWHU+ONbVgSm0d56xYHfnTn6u1sRRE4GthEtvRyV5L6DaKLvLXIUuFQilQbSxOwxeOK2guN8Eef0F02m8X9wDjvYi0VmZ2/lXq4HKUDl0IeOJkzAuvj1CFRKjdBwhjxzZFprTKJlHhsS8Kfw2MviAqa8LapqCTzpBH2m2Bqh2ZjRyuafd8AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgxKURtsrgndCeifMwFJcWSUlZc1t6r0IRtW0+zLseo=;
 b=aZWeir9839waVI2JcV2l8hY5c9/pPhA7JzdRNvfeynHyCHsMewoVz76K6en/oO6u6RcrYCNt37LSQGGjNue2Y/QFDNEhc0gtrz7R/lCGdJFryyxJqjZ34/IXUHp/EQZf8XPgz+jDTVFEw5LB1voDejAQ5SmmpV586AbW/f2WSZtxQvyMc11ukk/YOUwEAPMtdz18Ggj5L5hqLyaajN3no7PdH30XiNz98+FaScOCCFj4JraibjpkwqvGpjbqxfemAJ6MXVG2ui7brwyzp+PE9Rm8BMk75hPdFdze+nYbHiGvDd/B0daYe96HcKALVN7rYPAFo1+yN58915p5ZxmNOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgxKURtsrgndCeifMwFJcWSUlZc1t6r0IRtW0+zLseo=;
 b=vcG9d87Hh/nlVrm/UmskIZ91qct/bpI8mww63f3I/8haLmD8JwAfJYZyYiRz1rvMp1rZYVst8qWUsx5autdoD/waiyo2VSU3mfFAszb9AzWYDBcHOttN+6sibaR6NN4yN4a6GOYoJfwkORxLMuOqiCq7Rzgk+TwGXRfo7nn2P0k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SA1PR01MB453621.prod.exchangelabs.com (2603:10b6:806:51a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.13; Sun, 16 Aug 2026 03:58:21 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 03:58:19 +0000
Message-ID: <1a2fb06b-a5e1-46e6-93d8-829b7419142d@amperemail.onmicrosoft.com>
Date: Sat, 15 Aug 2026 23:58:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailbox: pcc: Free the channel before unmapping the
 shared memory
To: Breno Leitao <leitao@debian.org>, Sudeep Holla <sudeep.holla@kernel.org>,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Adam Young <admiyo@os.amperecomputing.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 rmikey@meta.com, kernel-team@meta.com
References: <20260812-pcc-v1-1-5a94d2cc26cc@debian.org>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20260812-pcc-v1-1-5a94d2cc26cc@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0271.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::6) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SA1PR01MB453621:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db75970-92e4-44f6-1a32-08defb4a9bd2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10070799003|22082099003|18002099003|55112099003|11063799006|56012099006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	P8ffFEz7MR3A1eT9pz2mRAZz72NxuFLpjkLhUgNutGStJCaWtr2VoNHHXCJd5Fr8DSBfAmYtbb85dhdQ2gnoPYb3mProlYUOCGt/nveunZwVfxhHpUdk2F+FtJBMb9wYXUeUJBmqvBSU7DbfMO+zVjNFwlSIDpeOhEQmyl80pKqwv1ygIbs6/AHAVj4Ma92cbgEYMS0JRaCZRNyg0FExJeBxHDfdybkJgNWUFxikM61Ix/1aPrzWN4ZPnZ3t1C0/DbCcdjq+8IIMuW+LMJndUfV59DFT1b2Q7uGVQfCslknXiL9HQ4JjNKSSi3cima6mxDlghtD237xcXy/OpUsNDwqW3WmxscuD586EDEjoP1z6oAHN8xWTBSJHtlkMhzW5EuScM6ERElYPv11ouRqQv10AfGKe+xkFwjdCKNyNZCV6maR7plKZajy9mtIiKX4u+3YXD0Fcxf6ZPpBg4+YFGRa8p6JOq1/viAcRwB1b/ZkNmXMQA4pPBfZoVOuFj8HBGu2661UhCs0mQ74BknYHW6mZNBDjZRF3K8fTqxaqw/J+dQDRPAX89xvWiQEm7K4dOfqj86ApXAr/AiV4juVcZmaA9MWj2pZywxBZONs9Lelx6prYMN8I0ln07rkZFZ7u/DG4ZlJ40oVEKqrXk86aANnkqtVh8zB47X6qVFwUIWo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10070799003)(22082099003)(18002099003)(55112099003)(11063799006)(56012099006)(3023799007)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlBiclQ2Ky9hZy9IeVMyd00wWElDTGtQWmZyTjdNbHlXbVFjQUk2Wkl5UnVY?=
 =?utf-8?B?T1JZeTBGVldHd3VjWlFZNnFmQXA0R2s3M0VnMDRFajFBVGkyK3MvSnVLeFZl?=
 =?utf-8?B?cGw0UnNxLzlSU3BGOVRiMENMM0xrdER3eElOWGlESmUrYnJrNFpQekg3eFBh?=
 =?utf-8?B?NXg2L3lUMHVJN29WdWNyTzBhS2hZc29sTk5rcEtPaUloK0wyZGVXU2RIamJF?=
 =?utf-8?B?MzUrTXNBZXFBZ0tqOXMvN3VGcDNNNmFmbjUxdzFxU0hRcEthS1dGRHNyc1Rj?=
 =?utf-8?B?RFVyNG16cXpFaWw3bGdFTXZtbE5YRjVleVJmTDRhbTZGREVvcUVYb3l6TmF1?=
 =?utf-8?B?VGdrT3dUQjE0QjFrWlFnZUM5RWhrcEcrZ0dyL3pCSUExZGZ2VDd2dFpEdmdk?=
 =?utf-8?B?cTdsYkt3ZXowY3VqUjMvSnovSFpkSDMvSXhHemFOMVErdHRJK0J4N01QSzlC?=
 =?utf-8?B?R0lOUnJGaXJTR1hrNUZpeTBuWDVCZk8rNHpDeWE2MkQ5d2lXVlJ5VEtrNjA2?=
 =?utf-8?B?MFRvVFlaTFZ2U2lCbHlqVTFCaWt4WTVHY2tZS0loc2ZQdzMrYVRuRzVFbFA1?=
 =?utf-8?B?Yk9RbTczTjBOSXdRaEdCRDJ6WDFMTCtDcXBrOEN5ODFtN0tXWlRGVEp2Y3E5?=
 =?utf-8?B?ckUvUzZaUi85WGMwR3psQ1o3c0Fwa2tQaHN2MlZ2K29TMTNVV0ZISzZsOFZG?=
 =?utf-8?B?TEpSMlg3MlF2SyswcFpPandmaDlaY052NnJST1JSbUg4Wmt1WEJsWjZtNjcv?=
 =?utf-8?B?OHNUblEwYjhjZ1VrYU9XWVFzT3lWREJuTmo0TzFtUU9QdFQ4OEZsbU5HeXps?=
 =?utf-8?B?OWJDYmp5cGFVZ0w3NktFRG9Pc1pjZzFvV1NBRVExQytyS2JvSTI4dWI0eWNX?=
 =?utf-8?B?ejFTdGhRbnRzeExNQTZJSE5FcC9jV2FCcGZSMGdLWC9EdU1BTjJoZ1lFa1hq?=
 =?utf-8?B?WWEwL0d4YzFEcGkwaFp4TllYblRJK1pPclJ0czVYQWNibFJHWllMTU9BWHE1?=
 =?utf-8?B?ZEgxVVVzUEtydmU5TktRdlpaUWdmNGtTNjV1czZlUnNWNi9QRHNQWW5pK3c3?=
 =?utf-8?B?S3ZKM3NTRzVKTW1HTW1BenR6SExMZWNIZldOK29YbmxEY2xxM2RLV1l4VFc1?=
 =?utf-8?B?eHRFMUdLY1dZWDhNd2NhUWhnRzFlcG9jMEpkTWUyQ05oSnNrWjhLSHZtLzFM?=
 =?utf-8?B?Wks4Ny93Y1J4M0pOallUcTBidTRzcllMbFNzNjhRM0d0R3ZSV1FJRGVITElz?=
 =?utf-8?B?SG5SVHBYQnI3bTBQQUx0SForN1ZraGs4cWI4RU1YN1RCVG13WHpXUWdFR213?=
 =?utf-8?B?Z2c2eGZiSXUyWHV4Y1dWUVpMVnBMRGh1TzdTQkpOcGkwZ01lT1hveEhLbzUz?=
 =?utf-8?B?RHpkVEQvYy91dlJXNFFqejhNSFg1R1lKOEpNYlJPckRzYXVQajJmSG03WWxj?=
 =?utf-8?B?UEFoT3IwcjRBRHdobkdJUFVJZWVqWkVEL3lWMlUzdFhpaHZNaWRHcVB6NDJ3?=
 =?utf-8?B?ZVRlRllmOGhXbXdCV1c5UHJ4SmRGbFdjcDNLYXU5VXJFUXQzR256a1piWktJ?=
 =?utf-8?B?SmphRzBvWHRrcnJaQi9UTTUrQTUrVDYzc3FhMENMZTgwS05OWTQyT2Fid3dO?=
 =?utf-8?B?dDNBN3RzVEcrUFl3TUdUWHMvQmhTZFF2ejhmbzlaOEx4NjJKbnR4d3lYaEcw?=
 =?utf-8?B?U2IwYlB3dTRQUXFjdmJBUkRia1NvcmlBcCtQbDd6WU0wZlZxVzA5OWo0MHRM?=
 =?utf-8?B?Qys4TDdWbDZlUE9OeVh6bm03aHM0WHl4b2drVXNNdXpLVWhkcnVmVFJFWHpi?=
 =?utf-8?B?cVEvcUQxa3QrQW44bnNsdFc5WWIweDhFbUJMUFMzNTBRcCtqQUNYdERoaGNP?=
 =?utf-8?B?eTNBaHpFSTNnN3RXSnl6eGhFL2hVNFlxWXhnUXdscHZkWTRtdldMQ0QzWHNO?=
 =?utf-8?B?UGxRMlZoamE3b1VYaTBZWnlISlVzN2ZCTjJzL0NiZGtzK0V6S3k4dEV6cTNH?=
 =?utf-8?B?cmFaZ3hqRzZ1RXNSMVdzVHNmbmsya0FtQXNFUjNRVnhEY0g5T0tXbW0wQWN1?=
 =?utf-8?B?dmFEcVFGd2gyYjBpZGIwWUg5VWhLa1JvUVREWlN4OFpwVVk4a1BsckRPclA1?=
 =?utf-8?B?anVlazBJbVFqUGhKZGZsUFE1cGNsdnVhN3BoaURaaU5UQXFJN01WYXJPNDVX?=
 =?utf-8?B?c2FqZXRSYUtiTUJyb3NJSzB3TW1jMzVlcDZ6bDlCWGN2NHRhSjdUbkUwVFN2?=
 =?utf-8?B?Z25TVW52VC9pOEtvalVVN1JFUHFtNUY3cWNCd2VWSkd4ZXlZTTdVRUxHVHBy?=
 =?utf-8?B?Q3B3MW5ZcVlEMnZIdFNtMTluOW5nQ1VrSmtWRGsrMGxkSU9hTm44ZDBqQ2s3?=
 =?utf-8?Q?6+9DJCJ81mXyNV87JSS40ojWvHXZ9TRdX2V6xR09DHlFd?=
X-MS-Exchange-AntiSpam-MessageData-1: jJK/wqPu7mHhaM5ZtyXOrx/QT568+eDuEBc=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db75970-92e4-44f6-1a32-08defb4a9bd2
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 03:58:19.5810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qICrzTBVDxSL4b8PecMevzpeTJ8hX/iywNwUOn2+Ulaa2Rtry0xi62q6DHD7zcC7mCpIl2ZCDmrSVFORZcQUcbAXW8atce4Rg674/H0hyQTYUX/rz4zEOfTRXVPCXWdf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB453621


On 8/12/26 08:36, Breno Leitao wrote:
> I am seeing a crash on PCC that is related to a an shared memory being
> unmapped before the IRQ is disabled, and the IRQ kicks in and hits the
> unmapped (NULL) address. This is a summary of what I see on my box:
>
> 	scmi_protocol scmi_dev.1: Message for 1 type 0 is not expected!
> 	Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
> 	 __handle_irq_event_percpu+0x1c4/0x9e0
> 	 handle_irq_event+0x98/0x218
> 	 handle_fasteoi_irq+0x230/0x750
> 	 generic_handle_domain_irq+0xac/0x138
> 	 gic_handle_irq+0x344/0x740
> 	 call_on_irq_stack+0x30/0x48
>
> The trapping store is iowrite32(SCMI_SHMEM_FLAG_INTR_ENABLED,
> &shmem->header.flags), a write of 1 at offset 4 of a NULL base.
>
> But, back to the problem, pcc_mbox_free_channel() unmaps the shared
> memory and clears pchan->chan.shmem *before* freeing the IRQ (aka
> calling mbox_free_channel()).
>
> The interrupt is still live when the mapping goes away.
>
> Free the channel first, before the memory unmap. mbox_free_channel()
> calls pcc_shutdown(), which frees the platform interrupt, and then unmap
> shared memory.

I posted a related fix undere the MCTP PCC Driver changes.

This fix is necessary but not sufficient to deal with the race 
conditions.  Take a look at the series of patches under here:

https://lore.kernel.org/all/20260721175258.87600-1-admiyo@os.amperecomputing.com/




>
> Fixes: 7f9e19f207be ("mailbox: pcc: Check before sending MCTP PCC response ACK")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   drivers/mailbox/pcc.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 636879ae1db76..d32f170141de7 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -408,12 +408,13 @@ void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
>   		return;
>   	pchan_info = chan->con_priv;
>   	pcc_mbox_chan = &pchan_info->chan;
> +
> +	mbox_free_channel(chan);
> +
>   	if (pcc_mbox_chan->shmem) {
>   		iounmap(pcc_mbox_chan->shmem);
>   		pcc_mbox_chan->shmem = NULL;
>   	}
> -
> -	mbox_free_channel(chan);
>   }
>   EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
>   
>
> ---
> base-commit: 5e6de6a2b522f659defacb1551d0465ba6ce13cf
> change-id: 20260812-pcc-3a7413982a5e
>
> Best regards,
> --
> Breno Leitao <leitao@debian.org>
>
