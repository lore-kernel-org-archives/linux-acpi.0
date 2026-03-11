Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010042.outbound.protection.outlook.com [52.101.69.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02F93E0242;
	Wed, 11 Mar 2026 11:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.42
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773230198; cv=fail; b=SMx6DZ16jH/MccrlZEh8utcFAs8C9Xdwosb6/QY9smSAlUuhdUYkYvtw0LzmUn3/Rhvh6z7xy1+jHSvftILiNTYZiZrXi88pW3BPvnV10xIQHwKCSvfemLPo2Pimk6nDQKwiEzuQNKPiyOBT8nAKgDYu5rhZvukmyDKQP9xz8uw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773230198; c=relaxed/simple;
	bh=rgsTxt0yDJ+hy/9CnbM7sOXa2IhCw7OXJnfJ4x9sxXc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PLQp92RDmWIxw9KJu2LDnCzMEOVJQFfJvd0WUeFSEAV842ZUWQcLHA7m5AWWXyycEAFiazYc9kMbjjNiqkMwPyAFUlhcn2hnzcxFG53qPqw6uQkp/KGAY3AiloU95IlKaT0oiC8G9aZvdqyL3cnt8Lu5qBA06C7aVuMkGFwlhKo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YdqBRW6g; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YdqBRW6g; arc=fail smtp.client-ip=52.101.69.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YdqBRW6g";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YdqBRW6g"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=PvuRuwbkXLHHffP+4sruz4AyZOsgmI2ecP64siAmhwB10A6Zj2z/HpvC875Ppfk4aPGpjNbGOkgQYqai5mmzuWyEfs9493RCEUMf8s1kPZCTjElsn9ayNAeXYsQoaci8wn2zd7sW4FX6WjKKva58+yQ8AHFKS7x/YICKQT5RspqTfRoOOipNp8LBJB7+15iB+4wOX4o1cWwaz1DF+WVPSgEbUpyvywPgbKtFiuPWF54C2Eg+y62m9YBAwnFIcYB3b6nQYC2d7ypyoe6T34o+cGpxFH6bQYY8D0Z4H78o/luZRzSRa4J8+2hOWzRj2f1Xb3edBy82fagoHKF2xjMfXQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNKT2kE4KGI1QU1dgQn/wggreYmxWDWpePTV8f+IzsU=;
 b=XDLdCVwn7wr9LOs3iYPomQgFlv4Uax0K7bJIfIBbRcHt/QH8UTOR4FnAPbLG1EVjHif0+U+NRsWBLyqiPYZxiy/uEeTMvmmt+Xs4fcI+Nb8OOaoRpoeZPQwOIfZMcBv7ClvzYAAzd0Z/jdERYT6gsEP/g/la+g42qjcfwSJwT5daUXeV9a1J0CiPu/E2/8FJDXVzO2aaZEZ25IAmRPib8NqQvz/G/fkdQM+mK3LkSK01b0rzbi886jtbTuF9KH09oWCOGQOfaRLcUyffjqIN1qeTcBdSK5yj3LAT5dBozwVSS9KbQNsEIVoZT+Uv6PM2sz6x4Hoap/oUm+F1U1W2dw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNKT2kE4KGI1QU1dgQn/wggreYmxWDWpePTV8f+IzsU=;
 b=YdqBRW6gMj1y09gMq5qIzGg4+k+QFLp7EV6u248XOVLgxerLEF4IGMgS/J5oM29iZi3oEjmoclqkVAdehaV5aSw5hWrY2zYjXXfPPCIDlSBkUEDt1mhxhYDwgpoMY2YVem1f9C/PuyilR14cS+IzK6U//d5JCFcNIjsBjlSfKWA=
Received: from AS4P251CA0025.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d3::12)
 by AS8PR08MB6056.eurprd08.prod.outlook.com (2603:10a6:20b:299::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 11:56:32 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d3:cafe::fe) by AS4P251CA0025.outlook.office365.com
 (2603:10a6:20b:5d3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 11:56:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Wed, 11 Mar 2026 11:56:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ib/CiKAuiCuY2k3AViuQySYQ5x0uw4h/HXh2t60ntzmCIPlmljuJXvqg9Tu+PjWk2I/SkG1LtTKsWHM6khvKN2dMQwgyGpbNgKbDoo3pym9sAdbCjij2AS4Ek3EHJwe/VhB8DWLJUwLUDDSO/OmP+yPIJ/L2wRjcWlyaFxXiJrogVKjByEePN7NC923KLGboalAP4MkhHNZSdc1GdI0qB6ls//JEkPQDWMk6jSo6J4ZAG2LYoV0S+6IOJeHl4fTO4nHYUpWJo/rGsq6Cd/tKmvQrmE2haIIAeitt4eIdfdJ+HOGLKjFzGshi6c48gPTO9G24TIFz89MKqu5WPSh+Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNKT2kE4KGI1QU1dgQn/wggreYmxWDWpePTV8f+IzsU=;
 b=EAVRi9OwWLoohmBDW7+Bik2S9zO4DPUaskji52XQ8kpb7x9/exptJvMRDOSwNJyoQYdUcJ97vtbRCdGKvz7jLQ0YNrs+RkM/acannzWOTRRHWlMCnGtMVikylg/97TrTMWZzd7ZNYdu2Btzm2qep9sLKgeprA+m5k76ONzjCELZvWTPhhYBPvAVlAIJVaZD0Sz3cBEQjfhR0vwR/CmF3bNTLwnZ/bInGfaDUZUHN8rusPh5Dee4Uduyt89BdZqrzG01C/uft0N6F+lWfRvL3MWTVypX/lk2t9nwz3JCHvz12U3oBRVVaWTjr/iU+OwP5EUn7E9cFDO3kagINmHLh+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNKT2kE4KGI1QU1dgQn/wggreYmxWDWpePTV8f+IzsU=;
 b=YdqBRW6gMj1y09gMq5qIzGg4+k+QFLp7EV6u248XOVLgxerLEF4IGMgS/J5oM29iZi3oEjmoclqkVAdehaV5aSw5hWrY2zYjXXfPPCIDlSBkUEDt1mhxhYDwgpoMY2YVem1f9C/PuyilR14cS+IzK6U//d5JCFcNIjsBjlSfKWA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com (2603:10a6:800:324::5)
 by DU2PR08MB10066.eurprd08.prod.outlook.com (2603:10a6:10:492::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Wed, 11 Mar
 2026 11:55:25 +0000
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd]) by VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 11:55:25 +0000
Message-ID: <0f1e7343-2d6c-48f5-b416-49518117c9b6@arm.com>
Date: Wed, 11 Mar 2026 11:55:10 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] ACPI: APEI: GHES: share macros via a private
 header
Content-Language: en-GB
To: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 Dmitry.Lamerov@arm.com, catalin.marinas@arm.com, bp@alien8.de,
 robh@kernel.org, rafael@kernel.org, will@kernel.org, conor@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 krzk+dt@kernel.org, Michael.Zhao2@arm.com, tony.luck@intel.com
References: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com>
 <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-1-347fa2d7351b@arm.com>
 <CA+Ht8=a9a-zB_kEt1ZHFeTWSYGn4o3MRuHdXY9FDWWNZ=gc-Yg@mail.gmail.com>
From: Ahmed Tiba <ahmed.tiba@arm.com>
In-Reply-To: <CA+Ht8=a9a-zB_kEt1ZHFeTWSYGn4o3MRuHdXY9FDWWNZ=gc-Yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0174.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:344::18) To VI0PR08MB11823.eurprd08.prod.outlook.com
 (2603:10a6:800:324::5)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB11823:EE_|DU2PR08MB10066:EE_|AM3PEPF00009B9C:EE_|AS8PR08MB6056:EE_
X-MS-Office365-Filtering-Correlation-Id: 13163dbf-b236-475c-8117-08de7f653c83
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 3/n70GgotdTVCVa6e3WbrA8uSLbwh625XszpQFuaxMOx6AKhfETAZdaueKuCsXozUXrMRaq3qHBxfPvooai9XAykUTpfzpDe8odzLKJMUx248S1mcMMDqvMgx6WGSu0GCzzLCXQOuCxxXJIJ0yBSl8RYfeSbtdWTShlQ8Sr4owdlUKcvCblZWknXjYA9JzdwWmN3JeVvKThc9tG/MJJRciHzogIGNZbizeh2P34G9Bq/RBI0z0edMY5VFjfnd57LP/i7ut3Dowktn3qlo+/hz0ov2XO2CFbKkq3LicYx6l4la5oG1wFA4a3qIn9+YHM3cDgPO1iYBII2DkTFTsKF2HANfylZBXyziya+uTLxJv/SiLFgiE5Pjnv48O+DpOpCusdiZ3ZajKiVLSsONRZZpZD/gMLKxUxbi63RuDldGWSAuW2Qd2dQpZYhreVkgs8lPg9KfUoKehv9JpAED74xuWQARRY8ZIufE1x848ykMb6uoSOzusg2nLsAZF3yD2camLAVZl9nPh01LboewWBD8HeYqhgO/K9XcFN3RfmTxQod5SdLiU3Pzvhg/GpXtE/pLX31huLNvrNShUEaG1kQBg8xpUAJE+spCKlhkhAxsdcp75KHYRl63AHNHKRGjkkIBHwYXr8YnBsIFwjTaAGTcFe1vmtlM1VO/To9lN6mQmNgczglCnOS17TEYoi8AcXz16FNtwEQijrX/4FKeAF0uZYsMJG8+ssjLfMsRubfSxs=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB11823.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 rqrOd7WqU2rE1Qp3GCRQwTW+8J+plwgBMGFt2PJjlEvoJ/+QbfQxQsP/nvdQXt/g90+rJICOn+aPL2n89524MDoEQtg1+9h2uN2KLDTSYIkhlx05/9LIEE5N9pYL9noVRXFgSuuAKZIcE85oHblmNEhxsACaqmmiUJ9MjVLqOG2f8jvCSD2qhtDj+O5DKI3Vjnff/8xDuWB533ua6xb4C2y43NtCIYHjuFaEPlmOhiTlyydpiKNxV5DA/pfBmFnBPQZ34jcuJxD5tM1ORVTBZHwS7jQwqUn64PP7UzfChov6+OClvdqy07PvaPL62xXAWTcPl82h5xZnoaYdG0mR8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10066
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7242fba8-ba43-4900-0758-08de7f6514a1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|14060799003|82310400026|36860700016|376014|7416014|35042699022|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Pk9pWoaebtRO4VoIKELdC6V0KY/d6dM1MiZ7DbZ5Ny7swPTbn0QQiaEu3oXoHPCriwLVZho6Bp35jlX4B2EsDwO6bg/JcSnJo0FCQdZEjux0EkpCY9CLeKROecBDP4YwTYVQ+3kaKOxcmYY/4mkGkuygrwDm2pJxjCTkViNHTLATuI9Ngrb7HI0dHMwqbFAYQBdqkYlIDF0rJQudLAnKg7vbLDwllWnAPanhsMetl8GMLlTuUT2Lk6lTmiDc7M2TZL+0TmzrkNh444Gkm9bfEm8FA5W7vPsIfKyyregLZh892DLL4ImaLiKBZK1Eb0H7HNBfuZBlGsWTR7tm7ZXeNYzEFEWaTL23DL7Tj2Q0bbGRZ6qgDYDxDVjLmx2BkJ46cIG96QSXu2M7SJudoGRuvna+Ptucf/2I9YcfoquuZybBAmhH6udSPkB3mL3P61MrjlI7q2Kamj1rwRPNShQlMCvzrXlfNFFZX3/35yFUQV0EFOtyLosR8BPgqbeqxaaEcxFGuiufaJKwK9bJ+xKMAaOokVeaY1bbwTvyX3UC9oMY9kUi/hbKGWw/uBqjPk+Z5Pw+GWgBluz64Gxf7HXRTe13HgtXJ4NPRyX7hRGKa4Yo5GMT69k7fp/wRaAGgkev+9REKR13pyznoruZN5qWL5c/cjVfjicvtkzWLIA/4EgrBMPFaFHMnDTQ5J+3qdalITR/DtooitffHFdsThdUPgHx7pWiKPe1NdDnSDCImMzL0YTCqMWYaSFtYd5bBew8XKHjCO72gPU2et7BLfVphg==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(82310400026)(36860700016)(376014)(7416014)(35042699022)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WwFTmyLweTMWrxzLBTs3mm9v622nesl1B0ootP4JXnDluzeYQmyXXLlrZE3AljTAkQI5eUpk27gtHaQ1CdozpotJZYJBvYzBqYaeeAaZQa9nJgevQTU7GdbIPowYR7r01WxLI53q9UQfmAWqCNCapVFCUNBKO3N6GdM/657koNHpBfa734hZkjNrreyFvzdmobvcvCQLS6sqq513PHdzRJpeKHwkVVL8zIvp+HKrHe/0aJLi61CWZhJsUmXpZYfr38RIL3pDrpnHRLbQR0SX/0sger5TeH2KvHskMRAMOycbLxeZGmGrndGHH+rxipEK9BuTLNtb7Tw+ivk/a5HTzpNXBClj40VaUmorDiaobuqCpsUdk6OU+GtSmSm/3eGqq0+jAoWRt4HQ/HWkYsnvhHK5zTJ0p2MvmMP3JOg6ogduIvtCfkHDunL3bTfeDqCL
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 11:56:31.5758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13163dbf-b236-475c-8117-08de7f653c83
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6056

On 26/02/2026 06:44, Himanshu Chauhan wrote:
> On Fri, Feb 20, 2026 at 7:13 PM Ahmed Tiba <ahmed.tiba@arm.com> wrote:
>>
>> Carve the CPER helper macros out of ghes.c and place them in a private
>> header so they can be shared with upcoming helper files. This is a
>> mechanical include change with no functional differences.
>>
>> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
>> ---
>>   drivers/acpi/apei/ghes.c | 60 +-----------------------------
>>   include/acpi/ghes_cper.h | 95 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 96 insertions(+), 59 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index f96aede5d9a3..07b70bcb8342 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -49,6 +49,7 @@
>>
>>   #include <acpi/actbl1.h>
>>   #include <acpi/ghes.h>
>> +#include <acpi/ghes_cper.h>
>>   #include <acpi/apei.h>
>>   #include <asm/fixmap.h>
>>   #include <asm/tlbflush.h>
>> @@ -57,40 +58,6 @@
>>
>>   #include "apei-internal.h"
>>
>> -#define GHES_PFX       "GHES: "
>> -
>> -#define GHES_ESTATUS_MAX_SIZE          65536
>> -#define GHES_ESOURCE_PREALLOC_MAX_SIZE 65536
>> -
>> -#define GHES_ESTATUS_POOL_MIN_ALLOC_ORDER 3
>> -
>> -/* This is just an estimation for memory pool allocation */
>> -#define GHES_ESTATUS_CACHE_AVG_SIZE    512
>> -
>> -#define GHES_ESTATUS_CACHES_SIZE       4
>> -
>> -#define GHES_ESTATUS_IN_CACHE_MAX_NSEC 10000000000ULL
>> -/* Prevent too many caches are allocated because of RCU */
>> -#define GHES_ESTATUS_CACHE_ALLOCED_MAX (GHES_ESTATUS_CACHES_SIZE * 3 / 2)
>> -
>> -#define GHES_ESTATUS_CACHE_LEN(estatus_len)                    \
>> -       (sizeof(struct ghes_estatus_cache) + (estatus_len))
>> -#define GHES_ESTATUS_FROM_CACHE(estatus_cache)                 \
>> -       ((struct acpi_hest_generic_status *)                            \
>> -        ((struct ghes_estatus_cache *)(estatus_cache) + 1))
>> -
>> -#define GHES_ESTATUS_NODE_LEN(estatus_len)                     \
>> -       (sizeof(struct ghes_estatus_node) + (estatus_len))
>> -#define GHES_ESTATUS_FROM_NODE(estatus_node)                   \
>> -       ((struct acpi_hest_generic_status *)                            \
>> -        ((struct ghes_estatus_node *)(estatus_node) + 1))
>> -
>> -#define GHES_VENDOR_ENTRY_LEN(gdata_len)                               \
>> -       (sizeof(struct ghes_vendor_record_entry) + (gdata_len))
>> -#define GHES_GDATA_FROM_VENDOR_ENTRY(vendor_entry)                     \
>> -       ((struct acpi_hest_generic_data *)                              \
>> -       ((struct ghes_vendor_record_entry *)(vendor_entry) + 1))
>> -
>>   /*
>>    *  NMI-like notifications vary by architecture, before the compiler can prune
>>    *  unused static functions it needs a value for these enums.
>> @@ -102,25 +69,6 @@
>>
>>   static ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
>>
>> -static inline bool is_hest_type_generic_v2(struct ghes *ghes)
>> -{
>> -       return ghes->generic->header.type == ACPI_HEST_TYPE_GENERIC_ERROR_V2;
>> -}
>> -
>> -/*
>> - * A platform may describe one error source for the handling of synchronous
>> - * errors (e.g. MCE or SEA), or for handling asynchronous errors (e.g. SCI
>> - * or External Interrupt). On x86, the HEST notifications are always
>> - * asynchronous, so only SEA on ARM is delivered as a synchronous
>> - * notification.
>> - */
>> -static inline bool is_hest_sync_notify(struct ghes *ghes)
>> -{
>> -       u8 notify_type = ghes->generic->notify.type;
>> -
>> -       return notify_type == ACPI_HEST_NOTIFY_SEA;
>> -}
> 
> All this has nothing to do with CPER which is defined in UEFI. All of
> this is part of the GHES structure defined in ACPI. Why are these
> being moved to ghes_cper.h.
> It is blurring out the demacations. If you are caving out CPER
> helpers, please don't move GHES helpers. The better place to move
> these helpers is ghes.h otherwise they are good where they are.

These helpers are part of the GHES CPER handling path,
not generic UEFI CPER. They sit at the boundary where GHES consumes CPER 
(read/clear/ack/notify), and that boundary is exactly what the DT 
provider must share to keep behavior identical. Putting them in ghes.h 
would expand the GHES public surface and mix non‑CPER GHES internals 
with the shared CPER path. ghes_cper.h keeps the shared GHES‑CPER 
boundary explicit and avoids duplicating the pipeline in a DT‑only file. 
That’s why they’re moved there.

>> -
>>   /*
>>    * This driver isn't really modular, however for the time being,
>>    * continuing to use module_param is the easiest way to remain
>> @@ -165,12 +113,6 @@ static DEFINE_MUTEX(ghes_devs_mutex);
>>    */
>>   static DEFINE_SPINLOCK(ghes_notify_lock_irq);
>>
>> -struct ghes_vendor_record_entry {
>> -       struct work_struct work;
>> -       int error_severity;
>> -       char vendor_record[];
>> -};
>> -
>>   static struct gen_pool *ghes_estatus_pool;
>>
>>   static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
>> diff --git a/include/acpi/ghes_cper.h b/include/acpi/ghes_cper.h
>> new file mode 100644
>> index 000000000000..2597fbadc4f3
>> --- /dev/null
>> +++ b/include/acpi/ghes_cper.h
>> @@ -0,0 +1,95 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * APEI Generic Hardware Error Source: CPER Helper
>> + *
>> + * Copyright (C) 2026 ARM Ltd.
>> + * Author: Ahmed Tiba <ahmed.tiba@arm.com>
>> + * Based on ACPI APEI GHES driver.
>> + *
>> + */
>> +
>> +#ifndef ACPI_APEI_GHES_CPER_H
>> +#define ACPI_APEI_GHES_CPER_H
>> +
>> +#include <linux/workqueue.h>
>> +
>> +#include <acpi/ghes.h>
>> +
>> +#define GHES_PFX       "GHES: "
>> +
>> +#define GHES_ESTATUS_MAX_SIZE          65536
>> +#define GHES_ESOURCE_PREALLOC_MAX_SIZE 65536
>> +
>> +#define GHES_ESTATUS_POOL_MIN_ALLOC_ORDER 3
>> +
>> +/* This is just an estimation for memory pool allocation */
>> +#define GHES_ESTATUS_CACHE_AVG_SIZE    512
>> +
>> +#define GHES_ESTATUS_CACHES_SIZE       4
>> +
>> +#define GHES_ESTATUS_IN_CACHE_MAX_NSEC 10000000000ULL
>> +/* Prevent too many caches are allocated because of RCU */
>> +#define GHES_ESTATUS_CACHE_ALLOCED_MAX (GHES_ESTATUS_CACHES_SIZE * 3 / 2)
>> +
>> +#define GHES_ESTATUS_CACHE_LEN(estatus_len)                    \
>> +       (sizeof(struct ghes_estatus_cache) + (estatus_len))
>> +#define GHES_ESTATUS_FROM_CACHE(estatus_cache)                 \
>> +       ((struct acpi_hest_generic_status *)                            \
>> +        ((struct ghes_estatus_cache *)(estatus_cache) + 1))
>> +
>> +#define GHES_ESTATUS_NODE_LEN(estatus_len)                     \
>> +       (sizeof(struct ghes_estatus_node) + (estatus_len))
>> +#define GHES_ESTATUS_FROM_NODE(estatus_node)                   \
>> +       ((struct acpi_hest_generic_status *)                            \
>> +        ((struct ghes_estatus_node *)(estatus_node) + 1))
>> +
>> +#define GHES_VENDOR_ENTRY_LEN(gdata_len)                               \
>> +       (sizeof(struct ghes_vendor_record_entry) + (gdata_len))
>> +#define GHES_GDATA_FROM_VENDOR_ENTRY(vendor_entry)                     \
>> +       ((struct acpi_hest_generic_data *)                              \
>> +       ((struct ghes_vendor_record_entry *)(vendor_entry) + 1))
>> +
>> +static inline bool is_hest_type_generic_v2(struct ghes *ghes)
>> +{
>> +       return ghes->generic->header.type == ACPI_HEST_TYPE_GENERIC_ERROR_V2;
>> +}
>> +
>> +/*
>> + * A platform may describe one error source for the handling of synchronous
>> + * errors (e.g. MCE or SEA), or for handling asynchronous errors (e.g. SCI
>> + * or External Interrupt). On x86, the HEST notifications are always
>> + * asynchronous, so only SEA on ARM is delivered as a synchronous
>> + * notification.
>> + */
>> +static inline bool is_hest_sync_notify(struct ghes *ghes)
>> +{
>> +       u8 notify_type = ghes->generic->notify.type;
>> +
>> +       return notify_type == ACPI_HEST_NOTIFY_SEA;
>> +}
>> +
>> +struct ghes_vendor_record_entry {
>> +       struct work_struct work;
>> +       int error_severity;
>> +       char vendor_record[];
>> +};
>> +
>> +static struct ghes *ghes_new(struct acpi_hest_generic *generic);
>> +static void ghes_fini(struct ghes *ghes);
>> +
>> +static int ghes_read_estatus(struct ghes *ghes,
>> +                     struct acpi_hest_generic_status *estatus,
>> +                     u64 *buf_paddr, enum fixed_addresses fixmap_idx);
>> +static void ghes_clear_estatus(struct ghes *ghes,
>> +                       struct acpi_hest_generic_status *estatus,
>> +                       u64 buf_paddr, enum fixed_addresses fixmap_idx);
>> +static int __ghes_peek_estatus(struct ghes *ghes,
>> +                       struct acpi_hest_generic_status *estatus,
>> +                       u64 *buf_paddr, enum fixed_addresses fixmap_idx);
>> +static int __ghes_check_estatus(struct ghes *ghes,
>> +                        struct acpi_hest_generic_status *estatus);
>> +static int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
>> +                       u64 buf_paddr, enum fixed_addresses fixmap_idx,
>> +                       size_t buf_len);
>> +
>> +#endif /* ACPI_APEI_GHES_CPER_H */
>>
>> --
>> 2.43.0
>>
>>

