Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021129.outbound.protection.outlook.com [52.101.57.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897E530FC03;
	Thu, 23 Jul 2026 03:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784776265; cv=fail; b=ePC6eTtRsqqaJaei8fusL5B5cnPSkcmXcT5uE/Xtp+YywtEqwjAvyYxkYVc0r7HFIQWTYgD7jETmt7tp0C4KYwar1DqQpBdRRxmpnPH93gvPv1H8Jwy4uOyLHk32sVL8QFt1i5O+jRiUbzTTlYH5Z6MoX5tuKsouz949bcyQbf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784776265; c=relaxed/simple;
	bh=qILsgLprcAju+jJAX/LxaT+5GrlrSvCeC6qaeQs2jNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PEXBUgdS6wl7SIhhOWIYu7QIfJi9tyBmFlFp1TcnL+urelRtsTno8oS4K4lgipPcrT0tQl0tNo99Me/pun82FjCHgvVOLPHbil/otul4Xv6kjg0DRfVUuTBIP/TnItyVntQ5XvhypE11f7iiPYCfS5Mlvz+RfYvx3NUUW5Gz0mM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Ahqtxprk; arc=fail smtp.client-ip=52.101.57.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Ahqtxprk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SiaBSMASqwDtPMmPnCFt2xIT9AU+O1qih6XCFI7YeHOXogXVwpg8KoAlc++FD+ef98RgLsrCRGojGyFULZQhQHElOeErPjB4Ry02Vg0SL9Ha0b5M4de8ozOq73tqa1I6INlC3i5cWUSnPm3MAlFdiBxXRJbvQAxxKU4TwJsHqz72m55tp7LInybtUcB+IBgr7lKDE77INLQ8ONgBP2f38dP5s/0HU2PeETlg1XqWWpLMbegoUclvK3qwRagfMDTKlBeWo4LADbqAs3/xjM0CSkDqmgBP36t/MfV8OBFmkzaje85iz+GOzoXcyplGjdEgUSV4TRtgKOZxtJKLgEGDDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6T7ibrDlQRP1afVY6OzC9psZXJmSThVUptsdneoyBMk=;
 b=AgYyJRVdJKNCpq5L2ejpqFwibDIna4CR+1kgBbjfZIMqlGh0DWRDRncHH0fcUaNgi03BMIt2Sl8FWaGgTwwB480AEVZAmepz9tEwKSzdtgb1lFWc2tY/IphHhUBvWR61pMJnQEE/rKwpOLI3+gJjbBpSCHFkRHVAYdqDzCfgIWkkr5meQ0Y/9hpFQarTDXtcJFEk5OwYKz+Fcxa/OfK+Ay0aCZJYEtJeuQrApZqbkqEPuJvYci3nxGRKUJAm7Q3tlLYD5QIC26acI/fBm4IdmG/sYfw6FDYhdx9HiQgxMzNtcsQgppJ2t1M6UtUKLnuHttxavdX3eOs+Em9MA/LYmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6T7ibrDlQRP1afVY6OzC9psZXJmSThVUptsdneoyBMk=;
 b=AhqtxprkZgppWRjaXFW//60hjYsMHibfcnDU90InIqjJDBFS484tuzmzJwNb4jqBEx/0c0W/pDxAC4Vvcl43uVBZYrtoX4N+DKKCTfpv7dtWxfXzEvXnsT/iwXBvpCK3P/PNayRQZWVui0F7/B6l+Bfq0dzoVZZmftRQur2HcSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SA1PR01MB8203.prod.exchangelabs.com (2603:10b6:806:37c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Thu, 23 Jul 2026 03:10:58 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 03:10:57 +0000
From: Adam Young <admiyo@os.amperecomputing.com>
To: sudeep.holla@kernel.org
Cc: jassisinghbrar@gmail.com,
	lihuisong@huawei.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: re: [PATCH 3/3] mailbox: pcc: Fix command timeout due to missed interrupt
Date: Wed, 22 Jul 2026 23:10:51 -0400
Message-ID: <20260723031051.156890-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717075649.467172-4-sudeep.holla@kernel.org>
References: <20260717075649.467172-4-sudeep.holla@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYXPR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:930:d1::7) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SA1PR01MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: 350d0a99-62ab-4cfa-dd26-08dee8680431
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10070799003|22082099003|55112099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	KDthmoKq5Ij/Pwc4xkynx6BYwgRKYcrxMxdFPqQnBBX7H5WC8dNiRXqo7RcSeLDDmtP4lvrTFOAAaHiO5Hx3i1X2cDrQEAUSpyytnNchVeHVKRtUxTbRND6u+XEz/p9PyiMAeTIwldKen9yBgwbdqEaxbELQXouqnhKXKOGTcK064zRTmFVrkTb16n0vmbr6VoDYP18ZGiiOAKqwE9FfAmUspbzQhOBoQwR0PqS2vjxtb3N6V3cpq4V7PjeXxsMgVhPzwCeS9Wp3h8wgNB8jIuwKCIxE4FedSKpjEwb+h5V3C0UdvpdKRK73bS/dtd5O3OuQzYntt9Mp93hHRwo8uAc1YyfiriuSP30Od7ChClwjoijJhWYOYk8hnMmZHRHMGR5fJDuudfyL/eJwPidoXZfXJ4LjCrrMSKPXYimouIjpcgWdSbeWYi4z+2voCOkbhyM+8sK+3XEXPTK/8qSa9r6bAa4gcgFOmG/D6FwIT24kFVP2MQZBlfWHPWTJl50EDxRwEuR+JQQB0iYacIWYCeqiM7tithnobtFNHnkWSX16dO1WbiQ22QLbcxTi3TFpx6a3BB1hW5mNA73ugYVH+FAUoMddjHz8AGepMJffsWyhlPEi+Bc6kmGOeiqmiMYXsZaD4oA44LqPeRFhu59KrgZwWHt86PxxFwXRxM+bD4o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10070799003)(22082099003)(55112099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O9Cv6tEPJH/eIxuZROi7muBBCL/hK3gBRt6toCeBDrcoc0p7+sNRkBTfGLQS?=
 =?us-ascii?Q?MtoSsnD1UrOZWAxn5zs9paDwq/MQULwunTiWKUAiPD9LHXgwaK4cyeik1mnW?=
 =?us-ascii?Q?TGqxQLmA3oCZV/CpVOmIArU4o/lTtfWb+9ZKiO13DwKgxmOZTgwrgNe/TTox?=
 =?us-ascii?Q?tglif3+OsPwbQegcZa1Ko5sk9vAiPdvcdFqfgElEPcVKHrfGi1zz1Ujbufmo?=
 =?us-ascii?Q?xTtaMWLkBzfKs/r+Y090rU/bp8vOqi9efrksJGjfFVgvA9QZaB2gzSUSQSi9?=
 =?us-ascii?Q?09n0CyBT1WJQ24tUout5+T8pjAF0W7DotlCMwp7aa+9kdEkBZRSV02Bm+C6K?=
 =?us-ascii?Q?vQAAQiwzAylSucJ/q+MsDfDwD1uh6ZBJ68dAkQ6+TXK/VhOJIrCUvTpvn5LJ?=
 =?us-ascii?Q?6OhjKQsETcZOyLcuE/HRYm4u8uTUNCME0iQXnjUliJiPrFbjSg87Lj9PNO9Z?=
 =?us-ascii?Q?3UxhQs/gRI0mqPJ/TmfQ+ZQlV+uUO+3AtZeZAbSj9ttNgHUxO2RZHxwkcIQN?=
 =?us-ascii?Q?CR4U+l6u0hAr7yfH1pxiqGCfm7fPIbt5mgYe+oWbH2reH4wKmoC59wvJj1N2?=
 =?us-ascii?Q?GesAt9pQgl3+fi5hSMYDw+wh98BcrwHDXCMolijXsbiMMGaQC1ToTrBGPAfi?=
 =?us-ascii?Q?k2ZmcCv62J57+yNbuFNuZ0iitS5z9XO1Iqx7tog3hSWhXay2Pxz75QeL1ZkG?=
 =?us-ascii?Q?W1xDlBI20VL5jVNv6ssIUsqwFiG0T/+kA2+WxVzItqxAIItGd9W9kiRZh2bL?=
 =?us-ascii?Q?zQws1imWmP0yX8B85MSqhCdZIM9RFyQZ2CAQ0CCI3mUGhqXIrbxFoAFyNx8r?=
 =?us-ascii?Q?G3uSgZcw7+N0ohSyKjoNhHnfOcji9Y0vlRjvGMYrmB1BJNyuAdoGk7s9Un5t?=
 =?us-ascii?Q?nJuQUY6hOQWcL80hSTBQItRieBa+eVfiN1JvDCbdnsRZBojlKHlv0GB9dpgm?=
 =?us-ascii?Q?GzvmB8OojLPWUMr8u1gC9Po1SAdM3ZoUbrPymWMr5GLcVAtWAhMytycBlAvG?=
 =?us-ascii?Q?UQBEMq13FyuX23YKpGmfuO5SVNQNSHyEVPahI0yyEo2GX/E3gXfqEBiquA6L?=
 =?us-ascii?Q?UlLwqX9xrocSHWoTKT2RPUgIG2cRJd4FjAQeGeri2O+vlHOl9QpMna33Aarg?=
 =?us-ascii?Q?9Pd75AJyad1pcLLsl3xRRzuJy3FZsW2l2lMSuaNKtkz/KCN1W2T4EpV3ee70?=
 =?us-ascii?Q?PewBRoAHTuADmKSE4AYTb16mG+pKwaiTSynj7+rlsoumH5sO4joVYoowiPAR?=
 =?us-ascii?Q?8S0hz4jJc9fPqxl/0lS0fDwHhI+jMD9WUJQ+uefgftZVHwLtil62Q8dUPkiT?=
 =?us-ascii?Q?H+0ImMf6rTy2TXP60EG7JiutJST/pkoKjrEIwOeFMzyuYi3LBdg/mjQo/awG?=
 =?us-ascii?Q?rPOkKn74/AA1xiX/f9kMdqNUjEt7W1u9r0Gy1myaQGZ2DI64wvVX2Sflspvy?=
 =?us-ascii?Q?di8vniGDFbD56iw0bgSoVhvCAO4uh0tgr7yr3bJoZ3VDSzgy9QxdOp8rgkwM?=
 =?us-ascii?Q?OLwtnwNBSgKeYl4UXkpVPLVJGHZjS2zqimO060JMbnY43fCqjaM/HyNRXe8a?=
 =?us-ascii?Q?ATk09/rbhg7GboL9ltz+gMko+S850fBiwPmIrIGFHMqps1uSN+cVWt2vKtqf?=
 =?us-ascii?Q?AvWal97s5oOeFSulxKWTbyZ1OaTyQUtT2loNz8QP+LyqLvy/4adHDDcVmYvp?=
 =?us-ascii?Q?3hZSfbSO9+HwbPWayk881f0BS6yj6g7M6EtjsL/VVGWfMBpc22eI5G+KTO0F?=
 =?us-ascii?Q?OD6xqszgqzZznuKM5SisgZH3WLOA8dawILoUka0qbWasAFCvZtCo/QEGBg8R?=
X-MS-Exchange-AntiSpam-MessageData-1:
	huSbkTu6waZ8IyECdJYi2hFXpE4oCClaspvCsN3+vxO5p+3phi7MhsVg
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 350d0a99-62ab-4cfa-dd26-08dee8680431
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 03:10:57.9046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HFP0ayte2n3dIxm7NLt0qi5ObxOFtPw3v0X/adVuMlelOYEYhWPejp/wg1LtVTqSKnw3tGK6eF6DYvc2NK6XOZGMKWYwLbJ5yklPJ6/Nob0v24pPu0E2V5IvDlcup3hq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB8203

 
+	/*
+	 * Set chan_in_use before ringing the doorbell so a fast completion
+	 * interrupt is not mistaken for a shared interrupt from another
+	 * subspace. Use WRITE_ONCE() for the lockless flag update. The
+	 * ordered MMIO accessor used to ring the doorbell keeps this store
+	 * visible before the platform is notified.
+	 */
+	if (pchan->plat_irq > 0)
+		WRITE_ONCE(pchan->chan_in_use, true);
 	ret = pcc_chan_reg_read_modify_write(&pchan->db);
 	if (!ret && pchan->plat_irq > 0)
-		pchan->chan_in_use = true;
+		WRITE_ONCE(pchan->chan_in_use, false);
 
 	return ret;
 }
-- 
2.43.0
iAt the end of the above code, 
 WRITE_ONCE(pchan->chan_in_use, false); 
 should be 
 WRITE_ONCE(pchan->chan_in_use, true);

In order to keep the original semantics.  The flag is cleared when the messages is ACKed, not here.  This version causes a hang.



