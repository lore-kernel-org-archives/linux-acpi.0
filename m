Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6573D9024;
	Wed, 25 Mar 2026 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774453316; cv=fail; b=Y/ZwwWG7T44yi89mAYHRAEZIPrlpCMsn/3QHiIYhoZwL0odb50OyUsucNHYRgUUCzDb5IWhwplmIE873qkKfzgB4rYveO7FsJ2XgjMXkBrKOAi2gzcghkITZU7zl+NefZmeWO5VzCquSFSsmLNV9bD+Fw66BUPTnHezRGMSj+iI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774453316; c=relaxed/simple;
	bh=TjfsPWw/FJFB8O1Z03UqEVVtrieoATKxgz3eFaj2Fi4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J7yNreZ+GyWoimEN5XLXAiXyKVu5VPYzplLaLY6bEBt7mja+23lnPHwNC6BViv1KHPMv3mBwPg0x+KrNo9H5356yc+Kiju83OzaCqox+9ZNrRSC9zF2Q516pKTleIrf/ezVcqN4oGjrUdo9zXStd30lCV4cuIfQQDxi0wv4HmuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dGkr3SPA; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dGkr3SPA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774453314; x=1805989314;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TjfsPWw/FJFB8O1Z03UqEVVtrieoATKxgz3eFaj2Fi4=;
  b=dGkr3SPAzlq4pSrO3XQcqUg0sQqe4IA9Ei0kra8knZ4mZqUZ1yK0/ank
   K8C11a5DgZfrmQyffy+F5tD8jtgzNh+Gs/pI5ZWMaW9dGir96dClddvlo
   W64jAniZ1rThV5qGgnTUh2lXoZ5OfJsggABwyhbakpBzByccImVOhsEOx
   /u+6BAEorptW+kMtn8DYT6kVsKF+au54NXHi6wMLF6M7044IDaHL4/sAT
   docNL/1Ngo71Vyv+C5e1bw0+jLZWD7JFaFiF35D0ing2GASVOLzaX+3O4
   EFl4hSUtCizZCia38vJ4CMEax9Ir/lvYav2l+uipvawJQb9z+lQocoxGK
   w==;
X-CSE-ConnectionGUID: NV7QVTkmR2ui01LA945C1g==
X-CSE-MsgGUID: Ceb4tQ72Q/mhFloOvzLEdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75381355"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="75381355"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 08:41:54 -0700
X-CSE-ConnectionGUID: rWZsZVAqR1OWi5amOLCsEg==
X-CSE-MsgGUID: LWzcndjHQrukQYFo3QYv9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="229171880"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 08:41:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 08:41:53 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 08:41:53 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.41) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 08:41:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYmSMBFT75PSaDNLWGggUws40zfS0pjoDgXcv5fC3vFn7teeXuLGYtRRQiAvvwy3I5fYJ984FOatB2OlGyU1yXPf1eFZvzYIvJf1rnh3UQYPxU4vQlCY6re1VgCzFw/wMlpU2upQ4Ahfxq5YB5CnEVD/AdpRUp3TisV/YPFMWxfzEx6rj2WedzSvYvlZdwRPTr3Xm8qYkLECGr9VpCzKQVFf4eotG9FPNt8+q1dlkHvUackavH2X//1tv8PJFai8vMzs55DfBVB4Jyx7Q+hYe17rC/bMRwRy9Nn8Cj/g+B15I3wNUTw4Uq8dD4bNR1bj70c9pUDl8OPiy57FJjp7eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGrJ7DUz9PVnQxk9/WXSEJF+lG+3xEbKTMex1EYHsZo=;
 b=Huk0iT38DAf5o51m1lh11YhIFPjHq5PsxFP/trg4BuVdaqM1kficIuIVNlOMuNb011GAwj+2xyuWIOMNmA7I7ZGMF1HqiIXXIKn52L4bRWWopBAVGgwYqyzH7OdnbFSzWfGylN10s7X4lZBRzCe9eenYEf72ot5Z6u0AgNSDMfCxYv05Z1iwcfx4MszxS1v9R6B7JQCTEwg4pBwW58zIP2VGdRZrZogbYQejwFm3y5JEJF+AT7iuJPT/6iZRh0nP3XopuDcFaY3y++5qUMN5QIaDa+CHroeNPX+5G5hrDGQ8rLjw9xntgzMD8r6MtuHweCg9L6L0oLuH/mYMQ9Xx3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by LVXPR11MB9756.namprd11.prod.outlook.com (2603:10b6:408:389::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Wed, 25 Mar
 2026 15:41:50 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6%7]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 15:41:50 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Padmashree S S <padmashreess2006@gmail.com>, "rafael@kernel.org"
	<rafael@kernel.org>, Ben Cheatham <Benjamin.Cheatham@amd.com>, "Williams, Dan
 J" <dan.j.williams@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "guohanjun@huawei.com"
	<guohanjun@huawei.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ACPI: APEI: EINJ: make einj_initialized static
Thread-Topic: [PATCH] ACPI: APEI: EINJ: make einj_initialized static
Thread-Index: AQHcvAoWPGnNh/lNwEe9pt0UfF9DP7W/YppA
Date: Wed, 25 Mar 2026 15:41:49 +0000
Message-ID: <SJ1PR11MB6083D15B882275321105286EFC49A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20260325034626.405366-1-padmashreess2006@gmail.com>
In-Reply-To: <20260325034626.405366-1-padmashreess2006@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|LVXPR11MB9756:EE_
x-ms-office365-filtering-correlation-id: 0895858d-353c-421f-0381-08de8a8507dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: B+VoEiuhOF7NVUQsHA8TnePkSj7skib0XEZ86dqDVbRz0XZGMfPJXn15ytIMy0gFNJaZnAC/xqQ2Ev6OiXivgq5Tc1PB69QiCt7Kg5dX5hRl9tG0LHKzbC6/xHzNcWHfcpWjtCKHG3MgOOlVI8eEmJA1MAORNC0LsH0xBQ/ALv0HccvoZi0GIbVqiyAWW2xVdJ0EtWr/AgLC3K0m9fAC6OD/3vt6dReeRO1CxIjQQIIjLfUWoF4hBW73y3sRpKJMuiEtWov3GtkWD62nA4VL8lJGKG8wmUVpIt/OyzvJFPezWoI+SiAqb/eTlvEMD9Z9xqKK3sgY+cFSftba+nwuQMNzHOYCIioJRkFaIgfXeVbGG4vhWKod/Aix7VZHPG12zbzJ/VnPzWyuz68XeCzBMicMCeoxHQG6nFnl7N1ixft/wjdJC+tTFF8uts5ydWGoB3JJ5WCnowF03Yy5icYZhyUE/2XCM0h61gDceNONJSGh371TUbBjloTFieVEe21xt/Ed6KqBdJQPXH8WqmzyIlxMcPt+NxC3gZf4+oiKo9bAHNIdSAReXIArPy64I0BkqefFdX1bMYDb7ze99XjHZzbdM3UdvyGM2bPGce4Rnmve8CtZYgdqPEy7Ayiwa1NiFfIaqVNEAEFLsP3KwWH61A3885lZEdadtT8kkeHNXFy5YQpnV0XmTra2ep0VXUAUfrHAkAEx3OBH4ZuHctQd1vSvU47Z/14fWkQK/AE//JVIRkA1hlDLo3c2FykvvTMykb49CTkwhZAnSzYYQCA9DE59YkYqS9YpLmIGaDtqFiM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XYETtS1oSRNkCEtLpwSyYnlkB6zJu9HZGwPO0HZDwPq3GOa8WgPWym0vLFDS?=
 =?us-ascii?Q?+ZOMEHiZRKH++xTlMf3Km0zgVKZF1UinksNfcyD9mXme1dict9HSdbTpnDiH?=
 =?us-ascii?Q?m1Nc6bu5ttGLUvVLLAtKDbYGSY6TqH/v0BzqmxXL9VROEPagFcEhbVlAuVx2?=
 =?us-ascii?Q?qIQOv4o96rrfuDn0f2xaJJoLhRk3Y2W6E3u1CahoPwrYufCTZ4z9JIShV011?=
 =?us-ascii?Q?dkNsR+LDBk4Ovx7qMdWG5hDON2elilnbif94/kfScWg6BHGgiuiFMK7GXVYh?=
 =?us-ascii?Q?VGh5geSuaIrs4vjdTjFGP2K0ndATeey/M8G/q382mzjsgJxcjRzTfyjCi0m8?=
 =?us-ascii?Q?3EZwG2bGIci8FWRhS+cczx9SRaGuzYv+A5OrXOZET+xkfmr9KwkOcT806w9C?=
 =?us-ascii?Q?frU72Oug5+74oglcx0fmNGSVM7b45w/jz5rPwmdsoMG6JoWgof3iqHOumDw2?=
 =?us-ascii?Q?Ov2xoG18Gu9mFcW0b1oooh1WWMdOv0FgNtOShCeV8P0q1eFwHCqTNQUhSDqd?=
 =?us-ascii?Q?dJOFjj5Xlf/gAAMXD7fo5eXoSHlO04I6+p/PA300aRq2+xQursI9xidVuYym?=
 =?us-ascii?Q?UDOPnQvvHXgyaCpDDU3V+MoAICHFOWaF4hYHB9gmEBhbMe32KnpwKA/tY49g?=
 =?us-ascii?Q?obOJAdB5nySGBb+CER6axBFFwF57xF9SvHUhWBkbg3sQn45z3402RvUjSmYN?=
 =?us-ascii?Q?G2KRCQwMr2Ph38j9RCBqq4MvnaGomEJyghsw/DmFoBYz1EpSZpAwDaNWQ1Sw?=
 =?us-ascii?Q?f1/C7ESBJhbF5CRDk62npLrd5fma7Lk7g08qZ/zTWgQ1YyMMBq8NA+i3D67/?=
 =?us-ascii?Q?Clfgx0JvVsBa0QBQOH64ktC48ojZI10xBqaghAoLjzg/iy7514C6xNJXULdA?=
 =?us-ascii?Q?cVA7FtSJS5nxLcTW2+shzw62NpeCJzXExh2GxELXiSwoBF+J3SYYz2GmpMEK?=
 =?us-ascii?Q?s4Det7/An7Kq9PR1X3O+4PnpCm+EGYvNToLNGuecOelld0hLYEGe5pX36Hi+?=
 =?us-ascii?Q?Q50gvFelWBtYbq2Psa85jMyy8vNgABvqOlpfgo43i/PbBZYSXlqqVk3SK/Pn?=
 =?us-ascii?Q?lKVZCXNzyzzr02fTzCVqggS6VmRPk8JeW1aFy7+7DlbdFz8CDar+hJ0jktq9?=
 =?us-ascii?Q?DHR/eKVgxieeY/XRgQuoEK6PXFT/N+cPzthNdLx458um8H2vpwNklc2YE4k9?=
 =?us-ascii?Q?Wh9az7yre7UZfyA9ud2Pw5qHJ6rgqzi4mvG3ex2PIMNWSCmAv4EjnqUVnI/y?=
 =?us-ascii?Q?0MzTG7CYbf/Ix+CtdVxj/5ljopkAmkLUKzMhQCa5XMkccTFWiD2vG8RZmdti?=
 =?us-ascii?Q?Sqtr/BEKvtEmPXf9bU+BPMnXfrL5cFanqW9ZG7Z+KSNv/CY89AmWOajh6yI0?=
 =?us-ascii?Q?YCpIjXfV1CwlCdxj5hukd36m+01XkCYtDrHYVsbpHpsiuYDD5nAv0RdwJtQ2?=
 =?us-ascii?Q?kuoytsyw9QDiSmxFv+nnlg7rVHSlteBQc5mt+Bsnxt2xUcBVEm6sg+HN63Yd?=
 =?us-ascii?Q?C2VaS7Ig3X5Xrsy+mr061FjkyRmrG1Un+x/bPyeA42MCBNIswaBkZgziye8r?=
 =?us-ascii?Q?kmdxY5CRz+6jVHIpqEYDP5H4Htlg7kATUUicnQuBRJx74K7c2T+WvRXRly8W?=
 =?us-ascii?Q?XIpwodV/fXXbzpMJlS0RHxm+3t//HTcxcJ84dKFLxvAt71AiGK5RwaLGfyft?=
 =?us-ascii?Q?T4Ppf8t4Q1C0BMGsgCE/HFj8K+1OZp0CgEV9mGZyU025kYv2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VF9gFMHNKJE0xRDwaen4yNNDzLmmiA2QgkYY4TcX1gmLy8OqmZma/n3zlfmhfJUuqDoPrqpvHRi3F/KhMvETXfhKe3RyYHyb7XHyr3mm7JUk65ZdV6DGxMnuFggE/4S2NHA5EH+QXVPbwypsXFo8y9UI3iFTOXze6lEmqsv4s4ZVnW8ClJ8eQ3QqY+rTbzRaRqWzs1kK7JfzcZ/1LobV8uZXiWWZmqnsXSS/Grb6hSWpxk21h2qdlnHFN2tBbbW0/KC9F+xg/rttRxLK2WbOZBRT0AfWok0b4zYe4uXarOXuYY54Ng2+xESOlAnhBEZ7PxMVnQUt44CHd+CG2yXCYw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0895858d-353c-421f-0381-08de8a8507dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 15:41:49.9474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qP3Sx2ykwnAezIl/iPbfMxu4BopfSTPsbvlE0rZvjg9Kni31qyOyLpYBF1qXTondcmWl9LzHw3SDJazJWy4K+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR11MB9756
X-OriginatorOrg: intel.com

> Sparse reports a warning for einj_initialized being a global symbol
> that is not declared static. The variable is only used within
> einj-core.c, so mark it static to limit its scope and resolve the warning=
.

"git grep" is your friend:

$ git grep einj_initialized
drivers/acpi/apei/einj-core.c:bool einj_initialized __ro_after_init;
drivers/acpi/apei/einj-core.c:          einj_initialized =3D true;
drivers/acpi/apei/einj-cxl.c:extern bool einj_initialized;
drivers/acpi/apei/einj-cxl.c:   return einj_initialized;

Ben, Dan: Is there some header file that could carry the declaration of ein=
j_initialized
instead of the "extern" in drivers/acpi/apei/einj-cxl.c

-Tony
