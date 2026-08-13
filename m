Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com [148.163.143.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B37A2472A2;
	Thu, 13 Aug 2026 03:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.241
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786592006; cv=fail; b=NBCJH+rkZ+CE1u6qWBxwhIBYGQarrvdCC6+JU+Y6sg3rCGHOzO4d4+Ld+xe9c7GTSMhxYe8VlrzyC0gXyumh8x9VEN3KNH6cE9iKFPYm6EQGO9L/vKaW4AK3d1js10o7d8WoQCSBr6lhvqiyS0UnnzcuAgjPqcjxQs7bVHj6Yg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786592006; c=relaxed/simple;
	bh=wKeOl5YN+ZRID/Pl24gtTI1xLe+tv7x3ypB0/SdT/Is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ususUQjlAauRruwwKG6BQjAXsGsnfjMMNeLKTBoJ9xM+QfM9gEPO/3aKmkDPa3nvMVMfadVipmycmFNyU+yTFyW5sghGxax+2mitwJKPZO9pkjI7dh6Jls3GJo6XDjBMVu3LUPrqFTw9UPCJFerIwcf82aGFukAqfVD3kgQoalE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ford.com; spf=pass smtp.mailfrom=ford.com; dkim=pass (2048-bit key) header.d=ford.com header.i=@ford.com header.b=qOnuemmB; dkim=pass (1024-bit key) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b=D7G1zcvp; dkim=pass (2048-bit key) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b=MwYOeis1; dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b=q+tSNxYc; arc=fail smtp.client-ip=148.163.143.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ford.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ford.com header.i=@ford.com header.b="qOnuemmB";
	dkim=pass (1024-bit key) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="D7G1zcvp";
	dkim=pass (2048-bit key) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="MwYOeis1";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="q+tSNxYc"
Received: from pps.filterd (m0482515.ppops.net [127.0.0.1])
	by m0482515.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67D2JcjP2258346;
	Wed, 12 Aug 2026 19:41:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=ppford; bh=0NP
	cZCPNBmeqP49Lzf2nINLpje8lWZFpj46365XseO4=; b=qOnuemmBiJWqVkqVxib
	kvZcccmE6BZ53GSiqXmMxwEuXZ+wQINAgMhbGebpd6e4lIsnIC9DKdOwYek2VPWY
	kXQ4ie7zZ5vF1zou06RHf+/7+5w2M5PX2es/yio7SyNN1r1nlI8DWDQzZrqzfxNC
	GXihELMwRmPtBT5UE189Xfif5nMm8ICFl5W3M/tzCIF2vMDFSqc4a9A0tOvXZw0s
	aKAgAQ4flD6NAvc1eG9ZfxZW72yWJeB9ubnOlfbdSE7Qx2RFxf16MGyT7OA5S1kZ
	96rd1ucVfx1nfv6c9hRHa7E6r7M28z8CFeUs9OxZLuV1Euga4qpEWSyNDkievXft
	ggw==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
	by m0482515.ppops.net (PPS) with ESMTPS id 4g0y3wjxgm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 19:41:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thlzeU9jGOeNPMXL9XUYXoPVtN2Ddmh39hUL9hIypdA3jqPknw/dnEGBdMEgUyH0VskFnhpkwzQbKwhQkGVWA9rC+94nNcPcm0Zuu4X+7nVF7XEFoMGfTHNQuccqeyGVrjUNNYnxA++d/YRar0UoZzFo9kEDwhi0WcICj+aX7NbXqqkoNkdbIqTAc3Y79epToQszabM/2r9RoWQLoCB+23xUveutfPnpxOPQLVfYEjgFmYIpn/c/RjaFSRuhbbOB7DJAGwvLa12CbS9K3ae6tRlmIDvbDgsSbKm5wwei45UX4A0aDdcYY6DYh4iCveP605S+NBoJiuEqamMju0rdJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NPcZCPNBmeqP49Lzf2nINLpje8lWZFpj46365XseO4=;
 b=GdrtG+dgrjsBmkK7NHqpU+islRBXA5SOJpXULwd11prQRFDTC19YYsEx722BxQH44ZPpcWr0iBWKcime1Eu4pP0AzLnTiIOeDCNks1cNofLFUU30VISIFVBbz6va+CrRSl/3Uz2fQaF8X2Ly2/N/B/QXrz4TcSBxTT184pOgT1OL0iCyMkZdaYywoz0bfnxWsh9r0dIgshXJTcfWKi+j+a1f1Kl2I6Lsi2CNUXeUhXw6jI50NUDE28IDeEcuP86yXuOpUkLDDgWbppV8UIoOpx4ZX0bgRbi8Nvkw5rwubARfOP5jGsoKQqdl1kktEiMRj/SunuRVRTod0AB19G6y/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NPcZCPNBmeqP49Lzf2nINLpje8lWZFpj46365XseO4=;
 b=D7G1zcvpuHa+fNXU7dIH81op1gPKwRCfHCD3aFlO/3+ebRSd8WbeL+eo1Woq4/I6t8WDxsNx8orrKYwrYYf+chLSRA3hG0vToLvR1M6Pt9M2IB1j+rGy0F99wzL27R8DrZ9ihsEXKdGHLbbG6qfma3G0xGxbZlccLOvliE/dMck=
Received: from CH0PR04CA0038.namprd04.prod.outlook.com (2603:10b6:610:77::13)
 by LV2PR16MB935061.namprd16.prod.outlook.com (2603:10b6:408:378::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Thu, 13 Aug
 2026 02:41:37 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:77:cafe::8) by CH0PR04CA0038.outlook.office365.com
 (2603:10b6:610:77::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 02:41:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.0
 via Frontend Transport; Thu, 13 Aug 2026 02:41:37 +0000
Received: from pps.filterd (m0426316.ppops.net [127.0.0.1])
	by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D2JaR63239203;
	Wed, 12 Aug 2026 22:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	ppserprodsaar; bh=0NPcZCPNBmeqP49Lzf2nINLpje8lWZFpj46365XseO4=; b=
	MwYOeis1Cksi1RJQpZA221TVrQHj15SMMtwuELZQ6+dPoWbFDtfOWK/ws5h/WGzU
	PBccpMNCFdiNKFL++iAxrkG4yRrLtc5wmmhvXXXrTS++UvIC8tlICMe0UFqHyY5i
	ryxQ3fvC2A2QiXr7cKjHpik8Cyk17ysHxzqf0N7a4wi0Pyyb5nlSTzHc6u3Ww+oT
	jEW+FOQaH0mAtk7KWnfv6iIUnukNKX/iKljpIVEW0U7sW2/Bah8ks7A5+7HlVBRy
	OV8hX0QCZ+/yMsRy1E6bLLvcn/+UdCR1619T7XRlGNJ/BIdAqcbhbiD+zH8jMqT9
	398rwV6oZ4psKEiF/oCgcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=ppfserpocford; bh=0NPcZCP
	NBmeqP49Lzf2nINLpje8lWZFpj46365XseO4=; b=q+tSNxYcLDqZX4Yfi6pVaO4
	fxAfOlAlxH+UfmKhM+Yk9/5XdcZ+qF7/RmVSPLsL9O+eL1xj3RNRhb4zvmH8O9SX
	nMypOU8pCT1KN2xtwV39/TslqLCd8SDCwMbYnUTN8X1fxMm/sdCb1jA6V/DRA/m2
	smxE43TI5Jn0tEveGK9GcuiTJKdRDAnExqTBxClKQMjhp/hdGyKWUYvI3emsL5eh
	wUNR81W0nsMigoZ4aF7PrxTEts5pBC3r0SndJvHPI6ZFRiDP8RsYYe0r9mRtABZn
	N10qASsoCoaoJQJpORWguWh+3TzAnu/K6ACOxdOMQncYOSjb6dVxczQUlF2jzng=
	=
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com [34.209.42.160])
	by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4fxkgccuw2-2
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
	Wed, 12 Aug 2026 22:41:36 -0400 (EDT)
Received: from localhost ([19.12.92.221])
	by cmsmtp with ESMTPSA
	id uLNuw8U1z6i5quLNvwc573; Thu, 13 Aug 2026 02:41:36 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: uLNuw8U1z6i5quLNvwc573
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Denis Mukhin <dmukhin@ford.com>
Subject: [PATCH 1/2] acpi: Use METHOD_NAME__UID instead of open-coded _UID
Date: Wed, 12 Aug 2026 19:41:28 -0700
Message-ID: <20260813024129.905583-2-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260813024129.905583-1-dmukhin@ford.com>
References: <20260813024129.905583-1-dmukhin@ford.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130017
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|LV2PR16MB935061:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1a6be0fd-17e5-42f9-092b-08def8e465a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IDZAnb+WHu4/aLEINzoEzuQza9P+jFnuwscrEhpc/OMY8ObrYEFG9Bed28cFRj0DYR9AdrDdXZ0ZyZ5jUkYkGTHGqaWZaDYYI6bSQetzCtQvItIXfZZw2rSmj/yc/0ixzN+BJ1ORNvbsnm/TxdluyumDiEnaVJukzcsYnt+JWngXiw9LSwqyGeCgaARXhtvdg/oFzVOVzyizXjnp4gutZ8C94z99Ro2+dEOTcc5FtvjBUY1T0rVzM19TNscFTCCclT398UO0MHXS0FYgCb9BgLJ0Esf1M/kvWzG2Fh/yhfWH7V0yWUpM4ACwnMPLDKwDrTJMdB5ej+KglvUCSBbcOy/ij/iPL7zah8VAEg+MOJ/7Zan9PML05vV9gqZw1t7YDVOkgNh/WOAPDa4OuTtCCoDYzAIPYKJTjxSKks6n5LCaTyyAJBB1jixzX0kUNBCnvC/Vj2xHLFdtTbY2CiFLxL+yD86UcZFhZS85M6LnQODULNU6Pp8EkhFxvZCYOl+cyQpgy6gCv8znriwXZXcP1RPGB/i6GAXBLdq1eyt0aC7U/YosZZ8WBeyNrAabeNwJ1skSSXTfxpm9eER2w+BHUI5e3w5KugCnTX/K/qP2BlFFX5VO20gS2u6pi4yKilFEI4SfP647CNjyxevFE//13DXB+qPO978ufqzXmNpeHA6QdqUdxljSrdTOAYR0NS8vpLaM+etH0qL5QU5pOrJedA==
X-Forefront-Antispam-Report:
	CIP:148.163.138.245;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mx0b-00498f04.pphosted.com;PTR:mx0b-00498f04.pphosted.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0st5YMXiaebv+Ff7zcHFfRydefowJrLFgiSEVkITQq+b6oMayT0qz/69NfvLW/t/cNnG39TRn6i/ctvP/hXygTH5IqOtG9lKIyN5me/w6kaRpt3/IZ0z+aoc9Mm+W+btbuz4wkPlNKbXIp6nfR8K/2cjbHK0QW4gOsxTCbPgfzkYr5hIjMXWEEQGzEPEB8PbUJ7skm7cfvz6uMCsK2VRvbg9oX0HXgUVA8+r68WTSWjMiF7ZjUcFnZ1sOmbCcFoR8uhmkk/oZkEtyPsvS2J5lvaVFweaHB5wc6Oh0kQDd44YGpXwFBuMaSMP/WScDkZlNM0ZnhvkempM8VY/2R70M4BHFauBkvwmxZwJ27GCHrWe09CHALHUX+yDu3wypSMuVndMX21AcdDcYo+cw7wyMSzRWAfTuj2jksAcOdmoe5D+4Tu6H86+NF08L5hGVfTU
X-Exchange-RoutingPolicyChecked:
	BqQQ5SEgtALi2wGoWY1BMYGhbIdQE8LEUg91LEI9PVxVrNoqCLQk8Z27Gtntuol5nk+8Gi1UONd/kyS1/DEA6LJFg4iUzfeHXe9aToCYUe0cnnI9TdDgt7p1/2Lyp+6qLq5aIDYtd7B2OFIkcBAJopeO0RgYg1Z/1bWKpc6IiTH3EEiG20U3Kkn69y1BrGJOp2Svm6d+rY3D6uGnBJN63M33BqvlO/PI7P2muh1RW4+KOT4AWFpPBO8i52LVSjl5REb26RHEDx7vysZ3MW5IXPnpIxpDx9lFflPz+RUOceuuHLEChwZsLjHYdq2KhGCkWGTXZ9dt00aiWI5Ps9PbeA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O2vC4OzeUzeluXkaWNHeOD+mKPSJKbWQnh+LJszmWQ7v0MOtfmbErFJPZzpNCGoh0mwPfMVXIQ9uSD+hRh5UgDRyyWyMRbp4N3Zusq/ggXi3dBPmX2ZRgeTi8eqw20NWM4pVIp2/ogzITi6LMRo9WQ4Qyzj1eckqIzI6CUNov3XrPVhTLUJAjhiNqb+JzBooTVogp8DSJGYt/acneVVidpamZl+H5e8dRhE6oOgPHXqukzNA3jjV87fqYnwnBJ2gNI3/K8j2bipFvvUO9BOdC58MAzf5Rdd9gWr1wLp2X6YO6JCEHOLQAWv1lDZFi7bWitSOEsQvgylF2Ar9o/kpzor1my4v1TaThfJm9ohsQHNrYMvq8RP8mMf6KoXqkxz9/CKqUF+rPZO+TKsYHyTj6u4k3iKYJJ5OfSPPfOQIczY4Xlfa1E3R1t3Q/QrtRBUeQkcXVln702I/7V9sFPQnIqGBujgzv6UFw+G8kNh2zGnWnIEQZVUvNABsCL4fQqiNvhs3bTZD06xSKTquxymnl0SWr5vlE4qN9Ht0pEz2YJZ9FkrgTwaKD+lelyjOgM+bgC+bfpYTq10Za7zh8PSBWxcnELsGWI9GCbhZfiQ39OHqXQapDjy2CdXyn4j1lGL+abTw77/UWuSMT9sWOS5kmA==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 02:41:37.2609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6be0fd-17e5-42f9-092b-08def8e465a2
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0;Ip=[148.163.138.245];Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR16MB935061
X-Authority-Analysis: v=2.4 cv=E9H9Y6dl c=1 sm=1 tr=0 ts=6a7d2ee4 cx=c_pps
 a=EaWthEyNNaJ7GkMLLYePaw==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=0GA0A_IKJoUHBEAzNTkD:22 a=cbNQJ9GKAAAA:8
 a=uiXQ-VffUSv7w1kNJYgA:9 a=P0bj-C3X3jJDpopQwM1U:22
X-Proofpoint-GUID: uALfNtisxW1qg5iTmRFkENOEcUtjDfIp
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDAxNyBTYWx0ZWRfX7tuWa6HP1eNR
 YVRStnQkQV4qirIWZI8VcNlNRhGwyfoyqz17TgzWr6uxRALj61vSX5t/MHX3+u5/aOH9PXy/Lpe
 uYrKOsDoe73dur6DwTiQaGG0+1Mh041iBIhKHaAklvUEX4sWzfYx
X-Proofpoint-ORIG-GUID: uALfNtisxW1qg5iTmRFkENOEcUtjDfIp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDAxNyBTYWx0ZWRfX/vG89GQ8bKRb
 GV2+9woHinBqlx/Am43wXNBbwamZMFQHoXcwMe9mTWrxE2jLBvSQKanwH6v6rUxlFWzxOdVyaha
 EdQHpdtLxIodR/DX0x6TSSSJFNRjXYU68pj4B69I+L1E2/dGDgdbgLzyiq13kJyHiEDJYGN496J
 JSsenNwKTs3lkGfgwltR4YubZn0BI/Q8PSav0Rp60ug9lgyq27DO5G/Ta8qm4G4PGPsml/UKXNu
 OTUna1+9zThenLWoHE/lksmpxElyLx+Cl2NlopjdnoI6amUarCsV24esEIjjdcHo1Zq2FSsq0pj
 5noq72iLh2hGaUAlTi4gkxiNmN8YLRm4jDK2CdKO8CV31XiH08U09kVMQhce5mLPk9lYj+MR4Pc
 /tUyQam2gX62eg1BJnH/AKfLvkidJlIF1MWeJkTmT3uOLolQYFsNpEqSoNSejqWna9OSEeOpksU
 6Y1zUXprvBfq6FczNvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130017

From: Denis Mukhin <dmukhin@ford.com> 

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
 drivers/acpi/acpi_processor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 00775b91bd41..cb39e4a30f0e 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -739,7 +739,7 @@ static acpi_status __init acpi_processor_ids_walk(acpi_handle handle,
 		break;
 
 	case ACPI_TYPE_DEVICE:
-		status = acpi_evaluate_integer(handle, "_UID", NULL, &uid);
+		status = acpi_evaluate_integer(handle, METHOD_NAME__UID, NULL, &uid);
 		if (ACPI_FAILURE(status))
 			goto err;
 		break;
-- 
2.54.0

