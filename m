Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794529767;
	b=VNIslmBeor4PUAjIylXfa8UyJtddVRrGwYdGcYWOg4bAaGgV48qxCpg9po+HhGBIdGRF
	 +YB8G0f/fVQLa8zUGKWbLk2gzbXDIcZ31Y17F9YBMr1wDBA/Sn5yPOumOetczLv0Nudga
	 XZM87cXyBwcuLcUueB6/gvAWVUBRrbNPJ25QGOEoAHNC0JfQT5Ia2WWRI9jKX/lewRuvi
	 kNgIqzXdS9PKiYB8PXeD9o9b638yH6mtIeCBJmwLIu8hROZ39+FaCKWD1+jYoYRwdC0cg
	 HrBgRC9A0YD1iQYcVHYyFpvnmPGLvL+a9BjUdh7pk2jzwaKLFiH9hnjZ6bXPLySeGWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794529767;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=wQUkZm2zn4Pk71XaaKir9TcgdZIdv8j1aJzmZoUhHIo=;
	b=ourxdvh/O2+/1NJeFn5Ci4sg/Jaw2hOpWbDQ6SpDLadYN7oRwwMhc/rsWtrn3075/u/h
	 RSp2VLJ7oj07V3KAgUF/1ME07eL5w643Bj9gHLyxMFzyv1+3yQmFbsZqdEv23MEKZ9eUY
	 HZp/bFtKmvecE6iSiFMxUvHsTApgkTdI0Y/ZA2Up7LzKkBiFl8yiaMBy05oo+jXv4d6Xx
	 FYcbYD2BI171bz5AP8nd51+/at1PS+0YKyYaKewiR1fmgBtr3q5ZKynis9nrYV5rg0eLK
	 W/qSkfSpxrAw7u3ssUn/wtFEis28nnV4Ri66wCJLBcU9YBBmB28tpPp56v2kAjkvwjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i+DUiVjc;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=loqYQz7F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F65606A31C;
	Fri, 13 Nov 2026 00:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95F65606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i+DUiVjc;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=loqYQz7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794529766; x=1826065766;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r50qKz22bdyq+Tk7dIvBjHFPLMjsyhG9xNwtA3kgiIU=;
  b=i+DUiVjcWaEKVwTi7XDSBYxDUJQmvjXDWgSj3/+ekQB5jSwJLdZmWiX1
   L9nBKSBxrDqFsMKm5BfGH8MZIvABrRp0GMv6dwB7+oaQibpxQ9UpZDPoT
   sPHpG3rewZXKkoK5JFXmSVvp9cdsGtPKyhi/TYb9Zn+Cv5U99aiWzUqeG
   NENXpTPu7ExBIV2P1Nvtrsx5RjMEROgelTGLFPb4iZYRRQpOi0olithPb
   hK5CCQ6qygtK378JOQMDO5LOJqXg8XxzlkNhW3gbWrX/EW5if/hu/UNvk
   EmL2RP/sVQAQsDLd0vAjZYFllP+puxlVwuMbkggqQT/xqfc04m4VItwtw
   g==;
X-CSE-ConnectionGUID: 6pSUUY7kQDOSbj76+K2MGQ==
X-CSE-MsgGUID: cR1m6GBzSR2m9cJjfX/xEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3204864"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3204864"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 16:29:26 -0800
X-CSE-ConnectionGUID: bv1PyV5tRoGbbkRLF2gf5Q==
X-CSE-MsgGUID: XEvSxm2/QH+utzbe90cBFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="10521507"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 16:29:26 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 16:29:25 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 12 Nov 2026 16:29:25 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.17)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 16:29:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5KjUHJN9mZWMh9E2l6gyXSsrmqpNM8ze/nvK8JSiJ5W9R2Hk4ClmvzE3w5ud6HMWFDQetoXPlZ6RG+lzdMQDL8pooJkA+E1kHe9qZ+bwPZpCUmX96y22rmAS5wxGQFOTKeh9krZ6183J3qd2neWoa/O4VDByttICmtu0YPsHD6DOu++/7S7y8Wp/nQok60VoEzc2l5r30hnLGQ9gpiwvBtpUmbCSAIk8wmpI2gqR/EeuqmF82rSw4O4GlC1cuRH7lvpD+naJwBK3coVYKfKoLNbH5DUoMglL6r14nkIL5VHIGjflDuzfvb4vtTpGtD0IS0kSe+P3cHLMeRBRCCoXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQUkZm2zn4Pk71XaaKir9TcgdZIdv8j1aJzmZoUhHIo=;
 b=UBA2JyPaOAWFMoBqy0C56uY77noT0nFFr7WbrTU4TFvwlyOAuFQrPk9Fdb0uhfraxPBlE4VSIC14rGk72I3Z60ml4N8PHy4MV3i+IZU/YpgGeQCYZBgF1nRTQeRQ1xpiJ8muvhm39WuHTLRnu5ya0SL81BWLFvr1tIGNdo4zckiQtRERm3S/72BR9gF/RB8TwoIREdGuFUNCHOIJiOGOuC/ThC3OECG9HVMsuyqhdkinQ+56JCCLBCHWIN2QnsSNBxAvX4gLgmNT7ai0/8kJkP1lLhxfKY8TMEcw2PKQowT4vbY3bwHQSyAgXNWdfi+q9Ensx8bmjZ04eP+v82GBCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQUkZm2zn4Pk71XaaKir9TcgdZIdv8j1aJzmZoUhHIo=;
 b=loqYQz7FmUaYd1FPRuqxC6BATwQlnrjJ2XStGiy3kNvZKEjJatxTE2F5lSzay4Uu33CXuyexKwqPG/1/uOhiKbfpFznNt1BBxE/VmUy/EEKagIQE9PdZ/vgtViCKWcoSZdEQWdguu4+IrYJJuvjs6uXt4OEDZrl1oHLGxVLmnRo=
Received: from CH8PR11MB403433.namprd11.prod.outlook.com
 (2603:10b6:610:32f::10) by AT6PR11MB935162.namprd11.prod.outlook.com
 (2603:10b6:170:113::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 00:27:20 +0000
Received: from CH8PR11MB403433.namprd11.prod.outlook.com
 ([fe80::b087:96e4:50ea:b5de]) by CH8PR11MB403433.namprd11.prod.outlook.com
 ([fe80::b087:96e4:50ea:b5de%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 00:27:20 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Zenghui Yu <yuzenghui@huawei.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "rafael@kernel.org" <rafael@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"guohanjun@huawei.com" <guohanjun@huawei.com>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "xueshuai@linux.alibaba.com"
	<xueshuai@linux.alibaba.com>, "lenb@kernel.org" <lenb@kernel.org>,
	"wangzhigang17@huawei.com" <wangzhigang17@huawei.com>
Subject: RE: [PATCH] ACPI: APEI: EINJ: Validate length of the Vendor Error
 Type Extension structure
Thread-Topic: [PATCH] ACPI: APEI: EINJ: Validate length of the Vendor Error
 Type Extension structure
Thread-Index: AQHdcdPjUx0U7PWz5ESx+HiIsCK3B7cqw7Og
Date: Fri, 13 Nov 2026 00:27:20 +0000
Message-ID: <CH8PR11MB40343305FD3C1BE0E18882B5CCFC7F2@CH8PR11MB403433.namprd11.prod.outlook.com>
References: <20261111115729.253-1-yuzenghui@huawei.com>
In-Reply-To: <20261111115729.253-1-yuzenghui@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH8PR11MB403433:EE_|AT6PR11MB935162:EE_
x-ms-office365-filtering-correlation-id: 11537ac6-928c-49ee-7876-08df411ce17c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|23010399003|376014|366016|18002099003|22082099003|11063799006|56012099006|261102123227099003|261022075727099003|261026121527099003|261021121427099003|38070700021|10067099003;
x-microsoft-antispam-message-info: SMq6R4JlUPVeq6bobhsryb3eonNT2+A++WOSyRYw3+wiZ5jXpLrSQu9qEQ7z8qjxWac8SXwSELbxKPQHiiTdc/Q2RkwCmT/pJ3wyvKPwn2Fk8WFMvHCAPvBCsDXgyy/SDISmmQakoT+ibPI2TxSQaTuR7BoxslsxvZXogNifzPxFVSICevLIWMCV29zpNyMjHMzKgqA6hj1d5JZZy1PgjJBJSs+453HoNcq82kaIWmaaoMJ4eHJ+ca3r2E1iA+yrrSXmUgQRc0QaS5wCmw8fvmoeayCWkWMHCcc4K3N1JVPVYgepaxOnaGpUk7MMdh4kIIDcSUePOY30k7REDKkhGoEgeNWQWFR8iMIfxkNOA7CJJuOF9IlGU7rKgJlwvqjCOzKvQg4IZmHI9A7D+YEq9QXDFcqjHsQUjqGN4OAihToY1TJy0fYAvVbdDHlZu2Q1AlCioZ3feZXZLCy2SsOIPgBtKj2wS13KpCqGw6LCYxdFWuApPKZsFqsqPKMEdaUMqeXh4PXwAfsNZbeJKe7I/3TZ6hzicbN/mNBSl1sf+zxmTRc/0ryVyp55aGqCR4ratkxZEjxYdRW+HWXOau9idzm+Qbxq3uOSqHQBv6ttpeONrx1/KBIJqC9NmHMjqoc/d8RIkpeqqZrFwbES7bohq6l4HYJRfi+zxueuhhK3j0LdG+eLS7GyJJGBzCjJ9e+6y3j0nYUeoQjj8gyLYxK4+cAp57Z5afjXf2eMYWZb/qg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR11MB403433.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(23010399003)(376014)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(261102123227099003)(261022075727099003)(261026121527099003)(261021121427099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tntPc95KKjdKUP+7WWRil98m5YPpJofun7L+KQLGRFTKqf1K+B1Nkor2EJlh?=
 =?us-ascii?Q?UxJyXvJ8HuFLSIIk+/LDx67LEj2jBKhmBbF/deAAjsHWKN/cBwbzhALZGBSR?=
 =?us-ascii?Q?Ryy73iHKkNsWgay8oq13dQerFhEZGsV8qXoeqNeYCBoykr7PweGPQIo7UCh6?=
 =?us-ascii?Q?Zl6jjOKINJI2/V4568dw4VqjGcdKTKyqq2MMggjJbZoYLDhhhu8xCkJCe9Gf?=
 =?us-ascii?Q?LFVhFCrzJ8r8Biu06DgC5vnX105m4zXDdWn8HM08uNcYxlJD3IAJx6SnYYR6?=
 =?us-ascii?Q?iEapK4Xo+3LaVwAUnWc0zQvu4pj4H9nPThD7Tp0lwPOmyuy8Z3JeDD2hpjr0?=
 =?us-ascii?Q?/J/nmcFtnUsVj+gHLPEOrAyPPVKu8IDjaeMCVCVq/8Tu+jrY3q/rar1wft9g?=
 =?us-ascii?Q?VewUBMIqPvWMX4i6cE/dISYAW58/wNxxlB4cvUrwaFrXzTdpOwqS2+0EREoC?=
 =?us-ascii?Q?QqBNaQwkPjBOmXeC0HX8Nf4IXK4AQI+9TpLLY7F5zZWL9l5Glitdp5ve3VLU?=
 =?us-ascii?Q?w8L9dgWELWxot2N1uoF7ip+vljdsPYUkM9IeGxvD7eZeWYMAdfbAAngGMjJs?=
 =?us-ascii?Q?PmscP/LzmNysQ/8uatyjebnWvN881f5JZLIIMuVwkFOrcNippyZgt/9a2Kv0?=
 =?us-ascii?Q?iOyEZXfzOw/9y+Ux+CA0BMekmpNOzxwnONqvB0i9QuXr8fnPBr7h1wHX5yrV?=
 =?us-ascii?Q?jrTHGmoHBQF6VAaaLZqe00+1XfzV/vuTsP3ZCk2kxfSzt7V+b4pienBYAY60?=
 =?us-ascii?Q?AwVQJRQY88uFiENFEkuaIWtcE7cSZzb95ICvggNvnzjzQBCCWqz8FRd4Vpn+?=
 =?us-ascii?Q?zQmjWd1Px8M0DM2Pcy4TG6B79psCXhKiX911C+9MWwmOad4Q25XrA/bswLKE?=
 =?us-ascii?Q?H/HoXswN6fFBAojHtf+ZQ0p/NeauzuTKSn1MLl+UtAH5pbka5DVbledCaksi?=
 =?us-ascii?Q?hpJB/kfxAZS/apHG49JuQ6+3LRpvukuMWRcOk0ZxvF33HkPetfcg1uGeYpWo?=
 =?us-ascii?Q?7QM6toGNzZz+O+tbNCvOOD2HL2Hjh3PUf5nqtzRZ89Bw+Ygm6zZszVHaQgdD?=
 =?us-ascii?Q?8CUfFcdRVMHnHwaWGZxzVN48Bf0GYR9rNJDM/VjgKgW0TsrhCvB721KMLYIc?=
 =?us-ascii?Q?2oecZjK7hBmEPJrlBcPCeAJHF4dPXheLjJ2MFOU2vphQWWRj9nexOpT+s2NY?=
 =?us-ascii?Q?ML65todsdRi1aYVTPJ7J9Tui6n/cHS/mVNNRjHpTyYyjvreqdAU5ilkXkvwM?=
 =?us-ascii?Q?tgwgusowU5YdBOwXd3vcFKo3ZKhXKPy5g5kWr5P30MoylQImh0ftFWwENO3K?=
 =?us-ascii?Q?llnYMA80e5Qo6hR7lL6H9VksDc3xmVpb6Tw1bYvqNlE9lVsInQE5zFBL16t3?=
 =?us-ascii?Q?2QYUvSMsm3L4yaNerDZq2jYdGUD98ve53gWiQjGjavAG6gB43n5mOyDcfe4g?=
 =?us-ascii?Q?it18u35Ol+1oJoRDIQOZ2J9YowrKChVtdwAXu56Qa7uuPZUY4tByYMs8gKBB?=
 =?us-ascii?Q?a7kKb34kYGbJswT0q61rAPluy83Ry87AYEqfShLZuhidirr52RD5Ks4jyfDw?=
 =?us-ascii?Q?fMNs0XdASgw8bYsGZtV+f7hwBjIxaDd9ZGBIk2Fi7AJXUef8FACDH800DEkY?=
 =?us-ascii?Q?xMwiXcJIHtZMN7ayULX2HEgy8zmEeyHVn4XF1ksiDtKynvgg/11NH0rsbSXo?=
 =?us-ascii?Q?6Jqhb8f8hwMOljA/Z80lRqVnHOv9pwQ4QBwwgSQVdpfQy9Ol?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RZTOGPwYWoYVBp0MOeRWUA6gJ+gfn+BZhlAhdT4yzg6/LuUEHZqFAZBE0q9w/6qASHw06wZi0UXL5UwSEZIkm/D08D98rds3033CDThw4EJFrlgdvtXAOfpaBfVRdRnBGkOeGO5oJJalHXWVGl5AtOeLOTp/ootccp30yE0PgXaSkDd+XhpCd7ES2eZD0w2kOmXtyVBWHBCEYKhUrW+jeBGYSppNuDDUTyW+pDvp0lY2K37zZ1fIptmAuw+t/+winvefU5zvo+v8bcH68sOtX4hMLwCfvST5ENL4zVh8ERfgI/qleW6NDLls/TTEKAnYaBXfZVjwQJw5bvAxsOx5rw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH8PR11MB403433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11537ac6-928c-49ee-7876-08df411ce17c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2026 00:27:20.7445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FtYJInF/A8PisdK58QxoTKOPPKqoPVcrgoTU0umfCHaV4FEALQuCJ4RoYh6Hmtwy7E4Qh38c7kytX+6gF/u+iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT6PR11MB935162
X-OriginatorOrg: intel.com

> The BIOS on my machine is obviously buggy (non-zero Vendor Extension offs=
et
> pointing to zeroed memory, and bit 31 is not set in the error type either=
)
> and needs fixing. I'm not sure if it is necessary to add such a sanity
> check for EINJ at all.

Production machine? Or just an internal development machine?  I.e. is this =
broken
BIOS out in the wild for others to hit this bug?

>
>
> +     if (v.length < sizeof(v) || v.length > PAGE_SIZE) {
> +             pr_warn(FW_BUG "Invalid vendor error extension length %u\n"=
,

The "FW_BUG" tag was created specifically to point blame at BIOS and thus
encourage OEMs to fix their BIOS. So correct use of it here :-)

> +                     v.length);
> +             acpi_os_unmap_iomem(p, sizeof(v));
> +             return;
> +     }

The fix looks reasonable. If this has been seen on a production system, the=
n
seems a good idea to apply your patch.

Reviewed-by: Tony Luck <tony.luck@intel.com>

-Tony

