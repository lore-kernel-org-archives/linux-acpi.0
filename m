Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022138.outbound.protection.outlook.com [52.101.101.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C763A4503;
	Fri, 10 Apr 2026 15:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775836417; cv=fail; b=ewa6HMmlAD5LJIvbE9F7ZnFQqbRbxCTvFGblb2YCH5FtUwEauk7OopdyP4xsOGqp1RG4uK2CoV1W6q18c/AzGECo9/6uUzrlgSKHfXIKq4VTcqSD05QUGYDhvoFOntmue5kY1twiD3f5VGTRRb1QyNHXqc/rO8A4/OTIxbO4pnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775836417; c=relaxed/simple;
	bh=ebM0m5UEKsUT25yS9wQa4yTJLXyvS8qRbSrbGjpYDA0=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=dZsU436NcFT1UDOnyPXsj2SauON3fJHLRBeQkDopEGNeE853X9InHIhFQMEfgyY9bnDp1Pc3MkSzIuKqLR/g7lUS0/Tp7GWKR+0yp5SWl7Ravw70zMSW4f7bMEfyYotadTbcOBa2u6CBYOCZDIf/75VHOgFJAAz+mRdl3CJXlLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=CbrWcdrC; arc=fail smtp.client-ip=52.101.101.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="CbrWcdrC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ko4WRkvMFdCFfM0+Qp8zS8Sdg/ec62BjVa0xP554t/yfyKusxZQEVYOZxBT0vLYz4po6qMWyVEhay8atfA3Q6zYHQ/HIffTEYnoCmxZaOvgaMylnzd3N7h1D98AishRMqFDLeobAAVZ2wcE4cDUD9F4EyzT20hWly0ZSLyjtt+DewmInVocBnsYvI9TVxe83IYKXSKWoepPiKl67aS2r62uZ8Lr2alGvBjSRc4xw4KOi0Q278DCSr0hrLMGTppcK+O2y9YQRQHZVDtxYKr20emvg+PO6pg57TKKpcfoKLOKnKJenpvPiukIFU3ugypC42O4/vOab5Gj9NnbJHh2FoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vc81S6HYV+PQBA4Y89X0l5qgUIf8QDjpLAbQ1INepHU=;
 b=BUy4y/FdKC6zwcI2eHJFxSREXGtm0D+G8d+8UvTLNoBXtWoceXmWjW7wJ6VL0dJ9KjZ8sdTrZdvRCR8xBRI/nmLQiWy9sqXEiZXGNWBuMMQ5g6VT0ybH+BV1/iSnN4KXVlvdVXkFHdvR+45sw6j5hCGxpTSA4bIRcGLItizSfGMHh5gEWmDp/Suf0d17uwMD9H7i6dgFr28xTZ4YRDZhICPntAgg+Dy0GF/A1nWXNotqrJ70ukSAV8EHodRRM0jzZoWV2Zwws5SGK1lwyvhidAR18GF8rF9RlF0lHbydjYCeibLodcNzDn1AY9hsJpCNATxvGYjVt3v7xZU3rwY7+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vc81S6HYV+PQBA4Y89X0l5qgUIf8QDjpLAbQ1INepHU=;
 b=CbrWcdrCDEtLK2eNFMZsizH5eUKdxP943qB37xqRwSzni3fIMT6nqZzxLmXd+rmuTz4+g5G2XoTK7NUkM+scnCe4r4xV9IjZRkQR7bX/hqwRobNNsEOGtX1+SDJ9LjvLuo8MQweIhyF+bGGKUdHBpVPPTanxfy6GfeWFQMV32UU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO4P265MB6982.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:34d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.44; Fri, 10 Apr
 2026 15:53:32 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.20.9769.035; Fri, 10 Apr 2026
 15:53:32 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Apr 2026 16:53:31 +0100
Message-Id: <DHPLGWZS3MHN.XT3QZ5XQ4FA4@garyguo.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Robert Moore" <robert.moore@intel.com>,
 <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v3] rust: ACPI: fix missing match data for PRP0001
From: "Gary Guo" <gary@garyguo.net>
To: "Markus Probst" <markus.probst@posteo.de>, "Danilo Krummrich"
 <dakr@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260407-rust_acpi_prp0001-v3-1-c5b24590c273@posteo.de>
 <DHNWFFEB3HD9.1QM2XXNE6BANY@kernel.org>
 <4d5cd9887e67007f4dabfed0986861a60e395ae6.camel@posteo.de>
 <DHO1GI8ZAR1L.3DUWFSM1VT8BS@kernel.org>
 <e6985ffe6d35e27b85b540e410cf92592d597a69.camel@posteo.de>
 <DHO46CIJNVZH.1Q6ZLX1XNWRR4@kernel.org>
 <bbf903b3db06fbe9f5042dd64dc18fbc897927a4.camel@posteo.de>
In-Reply-To: <bbf903b3db06fbe9f5042dd64dc18fbc897927a4.camel@posteo.de>
X-ClientProxiedBy: LO2P265CA0166.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::34) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|LO4P265MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: f09b8b5f-3979-4e79-963b-08de971950cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	VAfrOat3l7+SOjAOnvIPUFrIMXmO9m49r2P6eI8dlcIfkyO90a4QOMemMYqecksYyO7EPTlxTkBATc6P0liF5hizLxGrP4SBr23Jt8eDwkqGFsHce2owsWBITg8X5XFNr4zzcyC88GYSPSyfAxgEi4mryyhKaqTq4EFFJN/tAK6TNKEUccAQOu5HfS2fwjBR+g4WCGmCGF4UT+3+5DIqdAgDgYRqmvxAOJbPqnP7CiN8uF+GqpAmkhdOkoCP7FWZ0m381BvPCdshqsbE2J5eeqW1sTcKSORf51W7yfDoQWJZZvpW1RtF6967pB/3NiAoLbraWYaXREM/7mYqgTfQDzReT+t0+B7bzMJXWCRol1YJSHRVj5TihUBxocwnPCRKJK+ej8RTOB3XgjgGqYsuOlguJTAqTDmWQVfOcWCbZQZEU+pGDgvuQ3FIi4fywJZBpi8G269UlixX9d0bDNEqJSr/gvNkamz/6IBLpzGihpG8o4cGbTWWbiZwEjxSfspu/aj2EpgU9Ps9DRkC7Nj3oqKCb5zegPEVqeYcDOW0S5dzXdnL4tO+0Rt4PdcSdGA2DsC8H6DtVwWC/nL8wlaAf+NOwg0zQpwkZFl7qQN2ebSW0cnu6cnHLJye9SqYrvpaaTrxfTTyIIuA099Y34dY6ul3CJfy4xR08Ygoh5Bj2fEITjZZ9ZwMUaD3fMgzKHG1vxl9R3jNKtbgK9zCGU8H3sYYam9tMHnSmIlJRmBY0TY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2sweGN2MTdEQXE4cG8wNUJHejZ4OGNSb3JBZkZaN25NOEJ3SjF6V3ZlVVpw?=
 =?utf-8?B?a3VtSnQ1WWJLcTlOMFpxVC9wZW1YL3hwa3NwNzZJTXlhZnlDZFQyQ3NHcUxC?=
 =?utf-8?B?SXZlSlV4eGdZSms5VVlsNUk2eE9jYVh3OUZFaFFpWEJ1eVlpc2hkMkhIMEFm?=
 =?utf-8?B?M0JhVDMyMGo0WGlaL3Fqd3dFbzhVZU1TN3QySDkrcVRXWkJueG1jVm10R3Mz?=
 =?utf-8?B?dGo2bXU0dTJuczFjY2t0RTFVNk5mWWFLcU9NNFdFeWRZRkRlT2xkalAvZFRD?=
 =?utf-8?B?bENDUDNQczlJWDY3eWFqYlNrN3JLZ1k4TC9UbEtJSjN2bFRNWGtreVRFL2Jw?=
 =?utf-8?B?MUdEUlZyaGNJRC96Wkg4Y1I4YWhJY3hYWk5IeG1DSzhxQ0o3c3pxOEY2d0VO?=
 =?utf-8?B?eE9aSVdyWWVsV0crSTB4QWx5SFRKLzhKSysxVkdZdXNkdVdZcC9BbWwzSkdG?=
 =?utf-8?B?NlFIb0o3VUx3TytwM2lCNEZMYmtUM3NFY0Nid3Y5QzNjc3B5OGRUMG1WNWZl?=
 =?utf-8?B?RVhrY0lJeDVqYkt1U3pmZU16dzhjaHMzbXJaTHZVUnFHaStnT1NaUmFKaEJO?=
 =?utf-8?B?Mm1xUHM3NTExYll6cjVPMERTbldYNEFUVXhsN3lTTlR4Y2dsb3RVZHlEVEpD?=
 =?utf-8?B?ZG5kSmRmTmsxWkpUOFJlekRRSFh4QW5uWmVsWmZiRjQvc3lyNEtXTFd2T0xK?=
 =?utf-8?B?ZUNCQmpnQThjTGEzU1hYNkxiTTZCU3FyS3orajVRMUFJQWw1YXRnbW9CalN5?=
 =?utf-8?B?bVJ2QWE0Yms5REdBQ2EvWjRsSUtoc0xXUzdmZTZpTk54N005RWY0SUJ4UlNB?=
 =?utf-8?B?b3I2WURia1Y3d2N5QkxzTTFnRWhIMDR3RTlpbUlzTWtjWUdQRnU3LzZOZjkx?=
 =?utf-8?B?ZUNldWhQWU9iRGpyZVNtQldFOGJYMStWdVEwVlU3RGx0K293MklNWGtHTGtn?=
 =?utf-8?B?MnhPQktCSXR6R2I3eVd5RkFhNXR5UFBPaFg1b2lFUUdNSFgvS3NwYnM0VU05?=
 =?utf-8?B?RkloZURldXRMNFkwM3RlVy8wNUVWVmNoTHpwYXVOUDQrNG5NTDhvUHZJVUxS?=
 =?utf-8?B?MFVzcis1V0FmcCswQWYzNklKVTRvc2VyUUlmcDdVWmc0a2MyQlRteFROOUN3?=
 =?utf-8?B?djJjWXVDOFVZK2FBbit2SGNNRkE5QnBQa2xMSGVqbnFQUjV6V3NFbzRsZHZV?=
 =?utf-8?B?VndEaEl4blVKSWw0MXA4ZjJJa3RyelJoSE15N3VpTWUvaE5JMHF0T0M4TFZU?=
 =?utf-8?B?TDJWT0JKRTdNTGNjdURnd2cwNDZjdDR3Z3Azem1VV3hFY0liYUgraXVSbDhn?=
 =?utf-8?B?MGVwKzJjVWg2SWYrQTh4S1daY1VWSXFyR1l6T3diczREeWNrODRzNEUyUUJB?=
 =?utf-8?B?SlVYYWtEYVRvRTVWNlRYMHhESnc0UXkxYTZKL1ZzQ0RGb09RVzk2eE5RYWV4?=
 =?utf-8?B?SG1PanFDU0tnOEtyRCtOdU55MlVEQnJqTks5MGR6bTRNUHQ3QzVKZnhMaWc0?=
 =?utf-8?B?K1dURDlXUkR3cDNVUCtTWk9YdDVnWkJDVXhqZHhramhQUFpMU3dwaXdoQ0xW?=
 =?utf-8?B?Zm15LzlMYW9TS3NUMko2cDVtdGRPeWQ0bDBhQVIyb1JuN3N4R1VWUFUvaEkw?=
 =?utf-8?B?elZsbFFYZVRQN0pDdlZwSTBreTJaRzVldW1UOG1NVFJYR214VERsZ3JwSkxK?=
 =?utf-8?B?VnJLd1pBdWdQU2UveHJocjV6d2ZEVWM5aVRpRXlBRS9Oc2RGTTBXMnRiTHRI?=
 =?utf-8?B?TFZ5a3AxUG04MjJ3TVBqR3cvYU1NY0hlOVE3Q1FjL2RDQU5FN25sVnBqbk1k?=
 =?utf-8?B?OEpKQnBMeVJoYzhjMTg5TGRQYXdhWFcyaFdmeFl0Ri9vcDZ3Um9VVVdNQ3Zk?=
 =?utf-8?B?RCtSNUZNYTJMckQ1VmN3YW4yRmhjQWtlV3BndXIxYjlMa2pJR3VsMDlJNzht?=
 =?utf-8?B?ZzRRNS95RjVqZ01maVNBSXlPbUVmaGIrVlJXeTA2cHRpazNmRlJXbWptWU82?=
 =?utf-8?B?N1gxVlltZTdmMDB6OTNkczV1UDlaR1VnaWluNmZEWkg1dmV0YkpMNGVoUWlq?=
 =?utf-8?B?ZjFNN2c2bzFPbFRIWWUzb1dqNXE5ZlZvRlg2SlBqUkRNU3FCKzNFaWVLMVNl?=
 =?utf-8?B?NWhsNWYyYVQvYmsrWlJaeGswS0RsV2pJOTVUQUZPN3ZLWlF5SldCcTNoVnpR?=
 =?utf-8?B?UlZaYmgyVzZQUFZ3R3U0Rjc3L1NBK2lXdFZqZDRyanQ1VzNyR3pJbGNGaVVO?=
 =?utf-8?B?Vm16MGNwU2l6Z2dka3NJQUlFM3dsUnkwN3BJemhlTnU5UGZRWkU5Ym80aGhi?=
 =?utf-8?B?bERvWkJnZ20vMERDbDhjYTlneFI5SWZVdGZaMDg4N1hvbDFLTi8vdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f09b8b5f-3979-4e79-963b-08de971950cf
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 15:53:32.0249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qgEF5+/7+SvZqYa9/K+HUQfplecYgZ6J1PE3g/6g05iVavrMqRci04+Pgo4PQhSxe75uwnp7fmuXISTlbJr0AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6982

On Fri Apr 10, 2026 at 3:57 PM BST, Markus Probst wrote:
> On Thu, 2026-04-09 at 00:07 +0200, Danilo Krummrich wrote:
>> On Wed Apr 8, 2026 at 11:42 PM CEST, Markus Probst wrote:
>> > On Wed, 2026-04-08 at 21:59 +0200, Danilo Krummrich wrote:
>> > > On Wed Apr 8, 2026 at 9:40 PM CEST, Markus Probst wrote:
>> > > > On Wed, 2026-04-08 at 18:03 +0200, Danilo Krummrich wrote:
>> > > > > On Tue Apr 7, 2026 at 11:41 PM CEST, Markus Probst wrote:
>> > > > > > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
>> > > > > > index aad1a95e6863..d0098f24346f 100644
>> > > > > > --- a/include/acpi/acpi_bus.h
>> > > > > > +++ b/include/acpi/acpi_bus.h
>> > > > > > @@ -187,6 +187,10 @@ struct acpi_driver {
>> > > > > >   * -----------
>> > > > > >   */
>> > > > > > =20
>> > > > > > +bool acpi_of_match_device(const struct acpi_device *adev,
>> > > > > > +			  const struct of_device_id *of_match_table,
>> > > > > > +			  const struct of_device_id **of_id);
>> > > > >=20
>> > > > > This also has to be defined for !CONFIG_ACPI, otherwise we run i=
nto the
>> > > > > following compatible error.
>> > > > >=20
>> > > > > 	error[E0425]: cannot find function `acpi_of_match_device` in cr=
ate `bindings`
>> > > > > 	      --> rust/kernel/driver.rs:295:24
>> > > > > 	       |
>> > > > > 	   295 |       unsafe { bindings::acpi_of_match_device(adev, of=
_match_table, of_id) }
>> > > > > 	       |                          ^^^^^^^^^^^^^^^^^^^^
>> > > > > 	       |
>> > > > > 	      ::: /mnt/nvme/work/projects/linux/driver-core/driver-core=
-testing/rust/bindings/bindings_generated.rs:118713:5
>> > > > >=20
>> > > > > There is an
>> > > > >=20
>> > > > > 	#else	/* CONFIG_ACPI */
>> > > > >=20
>> > > > > block at the end of acpi_bus.h for this.
>> > > > I don't think the function exists in that case and bindgen can't
>> > > > generate inline functions, so I will just add a `#[cfg(CONFIG_ACPI=
)]`
>> > > > condition on top of the function.
>> > >=20
>> > > Usually we provide a stub instead of conditionalize the callers; thi=
s case might
>> > > be a bit special, but I'd still follow the usual pattern.
>> > The usual C pattern would be
>> >=20
>> > static inline bool acpi_of_match_device(const struct acpi_device *adev=
,
>> > 			const struct of_device_id *of_match_table,
>> > 			const struct of_device_id **of_id);
>> >=20
>> > , which is ignored by bindgen (i. e. same error).
>>=20
>> That's where you define a Rust helper; we have lots of cases where we on=
ly have
>> the Rust helper to deal with the inline function stub used when the
>> corresponding CONFIG_* is disabled.
> According to git commit msg [1], __rust_helper is needed to inline
> these helpers into Rust code. Does this mean we could omit the extra
> function declaration with #[inline(never)] and just use a helper
> without __rust_helper?
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Da9aabb3b839aba094ed80861054993785c61462c

The helpers can still be linked together with modules (especially when
CONFIG_RUST_INLINE_HELPERS=3Dy), it's just that they're no longer inlined.

So you'll still need to make sure the function callers don't get codegen'ed=
 into
modules, which means that you'll still need the `#[inline(never)]` trick.

Best,
Gary

