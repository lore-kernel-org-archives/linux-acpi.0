Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013049.outbound.protection.outlook.com [52.101.83.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D92411A1F;
	Thu, 30 Jul 2026 11:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.49
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785409681; cv=fail; b=b1k7INzyKMCm/hY+I9CYx3BDw2LA1U6iLZkdUPln+s/FEPp6lsQVkfk7lnyC+datdH2eM+QGq7bcXXJPcGfHqA8bHp+myQuvnVL9kVF8THnan17bw2xAsqJQHQ1Kh9CSLLXbhSyROv5cFe7PJCkQJ4EesraK992ty/MLsOvvdtI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785409681; c=relaxed/simple;
	bh=+URN6gij8b57WU52rLRK1lbsuSGbNFW//bizlN9gKCU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RlLsbi6rsKkRgc4tnhIW0XgqYTee20IJL+MqJRV/kAYvs40cgrkVYlErsyqHFNzRHb5hz+Uvxe72I0C9ze5ohRvPVBTjuAytorWy+TJTxX8T1umZ1G2FYYAjn2GdSvwrRz00rEHf8wYOg/vgUf4j1lrh4w5wvi324wvETKhaO20=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lS67gvBQ; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lS67gvBQ; arc=fail smtp.client-ip=52.101.83.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lS67gvBQ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lS67gvBQ"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Icg7Y+ls9D4dWixYR8L9ysiWg/EfyNPhta1sHVS3Q9rZuPTHxHZ8bowpMqWvb3oBVTfcWgt3mpCJ3lSIegTj/rKrZiSf5ibGPefOW0HHkZT4+v+9iJkM5b+HPVT/FI7iub3cUf2sZTPEWRy0y+wItvsuFO4dg5z4tVMj0CXv23ZTOPhFocPz3kav+S4s54V4y9ElszWGbqX5WhTwJQBnNOrXMSAe2Ndodf73HSlLXn8JkMN1LWOzdF6iRTZPvnovqmD6P0K3s3GEWsCQXG+nsaYKgevnyFxfXNOW8Yyj42yP77vYv7vPzidO2FGToWh1MJJlIrk4Oo5U1iILOp9w9Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+URN6gij8b57WU52rLRK1lbsuSGbNFW//bizlN9gKCU=;
 b=lzwTUwvOrGdUcWF7E1zdnv2rqQJRKohdr1Zg5egr5eaRVWIvVvJyuw3IbVf0b53oZla95iHnj94V2UmYWcpf/lcJ9yGQXrgCb3fcLy0iPkWa8O9twCqtJUG51pBbtIe4BJgi0T8npAyJYOVOwnX/ijrA7tR+1jZnFklb6eg7yZxQ3D89utSsmPsSUOEXjzMjiVJWxxbrhSt/+d7d7ZNCVwyiOVTdVb6ZeOdrhCQ500HklXeFLJ6px3UkTJ3N819SZE+68EPtugSlrg8IwfqlTLdQByxYaku6OqkhTSANbBiLjKbGC1AMu0IKuj2HnpiylOm60UcCYN0KHBcei9vnnQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+URN6gij8b57WU52rLRK1lbsuSGbNFW//bizlN9gKCU=;
 b=lS67gvBQVQFchP9PutXs6Bm+g9CWCQVFdNIwGUdLhbkzJ3J7UzVkmZ9ohQFSx8cmcLSwwFR1dTKeFDCOqa7IqCuDGG+tQJXb9rpHk3B27nfmjIDhdyuFmhaB6XFUx1iCue6cxKYm54sMcaSb5cqSoMhR5klUu/+FuJR5gWvrvxQ=
Received: from DU7P251CA0004.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::28)
 by DU0PR08MB7613.eurprd08.prod.outlook.com (2603:10a6:10:311::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 11:07:48 +0000
Received: from DB3PEPF00008860.eurprd02.prod.outlook.com
 (2603:10a6:10:551:cafe::67) by DU7P251CA0004.outlook.office365.com
 (2603:10a6:10:551::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.14 via Frontend Transport; Thu,
 30 Jul 2026 11:07:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF00008860.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8
 via Frontend Transport; Thu, 30 Jul 2026 11:07:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izDKqYMt7ngtodfSlimNS7XZ6xSHiHDpgyAsSAwEe/2AVskJVaqT6RAm2ubGcQ7fTlTl6xBiV3JmJ/BrurCaaDw1PnPXFN6ae5I3Hakb2ZdgkeeMIH28H5Mh+YQMELMtzqA2OTnfmiGbpw/iIqW0NBNORjfcQEyJ1Sh5WII8WOYUolv3HDM3ubvjNt1Yciv24eUXz0yZmhrOLTe5b3+QH1gQxHYmLppAKcPoErZR3DY8T4bCrav7gJqoTy0DDalsDqBoYwy3gS18AavhGLAYxNI7rQfOf/aw+I39oYhUgAfiEuBpYFwqbLnpgNoV9Vf3LL8qGi963EoK17tApHbwAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+URN6gij8b57WU52rLRK1lbsuSGbNFW//bizlN9gKCU=;
 b=ITTVi6ERzWWMjm1jIB7wUrW6vgaNaNxXbWOOhUBDVp4qeZvPTdb09tzs2dhDY4HxFL9L1q41fw4o0i9wBDbQcYh0sQV60n17l3wbjqwXpjBL9xKJapsjwg7iAapqYZ1k8Xh5kM28RF+AVart/0I6tpyjxXDMaIpjxGOEYyBiqf3KCddh4OiB4/wQ55sWMzuvBncExPhKyq9M93Z3IU5n1JZsQZQD1pe6hhj2FAZx1xBHOAKjsmwJCnZQ3lTPu/9V1TdrJXHHcbPMTpclEjl40UFNkWWIKribtagFuVBWZJq9RoSYqqqNWiKyZ+QzTm771LBiK30qTLBc/oT1TZLszA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+URN6gij8b57WU52rLRK1lbsuSGbNFW//bizlN9gKCU=;
 b=lS67gvBQVQFchP9PutXs6Bm+g9CWCQVFdNIwGUdLhbkzJ3J7UzVkmZ9ohQFSx8cmcLSwwFR1dTKeFDCOqa7IqCuDGG+tQJXb9rpHk3B27nfmjIDhdyuFmhaB6XFUx1iCue6cxKYm54sMcaSb5cqSoMhR5klUu/+FuJR5gWvrvxQ=
Received: from AMBPR08MB11569.eurprd08.prod.outlook.com
 (2603:10a6:20b:6f1::18) by DBAPR08MB5640.eurprd08.prod.outlook.com
 (2603:10a6:10:1a3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 11:06:46 +0000
Received: from AMBPR08MB11569.eurprd08.prod.outlook.com
 ([fe80::5f1c:3cee:d582:fdd4]) by AMBPR08MB11569.eurprd08.prod.outlook.com
 ([fe80::5f1c:3cee:d582:fdd4%4]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 11:06:45 +0000
From: Ritwick Sharma <Ritwick.Sharma@arm.com>
To: Andre Przywara <Andre.Przywara@arm.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, "guohanjun@huawei.com" <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>, Catalin Marinas
	<Catalin.Marinas@arm.com>, Will Deacon <will@kernel.org>, "Rafael J .
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, James Morse
	<James.Morse@arm.com>, Ben Horgan <Ben.Horgan@arm.com>, Reinette Chatre
	<reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
CC: Jonathan Cameron <jic23@kernel.org>, Srivathsa L Rao
	<srivathsa.rao@oss.qualcomm.com>, Ganapatrao Kulkarni
	<ganapatrao.kulkarni@oss.qualcomm.com>, Trilok Soni <tsoni@quicinc.com>,
	Srinivas Ramana <sramana@qti.qualcomm.com>, Niyas Sait <Niyas.Sait@arm.com>,
	Lee Trager <lee@trager.us>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 00/10] arm_mpam: Add MPAM-Fb firmware support
Thread-Topic: [PATCH v5 00/10] arm_mpam: Add MPAM-Fb firmware support
Thread-Index: AQINFA/OnPdZzdbqurEd1kNG+ggnb7Yl+oGg
Date: Thu, 30 Jul 2026 11:06:45 +0000
Message-ID:
 <AMBPR08MB1156900EF7E8714DF4A83EB8B98C92@AMBPR08MB11569.eurprd08.prod.outlook.com>
References: <20260729134124.2506269-1-andre.przywara@arm.com>
In-Reply-To: <20260729134124.2506269-1-andre.przywara@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	AMBPR08MB11569:EE_|DBAPR08MB5640:EE_|DB3PEPF00008860:EE_|DU0PR08MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: 718a6d28-cf91-4e5c-fb43-08deee2aca67
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|38070700021|921020|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 +0W1q1ntkIRyma2m1Pfz6xDUiT9Tv8dCtdZbZz/mZVxEFOCWC+4DEXh33b1OlRqRuOEV1aKPPqFGDjghB0unze1YzndizBRH8aludKobVPmC8pxnMxzh9K0b25m/Yqhs69bnkGR4wbIlUfGPGwxBCxKgDMB73lxhQEkV0yU+puXDv/vv+rHpkUjji147usa3Tlyn+H9bGZA+HtnCfKh0ncXoka9AOD8LI+5eWRE4UBO+XBJhlvuspsjiF/L4EUFaBPCDUokwi51pwUAHYZ2xg7dMhgA6nsXfbgRK1Dt+0LFMHUQOtACPzCBrsgBV85FRHxUX6U07cKZROPvJ3NaezL4xiLK4+qKBPio0Njz9S7om3hHBbu6i16nf7vErIby8sNezYtKWd8pdbVwtZcfoAUBlLf03PtEgsieTvsaHGy+NC7zI1L20SjI/elqjpU34RWNvymBrdDhDOzCB/FkiVEazS0MxWhnIk4PDAqpNObW9XxSziwHM4VlacLRln4+qwuwrf25ZPVv5tSfCBR6Qz4YV3fO4HLvXXtwM20yIgeI1yownK50ZbLZnimPpJ1smulFRghkpLZWt6TG2AXb+NstmC3rYEedxttWCeE3ln7Zfpe7asd0cfukwRHl9EYTPXM4Ayl08sS/ROWIovY79E8rPaL27M0c5Ru2Z3+bUFHXvL5//FBj2KSoIwSxhw62/N4wReNySWRhtT2a4HZeU92HNUc9/0O1mhVcGxQNRHY/R6R+bf3UShKHytJat62Ry
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR08MB11569.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(38070700021)(921020)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 q/tov38qnUpgbfX6ePgoZ17/2HE1fJ8v3wj0HA3N4dkgosNbelYzByk590cAObD9bugEPxKg7mR2uAa6mZjwCVVDWciniwz8iPiihORdf4bhM8858GVG2W1D1NanFpNcOAdTulUwuxMrGvPPpNu4pFD+x1R+gfAcE4rarC0Jcm9awgNWosBONBqZnMXsyg26mCHfEwD1MsV1dJBSyiB2MlFgGPFN2fKsB69ohSERG+Cfbh/4hvz8V3WpqIHjtQoZWiBkZPD9e9AM0IFog1zlvQCm7mhv9qYRZZVfk1vHdykLumm9ecYGVf/l8sA6b1JYoEWE5XFAtTDSA/jx7UTe/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5640
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	af10bc64-2fed-4589-13c9-08deee2aa51a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|23010399003|35042699022|36860700016|14060799003|921020|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bNuTtbGDyLVYG1Jm7/oPpmDWDwtfGv5Rg73DjDHBjbhzlzm4rYFM7K3aWzCYlJIyea/7h3YtrTbypPvdDAH8HV8k62kWoFlD0l229Yiv9pzaHHMtuu1N28HXdFgyybUo5VHx/w4vz4lZqlB1shlHiohZUvUWSSj/zg0kNPdShKqnkDhz2l5/xaqjnHgHO1xifyfFOnrOZcn6OXsLHZ2cYTsUb5ziO3Vf/PbN2Ne7oFNcD3k+fQCGjSFWMtSRmc7Y1/mGreT5F0dhL1HP7uA2x/knNeuc2dg4MiHcMbv0BELpH7Vw0jLf0LgpgzCDUtND5/VPmMQLykwW/Ei4eU673IDnJ5nEFI1wXhzpai4aghn5kUWWEvnEh/qpCqrIKOaZJlICRGAgAMk9NEhrBz+hMbMsTcCyRzOx+4uvXeuR7tMUj/y9Ng6dSgGR5kZ1diRBJ4SEA0QKvOGchAxxm7HzZg4m3e+D/TEb1fphIuHQzEyG50oKFbeNk/QKvGOPN9V0HI5LE+ASc5ja/keYk6Ue99YCTWshY3EJfE6MuqA0Xkbb8o7hx884mbu+ossYfe2Kyz4YLjWeaVjQRUjP/3HmjeBzUhb8MFzsrSxG4yrafuCfVsybnC0aJ2N6icMQquOFVnUv7TIwP5cDufDCr00Ur45+xBD/LxDVFlQBBYsPvpscHChMP0vtWwi4EzIQn5b3DaHHrgNbUy2MBMN3tFpJzKJIRgzzP+aRN8cbzj+UI5zbEzVuCwcOMzZRlsPc6iA/
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(23010399003)(35042699022)(36860700016)(14060799003)(921020)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YwOAIzqqiOBC89SHmMcVxComIblHAoNycV8XA5SXTPNzTLMf/ob/pt8QNQVanll27sCvWhHaeoWa11SnI/GDeFXdQdfruP647H64dFC3SbA99InguPc7y1HnZmOEarBmxdx3Y/vKvxoX04muY8Fv61cJM83/LS+qJgPwAZXyysC9j5yJFaAaNAVI73MUfx+XXT/3qCJPLlULdh1l1iSgE3csEDbf3s5edj35DOpoHKwsbp9GEOwD7yaSFcRWWAZruNVB6HXqaOHWkyv5ajNHezVHtHVSaQx6EPr3R3zl2GENvo+m91Hi/a2Vzd984rzK20SevsgWmUT+Q3zXnRz+q29Cav5BwcdV1CC5uvSbO2ZcDxfobEndBlv4ebinqY4jvFEa6Xv/bCUcj97X1ewg4mXPVJVHzyGfXS/BwJMbYVbTvLx+FVpqh3y/7mT9BDWx
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 11:07:48.4059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 718a6d28-cf91-4e5c-fb43-08deee2aca67
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7613

SGkgQW5kcmUsDQoNCk9uIFdlZCwgMjkgSnVsIDIwMjYgYXQgMTU6NDEsIEFuZHJlIFByenl3YXJh
IHdyb3RlOg0KPiBQbGVhc2UgaGF2ZSBhIGxvb2sgYW5kIHRlc3QhDQoNCkkgdGVzdGVkIHRoZSB2
NSBzZXJpZXMgb24gdGhlIEFybSBBR0kgQ1BVIHBsYXRmb3JtLiBNUEFNLUZiIGFjY2Vzcw0Kd29y
a3MgYXMgZXhwZWN0ZWQsIGFuZCB0aGUgcHJldmlvdXNseSByZXBvcnRlZCB3YXJuaW5nIGlzIG5v
IGxvbmdlcg0Kb2JzZXJ2ZWQuDQoNCkZvciB0aGlzIHNlcmllczoNCg0KVGVzdGVkLWJ5OiBSaXR3
aWNrIFNoYXJtYSA8cml0d2ljay5zaGFybWFAYXJtLmNvbT4NCg0KVGhhbmtzLA0KUml0d2ljaw0K
