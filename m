Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795612989;
	b=vhcqzh8vOO95tGCMo2WAz3AwnMFSIu0WbaP+KyhFim5MrEZg9K3dBL6hwHFrNYvduxiy
	 fvkAAh2hs7wBKoikDtIRfmjhsFsnVBsEPGrEjWF/q85Bv1eG2SFYWnfJcCxw869Rta4s5
	 IfVmGBWrDgs9DwmBTlNaJmCdwcXAroQuEomqcH+9Nu5LyPF/7Mwt+dG6/L41XzD0GsvZs
	 ayVZ6QSeQjvstgqV8T8dknVttAYrzv+aJfauVI28WgSq0BGS8ZDcMkveqOc2lolHDhsVl
	 tzPAsZRVk+D2hUYN1eXIHeP6inwFZQI+qsu9ERrpBJrrxNliFv8jgrkEsQa7VNWPNLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612989;
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
	bh=d8bf3PgGn/eka2CzJZGzMcYoDtw6FcZkyCoLxnpuvGA=;
	b=wg9DjSsCViAPEoJlCFE93lg4y/aosMW5B5zzt2ZL0HFq1nF+JPF6cNp/m1Y6drQwBEI+
	 eRapHNf+KLzOVFifejr+DPlazgnHAWluzBNV/2vmr04X5ASC4tykensofjFQvF94CP8QT
	 CyPDNg9H9PT/U9A+MQAV7lKXB0nKcMGLy33D/vh93zA1HNeZXuln5whe4EXMftb4VTr9X
	 3cuSr3gBODX8uR7PzUiDoN7AN5FHFYCLkeP4fkOJbXT/Slim37gtHqiBJIfFWhPpGsFiw
	 oJVcQAVXMj5R6ZvCW4D/gO+jNhyEjv4xF+yjwIX1bjNSENdz71vsn2VuKhZ/EEIW6CA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ebNHPNnh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.26
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011026.outbound.protection.outlook.com [52.101.52.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A0F606A323;
	Wed, 25 Nov 2026 13:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0A0F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ebNHPNnh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XD9ixmL3PUglkNy8hl1G+/6pAIDSZoBpDxBOGdpoNhc0GAulVozX0n1pq1gOBPIsastaUdLbFRgKCBysz+xZNC9IEuCPlf5SplF2BcNXiYXv7WJ2Bz9nl4yIWjvPSZMAxFfZgqBvedUAwIWG1lEJUw+M5oMKXpPfzaoSmPBhWzmsrvOKbwTCD2fvyl6plt0dlsINKSTLwUnVTnAbJuPsLGy/GXM3mYJRtoKhAY2DPrWZ94iRBH77i882/cTr+QQOmD+FlZRgJhVPHCvo+HKzMLAzomwe3/xBy1/vBxcyeCrBGNJFh+Bzj12FIBN9ep8oGUlkxILJfx1TjfC2p/2kzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8bf3PgGn/eka2CzJZGzMcYoDtw6FcZkyCoLxnpuvGA=;
 b=RuOxjk1fPaKO1PmhuuTJYAjxPxT+o+u0L4NnA9upAMEfvH9416bBiyWYdP06929V0IpIOJ8fSqUt8h+r5fW9z7B2etulmyZQD9+4ZTuj3BYE8dlpMEMVrmbJJHKMHEwvKfi+LOuT9CKN00IWdZ4eUrW2Y+QDCl/XvQa6TxcVa1As6ekANWLLJuo3X39wPvtjr4l0aJMxx4Yai9c9HW6C5OT+ChmRqqzvXYRwUOXQg/Pw1C0pwqVJpdAaWtHE1v0ZykfOZOwhvtGqEIUulmO1Pze2qosm2WxJ4dvvhmdDqzlDX0eZst3ejZRdwOCroVm8Sj5VLZE4+aJ5nmEe7ahcSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8bf3PgGn/eka2CzJZGzMcYoDtw6FcZkyCoLxnpuvGA=;
 b=ebNHPNnhvdHXCjoFtxSB6rWpyTiGYAN4nsURRSbcIAwh/wBiVweJrVk6m16MOYGAUwP/uts2U7vzE3c73IshB3ni+lScAF80GCmG16qWq2gMf8rpkQcsbXPGUb/xc6ORz93uy1AxJl5mSPNkVVMW8KSqGYyOQxfVXCXEEGESLuklHGCEsQqQQ07M1Qpv8QV0q9uJ2AnfDHh3+/vyqjW0YyNakJ0t6F1VCwoP0IX6SIYC+WfCJBVfL5V8fz5AEdUqaghsU+HPPw+kFnTaS69BPr4tJQZsfQMTTmeOICZAjUJVJgpdR0Xx6vZvimJOygIzSpjh0pt5xANDX3B3f8GLSg==
Received: from DSVPR12MB664020.namprd12.prod.outlook.com (2603:10b6:8:3e5::8)
 by IA0PPF002462CFE.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Wed, 25 Nov
 2026 13:20:57 +0000
Received: from DSVPR12MB664020.namprd12.prod.outlook.com
 ([fe80::76b4:63e0:3d27:bacf]) by DSVPR12MB664020.namprd12.prod.outlook.com
 ([fe80::76b4:63e0:3d27:bacf%4]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 13:20:57 +0000
From: Daniel Dadap <ddadap@nvidia.com>
To: =?iso-8859-1?Q?Riccardo_Zangh=ED?= <riccardo.z.dev@gmail.com>, Armin Wolf
	<W_Armin@gmx.de>
CC: Denis Benato <denis.benato@linux.dev>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"hansg@kernel.org" <hansg@kernel.org>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "luke@ljones.dev" <luke@ljones.dev>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [BUG] ASUS TUF Gaming A16 FA608UM: working backlight device
 differs between MUX modes
Thread-Topic: [BUG] ASUS TUF Gaming A16 FA608UM: working backlight device
 differs between MUX modes
Thread-Index: AQHde6JUor2pzzw0bk6vTAdpIU+OBbc9kZMAgAAYzQCAADA4gIAA68ey
Date: Wed, 25 Nov 2026 13:20:57 +0000
Message-ID:
 <DSVPR12MB66402023AE5250384B26515942BC432@DSVPR12MB664020.namprd12.prod.outlook.com>
References:
 <CAMnz_-Dgg2eCgZxcCaGuKPV=3-kCfg7ajd9w=vs2fGL-Cb6hvw@mail.gmail.com>
 <f1b7d729-771a-4fba-89c0-996a8a168126@linux.dev>
 <ce46d69f-2a3e-45fe-abe2-f643f683d09f@gmx.de>
 <CAMnz_-Dztuj3CRsxcVnfe2=OCB3tTJzK6Lu7-AKfkbuqn5N-UQ@mail.gmail.com>
In-Reply-To:
 <CAMnz_-Dztuj3CRsxcVnfe2=OCB3tTJzK6Lu7-AKfkbuqn5N-UQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DSVPR12MB664020:EE_|IA0PPF002462CFE:EE_
x-ms-office365-filtering-correlation-id: 0664ad98-6127-4a19-2a30-08df4af6f0c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|23010399003|6133799003|22082099003|18002099003|3023799007|11063799006|56012099006|261021135927099003|261102123227099003|261022075727099003|261022113327099003|261022105027099003|5023799004|261028144727099003|261021121427099003|261026121527099003|261009223027099003|4143699003|261021123027099003|261026140227099003|38070700021|10067099003;
x-microsoft-antispam-message-info:
 jP2gYCQEFT6QesEWa3g2qSSXf+usSFGu3yeoMDz5cw+Dh9ui3RhlDWJRNOkU5TzxCB9zGM2WffHkFn4GkaYDLvitJAS9Iaw3IMxsRjTVFCyyQlB9I7tA/js1KrZ8NS7TRlMfmJFcdS+pstNgHuFqiFnQulur3m7PnUjwqDOlql4WRK5xp0KCwBx5s4lL8HneB3l+6h4vGZRqEgiUaddGvFt5iKZUMoZC4KlLxydQUQF/G1V0D5KK+30AT8H6CFkm2nzLJJIZDJwshozFWjxID/bdzydcy+rZtJsrH/sbalxBwKp9AhYCTCyOaW2kWd0a5AOWSAjXSVjOIv2I5XXGYInyvzckpKJv9vWUWRDp4ug/UIIjeUe+2abTBMe84EBQZcp41Vj34kebDJbBQYzPWBmEi/LjEWNMthKxE3S0IMXnAo+l6kNKnWKzxM8tPcYjaoh9MS+RWDT9PRuH+vvTtNWTou7Adu6NGWO7hT0toq+iC8xZsKVpH6hu8vpsvNnl7AoCwaN44nMaVooOjVw0jdcbyuigdN7CCsF9TgVcvhrVbibJAdrpmbxU4erkfLjUuUfSmjYWHlaYdjTDVT1CPdaglqQip0ok3k2ezVFZta1LL5v76tpV6+QXOZc25jmmyFFCtG8LfggambIlBjqnP6ldyxdSBtAK8RYHp7n7cfNAHvKzqg/yt6aqO5WFlYjsyPNdXf8S5BLiTQ6nU+5fH8eX3hjhqduj49w14XyWmUo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB664020.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006)(261021135927099003)(261102123227099003)(261022075727099003)(261022113327099003)(261022105027099003)(5023799004)(261028144727099003)(261021121427099003)(261026121527099003)(261009223027099003)(4143699003)(261021123027099003)(261026140227099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7HrjJBsenft8ANkeJpfK1j5gv+tZNrQDUX/b+BS0TPoBCJMxDRkIxDILOd?=
 =?iso-8859-1?Q?fyaTdsvyk+G2U6x5wgIETtgsQ6oKLbiNPscyj+w1kS2dh4vo6a4K1H/7Uc?=
 =?iso-8859-1?Q?S0MlIbG3sQjBuu6X2abSs8sP5egCH5MB4YJmYipfXS1dJIQxoiGpSHAvfR?=
 =?iso-8859-1?Q?1JwcQwf89PW6EUFjUKCt42pWoYl9cUijwuHS2GJj6f2es7Av96E94LPb5C?=
 =?iso-8859-1?Q?6fSy9RX3lAVUoCSSl7T6RP3eGzjH32Epex7ufM2Jn8OOkmZOKcnwxF5OJu?=
 =?iso-8859-1?Q?9I95ZxMJZuUB5Md5YN3wf2SEsahs24wVnL7yfuzsvkVHcNuTl3AKLvqp4w?=
 =?iso-8859-1?Q?BmO+a8xt1yD+hj3Pqlq/CKzdk3KHA0NZJbLlSwr/FxVjHsubsrr57yHUmU?=
 =?iso-8859-1?Q?cMJROwM6RowCIbDroO9IrGGuJQ/xC1mGRHb6nNQaCJGRbAT1OeWT/CzDQK?=
 =?iso-8859-1?Q?YQYoQcn9+XGoAZWwJrLkZbtk9ACn4Rlbt7gtoFzXrzkCXzjDZMulNjI6vc?=
 =?iso-8859-1?Q?1x4kJTF5nsKhpTan5V7bMd2tdAqi9x2FyFLt/RVKHgzB3W349H7lPamM36?=
 =?iso-8859-1?Q?A5rqk4X942H5q1RP6JBTxbJJxyM0WNukwIMS9FAIOcpOUc/Ym8FMlxK0TS?=
 =?iso-8859-1?Q?CHHITwQTG0mYuGhGwcmlF9ci2nEBYJBNycSA+5awj4yyn7YU9kWw6FSZXi?=
 =?iso-8859-1?Q?Sc0D+d4CJDpKq+ttQEMQybRmS1SSx61TOwm28S6IrF5pyYDP7EcuXYQ108?=
 =?iso-8859-1?Q?ivzSCFtTz+IqxPK+ebWNtJVcJxJXPak19FhFIviKST4OUvqG8QBSwI5Qv+?=
 =?iso-8859-1?Q?0Lhsv2Cdx7VYkO96Z/GSlKoF4oDbLsZQUJwNBAnM116RnQNVh/rVESp9nP?=
 =?iso-8859-1?Q?UkGmP6cYSBZkEe8qc6IvCmjpaPb7Bv4e6Yf0/V8P1QUyhWfBCvfsuCSO+e?=
 =?iso-8859-1?Q?rcg7iZtqvGyKpxeTICFd8HnWtbQklwUyz6hSByFEQNkuqg+KlQxFRm1HxO?=
 =?iso-8859-1?Q?Fug9LNYJk3glr3ysV+NHh2MW5Aimk6BR7JIXVYsQJMbn56XhpTwvuuCVpn?=
 =?iso-8859-1?Q?TQlr+dLa4HsitUOh6JsBHHshBBhmMQBTaOw/olm1GfW9X0L9aEoc4DPZW4?=
 =?iso-8859-1?Q?gt0RmQzFslEL8fx05WaAyJMHOzZlM0VJJwd+jL/jRrU6mXan4B/uB+hgE3?=
 =?iso-8859-1?Q?nzorRaj4oFXbPSX5R0PtLEpqsZurmBx7d3cxdf54/8+n8C3b+K0LDsXIvz?=
 =?iso-8859-1?Q?v8F3Kh0zFH6uSu4+GOdZk/Izxwde7V9o1L4xuK+WOLul88V6M68my0jfnW?=
 =?iso-8859-1?Q?yFxHkqW7tUBzeRzPitCVvPuunpuY3fI4jTaXVbXyOp5FHdVeoKBbahM7PA?=
 =?iso-8859-1?Q?6F0a4lfBqElRou3pcx8wCF9EaUow1bfauzmnZjtG/wSsvIWymxsm5uGkOw?=
 =?iso-8859-1?Q?rdKDegy5i6xgjtLXbg33AOkGwG1QoVTvqHidz4OJAWngK8EVPje4yb7aRM?=
 =?iso-8859-1?Q?9Xlb+QSNafI7fhfnm3Rhle97h9IaxHOHu3uIlu+DvJGLH1zYr1gw9LfbmI?=
 =?iso-8859-1?Q?gsbQyqNWRgFm3t/8Mxg7Sd6rGA0+Q6kkFa2d0539jhVzMMkYr4ro+3TsKl?=
 =?iso-8859-1?Q?4BzbpHzRvBeO7P1tXHvSTml7yOd8T4bKUWJmj2Q436XpYvM5Vj9tsV3iB6?=
 =?iso-8859-1?Q?kwUicqqdKOCf/yYDcoRqTN5j429reNaRRD2w6TWMcufADHMpS+GVO94Iqp?=
 =?iso-8859-1?Q?R5IBwInLGPtVyqPhy+mr2J9qXbU0bTUBGEu46riGboG0vAQZdV9EC+OYgj?=
 =?iso-8859-1?Q?pDk7rclQY6XDq3WswxZKffsezevkO9fVfa5zxdHjTUiwbLgymoRD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0664ad98-6127-4a19-2a30-08df4af6f0c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 13:20:57.1807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPb5xIXsmA3DKxv3tYXknF2R39bF85bW++LnrSP2tPG/wZmsmGKpSGOkHV8JZuOot8o59+6yOIIZE/wgTzKfwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF002462CFE

(This is my third attempt to send this message. The first attempt got bounc=
ed=0A=
by the mailing lists due to a DMARC mismatch, I sent the second in the hope=
s=0A=
that the first issue was transient, since I was able to send the same messa=
ge to=0A=
myself at a personal e-mail address without issue, but that bounced as well=
, so=0A=
this attempt is made with a different mail client (Outlook), since it integ=
rates=0A=
with our corporate mail system differently. It seems quite likely that both=
 of the=0A=
previous attempts would have delivered to the individual non-list recipient=
s, so=0A=
I apologize for the duplication. If individuals do indeed receive this mess=
age, I=0A=
would appreciate it if somebody would pass my notes along to the list, in c=
ase=0A=
I continue to struggle with getting the message to post directly.)=0A=
=0A=
On Wed, Nov 25, 2026 at 12:10:01AM +0100, Riccardo Zangh=ED wrote:=0A=
> On Tue, 24 Nov 2026 at 21:17, Armin Wolf <W_Armin@gmx.de> wrote:=0A=
> > AFAIK Windows will automatically fall back to the ACPI backlight=0A=
> > interface if the driver does not provide a native backlight=0A=
> > interface itself, so this strategy differs a lot from the strategy=0A=
> > used in Linux. Can you share the output of "acpidump"?=0A=
> =0A=
> Hi Armin and Denis,=0A=
> =0A=
> Here are the acpidump outputs, one file per mode, taken from separate=0A=
> boots after switching with supergfxctl:=0A=
> =0A=
> https://gist.github.com/Piadineitor09/062d3327731e5ec38fefcf5ae9064a26=0A=
> =0A=
> acpidump-dgpu.txt       (gpu_mux_mode =3D 0)=0A=
> acpidump-integrated.txt(integrated mode)=0A=
> =0A=
> The two dumps are different (cmp reports a difference),=0A=
> so the ACPI tables do change with the mode.=0A=
> =0A=
=0A=
Thanks for providing the dumps. The dumps do indeed differ, but if you=0A=
split out the individual tables, it seems that this is mostly due to some=
=0A=
tables being present in only the dump that got collected when booted to=0A=
iGPU mode.=0A=
=0A=
I did `acpixtract -a` on your dumps to separate out the individual tables,=
=0A=
and observed:=0A=
=0A=
Identical in both dumps (iGPU and dGPU):=0A=
=0A=
DSDT, SSDT2 - SSDT25=0A=
=0A=
Different between dumps:=0A=
=0A=
SSDT1=0A=
=0A=
Only in iGPU dump:=0A=
=0A=
APIC, BGRT, CDIT, CRAT, FACP, FACS, FIDT, FPDT, HPET, IVRS, MCFG, MHSP,=0A=
MSDM, SDEV, TPM2, UEFI, VFCT, WSMT=0A=
=0A=
Now, the part that is most relevant when it comes to the EC backlight=0A=
driver happens to be in one of the tables that's identical, namely, the=0A=
DSDT table. You can disassemble the table with `iasl -d` if you want the=0A=
full context, but I'll quote the relevant parts of the disassembly here.=0A=
=0A=
From include/linux/platform_data/x86/nvidia-wmi-ec-backlight.h, these=0A=
constants will help interpret the disassembled AML code:=0A=
=0A=
>#define WMI_BRIGHTNESS_GUID "603E9613-EF25-4338-A3D0-C46177516DB7"=0A=
>=0A=
>/**=0A=
> * enum wmi_brightness_method - WMI method IDs=0A=
> * @WMI_BRIGHTNESS_METHOD_LEVEL:  Get/Set EC brightness level status=0A=
> * @WMI_BRIGHTNESS_METHOD_SOURCE: Get/Set EC Brightness Source=0A=
> */=0A=
>enum wmi_brightness_method {=0A=
>        WMI_BRIGHTNESS_METHOD_LEVEL =3D 1,=0A=
>        WMI_BRIGHTNESS_METHOD_SOURCE =3D 2,=0A=
>        WMI_BRIGHTNESS_METHOD_MAX=0A=
>};=0A=
>=0A=
>/**=0A=
> * enum wmi_brightness_mode - Operation mode for WMI-wrapped method=0A=
> * @WMI_BRIGHTNESS_MODE_GET:            Get the current brightness level/s=
ource.=0A=
> * @WMI_BRIGHTNESS_MODE_SET:            Set the brightness level.=0A=
> * @WMI_BRIGHTNESS_MODE_GET_MAX_LEVEL:  Get the maximum brightness level. =
This=0A=
> *                                      is only valid when the WMI method =
is=0A=
> *                                      %WMI_BRIGHTNESS_METHOD_LEVEL.=0A=
> */=0A=
>enum wmi_brightness_mode {=0A=
>        WMI_BRIGHTNESS_MODE_GET =3D 0,=0A=
>        WMI_BRIGHTNESS_MODE_SET =3D 1,=0A=
>        WMI_BRIGHTNESS_MODE_GET_MAX_LEVEL =3D 2,=0A=
>        WMI_BRIGHTNESS_MODE_MAX=0A=
>};=0A=
>=0A=
>/**=0A=
> * enum wmi_brightness_source - Backlight brightness control source select=
ion=0A=
> * @WMI_BRIGHTNESS_SOURCE_GPU: Backlight brightness is controlled by the G=
PU.=0A=
> * @WMI_BRIGHTNESS_SOURCE_EC:  Backlight brightness is controlled by the=
=0A=
> *                             system's Embedded Controller (EC).=0A=
> * @WMI_BRIGHTNESS_SOURCE_AUX: Backlight brightness is controlled over the=
=0A=
> *                             DisplayPort AUX channel.=0A=
> */=0A=
>enum wmi_brightness_source {=0A=
>        WMI_BRIGHTNESS_SOURCE_GPU =3D 1,=0A=
>        WMI_BRIGHTNESS_SOURCE_EC =3D 2,=0A=
>        WMI_BRIGHTNESS_SOURCE_AUX =3D 3,=0A=
>        WMI_BRIGHTNESS_SOURCE_MAX=0A=
>};=0A=
=0A=
And here's the WMI data, with commentary:=0A=
=0A=
> Device (AWMI)=0A=
> {=0A=
>     Name (_HID, "PNP0C14" /* Windows Management Instrumentation Device */=
)  // _HID: Hardware ID=0A=
>     Name (_UID, "0x00")  // _UID: Unique ID=0A=
>     Name (_WDG, Buffer (0x28)=0A=
>     {=0A=
>         /* 0000 */  0x13, 0x96, 0x3E, 0x60, 0x25, 0xEF, 0x38, 0x43,  // .=
.>`%.8C=0A=
>         /* 0008 */  0xA3, 0xD0, 0xC4, 0x61, 0x77, 0x51, 0x6D, 0xB7,  // .=
..awQm.=0A=
=0A=
This is the WMI_BRIGHTNESS_GUID (first three fields are integers in little=
=0A=
endian order; last two form a byte array and are in array order).=0A=
=0A=
>         /* 0010 */  0x41, 0x41, 0x01, 0x02, 0x21, 0x12, 0x90, 0x05,  // A=
A..!...=0A=
=0A=
The "AA" object ID, instance count of 1, and flags indicating a WMI method=
=0A=
block mean we're going to look for the object named "WMAA" (it's the only o=
ne=0A=
here, so that's easy.)=0A=
=0A=
>         /* 0018 */  0x66, 0xD5, 0xD1, 0x11, 0xB2, 0xF0, 0x00, 0xA0,  // f=
.......=0A=
>         /* 0020 */  0xC9, 0x06, 0x29, 0x10, 0x30, 0x30, 0x01, 0x00   // .=
.).00..=0A=
>     })=0A=
>     Method (WMAA, 3, Serialized)=0A=
>     {=0A=
>         CreateByteField (Arg2, Zero, MODF)=0A=
>         CreateDWordField (Arg2, 0x04, LEDB)=0A=
>         Switch (Arg1)=0A=
=0A=
Arg1 selects which WMI method to use, and Arg2 contains its parameters. So=
=0A=
the cases in this switch statement represent different WMI methods, and the=
=0A=
one we want is WMI_BRIGHTNESS_METHOD_SOURCE (i.e., 2), and we want to see=
=0A=
how it responds to a parameter value of WMI_BRIGHTNESS_MODE_GET (i.e., 0),=
=0A=
since this is how the backlight code in the kernel determines who owns the=
=0A=
backlight control on this device. We'll check MODF for that, since that is=
=0A=
established above as a byte-sized field starting at offset 0 of Arg2.=0A=
=0A=
>         {=0A=
>             Case (One)=0A=
>             {=0A=
>                 If ((MODF =3D=3D Zero))=0A=
>                 {=0A=
>                     LEDB =3D ^^SBRG.EC0.GBLD /* \_SB_.PCI0.SBRG.EC0_.GBLD=
 */=0A=
>                     Return (LEDB) /* \_SB_.PCI0.AWMI.WMAA.LEDB */=0A=
>                 }=0A=
>                 ElseIf ((MODF =3D=3D One))=0A=
>                 {=0A=
>                     ^^SBRG.EC0.SBLD =3D LEDB /* \_SB_.PCI0.AWMI.WMAA.LEDB=
 */=0A=
>                     Return (Zero)=0A=
>                 }=0A=
>                 ElseIf ((MODF =3D=3D 0x02))=0A=
>                 {=0A=
>                     Return (0xC8)=0A=
>                 }=0A=
>                 Else=0A=
>                 {=0A=
>                     Return (One)=0A=
>                 }=0A=
>             }=0A=
>             Case (0x02)=0A=
>             {=0A=
=0A=
Here's WMI_BRIGHTNESS_METHOD_SOURCE=0A=
=0A=
>                 If ((MODF =3D=3D Zero))=0A=
>                 {=0A=
=0A=
And this is what it does for WMI_BRIGHTNESS_MODE_GET=0A=
=0A=
>                     If ((^^SBRG.EC0.G40C =3D=3D One))=0A=
>                     {=0A=
>                         Return (0x02)=0A=
>                     }=0A=
>                     Else=0A=
>                     {=0A=
>                         Return (0x02)=0A=
>                     }=0A=
=0A=
Now this is interesting, and suspicious. It checks a value from the EC's=0A=
mapped memory region, but regardless of the field's value, it ends up=0A=
returning 2. This corresponds to WMI_BRIGHTNESS_SOURCE_EC, which explains=
=0A=
why it ends up exposing nvidia_wmi_ec_backlight under /sys/class/backlight=
=0A=
regardless of whether you've selected iGPU or dGPU.=0A=
=0A=
The conditional here suggests that there may have been an intent to use a=
=0A=
different device, depending on what gets read back at that address. Your=0A=
observation that only the EC backlight driver works when you're booted in=
=0A=
iGPU mode and only the native backlight driver works in dGPU mode makes it=
=0A=
worth testing if the G40C value differs between the iGPU and dGPU cases.=0A=
=0A=
If we do observe different G40C values in iGPU and dGPU modes, that could=
=0A=
be used to determine which conditional branch could be changed to return=0A=
WMI_BRIGHTNESS_SOURCE_GPU (i.e. 1) instead of WMI_BRIGHTNESS_SOURCE_EC.=0A=
=0A=
>                 }=0A=
>                 ElseIf ((MODF =3D=3D One))=0A=
>                 {=0A=
>                     If ((LEDB < 0x03))=0A=
>                     {=0A=
>                         Return (Zero)=0A=
>                     }=0A=
>                     Return (One)=0A=
>                 }=0A=
>                 Else=0A=
>                 {=0A=
>                     Return (One)=0A=
>                 }=0A=
>             }=0A=
>             Default=0A=
>             {=0A=
>                 Return (One)=0A=
>             }=0A=
>         }=0A=
>     }=0A=
> }=0A=
=0A=
Here's the memory region where the G40C field is defined, quoting the first=
=0A=
couple of bytes for context and flavor:=0A=
=0A=
> OperationRegion (ERAM, SystemMemory, 0xFEDD8300, 0x0100)=0A=
> Field (ERAM, AnyAcc, NoLock, Preserve)=0A=
> {=0A=
>     Offset (0x00),=0A=
>     XKTM,   1,=0A=
>     FNED,   1,=0A=
>     XFFG,   1,=0A=
>     FNDI,   1,=0A=
>     TPAP,   1,=0A=
>     TPFG,   1,=0A=
>     WLRY,   1,=0A=
>     BHPE,   1,=0A=
>     Offset (0x01),=0A=
>     CLOT,   8,=0A=
=0A=
... and here's the byte where the actual field lives:=0A=
=0A=
>     Offset (0xB8),=0A=
>     G40C,   1,=0A=
>     LRPS,   1,=0A=
>     DMUS,   1,=0A=
>     PWMD,   1,=0A=
>     MNMS,   1,=0A=
>     D9FG,   1,=0A=
>     CF9F,   1,=0A=
=0A=
So, as an experiment, if you could read the LSb at physical address=0A=
0xFEDD83B8 in both iGPU and dGPU modes, and report on the value, that=0A=
would help. Assuming that the value does indeed differ, you can try to=0A=
patch whichever case corresponds to the dGPU in the WMI method in the=0A=
DSDT table and feed the patched DSDT table to the kernel via initrd:=0A=
=0A=
https://docs.kernel.org/admin-guide/acpi/initrd_table_override.html=0A=
=0A=
Something like:=0A=
=0A=
# od -j $((0xFEDD83B8)) -N 1 /dev/mem=0A=
=0A=
ought to get you that whole byte, then just % 2 for the bit we care about.=
=0A=
If you run into access problems beyond standard permissions issues you'll=
=0A=
probably need to set iomem=3Drelaxed to get around CONFIG_IO_STRICT_DEVMEM=
=0A=
protection and/or disable kernel lockdown. Of course, you will want to=0A=
replace that offset with one based on the actual values in your ACPI table=
=0A=
if they're different from the above quoted disassembly.=0A=
=0A=
You might be wondering, "but why does it work on Windows?" I've seen many=
=0A=
notebooks with buggy firmware reporting for which backlight interface to=0A=
use, which have perfectly functional backlight controlsi, despite plainly=
=0A=
obvious violations of the contract for how to advertise how the backlight=
=0A=
should be controlled so that the OS can select the correct drivers. I have=
=0A=
a working hypothesis that this class of bugs is masked by fallback and/or=
=0A=
broadcast behavior between multiple backlight drivers on Windows, beyond=0A=
the documented fallback behavior that Armin describes, for when a native=0A=
interface is unavailable. And because this behavior masks the underlying=0A=
firmware bugs, it makes the bugs harder to discover, which in turn makes=0A=
them surprisingly prevalent.=0A=
=0A=
A while ago we were discussing adding a similar proxy mechanism to Linux=0A=
backlight control, and I think I might have volunteered to implement that,=
=0A=
but it fell off my radar. Doing something like that would probably help=0A=
more generally to work around these sorts of issues. A DMI quirk could=0A=
probably help too, but all of the ones in video_detect_dmi_table[] so far=
=0A=
in drivers/acpi/video_detect.c have fixed override types per system. If we=
=0A=
wanted to use a DMI quirk here, we would need to supplement the machine ID=
=0A=
based detection with a reliable way to determine what GPU mode the system=
=0A=
is booted into.=0A=
=0A=
> Thanks,=0A=
> Riccardo=0A=
