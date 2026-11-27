Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795794688;
	b=QK33ZVBE4I1ot4nw4VTXFXmB+Bk3LlBgyUNN2PSp2QRluJDO8chfQOk/XsQniq3X+o/r
	 aRV0o9/G01JFoeFFDHsG9JAV1CElSwvjn88nys9Wb+QLCh2xOm1gyu0wZuIBX1NpmskVh
	 U2fxop48wC08kkXTI/ueRwA6clqmYvjQ4a2TQwbXcTh2Wz84RIb9HzveBoV2i+ssMAngr
	 bz6tMahl2p8bWcHq72z8akxWK+RTNczH2ytTzmFg4p4u4GZXz5AT0gZx2mUtm81XQXftM
	 t6LFE3+Z/UHk230+VeCBx5r7rvipcN5EpGsSjHe5uS/21CWrPqsz2h/A9vo6cO3YocQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795794688;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=sJ/a1N4/jr66IhWPHj6jlFeOf3BFb1x0P8XG6/YGxz4=;
	b=rfCiVO/b9DVosjF7RdSkcbqTrIic//ApuZDsN4huO1Ypbz5qKZX8tTnZ/Ehe5pFWD9eb
	 7Eupb/xYVg6Q0EmhU13aL9iPnACRdDYNupGHaMgCVGSs8q9qjsYOuHJ5BIlyyjLDWn/eH
	 DM2sAWUJCdXoK7h0DcOASTmmDysvQco+timr9fV9RkIKCsWNvRlwFFD7EMdSnhGzNgIh/
	 HjRYP6e47yhiNnA8cHq+aOzOkKA++wgOXDP17qRt+/gWzsujGy7M5lxjAGjANzlbuLsGo
	 +kxyJC8ajHSI+aiMjvGzODVGqosaMTJlWd6XSO/xHUka+kQnuEnDcpzXgE2Ft95TeYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="JGlo/+zJ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.51
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013051.outbound.protection.outlook.com [40.93.201.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EF6606A31E;
	Fri, 27 Nov 2026 15:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93EF6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JGlo/+zJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=leH3Mn0Ik2y+3MdQ94ZJzljN/hthPtcSCfASLIqEPvYiTN8CmJHOdwa/IlQyCMDtZdWGrJlvAbi4ZpyNmaCeBEoUMV1JRuhVu6tssAlnymdL2MyR14RJ5rAWVlsrl6YPqN93hC7APATAN0cb4vxBoUy26rF+1bojpZM3oN0Sze7QOeTrIV/g0fwWpXuGsBO0xa2Q5EUGty/YF6/lY87SPKzLs7exDPnE7RTAcBQMgCHTryuehHkK0TnIpBoD4NM6Xu6sL4XErhWp/gEBsKxjaMpLFlGVJpy7FjZL1dutm/GFzVJdialG7U37rRCUjhsuNE78fNGoVEfQseBTyxpMCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJ/a1N4/jr66IhWPHj6jlFeOf3BFb1x0P8XG6/YGxz4=;
 b=mGrlh5v2+n3GiE/aAXpBkAONScv1Kt1BU1X9S5b4UEJnG4eh9yhJW5wA9rBiZpLEqKJDpFpy7ORLaCzOau1onp/+n8NKEwcAUHSviAq6IQfwEpOHOJ675gINrKoTKYlgnCfCuLGN+lWWoxGY7i4gWmbnC8x2+BYF6JOgiYSrdUarbYpUOQofCAi9jRQha0yI66bO1SMNDbONrVanJ3XolS+ZiLquEndIWcGbL3bOCfm+trE2+L81andV14yO5yWlVFJ0mmT5IndJ1ekwRkgUMSvGYMnwyMvQpyw7qHr+rUi6o2nVPgYup7yjyBeGIHdKqRDCXO+wKFquTB0hzQ/2Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJ/a1N4/jr66IhWPHj6jlFeOf3BFb1x0P8XG6/YGxz4=;
 b=JGlo/+zJcQlHLWTtogS2nbR9wA2AH9NpxjVDETveS87NsKuiv3ZfN/ABKb8+MVey0OegxNtbn8R9PaNfe0kLrCt86Zi2ugNMdowqkFvHaI8WyKwaftUSZxAompK5rJi+h1eMaJeDoswFFCZxfXaerdz6h/pTjnQFNj7eLlsChEJULt8/wszIo6oHjiiAzG2nHPlwDTnCncEAHJU71WYTT0JVJS3MU3ZmSrPgya3U83UGP3pGJBSF/iDtjZK0vwIODPunYElvk6+YuHNIiMiZMLs1MDPd6WAixQSHASQq4fR1VE3IOMBmrELATBMrvBCFr4fHlFWK+VBdJ0JICxKbXQ==
Received: from DSVPR12MB664020.namprd12.prod.outlook.com (2603:10b6:8:3e5::8)
 by PH7PR12MB6936.namprd12.prod.outlook.com (2603:10b6:510:1ba::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 15:51:24 +0000
Received: from DSVPR12MB664020.namprd12.prod.outlook.com
 ([fe80::76b4:63e0:3d27:bacf]) by DSVPR12MB664020.namprd12.prod.outlook.com
 ([fe80::76b4:63e0:3d27:bacf%4]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 15:51:23 +0000
From: Daniel Dadap <ddadap@nvidia.com>
To: =?iso-8859-1?Q?Riccardo_Zangh=ED?= <riccardo.z.dev@gmail.com>
CC: Denis Benato <denis.benato@linux.dev>, Armin Wolf <W_Armin@gmx.de>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"hansg@kernel.org" <hansg@kernel.org>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "luke@ljones.dev" <luke@ljones.dev>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [BUG] ASUS TUF Gaming A16 FA608UM: working backlight device
 differs between MUX modes
Thread-Topic: [BUG] ASUS TUF Gaming A16 FA608UM: working backlight device
 differs between MUX modes
Thread-Index:
 AQHde6JUor2pzzw0bk6vTAdpIU+OBbc9kZMAgAAYzQCAADA4gIAA68eygABQ2wCAAETHuoAABKiAgAA1ITeAAHizgIACB5rZ
Date: Fri, 27 Nov 2026 15:51:23 +0000
Message-ID:
 <DSVPR12MB664020095EBBA5F6B374BE97E4BC412@DSVPR12MB664020.namprd12.prod.outlook.com>
References:
 <CAMnz_-Dgg2eCgZxcCaGuKPV=3-kCfg7ajd9w=vs2fGL-Cb6hvw@mail.gmail.com>
 <f1b7d729-771a-4fba-89c0-996a8a168126@linux.dev>
 <ce46d69f-2a3e-45fe-abe2-f643f683d09f@gmx.de>
 <CAMnz_-Dztuj3CRsxcVnfe2=OCB3tTJzK6Lu7-AKfkbuqn5N-UQ@mail.gmail.com>
 <DSVPR12MB66402023AE5250384B26515942BC432@DSVPR12MB664020.namprd12.prod.outlook.com>
 <CAMnz_-C02J6CznPD68GgWCPCWEDSGsq6hoC+AJhsZjw39H+hhQ@mail.gmail.com>
 <DSVPR12MB66402044074D6A8B1EDC584825BC432@DSVPR12MB664020.namprd12.prod.outlook.com>
 <94785b4d-c807-4465-84a1-25ae317df4b8@linux.dev>
 <20A82893-B458-43A0-A3B9-0C090BAF7F00@nvidia.com>
 <CAMnz_-Bah1bg9mR-t+oTnDVMXBwwm9n3GJ3cPB=q-X2y+_=YUQ@mail.gmail.com>
In-Reply-To:
 <CAMnz_-Bah1bg9mR-t+oTnDVMXBwwm9n3GJ3cPB=q-X2y+_=YUQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DSVPR12MB664020:EE_|PH7PR12MB6936:EE_
x-ms-office365-filtering-correlation-id: 11a790ab-403e-429b-6916-08df4c9e49e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|23010399003|38070700021|10067099003|56012099006|261026121527099003|261026140227099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261028144727099003|261102123227099003|261009223027099003|18002099003|22082099003|5023799004|11063799006|4143699003;
x-microsoft-antispam-message-info:
 Q/n2zhiis9MoMb7vnAbDcDydU7UHcPTMykALKL93zXczsKbBCO4aa9y1c9DXcryTTcGzB/WlTTD/ri3suQu/MJ1vFEcUsKdOU5RGK96jSCr55WQ2RKVOxpeayqkJ2xJHMIn2HuS4ZFvWnYtYcbuoNrYjUD/fnAnlNLPKfHR8R6Qt6E8GoQUta9/CFaJCETsYTrCFDG0IOqrKJQM9vDO9QvFROCE1yYScUpEOvDBM3H64Luu7a8fovULYxIyqILrD3G2k4Jn+yQXBz6GaCITW+TkGM7BJ7MxexrTQ1JGXIWmFX9Hkih99VwMX2sIGGt7JQUYD0/tmhgDUpwhpMmraN3un5zhoQHFgsRTJDYUPzX8Le7reGtBR37mhJqyvpGZKUfyETKgZxTmd0PRiAEZjK0/lualIgxQk5DLcuRm9/0yQs0SMwAEbUrGifJu+EGvsOy40EC0IoiEIPXd0vAyBYXRI+0wJrehfCea271hamqiH0/iBiTT3Xi0Ow7UcUOxPp/CvemQtDOCBUc27X3BsJiuQHdOMI/VIBiq9QpSdKJMuks5z+l7iavofVP7F1Upsb5Xs0/YIP/qn3priIGoU0RrMWGaD8s/Pfs53+kqXd6L0RkLNqEuSf4J0bxYXjAO8Uur+zJ5gW8SHozoHtzMvMb4eWBaYSVmumnxqe5fUuYTdz9Tijb3JdRLEg/V5bNtPhB7eSTvFLFU/xrVvtEMpCdlxZwTsjl6ddX3J0zbS5Iw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB664020.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(23010399003)(38070700021)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(5023799004)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?gobMP2JnIvr6Ck8Pp7C04pwaoLi+mkjoKioSkKuOBWp7ORw38DGCTEIK7n?=
 =?iso-8859-1?Q?YVl5d4LsSkepL415E2hAW7Z2uRqVbM6eWiUVN1JzNSoOMMNuDJ5Fg8F6tD?=
 =?iso-8859-1?Q?q1QvvaosnONKWr38iQfQztP961FAZ4HGNkc4xftN02bDsOK+m9ILNStAiF?=
 =?iso-8859-1?Q?BzcFzqipK8oM6wv2qWIUE/lHjjAeysaD5pkZgEtjRYnz9W21yrcqbHF8I+?=
 =?iso-8859-1?Q?Zpw4Ckxy7jX9bx00r0oMRGHDcYhSgOl4nL/z+rzdJq38O0asZGKxjmbB+T?=
 =?iso-8859-1?Q?3UHXGuRHSqPKa9HHjlW4Y7yT951P9+dSUbOCEgloUJup18IVB24xWUNbuU?=
 =?iso-8859-1?Q?OGVS5qfFzdnVAt/z+IUP/Oz4B5hBcoeYFxbFOKqubv5GWVqorjdgXq19Fd?=
 =?iso-8859-1?Q?0c56gELH4fqn3SZm6ZLmxocAA51maRM83RArZa0+o5KYQvR9/CuvepEATU?=
 =?iso-8859-1?Q?okf2PD99DU3WoUzp+TrAtKUxm0oGyN5yaGWgqkKWxFrBlMu6EkPf4A2KHU?=
 =?iso-8859-1?Q?uKdDj5Bq1XwPpQt34XD9/CcCqhfxBk8k/7jJppSmTakOr992vWg9Ll2JLJ?=
 =?iso-8859-1?Q?/gRUWO/91DJ0fumWSDZ0TyVp2D2UStjqyLtCA2m0EZXDKklOTRlrMgGQnd?=
 =?iso-8859-1?Q?UbrA2M8D8DM7brl16g0rJ6+MLys0wyy9fLa6/GGuZ0FGUdreeo2QSWyCuO?=
 =?iso-8859-1?Q?z2i6jvPNOyMVHb1aOd2a5YszHcYxrjlH6e3L/3BbF8Axoh7QtSlyg1DQzY?=
 =?iso-8859-1?Q?/PU3u7TupzjojbRuBf2aFqgOCVhdj3DTPxkPtdfVeU/3UUenh/8n6E6zg+?=
 =?iso-8859-1?Q?FNQ+APdQLUmwJbvMfVkUqq0qFUpOKeUm9hv8cRfr/lAjoa3AeqSTk6Q8Pb?=
 =?iso-8859-1?Q?TRIKbYFO2EEpgLQI+ROXWBeJ+R2LkyIGNdgyxSrvisPO+OgsVHqloiAPEl?=
 =?iso-8859-1?Q?r7uAM4iiGfFkssN0j0CzjRdmltyE2J4YSSeYqeID9zT7JG9w69LRAHZ/X2?=
 =?iso-8859-1?Q?Y7F5bZTHstuKU5hZ9gMkAkObmtbMoBKbnvUfMS+zFH22L+pDjXBaTrcZ2V?=
 =?iso-8859-1?Q?mThu7CtaB0S0w+k1YnNIw1LwbX5vQ8Gdx/MGCW+kd8A9i46txNkRUE4kBy?=
 =?iso-8859-1?Q?Yoq7iCmqpTsM6bxf6QPUAPFlLFsZej/EkUYOKzoMEbMmhitBp9zySlPKsU?=
 =?iso-8859-1?Q?qOgUcinrqIhcCXf+t3s0JTPR/S5XeaCRGpUowtUaiYuSvG5GBez8UCG9Eh?=
 =?iso-8859-1?Q?jzU8l1Ccg0+T2imna2rRA+Jq7PUzfKfUvCu0xq1wo1aF3MC/3P/fhNZSBy?=
 =?iso-8859-1?Q?RQ8JwnSjm+5g+JqWz0TKmh/LwBEFxjZOeowywsUn4mK1HX4QWW6eGKoYq2?=
 =?iso-8859-1?Q?UGRuUapyBXWnTsSx7zSHHXEdmRrOtizHk+UXXx5AQGX1HQQQDAVDqsIvsI?=
 =?iso-8859-1?Q?szuabldoDt5H8AWdqd85u48qgjVwXszyfkRpdg2stSg+WSUWPxDvWam3/c?=
 =?iso-8859-1?Q?1w3y+7InORZTDiYvuJu+QYWZ3VCljspGTD0e3JdOZ48ZFG7u0+Du4DrsAm?=
 =?iso-8859-1?Q?cgO0JShtQU9/gSEPMzjjxYxV3P5sr2NW+VZsqeZKh9QbpWamlpW7mHGRil?=
 =?iso-8859-1?Q?0Z/qDEa4Wa1oBXA+nU9oBmeu21eAMXAP9Ghar9dRGcNaTpKYWnL6sy1Qwb?=
 =?iso-8859-1?Q?6BScvD8+BCY60+uWe0ShYDlkd8tM5QtaVB6zlX4kiBHeCQ7C+bjakC3GJg?=
 =?iso-8859-1?Q?/8Gxsxx4pQWyV+OHBVtaTdtms9KU1zWn5xCgkIR2pIZVJS6GCt6Y4zA5/a?=
 =?iso-8859-1?Q?NZ9OMhgJhxO0SWD2T5XfGtUPflW4oRasghiwO2ZRV5U6yRDl7cob?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB664020.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a790ab-403e-429b-6916-08df4c9e49e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 15:51:23.7659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RgJwBvAouBgJRSH8umCeqT5WW/qVwzEJQnmr85BuOF8y25vrZfcCQP1UguqrcUfpl3KkxXfHOE6rVUVXyvH3ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6936

Thanks, Riccardo, for testing, and for the very detailed report, which made=
=0A=
it easier to debug by inspection, since I don't have this system available=
=0A=
for direct testing.=0A=
=0A=
On Thu, Nov 26, 2026 at 09:48:17AM +0100, Riccardo Zangh=ED wrote:=0A=
> On Wed, Nov 25, 2026 at 23:14, Daniel Dadap <ddadap@nvidia.com> wrote:=0A=
> > You could also try patching the kernel instead, maybe with something=0A=
> > along these lines [...]=0A=
> =0A=
> Hi Daniel,=0A=
> =0A=
> I tested your kernel patch (the later version using=0A=
> acpi_evaluate_integer), with these DMI matches filled in:=0A=
> =0A=
>   DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),=0A=
>   DMI_MATCH(DMI_PRODUCT_NAME, "ASUS TUF Gaming A16 FA608UM_FA608UM"),=0A=
=0A=
Okay, great. I will add these into my local copy of the patch.=0A=
=0A=
> =0A=
> Kernel: 7.3.6-1-cachyos-a16test (CachyOS tree plus this patch),=0A=
> no acpi_backlight parameter in the command line.=0A=
> =0A=
> dGPU (gpu_mux_mode =3D 0, G40C byte 0x07):=0A=
>   /sys/class/backlight: nvidia_0 (raw, max 100)=0A=
>   brightness control works, no "Unable to read" warning=0A=
> =0A=
> Integrated (gpu_mux_mode =3D 1, G40C byte 0x4a):=0A=
>   /sys/class/backlight: nvidia_wmi_ec_backlight (firmware, max 200)=0A=
>   brightness control works=0A=
> =0A=
> Hybrid (gpu_mux_mode =3D 1, G40C byte 0x4a):=0A=
>   /sys/class/backlight: nvidia_wmi_ec_backlight (firmware, max 200)=0A=
>   brightness control works=0A=
>   dmesg still has "ACPI reported no NVIDIA native backlight=0A=
>   available; attempting to use ACPI backlight." and two=0A=
>   "Unable to read EDID for display device DP-0" warnings=0A=
> =0A=
=0A=
These are all coming from the NVIDIA driver (nvidia-modeset.ko).=0A=
=0A=
The "ACPI reported no NVIDIA native backlight available; attempting to use=
=0A=
ACPI backlight" one is because acpi_video_backlight_use_native() returned=
=0A=
false, but explicitly falling back to the ACPI video backlight driver seems=
=0A=
wrong in this case, since it's supposed to be handled by the EC backlight=
=0A=
driver. Probably the acpi_video_register_backlight() call should be wrapped=
=0A=
in a test around acpi_video_get_backlight_type() =3D=3D acpi_backlight_vide=
o. I=0A=
think it should be harmless for the driver to call this, since the call to=
=0A=
acpi_video_register_backlight() wraps acpi_video_bus_register_backlight(),=
=0A=
which has an explicit early return case when the ACPI video driver is not=
=0A=
the correct one for backlight on the system. But it's probably still worth=
=0A=
avoiding the extra call from the NVIDIA driver, even if it ends up being a=
=0A=
no-op, like it appears to be.=0A=
=0A=
The 2x "Unable to read EDID" is probably because the mux is switched to the=
=0A=
iGPU, meaning that the panel isn't connected to the dGPU, so normal EDID=0A=
reading fails, and then the fallback to read the EDID over ACPI also failed=
=0A=
since it's not fully implemented in the driver. So I wouldn't be concerned=
=0A=
about any of those messages, since it seems that both display and backlight=
=0A=
are working as expected.=0A=
=0A=
In any case, nothing that this patch touches would have any effect on these=
=0A=
most likely harmless messages, so there wouldn't be any changes needed to=
=0A=
the patch on account of them.=0A=
=0A=
> Happy to test an updated version.=0A=
> =0A=
> If this becomes a formal patch, I'd be happy to have a Tested-by (and=0A=
> Reported-by, if appropriate) tag with the name and address I used on=0A=
> this thread. This is my first kernel contribution (I'm 17, if that=0A=
> matters :) ), so I'd appreciate it!=0A=
=0A=
Sure thing, I was actually planning to ask if you'd like to be attributed=
=0A=
in exactly this way, once I had the DMI ID information from your system.=0A=
Since you've explicitly requested the attribution, that makes it pretty=0A=
clear to me that you'd be alright with it. :)=0A=
=0A=
I think what I will do, before sending it out for formal upstream review,=
=0A=
is to share the patch at the places where you mentioned similar reports,=0A=
to see if there are any additional variations of DMI information (e.g.=0A=
slightly different SKUs of the same basic model) and/or ACPI details=0A=
(e.g., different ACPI path name for the relevant EC register, different=0A=
polarity of the test, completely unrelated issue where it's not the same=0A=
"both sides of a conditional return the same value" situation like what=0A=
we are observing here) that we need to take into account. If additional=0A=
variants don't pop up after a little while, I'll go ahead with just the=0A=
one set of DMI ID strings you tested.=
