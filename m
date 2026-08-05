Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80B53BB684
	for <linux-acpi@vger.kernel.org>; Wed,  5 Aug 2026 02:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896885; cv=fail; b=B6PrcuIgaU7KTL5jCwM8doWNmdTUzJy6oubxtD0guNYJSFs0Uyj2SxILhd0tVV0CQGb9pZseUgxyHjfa8JFi6OS1DyziAH+1DnRIYF+lk7Na4vQuMpop/JZwzpOUG/qvHf12l3mzWsj6TMuS4J0M7SXoJCTUBN8RpjoNuv8bWQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896885; c=relaxed/simple;
	bh=qIpVtDNeBNMwBHQZJ94NXQeM/09VG5Hps1qxCoMqLhM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FozeyaD4ku+3Ao4wZiRgQHJg80bOTIF3ZTPUHm7Ggw/RElP6Y/2wTj7x+jr0QEeQQUVKZpegU4Jez8LMUJysgpjo39xRxBvQHMpxLCkaXqrr2MJDaDDs5UYA3fiDZCsY5BzH71kUObvsp38nktRiQzOn6YoQtx/CE8xYyxc3vwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dAxjW/+o; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dAxjW/+o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785896884; x=1817432884;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qIpVtDNeBNMwBHQZJ94NXQeM/09VG5Hps1qxCoMqLhM=;
  b=dAxjW/+o1zcLCsd0S6dX0PqCDCSlDka5aBvaQEs1ff9z+7KBfH2iROtD
   B4FEC1FqA3yD1or18hkc1pLsDvPR34AEHCcrUw3eXONItm/aldlt5kOCk
   z32fB2Wd/Dr5kVNwKlJoLBD/ByToTS72FWKL/SE9q9ifFkvYUdvvVRBUr
   x9tqCH4A3K7DpqiVKaRW7Z2z3UwxEGknwVo848O9F4gH3oKSgsqWsW7Yi
   WBwkFcCxOKwRLLv9smL1y51q/7wTRxw/jTYOv0btpzRQZl9dBZFaQrrld
   hy4tXuLbhosYgDh3aKuQnpyVGFOKpLa67IpIU1dz+lkScO+x+geHEK6v4
   Q==;
X-CSE-ConnectionGUID: AfWcR+E/QIyadOZSpKdd+w==
X-CSE-MsgGUID: f4Ea9HdqSF+WF+uJE0WNrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="103865001"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="103865001"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:28:03 -0700
X-CSE-ConnectionGUID: EQ+M6Lo6TkKP7YqVddHxLQ==
X-CSE-MsgGUID: TN9ponreTD+V+74JzOKRCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="257354313"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:28:03 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 19:27:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 4 Aug 2026 19:27:29 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.58) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 19:27:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tt7RN141H7MybZpFSyK7oIK1iXId1rpTYAZ/XAZb80jjSbgXAQW4/GUA+t3lJN8pJ4sDCxnxp93lX80b+ZWxpBQO4O0JlSGy3Z3cgPuKc9u/WczjjZjXzNNDcxm3aCzzJMkoSx4B4DnceP/Pbg3RUaRyA4GpWkCBsUng7NfLmeje9NTS2O7SEPKGFbWHA+7ZdZcyWrD59bZecq+LSDHbd+e53smMS5zA73fUxNk0ejhCnm6sSd1E0eka3UFX3RehXmOp6Ixn1VZ0Z5rVS/UxqAXgNzB8GIylJe3ka2R5BJps0sFXKTqzTjAJTsZfkt+mHKl/VQFxlXwG2VjX2Lm8zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIpVtDNeBNMwBHQZJ94NXQeM/09VG5Hps1qxCoMqLhM=;
 b=P3ur5O5SMNNOMb9Amk8b82iQPkoy/Syl/63XAqFA1FV9gqCfW9/Ca+6zVD8JRMj+sJ+0AYhUjFx1SqinmYUQOrWw6okDHYzqJOL15AVkgwZXdHBz7i03ZSxZct4XTLZGykfGUQBa5ZE/ECM+atbVezIgiZmdwOxR61dTE5dKmenADvNsdrzHDYPtP9lQdVAdE/87EkBXWE0s5sfJ4sPZfKP/tTppHugD3tFLC4/EU0JzaEQRGnXXCdW24XJY3wmYDzlDfj2dpqh4arYv3kD45MBFmkANdC1ayAgEZ4Wt3cRunH03TROBoLUgzZCG7DwD5RitjDI60H63hokUCoZfxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com (2603:10b6:a03:3ab::12)
 by DS4PR11MB349881.namprd11.prod.outlook.com (2603:10b6:8:514::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 02:27:00 +0000
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae]) by SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae%4]) with mapi id 15.21.0292.013; Wed, 5 Aug 2026
 02:27:00 +0000
From: "Zhang, Lixu" <lixu.zhang@intel.com>
To: "frank717@qq.com" <frank717@qq.com>
CC: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-intel-ish@lists.linuxfoundation.org"
	<linux-intel-ish@lists.linuxfoundation.org>, "Pandruvada, Srinivas"
	<srinivas.pandruvada@intel.com>
Subject: RE: [BUG] Intel ISH (8086:E445) not working on Panther Lake - ACPI
 ISHD device missing _HID
Thread-Topic: [BUG] Intel ISH (8086:E445) not working on Panther Lake - ACPI
 ISHD device missing _HID
Thread-Index: AQHdI7YAH/fKOr5dBkGdvMBA7pl1/7aN+RaugAC8FaCAAACLIA==
Date: Wed, 5 Aug 2026 02:27:00 +0000
Message-ID: <SJ0PR11MB5613E764216E4A316442D54793D32@SJ0PR11MB5613.namprd11.prod.outlook.com>
References: <tencent_E301A1C5ED7C868FC1827068ADB63D727B09@qq.com>
 <DM8PR11MB5592E6650F974F89D3DCD2B1E4D42@DM8PR11MB5592.namprd11.prod.outlook.com>
 <SJ0PR11MB5613D3343CDFF1DC11941EB493D32@SJ0PR11MB5613.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB5613D3343CDFF1DC11941EB493D32@SJ0PR11MB5613.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5613:EE_|DS4PR11MB349881:EE_
x-ms-office365-filtering-correlation-id: 1797cabe-202b-4d0b-d124-08def2990776
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|11063799006|10067099003|4143699003|56012099006|6133799003|18002099003|22082099003|38070700021|13003099007;
x-microsoft-antispam-message-info: UeAy3ceoAPm+jc3kD+gpgJvNRFGamEp9ZTbQnMMj5K2D7mWBOcVkQIq2BwLw1cXcdkeigTJ31ZdHSp96X7+c6pij4xT2kqIZhh5QmuakuNAwWgPmlZJrGvO1i600KPxQNyBK/Ec+zskdoUoCRlNOKkoTSviqpD38vQe4wCVOkI6q2hv9hnlP8f99FEdEpjsfo0dZBuZwFD7PQPECaIRAjOd/OmGsaya4xsCcAAENFt80J/h7FxhIhEjBhLKOBPRtT3cVQLK6eFb+7i/E5uoYqUbdpTZ/Sm+fsGZvnsu00y7BZvhQGGLymThjjnbkdnsvyXmwrzPn8yAZeyQN0g9V8/dthREYQc0DDw7b+CfMCTsv0HlilYlORW522PQGr/ZNHHf1l0ZkxYgG0oz/a5ts9wYEqcT6TvvGx7E8hGbiCAnwv7PLYFaWBU4l34KrmY19eG2U6ecHdcnf4TJHl6fwa+gniw4i75WO6lvKO6se2CbK6A2eAqi4tzSN0worGs5kkvEBf86QPOb2IBHMnyqkKR43A5THNRFUxj93jOirHMY6jh1I7RC5zdrPxf+t55zKny9DCplDpm3aJYfIE6o1d0iKAaq8CpMxL8jKyCvfQ3MmBoL4tUU0DZbT8MA/v9wIdlCliluhHuQv7kKW6eg/32yN1kZAYSpLeyOpdK/BQMS55dkIMovIfVidsA9lxrKD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5613.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(10067099003)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003)(38070700021)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nhfVVWmqFy/358UnfE8kBalK5EjubqByZ6rmo0haEQPdMRqMUseXoxEJtR/h?=
 =?us-ascii?Q?PrhnQhAYaKwLW1CM8/2iC9V3cZWg+VAH1PoNJ0US/YwqLoN1BkiqHfkIrIls?=
 =?us-ascii?Q?OAx4t4gZphwzn66Px64KVrvm3yp+cJykVBK1EiSRYP3j3hw3QSc1Si5GWCn/?=
 =?us-ascii?Q?o3N1eD9Mhcd8eru4xTMtDps2N32KhXgHwUJaQhsVBXbl7RB1tbVRNJUDajMh?=
 =?us-ascii?Q?ck4E9aO2ZT7srHEeFcuKqueDtF/GxRaOmSyghG+TtEBBMCdfydISNFYGj/nc?=
 =?us-ascii?Q?+lgQkkBhbzna7+RBo2TONUrahuCRBCTncV+bDsxNRbLKtom1oEbDIrcveRav?=
 =?us-ascii?Q?bmh6wx4dWaftN3plHVrM/WCSgRcvGNh8UCyBLQbt7ahrTkpPF/5YNj9tPp/B?=
 =?us-ascii?Q?EBlwgt5yBsQOrVsQWDzbT2Jdk1E/QhaMDVGThwXOzynU3kDoi9lM8vzBgkCW?=
 =?us-ascii?Q?9+JZkgH+5JnI3V3Vkw43/aZkW1xwqIcV5y06gtrPDzM764B014/hihsloqdc?=
 =?us-ascii?Q?KvXICl1Hgbl5bRCGoSgsPPHL/R0Ej2tW5eMjYhsuG5C3PcqQ5wKKVLQXW3tf?=
 =?us-ascii?Q?glakH6Yz9uv/lyblFKLkw3AVFf8ETcMzuuIn2a6YqBaYCQPrzQI1+iKHgGrt?=
 =?us-ascii?Q?syv2LIiL3MRS0rp6gnGvnsmh6eghS6dxym5F/KivmzTdWA5TqzSUgNed0W/Q?=
 =?us-ascii?Q?BYX1h5OK+kbZSvgpjdwUyizFmFgHl5w1TnZoOEcFIKZN4qvKHSElC8zMMOvp?=
 =?us-ascii?Q?vTUQ6VUyOugMBCBVTq0Q0DhiqEc64Yb0JKboRtGyJ8Pu+vScDzP5x+NmdAoU?=
 =?us-ascii?Q?phm1ZJULhNRHePdgE/UlfE5gSWbct/ppKmvNgm6yD09WfGyj4EiYCQVhncpL?=
 =?us-ascii?Q?8gm7Gv71xeEwPEtlkByVZ2gjL5aHlP1jN1tmry1l0h//npKgYCerKH2OnoCA?=
 =?us-ascii?Q?cE+HdG8hVCYFs2ZpOPndpfDLfLICmgQ+JZldMfpLNjruco2J79DsOJrRFRYM?=
 =?us-ascii?Q?gs5S2glXYhmqZ3Yq/lGz/C8Byijzx2Qhnz5EH6KtLBlWK3JkIhYU1WMv0MUr?=
 =?us-ascii?Q?zfhvh7nfpUde4n/qpLuileFNNAqVNg9wqXZAuE/OWXDQny4djNLrn2wROPML?=
 =?us-ascii?Q?uyD2nvvS/dWTZugI3oUmZM334rKp89mRa0mwVmR1oF+QN9JLoY4KgB0fAtCL?=
 =?us-ascii?Q?8K60kMj9BUrRWMdiB2aTe2OtRB7HVMylReDnxzsz9nis1piTxMxlZWrqZClI?=
 =?us-ascii?Q?lXJWUnm8LkputG7uaQ41RuTB8I5RgWEn74qsaYwTeiu5g8DtBYh84G7KcWcW?=
 =?us-ascii?Q?mNw/EOUyuQ/GWuIuatddD3htci27WZ5eDitZZwM2N+M6nQTJJe0s9vwNULKh?=
 =?us-ascii?Q?/Wlg0L/eEANXsevttMEfqcZtEBLcUG72vg0mO7ijhSSOn7QlHho/aoVdh9t2?=
 =?us-ascii?Q?dN3gIhvu6SokPsZUpDTMo2J2kKKabcFU1TrZcJKu5kUly/0qFlCLG4bnw9n+?=
 =?us-ascii?Q?J+CKWYh268GV/JB21LxeG4+t9KcYf19zU7YrSyZUnvUbqNufLKo3KXjHcsaf?=
 =?us-ascii?Q?gjqj9eNPxHo/yNl99KGgpGvZ/dgd0pmT+r58/VI9WiLQ+nX9GT8blfOo0N9a?=
 =?us-ascii?Q?ZVs+V4Ojst53Skdp9nIA7xKx57x/+ZSt70wEDLzhng4LbvVY3j3BCxp9nbDN?=
 =?us-ascii?Q?KXU3nDOdsfepU71qh3XqGC+mNEUMlXT8X+Fn73ENQkEzXk5Q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TSVIps47gP4FYqiRTMOoc6yVcsMm773EztPr+OzzS+RAvOa0FP99PFBwdSil0WV/gUqH1mWFSRObVsTecDGMHcsPZQiKx5zOOLLqYQRVZqQ/F+Q8kW+WqpjNLIbJco7yzarwTBl8uC/t8Iv9QozSDFkfAxU+1c88FgFsuQxeFN0KrQrpdsKeZOXE61L7F7n/kEdRtRRKN8V34oXjnHmoabyY5Pm37ypCpmwI5G9pXXAkrRywC6ENnoLqL2IlMN1urggeGacdv+Bh1il/GA0nZddiQoI+uFQcFIHNt4Q737MGnOjh4KQFlWpqm6XGWSXwZy47g5PAXADynsOT0xajZg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5613.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1797cabe-202b-4d0b-d124-08def2990776
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 02:27:00.2138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rNkk29ht7/muiJamXpM6YcHkUTGEodXR3sM38f87tPYPMv3iWYyfngGA2FSuZBg9Hz8hdB/CcjHYccK+p/Mthg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB349881
X-OriginatorOrg: intel.com

>-----Original Message-----
>From: Zhang, Lixu <lixu.zhang@intel.com>
>Sent: Wednesday, August 5, 2026 10:02 AM
>To: Zhang, Lixu <lixu.zhang@intel.com>
>Subject: FW: [BUG] Intel ISH (8086:E445) not working on Panther Lake - ACP=
I
>ISHD device missing _HID
>
>From: mailto:frank717@qq.com <mailto:frank717@qq.com>
>Sent: Monday, August 3, 2026 7:07 PM
>To: Pandruvada, Srinivas <mailto:srinivas.pandruvada@intel.com>
>Cc: mailto:linux-intel-ish@lists.linuxfoundation.org <mailto:linux-intel-
>ish@lists.linuxfoundation.org>; mailto:linux-acpi@vger.kernel.org
><mailto:linux-acpi@vger.kernel.org>
>Subject: [BUG] Intel ISH (8086:E445) not working on Panther Lake - ACPI IS=
HD
>device missing _HID
>
...
>Firmware loading fails:
>```
>intel_ish_ipc 0000:00:12.0: ISH loader: load firmware: intel/ish/ish_ptl.b=
in
>intel_ish_ipc 0000:00:12.0: ISH loader: cmd 2 failed 10

Hi Frank,

` cmd 2 failed 10` means the firmware image loaded is wrong.
Please refer to https://lore.kernel.org/linux-input/SJ0PR11MB5613CE62B68CA4=
AD9B1ED33693D52@SJ0PR11MB5613.namprd11.prod.outlook.com/T/#u

>intel_ish_ipc 0000:00:12.0: ISH loader: cmd 0 failed 6
>intel_ish_ipc 0000:00:12.0: ISH loader: cmd 0 failed 6
>```
...
>
>## Questions
>
>1. Is Panther Lake ISH support planned for the upstream ISH driver?
The driver already supports the Panther Lake ISH.

>2. Does the ISHD ACPI device need a _HID for Linux to probe it?
No.

>3. Should the intel_ish_ipc driver call ACPI _DSM during initialization?
No.

>4. Is there a specific ISH firmware version needed for Panther Lake?

Please refer to https://lore.kernel.org/linux-input/SJ0PR11MB5613CE62B68CA4=
AD9B1ED33693D52@SJ0PR11MB5613.namprd11.prod.outlook.com/T/#u

Best regards,
Lixu
