Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFFE3DCD9B;
	Tue, 17 Mar 2026 15:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773760422; cv=fail; b=cNBe1+H3bZeoF8Jz5smA3TJwNwDbDCf2Ecrqno3CfLAHNUiPDh644EysgI4xmsMil3LPF4I+TZQLC7jSNp75M5JOLZsN+2lp6KX0cT+JcaXcEYqnBU58JpyKAIzfZSbWgcW0Vti8MkXEWpFEVj2SErpslyD9o6rbsep9aobiMqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773760422; c=relaxed/simple;
	bh=wNAz7wEGpTH1eMgDZNcGifYjzcLSEC3ywg57QhJpFd8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t6JGiVTY9vT/u8+lKzm9zibMS9Ex9kOv5sq98sAZuuHLEHufWkiUJR+nmEtMO6Hl8HVFknYpaT3fcTuv7NLtZyKvJZJyNlPBEs/2xmItXn/Tcq52FfThrCJo+b1b3ie/T9MuMOaCeNbGIOwCzMBobuI2+bbN7z82LX5qQrdrDhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R5Xsq1gR; arc=fail smtp.client-ip=52.101.201.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R5Xsq1gR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7nrCURTyjCWRQOoFdMr//Ol6HlbHXasL9veARXmBKEEdmviaSBqGYdiz4XB7nOr7+WVWN710m3CnJaoVtONFM8O+igPzzN5QZ477+2eTlyQ2IPf7htWeuhMcQADNXzTuoNaUZVxhI0vnIo+BR8GfEPiA7LW6EtBAp0kxzhA8hk8rbCZJESeX++aU/twA2fiUZ+8ec2XC4+pPuI4QRrvdPXlqdgLSZkvWwhtDxfKFwH2WLGJip0m7UlzIT9cOCtf5/nw0t0Sq1qqU8T/+GZbMn/2CmG9GgIUolmq8Y0r0Xp0Gr6U+J08NzOJdNA4cS3Y/86fLlas0aq7+xM0XJPnLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHl5v+JQiUYDpHCBtKnffo7RDHiqCGD/QSbS/ckMexE=;
 b=cFC6J5qh5IFzuDFAGgkynXqOQoAa1Juoj9iVFV63szvKdqw/6GPl2hpr+9bJyu3tDp4R7otm3A8SCWRtQ0rtWogWA6y1kk+nU+RYdHrhvnNQCAL/BtVkev6B9+aHvh3JPWIsA9LdQG3QssH7zTupN/PUNr8J2L3wjMtXNcBjdyNEYemcKSHz1+Dl4+JeNSjHr3aLh3OV/6fCsK0Z1nMsYMQFzK9iya6qOYO3Kw0m1mn3e6koqElZ6UWqzGLJMPQH8dQmCLLzFVElY6/zbeHnjf0LLyn41uqJcDR4gxtSbG/CgN6f/px+PNbuS+Ww+nHzgV6Cig+WPWVLNWEXI0j2NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHl5v+JQiUYDpHCBtKnffo7RDHiqCGD/QSbS/ckMexE=;
 b=R5Xsq1gRFJwOu+UF66PMFc+MmvpqzOPuZEk4g3wWDIY2f9TsrlTU/OAQfRjBfBJoJYImhyrI1xKaB6raCo6zcJnc1uQDetaM1r0GMqTAc0s0H2A1FuEoEvmld2Zy7I9BD6BOPLsZYvz4tuJHgl8XBY7SFBHAvrNPhcbb9C7tS2I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by IA1PR12MB6283.namprd12.prod.outlook.com (2603:10b6:208:3e5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 15:13:34 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 15:13:34 +0000
Message-ID: <35f773ff-6514-413c-988b-765bf2d0d293@amd.com>
Date: Tue, 17 Mar 2026 10:13:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 0/8] acpi/x86: s2idle: Introduce and implement runtime
 standby ABI for ACPI s0ix platforms
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Antheas Kapenekakis <lkml@antheas.dev>, bob.beckett@collabora.com,
 bookeldor@gmail.com, hadess@hadess.net, jaap@haitsma.org,
 kernel@collabora.com, lennart@poettering.net, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, mccann@jhu.edu, richard@hughsie.com,
 sebastian.reichel@collabora.com, superm1@kernel.org,
 systemd-devel@lists.freedesktop.org, xaver.hugl@gmail.com
References: <20251226102656.6296-1-lkml@antheas.dev>
 <CAJZ5v0iG-SPmqMYJExeOUGo301tL=+qyi2479QkXoR5Dq0d9bA@mail.gmail.com>
 <CAGwozwGEgLpjFTCF4kinR9+-_Wt=bYw19dcbVOswYe998z8Ykw@mail.gmail.com>
 <030c38aa-353e-4387-a006-42e641b3ac6a@collabora.com>
 <CAJZ5v0jbDqs=adBX-o-MDyNX+=Q6UAkw1=gh2y_9cAMMi+gi_g@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0jbDqs=adBX-o-MDyNX+=Q6UAkw1=gh2y_9cAMMi+gi_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P221CA0043.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::23) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|IA1PR12MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: f43cccc5-d72b-4451-999b-08de8437c190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ZhkH06A4GpBPsvotGR29yc3C0/PeKJoY4INgkEs7cGUHwglxaI3uhXC9RKJj2ommXsGs2brM1A7qeTkExRS2IvRH3h3pdRc8HiBpXfSfdxxKhYRnLb0jVqOCoqCiza5DqMD2TNzXrflE7rXxhpKwnyWjHniJVnl6wZFR/Zf6F+r5y1sLCWVU3tffWfEyuCyV7FPIzo74faAA6t2Cocd+TFefKOxWWfRsmxdjkjocu2ysaz4aXa5dd7iE95PLXaKq84vTJEgDCahYxZNSBJfH16jgFaGlPfvKmxHDPnJe2yn45rRT9sZ/jkPP7c9ziwIIpGKcSJu2sQtrGFzUB0JL84VFKjTltLZn/rLx2KliaIt6gJ/KZnFeSG4nVjpyA5vqS3QUzAJm0RZMDbBONmryAthfTorj3zEnERxEkjAmOFrRKWj45jgUjl7FutrVqR9frI8KvmkrYSrch//d7u1AVnVOmUkoeVOwrP5F8IgvNNSqKsvxMEAHIXLeiWnAWbRjYQsj/9SCp5L6Pb2XrSx9WuN/z/YIL3P2xTkMEltb75wwIlKPc7uDJiN+UWrWCBrbQNClFm0NdJe4CCO3kDHcBOWatkVGZn2sNPmuxOqsGUhh+9cIJXvzbUuIbOpU0KUtso7cq9NXJEVdTkEWWFZ25O584RcOv9LWHUTeKV7GR1jTAiDAW8tmO9kawN2JLkaPyPx7MLxahKNrpBlP+KDH3ceS8oUEfZatEXr6NWdwH94=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWo2TnpCZ2dvWE42UVJLY0V6TGoyRFRWV0FuVDlUU1ZtdFdibS9CaEpUd2VW?=
 =?utf-8?B?Mm0ycGVhbWJmWjlqa3NES0RCMU1QWDdWQWNGMnZkcE1kaFNsUTRQWUNOOXZO?=
 =?utf-8?B?NzBNazlUMjVJenJ2ZzJYME5zQVBSVHRKUk05azV5dWxENDIzY2RDbGdpMTFp?=
 =?utf-8?B?c2RmN2lhdlZVY01GVE5FWUN6NW9TZTR6VjV5bFdQNkxtYjNrWHlNekdzalV2?=
 =?utf-8?B?SzlZSlR2eHlyOGlMdmFCR0Y1eE9Xakl1b0QzQW10RlZhb0s1K2duRVF1N2tl?=
 =?utf-8?B?ek4wa0t5YzQ4WDVZYXVVSmxQSzFETWZHYlZrVWFaYStlR1ptWk9QM204SjJl?=
 =?utf-8?B?MHZVaFRha1c1eTZwL0Jwa3o5VmhGdzJCYkNwKzdobkdpdnl1dm5uYzFNUW9Y?=
 =?utf-8?B?VVU3RHczTkViaGVvaHBLbjNNRnNRSlFWSmI0N0RFbW9hdTdIbzFReXVwMnkv?=
 =?utf-8?B?eVdoVXJnYmRPYzIxRk9MZXdBa1p2NjRVMUF2N3B4WVluU21DTU92UU9KOXhl?=
 =?utf-8?B?USszRGd1Z3FXcTZmNnFCZkM2a2hQcHAzc2wzZkFsZ0ZmdFY0eVhnYUJnREI2?=
 =?utf-8?B?eHN2UG8vTWRNYXdORkpLeUpFUXRUVGNEbEJvalo5NWVrYmJyVmJJeElwSytD?=
 =?utf-8?B?K2dWb0krYXBGTjBRS1oyWWxRb24yOUM1bDYyOElrKzRjVEtKcHZWZWFibUdT?=
 =?utf-8?B?NUM2b1AwQ1dlcVlOeWtwTW1jeHlraWZMRmU3bGZjVzJPbjFCOWpmYWU0Vlhz?=
 =?utf-8?B?Tm04eWg1KzhJL0oxaVBkMTBqZm9HM2FpMGpEbDdJZmN5Si90MXNvaGtVdzBN?=
 =?utf-8?B?YmV1VXRNMk1ob2RVakhHZE1kQjJhS3Y1bGIyR2k1bThtY3crQ0JNRmxpcUx5?=
 =?utf-8?B?MlF6azJXTHRCQ05KNDZoS0ZSUVpPZUJuOVMza2dRdXVQN2dnSTNzcHJGUUhy?=
 =?utf-8?B?UWwwSk9FVFRxL2JoNEUrN1dYTjBOc3F3S2ZpSStBbEl2M2hOQmNFSGdENHcr?=
 =?utf-8?B?RDloeWg2bFlXWC92Y2hTMnpCMnlaUWsvM0VPQ2pVYy9uckt1VUJ3cmcwc1F0?=
 =?utf-8?B?emZqODRscXpxYm5LTi91d2lsV2h1SldkTkczUEt1bjZBb3JRZkdQK1dVbHM3?=
 =?utf-8?B?U21iSm5FNkVwemFpSXJjVlR6aUhhdjZSZDdZOFNFaHp0YTJKbXB2dmhFeUNV?=
 =?utf-8?B?U1VQVHhQUFdPMmNFTSs1cmxrcGV6YkpWR1NQenhTUUVURklUUDZGRkx6S2dZ?=
 =?utf-8?B?SHZkL3pxVzRLZDZkQ04zNzVUMjlqRnNyQjU3aEZGSlh1cFdKa2VEdlF3U0U0?=
 =?utf-8?B?Mk1RSmw3S0R5ekJnNDIrbHE4d1ZuRFdNYy9Qc1ZJNlE5OTJXdHoxTUd2d29L?=
 =?utf-8?B?V0o2WXJhZERrbkdZQWpZbzM0emlseDFHQSt1eWdHWnNnWDkrUVovdVpWSits?=
 =?utf-8?B?cHM2WFF6cjJBcy9QVzMvVUFEQ2tRdXMwRUhPbWJkMVVud3EvZzNLczJSOGRP?=
 =?utf-8?B?VFZWTXZtZVBySnRwMUxIVWVzUThTdzRLUGI2SDZpd1JuS2J2MHlMVktPUFJK?=
 =?utf-8?B?NkRGaENrUkUrNnRmcFN1UGdGSC9ORHBKK3pOYm0xZnV4UEJUQS9jWjZhS0lm?=
 =?utf-8?B?cW9TSEJGekVuLzh2dkY0Qm5KQ2Q1eFh3TG5sZ09uNkUxdjRkUUpvMmZGNndQ?=
 =?utf-8?B?ODV2eWdHaXRWMGd1dkxZNlhCU29TK1VtNzg1NXNNb1ROS3MvL3diRFZMVHQv?=
 =?utf-8?B?WHJqWkNxQXNBQnV2RnBZdTlSZzNxby9JRHhVYldrTzRHYXVXaEwvYlBFTTd4?=
 =?utf-8?B?QzQySkx6OTFnK1dKOVZrbGd1UjRRaml1R3JTZDlmaVVvZFNLdHF3TkpHVElm?=
 =?utf-8?B?b3Q3cUNiM3NTN2N4OGFTQnIyTmhGTjI1ODkrVEVvOS9lZm11NDBCSEwvYzVr?=
 =?utf-8?B?dmJZMjNURnNOSjA3M3ZCMHExRk9LN2hPS0c1YnVrWmE3OVNCTHQzU1JUd3Fo?=
 =?utf-8?B?aDNzUi9rNnF5bHhUTEV1cjIvQVVRcnFGOVB2UFV3MmEwOTdLSDEvc05ldGY2?=
 =?utf-8?B?d2hwdm96SHBlRjdEcFhXcXZYMUxxaUJUOEgxNlpaOFZQNENablFCTnNWbWtP?=
 =?utf-8?B?Y3Y2dG40WVBxVHIrdlliT1VYSk1NYVV1bFN0WnRyZDk5UnNYN3hqR0x0MUV0?=
 =?utf-8?B?UnJJU1FIMkhxWUhqV216NU1XbE5HMDd1K210TTByTGZZRy93dkpoQWhSaU5y?=
 =?utf-8?B?bm1sRVNtVHh2MFJLeWpIeXQ5cjJSSjFFMkZ0UnRFOEtqZ0FBTjZJbURrQXRV?=
 =?utf-8?B?SmQ4VUR6OXZEVEZNRmh6UVZlbFFod3V5MkhKTWxTWEhEKzRlNlZWUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f43cccc5-d72b-4451-999b-08de8437c190
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 15:13:34.2004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BHBdZ46zo1Lkecx7gYXx2iJevKi9qRmpCFhqBjgpBVRLzEO+s5u12rAPdgUgW0iNpp/TrURelBP+Ya8MsB3Axw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6283



On 3/17/26 07:09, Rafael J. Wysocki wrote:
> On Tue, Mar 17, 2026 at 12:57 PM Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
>>
>> On 3/16/26 22:52, Antheas Kapenekakis wrote:
>>>> So in accordance with the above, /sys/power/standby is not a very
>>>> fortunate choice of the name of this interface and I'm totally
>>>> unconvinced that it belongs to sys/power because its role is not
>>>> really power management (and it is ACPI-only for the time being).
>>> Hm, most of the changes / implementation resides in the pm subsystem
>>> and it is related to the s2idle suspend flow.
>>>
>>> I assume that when it stops being ACPI only provided we reach a design
>>> that allows for that, the related callbacks would also nest in pm ops.
>>>
>>> Where could a more appropriate directory in sysfs be? I would still
>>> tend towards /sys/power
>>
>> Question is whether anyone outside of ACPI will ever need the generic
>> interface. Making it generic based on guesswork could be a wasted effort
>> that Rafael and others will have to maintain. The mode file could go
>> under /sys/firmware/acpi if interface is made ACPI-specific.
> 
> Well, experience shows that it may end up the other way around.
> 
> People once thought that the platform profile interface would be
> ACPI-specific and we ended up having to extend it via
> platform_profile_class.
> 
> I'm thinking that something similar may take place in this case.
> Platforms that don't use ACPI may also want to define platform
> triggers to somehow adjust platform settings and those may be
> different from "inactive" or "snooze".
> 

At which point you would almost wonder if this should be super general 
like "foreground_workload_type".

Then this could be expanded for other uses later such as full screen 
video playback or full screen gaming.

There could be hooks for scheduler too in the future from this hint too 
then.

>> Will be good if you could demonstrate a need in making interface
>> generic, if there are any devices on your mind that could make use of it
>> right away. Old interface can be deprecated if a better new appears.
>>
>> Either way is okay to me, but Rafael is the PM expert and I'd do as he
>> wants it to be.
> 
> Thanks, much appreciated.
> 
> I just want to make one thing clear.  Linux does not implement
> anything like modern standby and that's for a reason, so I don't want
> this thing to be advertised as "Linux modern standby" in any shape or
> form.

