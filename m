Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012015.outbound.protection.outlook.com [40.107.209.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1283DB625;
	Tue, 11 Aug 2026 19:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786475315; cv=fail; b=O3fW9tZUXopEB5tGZTeMIQMcw8vL2V/Of2o83zPwlV1NCdT64wcSKOyknLseZfpXAIAKecTSfGis6uwvJSsTtXw6jmguJVzbYqt6i5XXNQw5pfX4QM+mMXO1tdTWe1r4G6hIJBiYR2weodkVAhQS75pp8qrBdQsp3AdPoAcW8aI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786475315; c=relaxed/simple;
	bh=uJNBU0bPfpBkn0wG1Wt+mUB/410jYUyb1jzlDrXD+5M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tylj6HIKnhtbPIiK7VwrmHjDWAv2fzi5ujFMJUTWt8ZmfEaAuT35CRn2t53Luh0zlIJvHHk0H5nPCAzKC0mX63puM5UWjv+nI20GPw1ZFfMMsFdiD5C0yV60tFJcfHd8eZdm6qkzR4WfX0sEuuqcwluL9Rua3Pp9pvq+AVNLtqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0ZKkEpBH; arc=fail smtp.client-ip=40.107.209.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0ZKkEpBH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5lBT4a9+1QQRHAsWtODpjrrLaq/4l56YshgqKnmf6UEAROu19ftQtNSSacGNaR+UoKNJAFXPSOIesVtcZ644t2beIi0VlebOIHJWCjz+uNyf0XySDvpFTW99Dktu7pIDhDhO62wqnrI7lswMRWzuHo1xp5oCG96Q35oUdoMkq3LyhfR0eX5WKYBXbKMRfnvrQEVfqHNOCHntnrJrU5YnylvBJFxJFyq4RM1ZczcvTxQ/Fuz5guJW4R8/8X8xjmPY8WVfMlezlFeM2HYGHRk/+GRUz3u64HBWlOj9IpWzmwLxvr7BCgci6MeqzjnSCIZxZV31nljyZoiQeV7W4jKsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoN0fNqPdetJynpm3Li8KP8T0oBr4C1Np5se+5a1IYY=;
 b=M7fYCS2ddJMIRlouGns0kI9PyY2zSrKj94u7zLvf7AHlU0ig0N09gO8nCSsmVuPe6iPTTPc02TJigPUBagkmf+JuHSiD9vyejtuSTwnUllDvkQ/ryqGsIyCLdd+DleIbQh2Kciuckv94V8vPQ2vmLzI5Otv9bU2n1waI+oBzqS5wDzZLn1Ny+KVpqQzdwvdj22tBJD1z7NPDbKrlgB5iqEbx5fKs84sciGlSFVgkaWhSpGT8jYRitUZAORHW5psDozDSJnfqjOWMC27pdNPq17kjOykWvxXtQoEJUPNi2BBvW9RY8MF68ZbZ90FC4r1sxuzzUMpL0UDjMgH0eLQErQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoN0fNqPdetJynpm3Li8KP8T0oBr4C1Np5se+5a1IYY=;
 b=0ZKkEpBHa6ybZDz2swMGgH+AQ7XjnhNToSbbfF0p9B9Jc/0Jd/RMVTRpnPGu1VqF4Bea92XPeSqO1GYWzMv7LQDDhqtFRqQDG7Wb8IrgnEoYsUx64/1LjK4WgXmGddK38b4340lkspzI9s3delZ6QmIQhgEmIBKR/etbtZHekQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by MW4PR12MB7261.namprd12.prod.outlook.com (2603:10b6:303:229::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 19:08:30 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 19:08:29 +0000
Message-ID: <3e0690a7-0ade-45fa-822c-1376656ec6a4@amd.com>
Date: Tue, 11 Aug 2026 14:08:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: OSI: Enable _OSI("Windows 2022") on HP OmniBook X
 Flip 16-ar0xxx
Content-Language: en-US
To: David Del Sol <daviddelsol1998@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 rafael@kernel.org, lenb@kernel.org, Armin Wolf <W_Armin@gmx.de>
References: <CADaJo4UrmNbPPxnnt0tjpdTuxK5wQdhS-0W=rAdLAC_++Vp47w@mail.gmail.com>
 <727bdb6c-8d49-4ec7-acbe-d73b6e63cfae@amd.com>
 <CADaJo4WSKvSSOt6vG64NjPwLnRot3tC5Uz9RBvKWTp0sUuFC=A@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADaJo4WSKvSSOt6vG64NjPwLnRot3tC5Uz9RBvKWTp0sUuFC=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:610:b0::8) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|MW4PR12MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 45da7340-9534-4ac2-67bb-08def7dbee03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|13003099007|6133799003|11063799006|56012099006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	l7lvV46ob4JUsHKPWUipUH74oOr2uVCkiqLdVxr2lsPKfULd5vfhJvDY/kejjBYow+F2zxTkoYzTAVP6gfBlOrAjIUHKenMFqyQ2otxKZfq9Ljj8Jhw2/m2toAHLyS0KttxPIF/Q5cf0Y8rbwPBQKC2RR8OLunRwUGAWPpLBivc57bODmGMbcFgMQegPoe6VxgS4T6ZQvO2ktRvzzuAR+j8mWjm2eTXEBmqS91wERzIJ3Aos9ba2hSXD/aiHMRh1peCswav2BNckjGE9ahVObl/ncLzTCQ0PYMaRrs8wx4Qb7WrpFr32b4LJTMKereogfMazj9UPSuhMNHmyOq67D2nAlkQn4OPbYCndvKftFTeGT8+kMCr6K2WrHcZovBqoHLy8+IfDNRWatfGsqO0zDktJ3WxjB+AJnJBjcdt2ZCo66IrTaIyesm4KrJr57FnmTI1HFz91PvKDTDORyErSKILDC7VXdUjMzqp0+Nop1e5bMiBZFh3HloKu92+ahvl6lsMZRFMen4mq2COeeRtaV1sMIRQC60c/i/LUM0HfYoH5jPgJlAEWedmw4ZS4ikcw/nU1m0WrtZJyl98YkVkPmhfZpU8avpZTk2ilvumQRfCzM0GMjOK1KP6cZ3L3Iidyrpe3ynyjnJ1XVqW5rL9K1LZ0t/3gBHynXNuM7T8KQH8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(13003099007)(6133799003)(11063799006)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnRvZU4xL010Uld2Q0xTNitNczIrSXpBanJTR2h2QmJsWHZKWWVsY0RabUVN?=
 =?utf-8?B?RjNJMHBjT0NiVTBBK0hIT3RuOXkyNGVCMThrajdpeW0vMjd2VFZpMU1TaTFT?=
 =?utf-8?B?aStnL1pzaCtrTmh2QkFtRDUzYm1JUlhFQ2pBTzRkWnIvQVROd2M0MVdCT2pH?=
 =?utf-8?B?QWR0ZWFvOElhVUVoUW8yb0d4K2dsbXhoVTF4OXZYWVFjQVg0UVhrTk85TU54?=
 =?utf-8?B?MU42eGtWVzIzWENidG9TL2tVRXpFWFVEWFB4cGcwVDJNY3FtK3hXdGtVckNm?=
 =?utf-8?B?OCtheDJ6dWY3YU1EV3Jxa2o5VHJOT2M0azk2Zk1LYXNRbEpYOXk1SnVzQWc2?=
 =?utf-8?B?RzdoZlhnOG45SE1naE1tV3ZoU0FueDd0enM0R0Mvem5QS2g0clpRclN5N0tP?=
 =?utf-8?B?a1p1Vm9nMXM1ZW1oQjd2K3M0MlFuUkhOaU1QaHlwUnZaSTdZNGZoVUlSc0ZW?=
 =?utf-8?B?REcxNkZtdjhVM20yMTZ6ajI4UDNhS25yRktHemMwZTRFbFV3SUlPNG9xdENj?=
 =?utf-8?B?ejFhekM5cE9DTHFKVWRrazAvOUs2YmMyZjFpaDd2Tk1tRWh2a2ZDOTQ1MnVE?=
 =?utf-8?B?QzZpTVBjZWhDcVA5cjQ0M3ltamVtMjQvUHlLNHNzR082T3kwd0ZrTC9pTFBi?=
 =?utf-8?B?Nit5K1h6UHg2ZmJNUXZxT25FTnpRSDJZaGo1allnaW03R0RpU08rNHVTZFNI?=
 =?utf-8?B?cE80VTN1eEo4TzEwSXJZbEs4MlpTODIrVElCTkFvdW53ODZzMkZtTWtNaHBU?=
 =?utf-8?B?SkpKN3ZaMWxsTlRVQ3BVNUxoVDJjdEZaUG1iWVlFZDNESkVTaERHODkyUzBP?=
 =?utf-8?B?MnQvTzNOVGFKODl3TENxeHIwZ3FacVljOWZsYlgzSm53ajJTZzkraTFTQXZp?=
 =?utf-8?B?R2FqNGFhOThseU81THh6L2VUSmEvajhOSU9ZQUluSzNZbWpiSk9RWVFRMkNa?=
 =?utf-8?B?aWk2aitUaEVGQzZ2SkgxU0tha3B0cEdSN085U2pSb3hPWnliaVhqY29lREg4?=
 =?utf-8?B?czNGODJOVTl2RXJNTXFlNURTb0Y0Tm5UVEdJbnRBRG9pT1VnbHJzb2x6M3VC?=
 =?utf-8?B?WTJINmF5eGdLbzU3Y3NGTzYzME1vMVNQdTdQWTM0dFpNUVJYQnBDM3JDL1d5?=
 =?utf-8?B?ZHBYemRMYUhqNXlpUmpmTE1oWnZRZ252ditrNVJwcThCNEpuRHBVWWxKM0ZK?=
 =?utf-8?B?MHdBMXMyRUJhU2JxcDZVemQzNDFqam1MWGMrTkJlVGt0UWloZ2UwYVFEenRj?=
 =?utf-8?B?eGl3WnFJZUFLdUVVMDNsUHpGRVB2Wk1qZ3lPMjNpNmhxUEFEd0xKdzZ0L1Jt?=
 =?utf-8?B?dU4vYzNGVnNqeE8vdC83N2M0TWZ3S3Y0ZGhmM2tJNnk1YnA4YkxaK3YxQVQr?=
 =?utf-8?B?eGRjeWQrVXVpTGcxYVp6aENRQWxXbVhiSmpkZEJxMEQ5dk5VUWZ2NlNaU0hF?=
 =?utf-8?B?MnVGNnpwMndSNkFPcnpiYW5GU2s0R1c0bHk1SE5KdUp1U1g3NmtCd3o1bW9h?=
 =?utf-8?B?bkJyUmEwdFJqK0liNnA4OHpxekswenVZTEUyekRPYi90TlloeW9PZHlPeXQv?=
 =?utf-8?B?OUxYNStHN0FiUTBkcnpGUC9rR2VQQlR1Vys2RkxXQVNZMmlOdS9HWjRLZksr?=
 =?utf-8?B?eG92aTlmSWdxMnVaTzBaclVTQjIxKzVYZmRwOXVTdUc5SCtjbk5GWTc4M0VQ?=
 =?utf-8?B?dHBzUlM0b1RXSlFsU3I1VkVqRDVVVnlUVnhoOGdnMzRTK1E5SzU2V0p0T2Nt?=
 =?utf-8?B?KzhpQkhmUEZTMHdCZ2NkZjJLM1UzUEx6LzRYOXRzaERrdnlDRmVVQXc5UkFk?=
 =?utf-8?B?ZjRGbmRma0VFbCtEeFZjbEw5TE5FSWsxdUR5UW9DamplNDdGbzZqWGpCQWNQ?=
 =?utf-8?B?dDV2YVFvbWNjRWRMSmJ0UU0zWW9QVWFNL1MxSEozWXVWUmlYUzVja2tTZlBr?=
 =?utf-8?B?OWZnbGZaaUJvaTAxVEFmRGs0MnpFZVIvZFFhUlIzcFFvZXpYNUpYb1p1RENl?=
 =?utf-8?B?TkZSVy9WZmU3SjIraEJ6NnlxMjhYeGNkWHQyL3lKTElWdHZBVTgvNFg5TnBr?=
 =?utf-8?B?MVAvYzRHd05TL3UzWWEvVHFBWmMxWjhSNTRLQVExeFVPcE9xYkowUGE2SXBz?=
 =?utf-8?B?WWJmWExYa3NqdnVFUUpUMXNkV0VpM1llNUt0aCtySmdXRWtnTW5KemhMTVpV?=
 =?utf-8?B?Q0ZxbVRtZm9VWFNMRmhRZW9Fc3QrNEhEVVA0SmNSUlE3WVpqMEpnM1cwRFVJ?=
 =?utf-8?B?MTJMWnViWHFkMEhadEJWV1VsUUx0ZURLaGVlRVBBNkh3YVJSYVdPRUNkQ2l6?=
 =?utf-8?Q?XAaCGpVsmt1tAUDw+s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45da7340-9534-4ac2-67bb-08def7dbee03
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 19:08:29.8299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubw2X5Hqr/R3z5A62ytjBQrdeOtEMr3DKiqLQtTf5vKDDBeCjJOBNch2g2KviidVJLq7qawd6v7Y0pOQ7p8hUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7261



On 8/11/26 13:45, David Del Sol wrote:
> Thanks for looking into this Mario,
> I'm not 100% sure of the root cause, and after dumping the
> ACPI tables I know my original explanation was wrong: there's no
> `_OSI("Windows 2022")` check anywhere in the DSDT or SSDTs.

It seemed like you were referencing a non-existent callback in your 
patch too.  I don't know how that could have possibly compiled.

> 
> What I do know: the combo `acpi_osi=! acpi_osi="Windows 2022"` reliably
> takes charging from ~0.2 W to 31-33 W. I'm isolating which half of the
> command line actually does the work now (testing each half alone), and
> I'll report back what I find, then update the bugzilla report with the
> corrected story.

It's more likely that the 'acpi_osi=!' did something IMO.

What strings are in your BIOS?  Have you looked at an acpidump yet?

> 
> David
> 
> On Tue, Aug 11, 2026 at 12:52 PM Mario Limonciello 
> <mario.limonciello@amd.com <mailto:mario.limonciello@amd.com>> wrote:
> 
> 
> 
>     On 8/11/26 12:48, David Del Sol wrote:
>      > Hi all,
>      >
>      > This fixes slow battery charging on the 2025 HP OmniBook X Flip
>     (AMD Ryzen
>      > AI 5 340, DMI board 8DA8): with a 65 W charger plugged in, the
>     battery
>      > charges at only ~0.2 W on Linux instead of the ~30 W Windows gets.
>      >
>      > The EC firmware only enables normal charging when the OS claims
>      > _OSI("Windows 2022"), and the DSDT/SSDT only check up to that string.
>      > Linux's default claimed OSI strings stop short of it, so the
>     fast-charging
>      > branch never runs. Adding acpi_osi=! acpi_osi="Windows 2022" to
>     the kernel
>      > cmdline restores 31-33 W - verified across multiple charge cycles on
>      > kernels 7.1.6 and 6.18.42-LTS.
>      >
>      > I checked with HP first: they declined in writing (warranty case
>      > #5163282638, supervisor email 2026-08-10), saying the firmware is
>      > "specifically manufactured and optimized for the Windows
>     operating system"
>      > and not supported for other OSes. A kernel-side quirk is
>     therefore the
>      > only fix path.
>      >
>      > The patch claims _OSI("Windows 2022") via acpi_osi_setup() with a DMI
>      > match scoped to board 8DA8 (same mechanism as
>     dmi_enable_osi_linux), so
>      > no other platform is affected. Full evidence - DSDT/SSDT strings,
>     EC RAM
>      > dumps, measurement logs - is on the bugzilla report below; happy
>     to add
>      > sibling boards as owners confirm.
>      >
>      > Thanks for looking,
>      > David
>      >
>      > Link: https://bugzilla.kernel.org/show_bug.cgi?id=221866
>     <https://bugzilla.kernel.org/show_bug.cgi?id=221866> <https://
>      > bugzilla.kernel.org/show_bug.cgi?id=221866 <http://
>     bugzilla.kernel.org/show_bug.cgi?id=221866>>
> 
>     Are you sure about your proposed root cause?  It has been enabled a
>     very
>     long time.
> 
>     https://git.kernel.org/torvalds/c/dd067afe3f8cb <https://
>     git.kernel.org/torvalds/c/dd067afe3f8cb>
> 

