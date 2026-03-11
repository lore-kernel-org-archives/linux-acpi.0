Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011028.outbound.protection.outlook.com [52.101.65.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2F22E4257;
	Wed, 11 Mar 2026 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.28
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773236565; cv=fail; b=KVwflBChFx6jP5LSM9TLBpPeUB0tVFmEApPOfUzSVGgU1MzOgK5+8tC2DMuYuHOpwzXeyueulKvgfXhlv7LHccD7nrTYG8y8bktpZmzcwsoy59mccdydZksIoqKF7DQsHMRqSjwl09uJsixM3Aa0J39GrH5QKP3KBb2tL/XeC68=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773236565; c=relaxed/simple;
	bh=GChVai2WoBVzCEYHA2Ztw7/9SMk9lMqv9L82N97eMiI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nmq2NST8QrzMug9CiLveq/ndTWpzLTepsxpTKti2VrDIv5qQ9iwIynTscprhpi5TruimO+CdaNHeiLKxoPmkCFiVrUB2S979/2+NKmJ1JPFPX93uHCvedzwFoyBsW7VZlJ/1q6kmAV2eH0xb7vhTYLl8mArctyMFOFzZZiRkytI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Tz9yk4hB; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Tz9yk4hB; arc=fail smtp.client-ip=52.101.65.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Tz9yk4hB";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Tz9yk4hB"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=JaJj/vJJ/4DUIQ4tFLTiJ/iSByk7loj9eOOvgK7wMMy9aiAAqjjGoEgVBP9qlRxKLpH6L+h8aC0JxMliS2foCOexUltDKzd1q54PjMAYHERbfRUDFMzS6equjTtiw31GjQy1Gf7f+Ja4dB42H2JNDQ0IjskH8qYx14oV8djBhbgwgZ7O3k2tz8uZCF1gfPXVEwikUNUsFFpeonkdEyP8xtjl1hSqzgbcClHPa0b4EI+Fngu4I2a12ofCSr1pHvHiFbtdmpU4eKZGIn1ON51EtEbJR8vW1u7nu7ML+jFxMJQreBgy60Ku400qj1RoJ9DjxJVFTUeRltwntAU5nV49zg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+HoSVKjxFIqFjlRtaAPGrWAFkJPI9iwGYPeIW6az5w=;
 b=n4xJYYYhFwFnTYmCMmDhBkbUA+KRLZFkrzKnDn/oEPYLRK7q0wx4VcWVflt9zClh/8eBM8fSVf8M8sDsGMxnBhkNglWapZvv25USlu6sSn13LHW5aWnQAvAXfiUgR3KoxXA+I0IMXvDy0ADSgPHTyAx8lAB/Na/FR+4gMlsXILDqjHdz8KTMjFqmMjH43qZjxjZndqPj10n9S/Zz4I0kOLb08yoi7Q75+IJCmk2oJbz3d7b1YlS4XwiVTbpcWNp/0aPbxAcaYNRHEnhEl9sC45ZodO8Pn9fIWUecUyxb6nyGU7ET1mo1oou7DNpUUhrUJrjOc5aNQAP/QugIutheSA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+HoSVKjxFIqFjlRtaAPGrWAFkJPI9iwGYPeIW6az5w=;
 b=Tz9yk4hBrJ5xRoiCHPoGW8CRB/SaT9DcNn16bluHyLkJCs7RYRsU2H/2k0cmmNTTH/xaPM5DWIUek12hDZwNQb7gydQDHA3NLgZVKiqDhXCa0oC9HWlhNSmJXH5N0R7SRZnIOh115X7hY0T7XrnJTKL4UCoxEMa0qSIkazuaSMw=
Received: from AM9P193CA0030.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::35)
 by DU0PR08MB9106.eurprd08.prod.outlook.com (2603:10a6:10:470::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Wed, 11 Mar
 2026 13:42:38 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:20b:21e:cafe::bf) by AM9P193CA0030.outlook.office365.com
 (2603:10a6:20b:21e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 13:42:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Wed, 11 Mar 2026 13:42:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnYz+AnpiZNnGwfoaKGpwqkr3fYEF48GcQlXz8cU/Y934CQvZjN1FXQN3XL07V6qh41lKdXBdGmtB/LCPA5d8vKFYFW9ZAmHpr3Sieu0AS/yt7FPXvZ0nYekY32XnX+7YaLfzOUH5rxt9JzckOX5dudJ8ZPNIT65MVfSA8Y9bg2m5qCE5uwi6IZhPdRbJPFOaIXcbPhzGScUXQHBt4d+p8vzENsNiSqAMckI0PXg8+h/WHcLcX+k71S3viLCDidi50aOKNqOhwvJP2mSaFH2nn1PIT495+c4juDN9kN6RxuZoR/yKvlDPhXbOBCEQANxXnstls5yYY3d5hPmF18ZRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+HoSVKjxFIqFjlRtaAPGrWAFkJPI9iwGYPeIW6az5w=;
 b=RWBWzZYOHJ11lVCTpzAZH1LMSO/zh/Qn89QrKfK5icIc4WKXTKU0g1iwdWyf4jXcqf3gz12MrCR1i5RgQYfrBBAZcbuD79noLxw0nCWL/Qju5wlY4ELOnzvG2R1xpw43F2xYQqeAH6ah9vJuTEAhqVU63JlwPD5VwPQyiTydb6ZyaAuIZmue3g2/yxG3pf9ttKn6Gk/6BxSsqlP5290VBiFQCKW5VOuRaRywzeX8LJJRWvlOvpz48QlND4B6i0efLuC3egC/uaeiY4kZW1OZbyqhov2f+AYftNdG5QI0Y2ORxhmnOMhZZuXWq0HBtrI+TgdMZBcIFZi4a3n5dJ6YSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+HoSVKjxFIqFjlRtaAPGrWAFkJPI9iwGYPeIW6az5w=;
 b=Tz9yk4hBrJ5xRoiCHPoGW8CRB/SaT9DcNn16bluHyLkJCs7RYRsU2H/2k0cmmNTTH/xaPM5DWIUek12hDZwNQb7gydQDHA3NLgZVKiqDhXCa0oC9HWlhNSmJXH5N0R7SRZnIOh115X7hY0T7XrnJTKL4UCoxEMa0qSIkazuaSMw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com (2603:10a6:800:324::5)
 by PAWPR08MB11300.eurprd08.prod.outlook.com (2603:10a6:102:511::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 13:41:35 +0000
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd]) by VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 13:41:35 +0000
Message-ID: <16a5363d-6b34-4853-aa3a-e4b3023fb81a@arm.com>
Date: Wed, 11 Mar 2026 13:41:07 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] dt-bindings: firmware: add arm,ras-ffh
Content-Language: en-GB
To: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 Dmitry.Lamerov@arm.com, catalin.marinas@arm.com, bp@alien8.de,
 robh@kernel.org, rafael@kernel.org, will@kernel.org, conor@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 krzk+dt@kernel.org, Michael.Zhao2@arm.com, tony.luck@intel.com
References: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com>
 <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-10-347fa2d7351b@arm.com>
 <CA+Ht8=ZSUGF9KQqy=yZ56kEDwsv3TvS6rLcMD85iwDxwOr3rpQ@mail.gmail.com>
From: Ahmed Tiba <ahmed.tiba@arm.com>
In-Reply-To: <CA+Ht8=ZSUGF9KQqy=yZ56kEDwsv3TvS6rLcMD85iwDxwOr3rpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P265CA0019.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::10) To VI0PR08MB11823.eurprd08.prod.outlook.com
 (2603:10a6:800:324::5)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB11823:EE_|PAWPR08MB11300:EE_|AMS0EPF000001A5:EE_|DU0PR08MB9106:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ce50051-4fce-43b1-d3f6-08de7f740ee2
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 CtJHfLFgt1YVylULgfuYDSvUtr1anHgEeKCrdSlEDNXTJkemFVeyl7lnpmxU9D7aniBEwbsYBDEgF1JtOD5B0f0ZG34A7QFVQycsGb2Fv5pslNI6PwImAX+xeNag5crmCB//n0dZGFJ2dOLDQvADVsLqpG3Ri32cfpRZUkowhfylbZ9vC6LbjOlgISeRUW+od3vK/vKS6O1esxYTo5+7CzMwHvfwAg091vMhz1bbzD0sKJWb9JiWNr4pV4S08/rxqjqC9aoRedMQ0lN9c9Op1Lmf57zEfUykStS4J1HmTOeraOCVZ5A29srI6p/BnVMjaufFdWhR2VQb/k1FrNP+XP0RTpAYH5YKOdSU9Rzbhl/55jts6uCtYw7mx8RRpldBFOepvKp+PYMe3a7QtstNaqRbCQeLdVxgDMIzbj0pod9Lmk7O76vwwfV+IFWfj1g+1bp+MHS60fMcgHQ2xxaAWGsTYJzKtmmyAaDpvUIf4WxaDus+ul+z2jTQrRhCKzcaY8aiHjsG3J7S6tLoHP58WdfWCcw6LBgY/Fa//o8QDHj3UziaMbkXzJFr1eAd7ELy74bXPRN50OqK8utOjm7MwXNinYCpftMjXKolSPBcH8LpxNrZWiPOdW8WLLOM5UQyr4ODDjVe2g5KvhDD2XgLp26Oh86dZ7ADUe9zrfQWD1XP43cZp4UhdrFSYJedCBO2
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB11823.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 VFqdrvGAYh2bpEgKh9DG6ev89ucHlY6IYHWGJrBdzb9pEhS9bXo5NcWFHlV11Vtwt+qJhjm/wEgbvwe2AS3Rj9zgOylxBSpBslWfS38Q7sqrugi5AlkOY2huGRqmuiT7bdOlT3y8R5CAmBZguU6cCNdISAOILFrEAIhTUtuYUEnGplt77ouJdFwddczOYz303zLHesY+3U/WawgeW8DCCiiahLYub7ZV7yXFSr50T8jnraLWlMST4MRl2FTjWbujZi0CtfaFD1nQQID34DutaVyC04fAm2zwAbDWCjTG9hzuNyPXvwEQtbZ6Flvng7QQLNKox7qbQ+0F4/+I4Tbbqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11300
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	62a8a403-a5ee-45e7-549b-08de7f73e986
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|36860700016|35042699022|7416014|376014|82310400026|13003099007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wm2XXCs1JlB8C4OwEaH2a6NRei58+rXVt1EMcw4BWV1ELe0+NsGHHVQKSBOAzmUjoqHQ7RW3ifykM1PHt9BvAARmb1Lwz6qUkkh9Uc4EYfrMrRC6CGGNluKooYAun2b8dQLqrP0P5LWtdhZgvfLcF3zY3vdmiUfYwOm/cSWGeUX04NyKRm1WEPy3QGec5GIhQacpqOSoO6Pql6LlbIGoOuDcjXqoQWo3HMVBxzGmttHPLFZuxBI7Mk41cb8UtRGilPnVpHdif5HxFkGIfmPT80q1KQh1Q7FppyYsBNxQa2IO+FDPYrmhacUAt/2KUX1Cp9dTyiZgH/JVP/XFy3umlqaG0zdK2FiEoJZi/RvkxpZ0Aeey8nMjgLUbvk2s84ffsqcykvlte9+yrDxEn2t3A4MZr2bIH5rEWwENeaWbgMMKDkT3K2xyomGWzFa93hz0ExzCProKKuPomFreGXwdJhpcpaJkE3Vgjc4s6VAZ0XzsalU8qjXsbhMg1mJmLxQG9gnBh/knE4+NgHs7TzTnsavmfwcRBW2S8HhUFaWTRzZalsXb/F6Wic5zoh0OvEx2laRXecpzWSxeChJhwF8m8O/wDpLASmZ/q0jcHbN9rq/0OopKUkXZ5QCV3TmIr5HnVm7TEOvwgMDkD+s36jh60DurrWI6R7uMsyWXML4ysDFS6k3H4VTTb9Ck7GU6jYLXUix8L0gx9vY9bGRuwVl9iiPccd4cATS2jt7eztKDvBE=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(36860700016)(35042699022)(7416014)(376014)(82310400026)(13003099007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	U5AxYTYfnBxRz9od0hyAdN3gW8SH/V9pCALyJLxJK+3FS9IYatVz8b3C9hQNT3gPWXa8EpVx8OusEVSyk+q0Mc4jOSy9Dajb7ydoQaoXZJhp4jENBNUKxs238VLyHO/sGERqEqhvYOcOlPVO/wVb9ap6lQXn4f+8J1kLPXu5KlgRoPN2aqPLEHnYA3Gcr5jvCTZj6rpdfcxTK0otxEc+yt7zEcvZyeC+P0pxY7/qfx7VLk7N/MBxZdbye3zKzWVr3kvJPKIC8clfX4UcDztZLgfsvUFFMJYicylsB8/1MtBZgyuzYK0Pln78qofg7ZbtlvO2KdQXFYs3fpMsTWe3FPxU7u/emZps7Lt4DfuPz/r2W3+o0vRHyCNA6Hpc+SdgrnI6AOWSency6iCA2Wcy2WZ2uOoPPB+6Trj9WSgCQW7b0+NU8Dpi7FhMyqeZVFSV
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 13:42:37.4900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce50051-4fce-43b1-d3f6-08de7f740ee2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9106

On 26/02/2026 07:03, Himanshu Chauhan wrote:
> On Fri, Feb 20, 2026 at 7:15 PM Ahmed Tiba <ahmed.tiba@arm.com> wrote:
>>
>> Describe the DeviceTree node that exposes the Arm firmware-first handler
>> CPER provider and hook the file into MAINTAINERS so the binding has an
>> owner.
>>
>> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
>> ---
>>   .../devicetree/bindings/firmware/arm,ras-ffh.yaml  | 71 ++++++++++++++++++++++
>>   MAINTAINERS                                        |  5 ++
>>   2 files changed, 76 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/firmware/arm,ras-ffh.yaml b/Documentation/devicetree/bindings/firmware/arm,ras-ffh.yaml
>> new file mode 100644
>> index 000000000000..eccbaaf45885
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/firmware/arm,ras-ffh.yaml
>> @@ -0,0 +1,71 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/firmware/arm,ras-ffh.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Arm Firmware-First Handler (FFH) CPER provider
> 
> Please don't called it FFH. FFH stands for Fixed Feature Hardware and
> ACPI uses it at multiple places. It is causing confusion.

Agreed. I can drop "ffh" and rename it to "arm,ras-cper".

>> +
>> +maintainers:
>> +  - Ahmed Tiba <ahmed.tiba@arm.com>
>> +
>> +description: |
>> +  Arm Reliability, Availability and Serviceability (RAS) firmware can expose
>> +  a firmware-first handler (FFH) that provides UEFI CPER Generic Error Status
>> +  blocks directly via DeviceTree. The firmware owns the CPER buffer
>> +  and notifies the OS through an interrupt.
>> +
>> +properties:
>> +  compatible:
>> +    const: arm,ras-ffh
>> +
>> +  reg:
>> +    minItems: 1
>> +    items:
>> +      - description:
>> +          CPER Generic Error Status block exposed by firmware
>> +      - description:
>> +          Optional 32- or 64-bit doorbell register used on platforms
>> +          where firmware needs an explicit "ack" handshake before overwriting
>> +          the CPER buffer. Firmware watches bit 0 and expects the OS to set it
>> +          once the current status block has been consumed.
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +    description:
>> +      Interrupt used to signal that a new status record is ready.
>> +
>> +  memory-region:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      Optional phandle to the reserved-memory entry that backs the status
>> +      buffer so firmware and the OS use the same carved-out region.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    reserved-memory {
>> +      #address-cells = <2>;
>> +      #size-cells = <2>;
>> +      ras_cper_buffer: cper@fe800000 {
>> +        reg = <0x0 0xfe800000 0x0 0x1000>;
>> +        no-map;
>> +      };
>> +    };
>> +
>> +    error-handler@fe800000 {
>> +      compatible = "arm,ras-ffh";
>> +      reg = <0xfe800000 0x1000>,
>> +            <0xfe810000 0x4>;
>> +      memory-region = <&ras_cper_buffer>;
>> +      interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
>> +    };
>> +...
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b8d8a5c41597..47db7877b485 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -22027,6 +22027,11 @@ M:     Alexandre Bounine <alex.bou9@gmail.com>
>>   S:     Maintained
>>   F:     drivers/rapidio/
>>
>> +RAS ERROR STATUS
>> +M:     Ahmed Tiba <ahmed.tiba@arm.com>
>> +S:     Maintained
>> +F:     Documentation/devicetree/bindings/firmware/arm,ras-ffh.yaml
>> +
>>   RAS INFRASTRUCTURE
>>   M:     Tony Luck <tony.luck@intel.com>
>>   M:     Borislav Petkov <bp@alien8.de>
>>
>> --
>> 2.43.0
>>
>>

