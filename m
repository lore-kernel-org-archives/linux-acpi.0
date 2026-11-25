Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795644864;
	b=RadSJouaXSJulhI94PVP/w/km6QI1A+TBSv8xXXS9GJAxfQ5GTf/xapbxRDu4T7xjwfA
	 KjRBKCHsJjJo7Y+AcU6wWZB3q7KjRqRaVwEIX+yCoOKSV4tyR2s2IthBelt6WcKc+ZWrV
	 t2rw/oq8uzQS85ZaGSLs2im2ZaDLGXDhsuHv7G4On10LWcIFZwbdB31GXPsbI6VaYSyet
	 +h3E/jgOxdeVd13ZNjKq9R++U2Dafh0Lr1ARijhywlmG2CVEj4DIEGlFbZBmmOPuoxvC4
	 27LZuR/Tv/gmAo7DsxrCgkF0lIGl8PM/ByZ+nqgw5pbB3GQGU1PtDXzbEiW2xnhIlBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795644864;
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
	bh=Jq4L4JnbQgSr7tfyUK6cd+5rNPE2T5kANARBvFM1YX0=;
	b=x7/cEhLq5xM1fF6PKeSozoB9ie4zMF++OwgEejk55KOPB0MHQntvh8vJvcewwgmPejkG
	 kLYSssqhsFxF8pLh72wrb8W+ZEm9906jzntu2xekqnmt1JfPkdFW+ct8BKpW/zn316kNQ
	 HWklsLzHimsGSQJICHPdvX1VxNwRBBypGINDyxoGZj6o5ZnbLyw+02bwNqmNf+BpkuLYO
	 KAly7bsw/7jiR1FM1zkmfuwBS58eQ9MetXdzJEqi8fWMYy3qcPX2Wb8jPjMjvyR3d3V00
	 orzKBbqKPHNkx1fpMP/kOOVC5e21JllE+W1Ffmj2Q1INnBRoFWasBjvOu/zcXtIuTiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=V+efI8wh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.51
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010051.outbound.protection.outlook.com [40.93.198.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782CD606A31E;
	Wed, 25 Nov 2026 22:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 782CD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=V+efI8wh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBYi7oKcGOIfaxFMVTmfiVcN5+cQ1+LGrNr5J4lFSNxaKXYYKjHeuMOvanTU3GIFjXVoLVhpcQOodAyIbvBJXUWfseh+CcqfACHAeOReJ682eUO6HEakAyMe4TS0isbL7dlALvNJbTiUbUhqPdJrE+pCbngWpR3TesnQGnuRrJsmR+b4XF4y4MUtJMXj0wpmSaB0iwNb0IAQYyzpP/X68OPQvgVl+JTWdOJUQgcNKddOM1cGxbgMPMXXUq9lZpSyGhvtHEtWi1vNeXD4DMBKzegzg3L9m66X2XHX5gZ4SjsTyX7GFXDsHRdWtPV/VyXV6utHNCFmRRKQyCgBe3+YJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jq4L4JnbQgSr7tfyUK6cd+5rNPE2T5kANARBvFM1YX0=;
 b=aV1Rjf9VdATlGPgXvh6UE/Nts64HThSxyMtHhVR/Fa7JKApKz5wFcXquUUEd/dj4xKp+97kSm1qjVmObye00l6q+I8haPrK13gbmcVkmChvoon8VI1t/S4AAOeUkA3RuOBVi4z3uD7pXZBzhs1UFGyUoDkL7IdZYlph4w5rDGsgs5hGwYWTgiGZGPEFvlk+J1x6LTSQZIxL9l2tLUMrKIEk+t85jzkstb/B/EKhLvn9Uefsg6feKUGA4oWpwntUJkgMhrWjF2mie4Vjyy09yAiu6ZTn9cOtzQ5hGgpkVTwpQ6LwGqYL36PszBct47WRmYOp5mHYjkPsiMXYBNNBCVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jq4L4JnbQgSr7tfyUK6cd+5rNPE2T5kANARBvFM1YX0=;
 b=V+efI8whBUkEivKHqhYEYNzSBETDMx2haHqqGNCqkR7FlBunso9VVRxnidhbe5/F35wabKNsdWbOtvrRChr9WoffhEasfEUpFDuRhBPHRP9WAC78oSOGuB+L4iGKyUQeVchIk8k2OFaVozYYL243oguyQ61dbV/smBrP20mkrpDCZBfMTATAGM3Fj5Y+NA++C9z/yYW9nY3o08pEMsvV+BAu18rAMIDPR0S2Z2uq8aXsMacCIXqGECoJALUKhA3JwJZFLb70M0g02OIDRxrBUUZRDN6Fhx/MNha6bZsP715NZkfrru7cwB40Hldd4pdTFpm77IcdHihquW7fGkUUcA==
Received: from DSVPR12MB664020.namprd12.prod.outlook.com (2603:10b6:8:3e5::8)
 by CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 22:14:21 +0000
Received: from DSVPR12MB664020.namprd12.prod.outlook.com
 ([fe80::76b4:63e0:3d27:bacf]) by DSVPR12MB664020.namprd12.prod.outlook.com
 ([fe80::76b4:63e0:3d27:bacf%4]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 22:14:21 +0000
From: Daniel Dadap <ddadap@nvidia.com>
To: =?iso-8859-1?Q?Riccardo_Zangh=ED?= <riccardo.z.dev@gmail.com>
CC: Armin Wolf <W_Armin@gmx.de>, Denis Benato <denis.benato@linux.dev>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"hansg@kernel.org" <hansg@kernel.org>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "luke@ljones.dev" <luke@ljones.dev>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [BUG] ASUS TUF Gaming A16 FA608UM: working backlight device
 differs between MUX modes
Thread-Topic: [BUG] ASUS TUF Gaming A16 FA608UM: working backlight device
 differs between MUX modes
Thread-Index:
 AQHde6JUor2pzzw0bk6vTAdpIU+OBbc9kZMAgAAYzQCAADA4gIAA68eygABQ2wCAAETHug==
Date: Wed, 25 Nov 2026 22:14:21 +0000
Message-ID:
 <DSVPR12MB66402044074D6A8B1EDC584825BC432@DSVPR12MB664020.namprd12.prod.outlook.com>
References:
 <CAMnz_-Dgg2eCgZxcCaGuKPV=3-kCfg7ajd9w=vs2fGL-Cb6hvw@mail.gmail.com>
 <f1b7d729-771a-4fba-89c0-996a8a168126@linux.dev>
 <ce46d69f-2a3e-45fe-abe2-f643f683d09f@gmx.de>
 <CAMnz_-Dztuj3CRsxcVnfe2=OCB3tTJzK6Lu7-AKfkbuqn5N-UQ@mail.gmail.com>
 <DSVPR12MB66402023AE5250384B26515942BC432@DSVPR12MB664020.namprd12.prod.outlook.com>
 <CAMnz_-C02J6CznPD68GgWCPCWEDSGsq6hoC+AJhsZjw39H+hhQ@mail.gmail.com>
In-Reply-To:
 <CAMnz_-C02J6CznPD68GgWCPCWEDSGsq6hoC+AJhsZjw39H+hhQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DSVPR12MB664020:EE_|CY5PR12MB6108:EE_
x-ms-office365-filtering-correlation-id: 880110a2-1a09-476d-895c-08df4b417494
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|38070700021|261028144727099003|10067099003|56012099006|11063799006|4143699003|5023799004|261021121427099003|261021123027099003|261026121527099003|261022075727099003|261022105027099003|261009223027099003|261102123227099003|261026140227099003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info:
 fCyWf8dYpDp3KpMBBYX7J0eqdWwYj7E2biQsXfKINlmopzq/xU9PZB4jHrtTQCcp70Gi+OTz6WZWV0rUW97gGiz2okYG/qT4wQIYsYLYsiGf4jMBF006KW0uiOUaWJGlNlcIGB2abvbNXTPrriX8662xzz9CD2sf5PXp7+r+jAg7sX4/6nO+436l2s2apjNCQQYUPgau9zC1+tnl0JsD2O6WgE0+DpWbiVV8CTXJdb+29oPXYqJ7/rEZQdo8tiWiPFRWmYfjnaaOCY/CpNGWZm4VgJk+qTL4b0hmWArdV9TzcbD3VpOD9VZc9ACFmU+j/nRs+bJeTVCtNKsd/SjHE+C0AcO6mEXu5Pst9Dopn0sOZTbUypQnDNSEXtjHXmcUWJ46FIWVJMT2NTYVoiYg7Eus5X+GIKX1n4ILMTjAlAdF0DVV0GZSiOha4eFtDOz2wGRIcEP+kDAnS1VlljcUG3T57oJIVMnKTWmHhuaVQ1hGghmlwm9xkiCwGh8r+puxdWg6T/1H/9aGDI5T0pZVtikzZwmNM3HKf3FPak2tlWsPyBe8nCr/BmNr0zgNGmEnv+0qiu6MMjo3nTAqhw83dmQXqSQWo/Fj5gDV7IxkgsOS5x9Zyvr/ljvN+bma7jtTFKBx7Bij1W8Vly64PO+I4Os8EH1AoVHbvYO6q1cat47bkGKTLd6Vm0YS7vgBd1jzAZw6w1OY8UGjH12ibO62NeGUOtkI8sNKo/VT1RNGe1M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB664020.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(261028144727099003)(10067099003)(56012099006)(11063799006)(4143699003)(5023799004)(261021121427099003)(261021123027099003)(261026121527099003)(261022075727099003)(261022105027099003)(261009223027099003)(261102123227099003)(261026140227099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Xu3mJFeVwIiWJ1V2uRBfuaDwnTzWJTd5rKKVCUruFA17nweJwPUdDIPyT1?=
 =?iso-8859-1?Q?FPTXhJei4CI15PQUJJKNKiX23D5lRGrqi6iTzkkLW0dhO9t5WcrfxbTUTq?=
 =?iso-8859-1?Q?syW7bIp0yZDFxJIGzYzPRxtGazltY7rIpZh5NocGC+s/0Ehx0kHMBcp7PG?=
 =?iso-8859-1?Q?gbWJciuB96mXJjSrIMZYv059lRgqVxa31oMoWQg3yK9wPeKiLTKTay4tgk?=
 =?iso-8859-1?Q?4cspi05bQPGQmeP29TfFkqPX5VmZW3AVhou/CPzv3MxW+Q3/Xm3nbyjXbT?=
 =?iso-8859-1?Q?6QYO48I3CrmeiZpy8ey89elJqlOwqr1FJFOHTzgO4oCp8/Y2CJG/eLDO86?=
 =?iso-8859-1?Q?UPjzRgAqE6ssRbWcyJhp7YzXesr6OE+Ql5bO9erSjgZhHnHaToJLVvAIiO?=
 =?iso-8859-1?Q?JWkVysNWW+m64xt9VdXCpcUVFeaLj3npgoNe6EYPv4Pq/GmCjfWCzzAnOL?=
 =?iso-8859-1?Q?QaaCQILxlkRZzZ74O6Pyw/f9KRQfq41Rg3kJmOwgCMGJ++3nr98q9oox7Q?=
 =?iso-8859-1?Q?TncGDTbp7VchncVDI7h413fjtQl9MAC2rf1oOIjCndn6OoJJpjQls+1wRp?=
 =?iso-8859-1?Q?z7xdrbukmfmuYCL4gmv3Lh5+1rQIXxcrZ4Ktn9IED+obbOqCyQeONSPpPB?=
 =?iso-8859-1?Q?+4msc16h7PC+fZOJZtYJOGVJ+QvU7woj0XSnrvLBpkuwEZtL0uWu6mxYX+?=
 =?iso-8859-1?Q?YKO1BvCHJ0Jaklxq3rDIgg1qWUzGpkNKGniQFzYOFW9gX9p6ib6JDogs94?=
 =?iso-8859-1?Q?Uke1//DRj+kPkxSXAw3jHnXp/7xncjhIFGNWC4m4F08ErQXXcUNNEL7P5u?=
 =?iso-8859-1?Q?nzHEWzRQIA6sSrhS/CMJy+u8Ny8uGCGb3+yVPufzspbNk1w2GRBgHRO1pz?=
 =?iso-8859-1?Q?yWBwzzQfUxUPtFnZvs2D70t0czYYCqJIo6NrJcw4ni7dUniMctfYocmN8/?=
 =?iso-8859-1?Q?id3g6va85rWjNwiFAM5sHtN7LhYGbnNjtnt4bB90N7nrW5k4YtousNhkFD?=
 =?iso-8859-1?Q?3hlP9H0J1ICks5AjyhNNm2qmNluuu60eLL1klCLx6aYTBSMj6x5K1X5Oo0?=
 =?iso-8859-1?Q?VjvyGZtBnHRGcLK8du7tM1j//zEjP41soPdMAv/Thbg9QMj+pJjzxjw5QP?=
 =?iso-8859-1?Q?k/AT46HJTdZQvoivuLJDj+1L992jtBINSGWHUJknMDlpZHlRNPIKHV9R8Z?=
 =?iso-8859-1?Q?zaj5AA0olSNa5PJEdx0QO+yBzaHSdp8k0GSZYs7CQho7kzSwCFXB1W1Ol3?=
 =?iso-8859-1?Q?hHODvvWOE4uTdky5qqO15rW4wdASUG5hVO4MW+a5lIu8Ogq9lNd6rX/trq?=
 =?iso-8859-1?Q?JAp85NcqDXZdqQ8SsrLEv81s8CBtqnaeAf6C80HcFGtzbzErvC6+XRfa8+?=
 =?iso-8859-1?Q?PFOLajydl+VEmb1xPfIHXZBp7KfCC6dSLD19pifAfnEfKE8O0428fpID61?=
 =?iso-8859-1?Q?0YxXX09sP0HliADXwVS8VNfZFLXAKE1H20kmBspRpLB7K8qglIkuuV04fU?=
 =?iso-8859-1?Q?nazeNWrGuJ9Zn19oR+c5MHbPfxoAH974EIyo7IuhfDxPs5BoSg/r5LjBJY?=
 =?iso-8859-1?Q?HnrXdQbf7PZZWHjJBtQB0iZEWffp3tteZk1XPnYBnu2wCcWHNneasaCNde?=
 =?iso-8859-1?Q?ZZU/5UNTp1DhOc1TzwfnRLGYbIBfSlQbkbe2MwZ3NuWMzL6FkDgaLRo+nR?=
 =?iso-8859-1?Q?HblGLwEuU9ssq406cvFLPYvnW1n8QWmtSbuc/GEJH8v6pPWYvAz1EBrpAH?=
 =?iso-8859-1?Q?fXAZeX3rzDSHnEuBO7Ft2LGFKju4jY2afj0nvwe4hEtf2F?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 880110a2-1a09-476d-895c-08df4b417494
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 22:14:21.0472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IXPDs/bnI7Z8tv5abD90hY62LO0tuTduZTHx4ykdSeLEa7poWs+v4PfRWmkktfF43Ewi4OULd54kKKaUv3fdNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6108

On Wed, Nov 25, 2026 at 07:03:18PM +0100, Riccardo Zangh=ED wrote:=0A=
> On Wed, 25 Nov 2026 at 07:13, Daniel Dadap <ddadap@nvidia.com> wrote:=0A=
> > So, as an experiment, if you could read the LSb at physical address=0A=
> > 0xFEDD83B8 in both iGPU and dGPU modes, and report on the value, that=
=0A=
> > would help.=0A=
> =0A=
> Hi Daniel,=0A=
> =0A=
> Thanks for the detailed analysis. I believe I received your full message =
by=0A=
> mail.=0A=
=0A=
Right, I only got bounces from the lists, not the individual recipients, so=
=0A=
you very likely got three copies. (Sorry.)=0A=
=0A=
> =0A=
> Result of: od -An -t x1 -j $((0xFEDD83B8)) -N 1 /dev/mem=0A=
> =0A=
> integrated mode:              4a  (bit 0 =3D 0)=0A=
> dGPU mode (gpu_mux_mode =3D 0): 07  (bit 0 =3D 1)=0A=
> =0A=
> So G40C does differ between the two modes. I can try the DSDT=0A=
> override next and report back, or test any other patch.=0A=
>=0A=
=0A=
Yes, I think doing the DSDT override as the next experiment makes the most=
=0A=
sense. The ASL should be amended to read:=0A=
=0A=
> If ((MODF =3D=3D Zero))=0A=
> {=0A=
>     If ((^^SBRG.EC0.G40C =3D=3D One))=0A=
>     {=0A=
>         Return (One)=0A=
>     }=0A=
>     Else=0A=
>     {=0A=
>         Return (0x02)=0A=
>     }=0A=
> } =0A=
=0A=
which I suspect will reflect the design intent better.=0A=
=0A=
You could also try patching the kernel instead, maybe with something along=
=0A=
these lines (completely untested; you'll need to supply your own DMI ID=0A=
strings from your machine's SMBIOS):=0A=
=0A=
=0A=
--- a/drivers/acpi/video_detect.c=0A=
+++ b/drivers/acpi/video_detect.c=0A=
@@ -131,6 +131,44 @@ static int video_detect_portege_r100(const struct dmi_=
system_id *d)=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+struct video_detect_runtime_dependent_data {=0A=
+	phys_addr_t address;=0A=
+	u8 mask;=0A=
+	enum acpi_backlight_type backlight_type_if_true;=0A=
+	enum acpi_backlight_type backlight_type_if_false;=0A=
+};=0A=
+=0A=
+static struct video_detect_runtime_dependent_data asus_a16_dmi_drvdata =3D=
 {=0A=
+	.address =3D 0xfedd83b8,=0A=
+	.mask =3D 1,=0A=
+	.backlight_type_if_true =3D acpi_backlight_native,=0A=
+	.backlight_type_if_false =3D acpi_backlight_nvidia_wmi_ec,=0A=
+};=0A=
+=0A=
+static int video_detect_runtime_dependent(const struct dmi_system_id *d)=
=0A=
+{=0A=
+	const struct video_detect_runtime_dependent_data *data =3D d->driver_data=
;=0A=
+	void __iomem *map;=0A=
+	u8 val;=0A=
+=0A=
+	map =3D ioremap(data->address, 1);=0A=
+	if (!map) {=0A=
+		pr_warn("Unable to map backlight selection register at %pa; skipping qui=
rk\n",=0A=
+		       &data->address);=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
+	val =3D readb(map);=0A=
+	iounmap(map);=0A=
+=0A=
+	if (val & data->mask)=0A=
+		acpi_backlight_dmi =3D data->backlight_type_if_true;=0A=
+	else=0A=
+		acpi_backlight_dmi =3D data->backlight_type_if_false;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 static const struct dmi_system_id video_detect_dmi_table[] =3D {=0A=
 	/*=0A=
 	 * Models which should use the vendor backlight interface,=0A=
@@ -986,6 +1024,19 @@ static const struct dmi_system_id video_detect_dmi_ta=
ble[] =3D {=0A=
 		DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),=0A=
 		},=0A=
 	},=0A=
+=0A=
+	/*=0A=
+	 * This notebook is supposed to select the backlight control device=0A=
+	 * based on runtime state readable from the EC's MMIO region, but=0A=
+	 * ends up requesting the EC backlight driver regardless of the state.=0A=
+	 */=0A=
+	{=0A=
+	 .callback =3D video_detect_runtime_dependent,=0A=
+	 .matches =3D {=0A=
+		 /* XXX supply appropriate DMI_MATCH() macros here */=0A=
+		},=0A=
+	 .driver_data =3D &asus_a16_dmi_drvdata,=0A=
+	},=0A=
 	{ },=0A=
 };=0A=
 =0A=
