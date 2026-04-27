Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023118.outbound.protection.outlook.com [52.101.83.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C98D211A09;
	Mon, 27 Apr 2026 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.118
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777300114; cv=fail; b=b1T+na/eWicTn3RfCN/yDKYEa2FhTv1zssOZS84JCmLW2/w5VlcIOkfsnLme2h7pHyu3bJkeg1iB1nH5WO9jg+HrFvdvy2GQhpte+4ybbzYAa/m1HTIGSYcl2Wrm/w1bC4wWWciCaRVXHAGFp9GH4cgzuIRao/fL2bgToUE+8IA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777300114; c=relaxed/simple;
	bh=Txfz5yXn+Ff59WemuR727GLayuLTjpt562WmhlZRDl0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I0PtThlHekvfdW53rIioH9jgkZfh1dyhM3tnvimZGpg5wikTQeW9dgGh2vB/oNoYAi3a8OR6xySKOkVE7kOEzd69p9Ihs0GKiYYUqdqlaa/IWWF8c6CxmgJlzTSDZMecjYqc70eL5ZapLguQnj9UkjROCwD7q/vMCZ3en0APUe4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xsightlabs.com; spf=pass smtp.mailfrom=xsightlabs.com; dkim=pass (1024-bit key) header.d=xsightlabs.com header.i=@xsightlabs.com header.b=qLSDu99+; dkim=pass (1024-bit key) header.d=xsightlabs.com header.i=@xsightlabs.com header.b=qLSDu99+; arc=fail smtp.client-ip=52.101.83.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xsightlabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xsightlabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xsightlabs.com header.i=@xsightlabs.com header.b="qLSDu99+";
	dkim=pass (1024-bit key) header.d=xsightlabs.com header.i=@xsightlabs.com header.b="qLSDu99+"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=gVXFWBPFa1gZywcndJXtFtP8ArE1avdwiWa5Psz/kSn63jPG8JddeIMMgmUIJ/8R6dK3HfvPZP7YGiPQ/dFBAYNxoajJKs9PKmzb0mRbD17s75KE+1NRyPUmhJAT/OJp8lFNTJn6kdf6/ZfFfXH91d+wZxV/lq6GbiA4N1h+JEFoVx+wZanZhkRS/lDi4vN3t79TeNp3GaG1nqysm8mRpeJE0No/ROhx/N8ViMmw0McEWtIt1dplG2jNuA442SMfMB90dmGHnKKWMdR/lWJiqs0fulQKJp+Fv4oA+ocNZEHAz6Zt6mAgMABJ1j/hPBmj2IVSsqaeHE9fQhrwEMp92Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2r1Opo9L8oqhJ7t/guuet98pkyodATZHrdji9Y53Soo=;
 b=SPgICdHd5C2WfQyjbbwc6owrmV4lwrxU2HMnxil0wg28j6YwqCi/xa5kAuUWBVdiglRCnVcfxBzi1AaK8wvWfGIjM1r+RMW+kK0u/e746QLttq/FHmJqi0j9y4plO8uQ3rougEaJc9arjYJSn27KPixECglaTABw8KKXjetWRy+HZHnQagyiaHESDM2FgSM/iNW6e//GV2ShYR5RM5bE5myj2dGhjL0VgJHQdAF9sv5M3XPPrWxCXeERux5Vg1lQTCp+JQXhXk6jsBHA6fW37fNeQplv+fWei3ahUC3vrjENwrBBXzXiPLiQx/vx+b11MZbErF5BWFfDezf+yXkFxA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 52.17.62.50) smtp.rcpttodomain=gmail.com smtp.mailfrom=xsightlabs.com;
 dmarc=bestguesspass action=none header.from=xsightlabs.com; dkim=pass
 (signature was verified) header.d=xsightlabs.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=xsightlabs.com] dkim=[1,1,header.d=xsightlabs.com]
 dmarc=[1,1,header.from=xsightlabs.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xsightlabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2r1Opo9L8oqhJ7t/guuet98pkyodATZHrdji9Y53Soo=;
 b=qLSDu99+ZCG/rgstsyXiTAwU2jw8k0RopDwCyKSnm+zV9kWk5SJHx22aMxoDc+O4Q9YYZWr0nYlgTKpsTc3Y5qa7QRUZLZiyNTqiUyrsWVOOs05ZIgGHhkzwB7jDaXNnM6EVMHxBPveMWLfxzI+pnTu7p1pNzifs8GLgkcDf1q4=
Received: from CWLP265CA0301.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5d::25)
 by AM0P193MB3171.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:741::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 14:28:29 +0000
Received: from AM3PEPF00009BA1.eurprd04.prod.outlook.com
 (2603:10a6:401:5d:cafe::9b) by CWLP265CA0301.outlook.office365.com
 (2603:10a6:401:5d::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 14:28:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 52.17.62.50)
 smtp.mailfrom=xsightlabs.com; dkim=pass (signature was verified)
 header.d=xsightlabs.com;dmarc=bestguesspass action=none
 header.from=xsightlabs.com;
Received-SPF: Pass (protection.outlook.com: domain of xsightlabs.com
 designates 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com; pr=C
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AM3PEPF00009BA1.mail.protection.outlook.com (10.167.16.26) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Mon, 27 Apr 2026 14:28:28 +0000
Received: from emails-2642109-6-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-213.eu-west-1.compute.internal [10.20.6.213])
	by mta-outgoing-dlp-141-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id A153C8045A;
	Mon, 27 Apr 2026 14:28:28 +0000 (UTC)
X-Mailbox-Line: From b'robbiek@xsightlabs.com' Mon Apr 27 14:28:17 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iv5QSF2YMIU5NEHIhmYBRjdhfNBzCifshAiUwbwcoLpVctgJnLFcpzY9VK/HJXZA6fBf5t8yALuGz2J7M8Uz7u8wGezSmScX5nh34oqxhekRycX1sMbw3+nO2Nw/58SUgSGBk9l42XKcTgJb+cNdpytgrRhfgPrkYM4AM57yU9upuNSpKtdzPuCTTy6ybymJZOH78ucSzyrfu4UMkJPyyH/us1UYZNte8ZTb8fMtr0x9CEYFCdTIHANuBb/UIfSTe6HdGA0mMKtXAusyD63ELVgiQonKBFCD6Gsa3KR7PoS6KfwRFD8PJ6JqPU9DE5cyC1cPEm57MsEb1jCp0Eeizw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2r1Opo9L8oqhJ7t/guuet98pkyodATZHrdji9Y53Soo=;
 b=XCH7On3+lEsvca7OzTWzwxyig65M/+uTXsfk4QEVhKW3MEwYddqt54bNWLzmZIFUHl+Yg4mcQBckFHJfeKNSuu54YBmIqdZd/AuE4fH4dihPdhbIUW+vG/O8ftZiBJE4/yBxOaGVfFMurDOBRDgajwiJi1nPIrZrrmOxlZR+G7130HiQVacORz4lZfiR3eBovanawytPH91mrfbceQ22KPqv9NhwIsLktacDKQq39XV38QkOjzqqByr1U0L833i5CruAZ34iSi2f8tmg66LiIgYZGnxW1VXlU7BVwnjV+pOWhI2wZQrLORJShuWgH2nH38wwpDbb4sxxICpB5vPnNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xsightlabs.com; dmarc=pass action=none
 header.from=xsightlabs.com; dkim=pass header.d=xsightlabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xsightlabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2r1Opo9L8oqhJ7t/guuet98pkyodATZHrdji9Y53Soo=;
 b=qLSDu99+ZCG/rgstsyXiTAwU2jw8k0RopDwCyKSnm+zV9kWk5SJHx22aMxoDc+O4Q9YYZWr0nYlgTKpsTc3Y5qa7QRUZLZiyNTqiUyrsWVOOs05ZIgGHhkzwB7jDaXNnM6EVMHxBPveMWLfxzI+pnTu7p1pNzifs8GLgkcDf1q4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xsightlabs.com;
Received: from PA1P193MB2926.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:4ff::22)
 by PR3P193MB1102.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 14:28:15 +0000
Received: from PA1P193MB2926.EURP193.PROD.OUTLOOK.COM
 ([fe80::ec36:3a81:d4d3:d313]) by PA1P193MB2926.EURP193.PROD.OUTLOOK.COM
 ([fe80::ec36:3a81:d4d3:d313%3]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 14:28:15 +0000
Message-ID: <27794f6b-cd8f-4b38-a5c0-eed30858f8e2@xsightlabs.com>
Date: Mon, 27 Apr 2026 10:28:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailbox: pcc: Fix probabilistic command execution timeout
To: Sudeep Holla <sudeep.holla@kernel.org>, Huisong Li <lihuisong@huawei.com>
Cc: jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linuxarm@huawei.com,
 jonathan.cameron@huawei.com, zhanjie9@hisilicon.com
References: <20260417031429.2509443-1-lihuisong@huawei.com>
 <20260421-adventurous-victorious-caiman-dce291@sudeepholla>
Content-Language: en-US
From: Robbie King <robbiek@xsightlabs.com>
In-Reply-To: <20260421-adventurous-victorious-caiman-dce291@sudeepholla>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::11) To PA1P193MB2926.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:4ff::22)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PA1P193MB2926:EE_|PR3P193MB1102:EE_|AM3PEPF00009BA1:EE_|AM0P193MB3171:EE_
X-MS-Office365-Filtering-Correlation-Id: 2039b827-d05d-4467-0757-08dea469403a
X-CLOUD-SEC-AV-Info: xsightlabs,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 GBKFZfg7nOHG3ccr2mxuhS3oYB0vfpwJGf8s3GPcbT8gYvEBK3WEURaq1ChgyBHmbWEmDjHz+0lWovgJ86P1/EYPNImPXYCkYVV9/Y61xLOizhsDT5BWhQeJWxXGS2X4+rJHGmdjyKtxBGJKiWTWLutzlJ6i1QLcl7xh058PdHpeyiDXY3mx9L5nfcy+koTaxt7F82Hz96HUvv99o225Kk3rv+BAnGVAZe+83wjW3l/9/FoSFFl3pg+KAcM/VJSk1+dLqzIOFm5/EWe6u7cHBs1UMjLK2qvwmN7VsfZUca3pv2SZNUvKbldiOjxeX3dkxYYAOlftPoqC78Lm13n5lX1XWg7q4yAlJjnK9/ti0v7s+BcflbGrFboEiIkMfkEJ0zyEragl/dR2u7lX3AIb94njeUY05iDIlmXnLiIsb1T47B/77lXB73gPrDvGFnR/ePzVfTGD8d1OgjGGvLBf14EaaZzLvwj3EDRhUQsDowTJLrXBd+wkBeUvcO06ubzlGXaMbyYzHxxAtnDiAllk0o2XNI7hBbFiizuyLc2HCF3IcWntjJK96Rgn66OuSWm5bwC7a9rsMY06ldUSWFdcV/MhgvEOEqt/j+DZqftzW+9pON/BhNBWd0loufltIt/qsqH5mTACV+rOcP3wwihrSPnnrPeu2KiIyfCfscbw1e+ghTjdvCqR0OvEGx4us20gqkWnHVr2/bwYT0OFj3w5meCCt8VbHI25I5tqeRgzGRU=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA1P193MB2926.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked:
 utKL6kwEaXGum+dJbJf6DS8lMI4QmUlPbi9DUNQTFyYzbmdN88Xo0eAfx6YShFtBy1lvo5YG4kxBh3osYgjmlR0UG98XB9JCB0Sj/EhjdAnW7O+aFz9bLubft0It26TKITa4NDOaN50VZS4HmA2ajQYHNLhPjNTMfz/3R034cURv1VpytoXA9drz09Yb+6YNxhLXy3rB8qqYE8ymBUgNB0WZQxCMkjDH6o+z5326qdyn6/pPdBjAsC8SfbndCML2SsLCFRTYCqdAnD+1RDmNX2sKY2EX7DRGMuyYbmniATbOERcmNdCwO4CDRocjW4FEdaTpp7Y2LinSUD0WLZM5dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB1102
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: f6220d82315b450b91f2779b2358fd7d:xsightlabs,office365_emails,sent,inline:e0e6546e59b0a8350d81347b22de83c9
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c5236ad0-5519-412a-582f-08dea4693810
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|35042699022|14060799003|36860700016|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	JGy6gSmLJdhN/0Iv552jMyAVuDxnpbbzGcTPU/pY8aidfBIBpAAF3GmoefaJFdr8eMBFaoNf/FqaTHAkYkp/hCttdxcIy+t9Ycgcw3JaZp3vgzEDhxeHhP/Ze3kyFQdnTm77diZB8ik5cPpOnfmWtoF8f22cQUEOse0HjTy+vmFAspCnhe/hyH52QlLCB02Mt3wTvkONL7IbXCmbtFHF2uh/Jwr0imwzDv9ab3xcPKlOXOpgjyeGirl8fk8vy/X4Ww/fqJtjDw//cpaiRyreorL0Qo2OdeFVdegVMPrusyNkw6G+0DO5lLB+CHUTIrVUP+U3NUi+h1bvCTMZlewkEDEYSHHdAZlwYeSE0HqNc6Kye1cUXvLkYopw2sccYIT5mWUim9jnn1Ie0A8WBiDX43w8EJpzH9rLKWTbXSbn0+nvLdfGQ5DN6y7u3wbE12mgiCV4GBprcoafTizHUDXQsva5qxaBPQd2DzU62OkcO21Z5wVTlTbsWIVXMCvPnV0Fgm6oARuSrSPPScHpehGZyXDUn8nPk6oGIrsuMbLTcikqg+dmHzo5afQ0ejiv6V904X4yzUNe4SbED1d47TCxUehmDOdH+jhwbXZPHz5GRTJvbZDgD205Elo6Cf0tNZkQxnlgsHxO84rqjxBnMh8SikqR1vee4zas+F7fciB8Kc4Hl0FjVcOqLP+Ij34o/NyTsOsgEPQ/6QfkrPsOQ1jK7lAIIzD7uk22VGvMZzrjph96t7yQbb9XZQTXJxH4c4v1X8qpM6wuh5xmrClttN1h7w==
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(376014)(35042699022)(14060799003)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UMnSdlffD7npf1vBRhzb9MbjWLTVzIW9bDuQ8/D3ecIFBdXkXBJX6NXGDMoxcSKRbAgHMXq8Ho4YyODRooeJqhBBUDEKP3QY4+pftPnBfSMqvAyf0wkL3g+cJ90MPwKuhwdstzVurzzoF2wj9rhtCpendXBLu0ano9WMt4vegKVyKxK8B+KDBDoucBvrIc6+QvJ1rxM2OqSzyXWHF59qs+uvRe5yH1JFnMrPY4eJm7OTNniTUamH6vBoraeUOCOXK6ZIjcoEluC/xdBt/DM2NIvJVbJMbg0cHMD+gmsLZOZ5KcsLceuBnyRw6M+YfrnBboEjIEszP+X6PIUd1sKAGONHRLmAsiDYyx+uWnnJd6nXkZUw3KrVXy6e46teq8d3WltYhFUAtx7CsFwUfMKnwa6KfsYcqWFyBluRSm9YQttSvhlBNhKunMaJQpIcaya1
X-OriginatorOrg: xsightlabs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 14:28:28.8394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2039b827-d05d-4467-0757-08dea469403a
X-MS-Exchange-CrossTenant-Id: 646a3e34-83ea-4273-9177-ab01923abaa9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=646a3e34-83ea-4273-9177-ab01923abaa9;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB3171

On 4/21/2026 6:05 AM, Sudeep Holla wrote:
> On Fri, Apr 17, 2026 at 11:14:29AM +0800, Huisong Li wrote:
>> In some scenarios, PCC command may experience probabilistic timeout.
>> This is primarily caused by the chan_in_use flag being updated after
>> ringing the doorbell, coupled with a lack of proper memory barriers
>> across CPU cores.
>>
>> On fast platforms, a race condition occurs: the platform processing
>> completes and triggers an interrupt before the local CPU sets
>> chan_in_use to true. When the interrupt handler pcc_mbox_irq() runs,
>> it reads chan_in_use as false and incorrectly ignores the interrupt.
>>
>> This patch fixes the race by:
>> 1. Moving the chan_in_use update before ringing the doorbell.
>> 2. Using smp_store_release() to ensure the flag update is visible
>>    to other cores before subsequent hardware or software actions
>>    are triggered.
>> 3. Using smp_load_acquire() in the interrupt handler to ensure the
>>    latest flag value is read before deciding to skip the interrupt.
>>
> 
> Are you seeing the issue on real platforms or you are just reviewing the
> code. I would like to test it on the platform I use but I don't have it
> handy, so may take some time.
> 
> I have added Robbie King who also has helped in testing this PCC driver
> in the past.
> 

I was unable to apply the patch to our current kernel version.  We are in the
process of updating our kernel modules to support 7.0, once that effort is
finished I can run a few of our current regressions against the patch.
