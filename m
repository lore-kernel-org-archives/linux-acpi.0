Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012005.outbound.protection.outlook.com [40.107.209.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28D1481231
	for <linux-acpi@vger.kernel.org>; Tue,  1 Sep 2026 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281404; cv=fail; b=RF+cGs9WrJUB108GHQ+HGzd6J1+hTEy0KWth0BBobifO9988da1YgAmKFaBhD3fY9GhDDgvI7RCaHePiULHnIqSUkdDNNtN9TYuBdlnj0GxK3V2WmERULTvQx7Rv7lC9bThzdZy/a0pgpN7oqZ0n/fFGD38dsuI/OpEkfKTa+ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281404; c=relaxed/simple;
	bh=voorUyO+v11uOxDuc5lXKgH9NEvPjKIiO5TKoQ/RxwM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NDZ2KzeaYNr1zCN6R48eI6ukpbBy0+rrlznimMOpTqNX8nSvlmpL76B3dYwNZAtRgUypSHykYPCOpWKDIZ1EJx6jtgQTFNEBp6HquCWV2oaQUWsk3soMkpP1H60fScRkWdi3b2ZcxsPPo6Mao5RRAldBhUldAj07HqTpQNB4Qwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c8lzv7Hn; arc=fail smtp.client-ip=40.107.209.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c8lzv7Hn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tm1kRsGNWzIPm9TgZoLDkUcN9g7MW20P3kmbpvORmLB9YZcu3+j39SsDDAeco5MLY9WSy0V0AZ+cOkUWkwDysXaD/Tvf4uvU4AykU7AfIZrpIkLzpRb+xMMy2uoT+KFHbP+KGLcIgYMWrYbulKI87hoBkOUcQgcEsXe5Q450o1B4rDE8BGxivpxuL0D5uDaFXHFd+MaolfV52+cgNivF9qBGqV1DrP3qae+mi2nbaP692EUO8pUnUXw94X1hhC+RjCzz9JSw2qHT4bCYF4YnzjXHE9vOLFhVgGztoPKTH0mDVC6Rtgj85T1wIsoUprdPCh7vmCt1+HvC3m4z0djS3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSdf4I81bD1r/ny1iRDoNszvx3HkGq3epZ6YqnEM8s8=;
 b=siV00gyf4KbZH+PhfiGh7NfyVQ6KF5KdPxzdReSU30A+7RDSD4ReKmYWmK+flr6cnvjK+R7COHuedRj5Wyi5w2XMJXUNcEaIjec3hQtncBZPnH+vKJPt59yiFA3hAsmUK4NdFnQ6HKHlgRwom4uZbXKArHYnb+62qCkNG09npxPAbXLbGqolgSDarnUf0+MuGT5ozSjcs8Cp6tRy4Q/QEuYBxSdmx08KD1LwGq+DaB6TXoMfgE9RHQOHP4S3su1vP6UI8yJDQPBjZ0zZVLnzs4ot4df+L3dt9H+/36AoTX6f0aLGfVKxM3hythwCEiwCjqqeL/KWX67pQpHB9o7tLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSdf4I81bD1r/ny1iRDoNszvx3HkGq3epZ6YqnEM8s8=;
 b=c8lzv7HnVz/Mt8XtmGZquKoDx+ctl8rZVWXBufyTRLhha7fwsoJhKKlPe3bzEM4qSd7u/nOYUx/iFxgLSBhBoMNJ5h587idS8rAjEbeWIp7oIHa18BTGNmmqGBE7zyBgJHwDRy0IdWHFH8OYdLkAEfybM4gZmS9bYxkF8Y+h4SI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CY5PR12MB6250.namprd12.prod.outlook.com (2603:10b6:930:22::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 16:49:59 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 16:49:59 +0000
Message-ID: <a4dff3d1-afd3-4e49-a0e0-9739af8391c9@amd.com>
Date: Tue, 1 Sep 2026 11:49:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: CPPC: Don't gate FFH EPP writes on flexible address
 space _OSC
Content-Language: en-US
To: rafael@kernel.org, lenb@kernel.org
Cc: Giusy <kurmikon@yahoo.com>, rafael.j.wysocki@intel.com,
 linux-acpi@vger.kernel.org
References: <20260831054043.1884105-1-mario.limonciello@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260831054043.1884105-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P221CA0026.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::31) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CY5PR12MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: cb3f4fa9-e233-493a-aebd-08df08490f5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	GeN7IlyNaUJOt7sltYy8kwpaKFJX3LmRTp3PoGFDuYXHjHK5s3kTYSpP6PUjxrsu0rA6RxNrp9u6kfLafhbdo6QhkPSO1FcS1FWZ/CaRde5Drwqn016gCoQDKij6B+ZiYh3cRXkNkAxo0RZE9EznRKUbB4cB1ir1HKFQ4YV6m3VPdwjglPVDPhCvrTIP818qJ/Dl2VmKEwxTA5kwFrd+9Vai2aQiRffeDjgBDaN1rcLK1WpyRRPk61SHqPS6QA+AwQej0mt+G/401cHI39uFzDPMU/9EmQGQovMoDs3JIPCrJPEEQfZW7AgILxmF+NEKBHZpKhk123A+a+F5U4dkXxqo3D2Vf53N0US/4GfwYmPbZzfVf5NlvvwVW6+c06Bu8AyOZcM8ui+ItTTB+qsrfQYs2EYydYRSp/dCZlYkWUaMUUSnwM84nrMVVmHrrxBvcNGqqJse53dRTpeOplqJ+U3YTIg5qt0qgfkkd1poO2zqHDWz5GhlZKBWmp0plDQYbPlEP3Z1/4UjsMjM+A7N6jgYjvTl44wCXxgpU3h5APxLWEss0eu8sy4Wlvx5jaLNJOMobhh5wdavgnNkdgK3YNYv7W44qkm0WuDTZbbmVe4h2BxKdZIeV3+HS/3X5H7j
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWpQNk5KZmt0TS82YnpJKzBPc0RCa0IrSkNnNlZmVG03TmtnTjVHWjhCL1hV?=
 =?utf-8?B?YUQxUTNUOXBML3hoWWkvUXF5cE1hY3Q1cGhxV05NRXdIaFBVUE9NN1ltdjdk?=
 =?utf-8?B?RW5sVHFVcVBzV0lMUWhENE51WmdsOWtyWWJ5VGphL0s1NjRaenBpU2ozc2VD?=
 =?utf-8?B?MmZTd0R5aks2elJhTi8xeVdxWWlRSmZPVWRVSGJXaTVrZzhqZXMzaHRjNWFO?=
 =?utf-8?B?Z2N4VlRGNmc1U01zcmlINEdvd1dyaDF6MUwraVMvUC9zclhBV09wdUdtSUwr?=
 =?utf-8?B?aU5YaWMrLytYeDhEbEZKbmJ6OXpBaHhQak1jYVh5K1lCSHBFYytRRnM4T3pr?=
 =?utf-8?B?UWNpenpwRXFMMDMvc1FoVVZOVFVGVys4dzNPUnZTdWh2RXFmMlViVjQ0TCtF?=
 =?utf-8?B?eFpZTE5XZUlLckZ5ZUMyNHp3ZGgxTnNDanBaQUU1Zm1helNZS3doYmQ3eDA3?=
 =?utf-8?B?cjZGdElhOFZDcXpVWUk5TnVUQzFadWF2Wml5YkxqdEFvZGVhR1lndXFZak4y?=
 =?utf-8?B?eE94dWFqaDhOeWNHYTFxTHJ3WFdITzBOZWp1WHpZY0NNRFlKSFhXRGlPUTRZ?=
 =?utf-8?B?Z3BoNjU5ZEM3ZHlhdDVhek9Ld05kbEZDZkxwcTBLakxFYkdHa0Fta1NyeGRY?=
 =?utf-8?B?WDVzUkIybWFlQjlpMlUrWkZEL0d3RDZrNkxub1d6UGRXQVliUWZNZUlLbmdk?=
 =?utf-8?B?ZmVsSzNwcFhkSThwNjVaa2sxUStpUm5vRVZ2dktvSktSa2xpTDB0UVUzcTdh?=
 =?utf-8?B?QmowVi9zWEN2QkpXODYycWQ0ZzlxaHZVUXRYWTdrbHZ3RnJyY2hmeFBNT1NF?=
 =?utf-8?B?dytTR2NQb2JlZ1JrM0NQSUNBaWZYNncvaVNuamplVm52SFVEcVcrM1VKemN1?=
 =?utf-8?B?b0lkMjIrUmdWZDRHVWNBMUY1eEpuckZNNW9naVJtVUNhaCtWZjJpRWpCTHdk?=
 =?utf-8?B?dUJUQWdSTFhuVzdLR2VkajFGZGRxbEI3MldKTGlLTTR0dURqcmMrL2lESlg0?=
 =?utf-8?B?dEo3dWJ2VlIweFdFUlpvUHJUaUxHcFFHRi9zcWtmclV0K3p0SE4wYkNFTUM4?=
 =?utf-8?B?azBHNjViSmUvZnByaVVBZFRadFJvbmtkakd1Z3E3RzA3WTcvdGsxYmdBU2dx?=
 =?utf-8?B?UTBUSmdNS3hPR2UyWEkrTll6OXovYWNUT1UzZGxpNEZXZzdvMWtiWFRkMXcy?=
 =?utf-8?B?L0pZTlVSRUxjNjFOZTRacy9LUXpsbzcvenRXdldvVCtDWnRTK0xVTDJQQTl6?=
 =?utf-8?B?N3NRLzczZkNvZ1VqU0M5Y0JNLy90Tll5ZGpqczZWY3ZHeWlsc0JrQkZjR3lh?=
 =?utf-8?B?dmVxVk9adlRlc0NVVEFMTE8rY0dicjg2QVh0cHRESVVBeTQ0eWxLcWhIVWVM?=
 =?utf-8?B?YTV4YXJwcnF6elZueFM2aGJpNUlIMWo2cWswSXdzdFVrTUVDVDVHVHh4TVhH?=
 =?utf-8?B?RXNnOEhadkNvbm5wNXFvL2xES1JmVmUvU1BkSmhVVHZiRVFLR1dHS0NBTWMz?=
 =?utf-8?B?NlJMcnhqK3FWWXUrMWFucDcrR2wxYVJZMXhEdU1sQmlDbGZWb1BWUVQybjV0?=
 =?utf-8?B?UUV5WUIvVkVEZnF6a09pdjhUOGEzOW9nRVdSZERabGJ6aGF3MDdsNmYzN3Zm?=
 =?utf-8?B?UXYvWTBLYzNoYlNNZ1BocFJyb2xmRDkvM3dKcHdLaFpmK1dDMVlsNGdUa1or?=
 =?utf-8?B?d0VqbHMrbGd0ZVVwZ3BCekpDRHRlZ2tHZjNJVXZoejFaOVRDemo1UTNSN21D?=
 =?utf-8?B?NVd1dzdpNTd3SmlEZ0cvSlJ6VVdnbGxTRG9rL1BCT1dnTzVMYU1CemxzLzUw?=
 =?utf-8?B?cE1vbDBWSkI5bUUxVnpldlJPV2pNK1RYbUdwbnhDREhWdytaQWcwQzFwdGFJ?=
 =?utf-8?B?UzVTOE91RkgramtVRzdmK0lEMmVWZjNzcFUvbHVzZXdXb3hldVh3VzU3S3Ex?=
 =?utf-8?B?bFFOdjR0aWhRTTdMVkVqemZIYlpzQVVtck5UdlpNS1pjV29LOGxqKzN6NG9V?=
 =?utf-8?B?WGhESGN5QW42VDV0ZXRrNkZjbHBHNmVMQklkZ0VkaU4zQmZueFpuOWMxUVE2?=
 =?utf-8?B?Rkx3UDhCWGw0S2p3UURFV0VXNHYyaGt5MGFodDdzZUdpbktDaFZiclBGTFQ0?=
 =?utf-8?B?SnFzaGpXL0t1Vnh2OHErajZDdzdZZXhycG1MaHYyNGh6MDFKUWp4T05vVktK?=
 =?utf-8?B?RG8rQmMzOUI0T0gyNm11bUhlWlVRUURCS05abjlCSHpiQ3JxeUxnRUYzU1Ft?=
 =?utf-8?B?a0tFdjMzM25SV1AyTTJyUmdLbE5CT3RpOHIzY1FrbDBhZTE5eEhTNS9hSnJj?=
 =?utf-8?B?RVFEV0dzR2hCbW95dkswK2hwTjNvTGRkRUpDK1JNYWNSdDllcTlxUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3f4fa9-e233-493a-aebd-08df08490f5a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 16:49:59.6031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wcpAhbChqw8T64DOvzgesTU5rMzvWGTTZ7iZXBDbtznmN/q31V65TGzKGUz9AJnLb4zV61PdjaBbpuJ75Ve7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6250



On 8/31/26 00:40, Mario Limonciello wrote:
> cppc_set_epp_perf() requires osc_cpc_flexible_adr_space_confirmed before
> writing the EPP and autonomous-selection registers, even when they live
> in FFH.  FFH access is a direct rdmsr/wrmsr and does not depend on that
> _OSC bit, which only governs CPPC controls in SystemMemory/SystemIO.
> 
> As a result amd-pstate active mode fails to initialize on platforms whose
> firmware does not ack CPPC in _OSC but whose EPP register is a working FFH
> MSR.  On an HP 255 G8 (Ryzen 5 5500U) reads succeed via the _CPC parse
> path's cpc_supported_by_cpu() fallback, but the EPP write is rejected:
> 
>      amd_pstate: failed to set energy perf value (-524)
>      amd_pstate: failed to register with return -19
> 
> Gate only SystemMemory on osc_cpc_flexible_adr_space_confirmed and allow
> FFH unconditionally, matching the _CPC parse path and cpc_ffh_supported().
> 
> Fixes: aaf21ac93909 ("ACPI: CPPC: Add support for setting EPP register in FFH")
> Reported-by: Giusy <kurmikon@yahoo.com>
> Closes: https://lore.kernel.org/linux-pm/e4259474-fa4f-4ed8-8a7f-1a3a2521acd3@yahoo.com/
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/cppc_acpi.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index fef54fcd00b78..6b590842b5668 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1766,10 +1766,18 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>   	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
>   	epp_set_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
>   
> +	/*
> +	 * The flexible address space _OSC ack is only needed for
> +	 * SystemMemory/SystemIO; FFH is accessed directly and always available.
> +	 */
>   	epp_ffh_sysmem = CPC_SUPPORTED(epp_set_reg) &&
> -		(CPC_IN_FFH(epp_set_reg) || CPC_IN_SYSTEM_MEMORY(epp_set_reg));
> +		(CPC_IN_FFH(epp_set_reg) ||
> +		 (CPC_IN_SYSTEM_MEMORY(epp_set_reg) &&
> +		  osc_cpc_flexible_adr_space_confirmed));
>   	autosel_ffh_sysmem = CPC_SUPPORTED(auto_sel_reg) &&
> -		(CPC_IN_FFH(auto_sel_reg) || CPC_IN_SYSTEM_MEMORY(auto_sel_reg));
> +		(CPC_IN_FFH(auto_sel_reg) ||
> +		 (CPC_IN_SYSTEM_MEMORY(auto_sel_reg) &&
> +		  osc_cpc_flexible_adr_space_confirmed));
>   
>   	if (CPC_IN_PCC(epp_set_reg) || CPC_IN_PCC(auto_sel_reg)) {
>   		if (pcc_ss_id < 0) {
> @@ -1795,8 +1803,7 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>   		/* after writing CPC, transfer the ownership of PCC to platform */
>   		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
>   		up_write(&pcc_ss_data->pcc_lock);
> -	} else if (osc_cpc_flexible_adr_space_confirmed &&
> -		   (epp_ffh_sysmem || autosel_ffh_sysmem)) {
> +	} else if (epp_ffh_sysmem || autosel_ffh_sysmem) {
>   		if (autosel_ffh_sysmem) {
>   			ret = cpc_write(cpu, auto_sel_reg, enable);
>   			if (ret)

This patch can be dropped as 
https://lore.kernel.org/linux-acpi/20260830115644.2056983-1-christian.loehle@arm.com/#t 
will fix it.

FFH writes being gated on the _OSC ack — no longer exist due to the 
refactoring.
