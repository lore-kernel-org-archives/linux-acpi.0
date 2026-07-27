Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013017.outbound.protection.outlook.com [52.101.72.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D973403AE8;
	Mon, 27 Jul 2026 13:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.17
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158476; cv=fail; b=gNRAVakMyTxcaqANKy3sDTfh8vEKnnfnZthYX+C71eKvmUehLhlj9TBpxHwDOzUOsgBb2RA6WqI4vLwu6KQ/UM7Fi9sdMs9nu1fL8jc8gcqStZn+CyAA+6m1EodJSAEQru9EsfJXGD2r3jl9CD+dzTFlt1w6N74WJV2/b3CRLHY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158476; c=relaxed/simple;
	bh=Igd8M/vhsN2a9aDgHBNSKfi0SOzandV9MGaesdl5gFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kzeyb73EkREO6mlP4UAFQ0dYy3wEct1kKFMW57/r/QTlCHLbXjJ2RBjPDVmZhhBfAnKUSawtBWvKuxwoQbUH8vaLOmyxStOqKoXxN7UucaWsgSU24Gze0/lpo2o5qu0XsaFJ9WFIv3shkW4TbOKXqTORf7XQN2qOBFCCcC9bbm8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=W/UtsWcd; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=W/UtsWcd; arc=fail smtp.client-ip=52.101.72.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="W/UtsWcd";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="W/UtsWcd"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=iE5B4RQNuxdSploAMHMdngX+jHX0sYF5Mws1mv/ss26ZzKO72l8oJBSXC54F+xReeb+Pg/wG30mg6Bp6Ii0pT0caY/HazDTvvK5TTMHGiRoA/2RQoi4D6CijQYjNpXso08jhLxXTzvOpDuaRZVSKVG3JJx3dRjs9rmfVUKhAQZJB9I+f4cAmrQHk1kROQZTi+LTrS7mk++lHnxxw8Jwwr8SJ9cLiRx4LOPiFBrX8u/7owOAVQruUw7ZM9gvI4/pvPbwdlpys14/G7PS+/irKruCuGzs9vOFHlYPSI9Ci0i+2aO02RmWspz+sSFo4sHDqkJ2rFXnMas+cms6ppCt0VA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwnKirnqF7udZo/l6Ipd9gayAAouWlq+u/VVeZhExT0=;
 b=VcMmm7XWYDYXzl8tPTyaw075deFmLLeKtW0IaaazB8Ax8bdr8rLhRPTFoUCWteqoC4WuNNVibnn5KDqUeQlrYdLfIY/FTLewgAX0eXtVRqXub91zEr0IgSSHdnpylL3gtofwGV5+CBFXYlddoViH8eUwiwVRMS6c3HM92LTh0RwkwWyVNJaYYXZt0JNB4yOnK9mjEnM2C/FOmj8XB3kaFiQxn+MghKhIbrgAbEF/BNZbhxHuU3yJHcM8I8N8SEESqbeyC2Way2i8uw3p3qmGJc8LxYNZ88BcHinXIbreA5uFzssyp0ofSGnvxautBKADJZq5Gbz1DceLn/3+qtJnjw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwnKirnqF7udZo/l6Ipd9gayAAouWlq+u/VVeZhExT0=;
 b=W/UtsWcdTqjLnKNQuK3y/Fvn5KOJR3Vd18YG3E8HYWUOI+X9DkKnzjEC77XGEyDEnVdxoBkPFkdN8f8QUx0uPgU5Us+5hKapHwM+BhfEWXs5/Qh4Z4c4+lAVc86ub29O4NKpzsDI/3axvSvZUqvJDUQm3rWCRzmq4iIr9ga+v8Y=
Received: from AS9PR05CA0176.eurprd05.prod.outlook.com (2603:10a6:20b:496::14)
 by MRWPR08MB11708.eurprd08.prod.outlook.com (2603:10a6:501:94::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 13:21:08 +0000
Received: from AM4PEPF00027A64.eurprd04.prod.outlook.com
 (2603:10a6:20b:496:cafe::1) by AS9PR05CA0176.outlook.office365.com
 (2603:10a6:20b:496::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 13:21:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A64.mail.protection.outlook.com (10.167.16.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Mon, 27 Jul 2026 13:21:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XsPFTuDNgrB6/9R50zQUAOvsrMuIVQKFqOw5AVIbezfBxDKHBAhOo9Tcy6+wV+OlLq/W5Bz9rKnL7ejNBhsWZvNLghhjsAF/YbHYgZckG6c6BVZcnovQtUdnZDXohx7xykAoMo9WnNZVyVFWbvwCxG/CoTsVNGD+KCMovUJavzYgXK0GmIl+wnsFEMhDWxfXRLFeHLGPWN1Rtc9PEobYPYSUWw36qS7SHo0BQNx/RKL5KiVo2+cKpPw6eg6TUVMUjMto+HhNyoyeMTqRvNYc2m44ggfNs18zmKkZNf7eVrsPL+78NxcQTr1BvJvainBnIMKOmGQ2wF1dhY0jMK8yAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwnKirnqF7udZo/l6Ipd9gayAAouWlq+u/VVeZhExT0=;
 b=y/K/ksrI6mceq8+Gf43dFZjO1XTjEa6N9RzjPMHdI3VmtuuEbKVlsX5PwfScr0+Am1O9Pr6OCUgkMaLFFSI3uQw+NR0Ik2pcSzUWuEmY+kcgd/EKNo30DAnRwQhdCHlHT6PLNzhp7JUoVaK+9GwxgvNRCjfyEx2l/3SF5UdvqTiASxA7xzyxomAtxN8nzzvrfhUj+1TSfDnxE15xdYMc6iwmgU2Mse1FQFqhhF8bR/ok+95xeJgw0ESzKsvxxyQn0EdEn9EL04vimrtkBrLE0pKbkZFelM5EFRk2OijybLSb9EED8Mk7f/u/KHjO5qfodigdmXsrtLd0JYpVVNF8wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwnKirnqF7udZo/l6Ipd9gayAAouWlq+u/VVeZhExT0=;
 b=W/UtsWcdTqjLnKNQuK3y/Fvn5KOJR3Vd18YG3E8HYWUOI+X9DkKnzjEC77XGEyDEnVdxoBkPFkdN8f8QUx0uPgU5Us+5hKapHwM+BhfEWXs5/Qh4Z4c4+lAVc86ub29O4NKpzsDI/3axvSvZUqvJDUQm3rWCRzmq4iIr9ga+v8Y=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11778.eurprd08.prod.outlook.com (2603:10a6:20b:747::5)
 by VI0PR08MB11265.eurprd08.prod.outlook.com (2603:10a6:800:2f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 13:20:05 +0000
Received: from AM0PR08MB11778.eurprd08.prod.outlook.com
 ([fe80::a5dd:8b63:e253:18c]) by AM0PR08MB11778.eurprd08.prod.outlook.com
 ([fe80::a5dd:8b63:e253:18c%6]) with mapi id 15.21.0223.017; Mon, 27 Jul 2026
 13:20:05 +0000
Date: Mon, 27 Jul 2026 14:20:02 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	Ben Horgan <ben.horgan@arm.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
	Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
	Trilok Soni <tsoni@quicinc.com>,
	Srinivas Ramana <sramana@qti.qualcomm.com>,
	Niyas Sait <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/10] arm_mpam: detect and enable MPAM-Fb PCC support
Message-ID: <20260727-knowing-bittern-of-tempest-6deb54@sudeepholla>
References: <20260723155454.1760823-1-andre.przywara@arm.com>
 <20260723155454.1760823-11-andre.przywara@arm.com>
 <20260724-finicky-knowing-foxhound-df1e56@sudeepholla>
 <amdTr8Sxw9024CN7@lpieralisi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amdTr8Sxw9024CN7@lpieralisi>
X-ClientProxiedBy: LO0P123CA0010.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::19) To AM0PR08MB11778.eurprd08.prod.outlook.com
 (2603:10a6:20b:747::5)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM0PR08MB11778:EE_|VI0PR08MB11265:EE_|AM4PEPF00027A64:EE_|MRWPR08MB11708:EE_
X-MS-Office365-Filtering-Correlation-Id: 031e03fd-4998-4be5-2bcb-08deebe1eb4c
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|6133799003|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info-Original:
 X4uPKRhaT4yE1cg93W66khgTBYni/CY4ZjRZIRjqmrnK1PH1mXLLd1Znt5FvlkOBBpQL5tjrgk4Pg+rtyuw/IEcRQFX2uRpD/XZEBodbrivDEjBz7P4ajEVkgFrfBSJMpKmlNJVegj1VF651qyB7OetSfU7dbCjpkZeRV7aQ+aC3ZsKohwg/pIUMYCQP5ty02V0QZi/f3xQcgE1wg4RYfF0G01/QxxhTTC36fCYWF9OkeFXcL1flZlgV88cp3oJt4CFJWF/4Hvg4YtusE7cOTvmVQrvBCuYUUg6VHorQPE+zMkkdVt9iq/WNp/MY0VTeassMvCmivfd+IPXq7+LmJrcwSclt7Jk/e3iUq3H39hbescavIMsBbTjM0LM7Dr9RrHRga6XUeP4mHBvK0s6kreBfbhZLxwnXfqVMmvchnrBOiXdqcGKYvEN1LuqflIgK2LC3xcyvJFQLeupyubrU5D1fj6BDr09Bh93RrDwQrPR+wXZ7T2FQY3OPVNw6UW3qzbaGneH0YGcXTUBLpPoEjJuh5Wy4DEly27qTA2jsKSvA0OWXBHfFIWudWtk6kLd3aVUvMRzXZCfVh5VQT1793KNysnulFRIGvaCcGSLBscXp4R4kiZgzz+ca2wMrJMcwvdioCoivzO0ObodaUV5izIJcyqd+Bd2jfS+DoeZmT1g=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB11778.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(6133799003)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 MIH1SFCx2+vhdpN8sXsjbEwVidPx3Kn6Pp1K5DqBAH3oa7FhHSYE/JoYODGI0jJq7nKNkne2LzujlndpPoK7Cjc7wwXrpky1hWawCaKpTNLvJSF45lyRG0JBdtse91y6CdLaWHdA63n9giOBl3LFCRK7K+DgxG4vMOF3h9gnWHdAkZGlzb8ElagmQo0cuD21SC/T5ZbsRPN3wH3mZ7CfCRG7t7uVWLMqSAB9fFIqYbpnnFy4pIVdajIwauUCN9+r7Gt6kPHwFDmt9rJlfzzr0vJyIZfigXyUH2O7lK/U0hUOf3BDK6Rq/YTGqAeXz18/mv+Sko66s/NYK4++1ShDvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11265
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2133e1e2-98cf-4a60-4054-08deebe1c598
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|14060799003|23010399003|376014|7416014|1800799024|35042699022|6133799003|13003099007|4143699003|10067099003|22082099003|18002099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	anThtfsnEgU+LqNqEj5+HhP5lDxXVLqbBsYDwe6VjUTVW/mGMGiG0T//dz2t9sRgoy9ra1yIshwsBf+Y7SwtDFqeHnMvV3j+fNf2RDtHB+XkTPnkopYipePDOQlKsDhrjM8iyHsrj0FY7Fu/rmq2OuPXDfe1xo50WJH6vE5P3U4ZxqtShBOshBOG/XhEDYormfbhompHoxnx7IIe7dBHEg4HeiUbB3lPsXcFyZMhS7tSwn4ZnWGcv8uBcUb+8HdNZ25JH3+gz7NC5wV6UXzJ0LSz7tvXa6o0WagSoKSb/cVTIhYsepcC9JcMlRoGXsbOoi48OWXLNFflWEmpW4kwSHs1e5k4hTZ6+YTIrGCXBersei6mQz/ZT4FzhXjz6IO0Vdxz6wZDKUmwJM9EwSg3E9sgBdzM/8POzUbl1pGnOUOi3PIJ7IfcaU51K4wHttIZWaQ3Jvdf3ZOMdYSZy27iojA05B5nbxSQOIAUxJvzsKSZcnH2yNUWF4//Sl66hcpmno34Xh9upiFXOiDxptdRUUNI2qmCFNP22r1REPGxb1V76/NX4hUjAwIu5JLwFog072TIDrjsMSDHxO+PO+g0Z+aefW/8hBN7BMxxJzpEKJqQqNSwVIrVkasjMBY5htdkmxHSpwHkdIRJKQIqD/ar5w==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(14060799003)(23010399003)(376014)(7416014)(1800799024)(35042699022)(6133799003)(13003099007)(4143699003)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	o0gHrZQhwbl47cuTZl94vESHCk9PqBl7NTgatPI1Xyv7osOy219M6Nx/eMKPg6eQvQ460Phu2BLeBhvKWn1da1wQM5GZeZkIEIPtDjuZpUP7T/0baIq3VxkmaVGNiQotrskbf7N7iU7mZsT5U8x7jGHwIRT01qfgIjCEnjGYofsI/NR1EP6IR6VUGcyefvQXEcBjESIKDVH8tLKAIlw0oSxKGYbic8BNbtZ1GcN2QJpkKIfvf7Z3IwhPTzNJU7l02y1mgJBDrTeL0Yz3tOhioBkjyB/g2CK29dwGux7DsNZ3nbHnm5BkyoUIGAZu/eUfudxYigKC2Fb6lMrejn0ljG1pT6iw+zrfxU5RxfVc8nLCNmMAS/fwua2ctex1j7u+NnFV9p9jRwVy6G8kTV5o9Hn70DWBpX+LEaF6cJZKoxaDVeN0RbKCPFEYt0TB00gX
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:21:07.9964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 031e03fd-4998-4be5-2bcb-08deebe1eb4c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR08MB11708

On Mon, Jul 27, 2026 at 02:48:47PM +0200, Lorenzo Pieralisi wrote:
> On Fri, Jul 24, 2026 at 11:18:32AM +0100, Sudeep Holla wrote:
> > On Thu, Jul 23, 2026 at 05:54:54PM +0200, Andre Przywara wrote:
> > > The Arm MPAM-Fb specification [1] describes a protocol to access MSC
> > > registers through a firmware interface. This requires a shared memory
> > > region to hold the message, and a mailbox to trigger the access.
> > > For ACPI this is wrapped as a PCC channel, described using existing
> > > ACPI abstractions.
> > > 
> > > Add code to parse those PCC table descriptions associated with an MSC,
> > > and store the parsed information in the MSC struct.
> > > There can be multiple PCC channels, and each channel can serve multiple
> > > MSCs, so we need to keep track of the channel usage, using a list and
> > > a refcount.
> > > This will be used by the MPAM-Fb access wrapper code.
> > > 
> > > [1] https://developer.arm.com/documentation/den0144/latest
> > > 
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > ---
> > >  drivers/acpi/arm64/mpam.c      |   6 +-
> > >  drivers/resctrl/mpam_devices.c | 127 ++++++++++++++++++++++++++++++++-
> > >  2 files changed, 129 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
> > > index 84963a20c3e7..ca9b8754ae5f 100644
> > > --- a/drivers/acpi/arm64/mpam.c
> > > +++ b/drivers/acpi/arm64/mpam.c
> > > @@ -220,8 +220,8 @@ static struct platform_device * __init acpi_mpam_parse_msc(struct acpi_mpam_msc_
> > >  	struct platform_device *pdev __free(platform_device_put) =
> > >  		platform_device_alloc("mpam_msc", tbl_msc->identifier);
> > 
> > Looks like tbl_msc->identifier is getting stashed as pdev->id...
> > 
> > 
> > >  	int next_res = 0, next_prop = 0, err;
> > > -	/* pcc, nrdy, affinity and a sentinel */
> > > -	struct property_entry props[4] = { 0 };
> > > +	/* pcc, msc-id, nrdy, affinity and a sentinel */
> > > +	struct property_entry props[5] = { 0 };
> > >  	/* mmio, 2xirq, no sentinel. */
> > >  	struct resource res[3] = { 0 };
> > >  	struct acpi_device *companion;
> > > @@ -256,6 +256,8 @@ static struct platform_device * __init acpi_mpam_parse_msc(struct acpi_mpam_msc_
> > >  	} else if (iface == MPAM_IFACE_PCC) {
> > >  		props[next_prop++] = PROPERTY_ENTRY_U32("pcc-channel",
> > >  							tbl_msc->base_address);
> > > +		props[next_prop++] = PROPERTY_ENTRY_U32("msc-id",
> > > +							tbl_msc->identifier);
> > 
> > Why is this needed then as you can fetch it as pdev->id ?
> 
> I suppose it is to have properties parity between OF and ACPI without
> having to change the driver property parsing path.
> 

Yes, that was my initial thought as well. However, after looking into it
further, I could not find any device tree bindings in the upstream tree.
I am therefore unsure whether MPAM is supported on DT platforms.

The use of these device properties appears to have been based on DT bindings
that may never have been upstreamed. As [1] suggests, the bindings were
dropped before the initial merge.

Although we could rename these properties later to align with any DT bindings
that are introduced, I think it would be preferable to avoid adding new
properties unless they are strictly necessary.

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/all/20251107123450.664001-1-ben.horgan@arm.com/
