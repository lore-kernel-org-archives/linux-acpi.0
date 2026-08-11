Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011009.outbound.protection.outlook.com [52.101.57.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E1634C98C;
	Tue, 11 Aug 2026 17:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786470749; cv=fail; b=SnNbO1xsJmDoJHbj84jmVuI2lolGZnNDEqk0/rgsRx3DnEoFhtTsh4uVj4o29NupHWMjiMVE/ULpXOM8VYsAKd3ZZ4r6Uq8gE3CdjIekEVVnzPFIgcbmvPNGChC3iYVT7FMhGayxRvtGfu3Wa2IUYE3UI9ArUkXyVgf5YFN2V6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786470749; c=relaxed/simple;
	bh=2jE53EXlIABkQjKw6uMeL/gr3rdDmI00c2F8OMOzdTM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dIUE0euXj/aDG1pKiPzgJcJw2gHpvJnu72juAc4Oaff3jeX1tjef/FjGPnXlNdl6uPNC6tCfrbHK8sChZ2ErpnPedwcigrwA/79rfFpxdQTE4quQ1jGqGALBfTwwNH+E0GF67nhShIrroH1iZD79CNLQ2heDo/IDow+1uAaWLl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dNsPYfjT; arc=fail smtp.client-ip=52.101.57.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dNsPYfjT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WP/GXR7SHr95JiryuI38avASrIkuduoh9hOX/cTC9oGVxO68QXRCRDwkrgTuF4WqoFP8cOVQy2a3JLxcAJmgrZKoZTIC8JodJWCDpay2MaGY2EYxhItqZ8b77e/hlYtJtpKIni7Ml/i0JwGA5Rtc5yZGudbumjvN/d+9A2VbUBTMOZDdiN//VI3Dfzryek4jLBuG8tFXMFpx6mtvQGsfhuKHZJnRko8rlKeO8qQAwUytV69Af3k94wfZMGJREoOYSk3MHpNM/snWMkEoWVZtCAuPB36bN7m2MCIXvQtrAkG1VXMg37/bYJqbNzv2MyfGlFOamIccbPNJ649ZiXvCJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YhDhqq3l7893iXNrIKIImTBEmrSUBmzAQcuvWc0NYk=;
 b=X4EY2Dl7VEJ4h2iDinZK90qzWB7oL3JU4u/DlIGB1CYR1iC9/fxGISrj/NUliL4ml5zWrSo3FBnHU0Q32k3Xuc19XqTtvSfFhU9tKlVU1GdHaQxjlMsnZHfDNhp5ufI8oyzNp/9f0fIMd9c9xQnnSpINUoeetErFZep2z+91DkZ855amFcjhu52539Uk+Wip+Lqm0VOzAtg1c4cI6nZHfTUstdm0577GsosP2fhAYLRc+uw4acEuiv7Q2KMsLswSV+1y3DNK/gf+fttNr5ttU5uTqPe2cX9RqRvNuLUOQ7DCGINXY8529+BiqUtwXjKhczhM4bYJYFWcscBfUIcJHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YhDhqq3l7893iXNrIKIImTBEmrSUBmzAQcuvWc0NYk=;
 b=dNsPYfjTVE+QBunclj9MW1SVYThovnsA5Y3hxWqevoujBnD4n+az9gYnxn0K5Lrimperbs33jrZ72KXo4IoIQsFiDLDezqDXFsowdKV/5XVoFPfqLWsSfYJrK9MIycTYQa39OTnvFM5yw7eP8cCHHHSk095G5hgNsW2pmmGG/ug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SN7PR12MB6814.namprd12.prod.outlook.com (2603:10b6:806:266::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 17:52:20 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 17:52:20 +0000
Message-ID: <727bdb6c-8d49-4ec7-acbe-d73b6e63cfae@amd.com>
Date: Tue, 11 Aug 2026 12:52:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: OSI: Enable _OSI("Windows 2022") on HP OmniBook X
 Flip 16-ar0xxx
Content-Language: en-US
To: David Del Sol <daviddelsol1998@gmail.com>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
 Armin Wolf <W_Armin@gmx.de>
References: <CADaJo4UrmNbPPxnnt0tjpdTuxK5wQdhS-0W=rAdLAC_++Vp47w@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADaJo4UrmNbPPxnnt0tjpdTuxK5wQdhS-0W=rAdLAC_++Vp47w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:610:33::35) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SN7PR12MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: 8069607f-5f57-481d-8965-08def7d14a21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	NiSHGGIQAy4zNMo1HDfcfW0y7zPXW444x98O1dQeldjbTcFUUrtdQ9P6nl7brA2LAMwkmfD5HV9C97Xt7ztTvTmmRUDAH7mFOVsuZuf+fuKM6TA8kXHFTt0ZdDk+8HLODYG6kVCCYOxdIyTdcuMx1HVPJ3J/z3Enxxc6dSGLB34e0VLPzV0dxvoIDCoNgjM7uiaeELkbusMZOOWJbHzVrVE+0dzXITdp7KACdTdX+tElVIDZgr0fGlHPr38gOi2fqL1CWpXvZJs1QNCnv0AwP3s3aa4hqDcwxbITPsd16rg70U/G/Yg+sy4mcnaKzpPsydE4pn7FepF2qXaG6Qm2JKavOet6nxI9fKnXZHa1geXhSErz8+eWKifjwy9IP3d555TOMMTMe+8CO5Klb0VfHAjiM7vnXBi4eOz/Bjfu0KzmiXaGEy/7ueEaMHdJpPX2fb+Coi3L/5NDfC1UIsiJwiPT1RmiNETMsbclJMxGUIMC2sFd07lc1H23m9snq3s5ssoTXZFtjastwRX5iAC+mpBIoIleeKVEq3AHgOcCZcjwU6C2LZh2eTjZbHXzsTtRNNmjC2OnJfL/KrrEmYRFrTV4pG/jOMcWilGnoLFP/eGpTcSYXFhGZvvkTpmWkFfpHf1Hx3BYMKuDsiVKb/2yXWC6pHgWXk1sKoFS3bv2d3A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eW8zMWtma0h4YTVxbVpyVGdyVjRWRVRqVVBnUlh5SHV5djd1WkUzUUZvdVJz?=
 =?utf-8?B?TVdTTXlLVEt1L0d3Z1pZb1owaUZhcTA3RWVoSnE1cnNEQkJ6MytKd3VXbXUr?=
 =?utf-8?B?OXdJMWtmc25OSlpzOUVtS0Y1OGREVnJFUDdHblN3L0pKZlozbDFaM1dzZnVV?=
 =?utf-8?B?OGtDdHpxL3ZnUkdPK25SMG9ldnMxU0s4c3VRZWJMM2NaNmplc01jT3ZRRk1M?=
 =?utf-8?B?Y3NoWUUzQm1HTENvRWMzTThKS29mQkwzcFVoVk5ibC8vWUs0WW5LTWJVejFv?=
 =?utf-8?B?S24zb3NNU21JRUQyeEtQUGJFK3htODFNN01oaGxQMC9kd0xWUkRuTlh2MGMr?=
 =?utf-8?B?YWtqSmU3aUhQTVNSUW8zcjlZUHN2b3hSV283TVRaZkV4Z3pmSTdyVXJqNHo4?=
 =?utf-8?B?SUxsOGY5SDR3Sm4xS1R4Y2VHUi8wbEdkV3V4VW5IdUNBeXlLSWFRU2N4azd5?=
 =?utf-8?B?eFhkdDVpYkNyT25QWk95WFNvWXYzKy80QkZmbmRKbXZ4dDRuZFpQWWRPcTBh?=
 =?utf-8?B?cTRXZkMrT3pnb1BwSUVZazlaZURrMWlkbnc5NUNBby92alM1SGJlMDlLd0lL?=
 =?utf-8?B?ZUl1UlNmUldNOHpYTmVOWnIxZnRadlNoRUJDZG5TWUtVN3RLL3ZxZzZuUUNy?=
 =?utf-8?B?ck5POUEzcW92NEdTcXhnc3RKcCtRNzdTdU14d0N5MGZNdzYxSkx1bTFTTitW?=
 =?utf-8?B?S1VVUjd3WU1IOXVidmFJTktCTHl0bGlDYmttb0R6UStjUkR4NFFjRFFnYUtz?=
 =?utf-8?B?MjQ1Vm1zNUFiaFNRYmNGdkhvbzQ2Y2wvUk1HdmhVMUQ0NWZudEp0Q0I4ZkM5?=
 =?utf-8?B?ZUo5OGU0eXRDQW90bmFrRk5LditXMUJieHAza2RQdUwwQjI1NU9nTmNuRXlO?=
 =?utf-8?B?SEV4djdjYVRhZkQzREZVbldLZis1WHllYkJ1T0x6eXFHbkJvbWhKVnFhVFUw?=
 =?utf-8?B?UVI0Wmh3ZG5ROFJGaWU4R29nREJhV2l0ZTFNUmpLSUVRV1RtMElJVnFDb3Rh?=
 =?utf-8?B?ckorMmpYcElGU3NQYUl5ditSMTBWMExuU0hxWWNqQlB6SC80TGVnNVpDSXJr?=
 =?utf-8?B?eW9NTjRXeXlKQndYbVZ6d3JJeWs5Y1NvOGtiWGZwYmJFdG9OZC9XUGNLMWow?=
 =?utf-8?B?VUxCVWlSZlhSSFlOa2xEazdlck40TTVvL0JkMElobDM1bzl0bU9DTlAwdGU0?=
 =?utf-8?B?eGlhbk1lWVRZa2twWGRUZHNhRFpaM080aWxQMS9leS81VWFyNjF0dUxKQnhG?=
 =?utf-8?B?TVNQa3BwK0hwNXR0S0lscC9XNjFyZmg4UXpMelJzY1hVVDZOUFlGNTRlUnBn?=
 =?utf-8?B?Q2FXWXNqWFFXS1VNMXhvaDlHM0VBTlVGQVh6WXUrTlFDR1pqcmx3M05SNW9J?=
 =?utf-8?B?aHNsVG05azlXUW1GeDZzempKMVhVZ2VDQ1pKemYzZkkxVndrb2Z5cnFDZVdl?=
 =?utf-8?B?WTZjbjdUU2hESU5YeVU2czB6eWx4Z1lpN0w3Y3J4dEl4NzdEVUNCakNEc05u?=
 =?utf-8?B?aVZTSzlldk9FYS9LTDVZOVlNNlFxV3lHYnlYVEloVTU3Y2VkZVZOVEs1dFdp?=
 =?utf-8?B?cGsvVXRmajR4SUN1Vjl5ckZXUzVEMEFFNnU5anA4VFpUL2dUMlRDRnBQQ2w1?=
 =?utf-8?B?Uy9xMjdFZUZXRlFXclJRREt6eGFVREYrdlp0SUhzQnhuWlBOa0djSFFKR2hB?=
 =?utf-8?B?V2wvSUt5MkRJUHlYTjlGNHdsS2cvS00yUlNZeWtVakZxS3gzOWIzRXRjbWFZ?=
 =?utf-8?B?amxTSTdXeTBvUklGcmRCUTVGd1VCaFVnS1ZRT1pKYlVFbjFUK3FVbFZUdTdm?=
 =?utf-8?B?Zml3TXhQckNhSEpuYjVwS2J0bnB6cWRiWGp5WGRxTTlUWWtGUG5UWk5YN3Fs?=
 =?utf-8?B?dTloZkdiRDNTdXNxRVY2QzEzbDMxaVpyYjhxeGh0WUNNZThSekJFNkhPK05F?=
 =?utf-8?B?aVlDZzMrd2w1QktNY3FTQmhGRmNZaitmVEJsOW43WjBGNkEzWlFlenVZaDVr?=
 =?utf-8?B?ZnBTaG5GM2RsSE1wY0FCSWlScGxnaFgyR1NRS0lGbFl1YlRja3N5elRWblFK?=
 =?utf-8?B?elBna1Y4S2hQMVplcGcrOTRhL0I1UDY3Wk1ab1B0WDBVY2RhT3BnTHZHSEZE?=
 =?utf-8?B?WHZYZ3VjWm95eVhmNFIrWFl4UmJoNnBWWC8xTFhOYndHVUpNMEwwN1FxQ0J3?=
 =?utf-8?B?d244d3Y0cThBcnVVUmRvcXZ2aGQ4WlllZG9tekZkK2JnYkx6TzJLamZSU2Np?=
 =?utf-8?B?RXhlRVFCU0FkeXhOeENvaXgyYVA4NFdybGJvYzRFNkVRUUlLT2laUDNMVnZK?=
 =?utf-8?B?RmlWK3UwOWtuNXAzbUJSQXA2RHlvbDkyMkFya21VbEU1OW1KazhDdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8069607f-5f57-481d-8965-08def7d14a21
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 17:52:19.9387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CokpIKjDKVzJFQQOfnvZO8IjYXeW7uxbK8LunyaT3QiKRGKba1wlyI6jRRsC3dh+F6QGluBtd2buxb8KS2c+Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6814



On 8/11/26 12:48, David Del Sol wrote:
> Hi all,
> 
> This fixes slow battery charging on the 2025 HP OmniBook X Flip (AMD Ryzen
> AI 5 340, DMI board 8DA8): with a 65 W charger plugged in, the battery
> charges at only ~0.2 W on Linux instead of the ~30 W Windows gets.
> 
> The EC firmware only enables normal charging when the OS claims
> _OSI("Windows 2022"), and the DSDT/SSDT only check up to that string.
> Linux's default claimed OSI strings stop short of it, so the fast-charging
> branch never runs. Adding acpi_osi=! acpi_osi="Windows 2022" to the kernel
> cmdline restores 31-33 W - verified across multiple charge cycles on
> kernels 7.1.6 and 6.18.42-LTS.
> 
> I checked with HP first: they declined in writing (warranty case
> #5163282638, supervisor email 2026-08-10), saying the firmware is
> "specifically manufactured and optimized for the Windows operating system"
> and not supported for other OSes. A kernel-side quirk is therefore the
> only fix path.
> 
> The patch claims _OSI("Windows 2022") via acpi_osi_setup() with a DMI
> match scoped to board 8DA8 (same mechanism as dmi_enable_osi_linux), so
> no other platform is affected. Full evidence - DSDT/SSDT strings, EC RAM
> dumps, measurement logs - is on the bugzilla report below; happy to add
> sibling boards as owners confirm.
> 
> Thanks for looking,
> David
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221866 <https:// 
> bugzilla.kernel.org/show_bug.cgi?id=221866>

Are you sure about your proposed root cause?  It has been enabled a very 
long time.

https://git.kernel.org/torvalds/c/dd067afe3f8cb
