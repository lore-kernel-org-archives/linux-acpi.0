Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021072.outbound.protection.outlook.com [52.101.100.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ECF34D91C;
	Sat,  4 Apr 2026 21:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775337817; cv=fail; b=BjeDj9O6aQ2FzHcbQGrXQJkByd3QinV0F28sekzj1bikc/2PeSbjNg6bDMh+cD4Mrc2pGAWfk96GvQPUfDcfEUCOQIpdrAnlnVfLVdll0nAnOjs3yT1AJCxUR9FDaRqZ+qU08AOFXFELm/W7fl717ruoJOD3aeOCRXCqinCGgWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775337817; c=relaxed/simple;
	bh=/35IyEUTODaMNoCCifNftRj5Cah6Osvr9zeRwuGXemw=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=EcjPBMreqXCOvPNRiKQO9eZCTSOROEkm3Ij8qHqW7BR2qf6nVIWOZ7qW5heK6hhnJo/6TqBiM3RIDHLsnqMoZEMunERfSdYb8dVhXcIeFRrekLtRBsZO64bfOWGPMBAUDagv0o8jarsvblBno9M1WNqN3K7YOF5cICoMf0BHml0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Ez1VYVQs; arc=fail smtp.client-ip=52.101.100.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Ez1VYVQs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpYUN0WS5rFst5n2tttmcP1Wl1Y3xIf6uh/F58+vYlpbV0uB0oCNDxIXl034FrhsMuL85XV+fVeFXglziqEG+rBCoC3JJFEwdjJdMgxjmOpeymxcDnwiZMcXtmOxG5V8yQ0J1t6Sxev5FoXmQepg2+sj33BkUFpNnUvZRo/aiscyj52esQtUgW6TYx4ROxZcBAaENBj4R/m5vtjuzMGPK7UwJ7YZmZF2Etx2AQ84yQE/S4nv/WW+yyvsJ1RPa2w/ozZwaUkH6F4kBMF+1Iy4vnpe0joaqBlxAQB/0zRQBWePa/FwiiNy4mw4T37QqCDBVLsT2YFU2GYrV2PL5zI9Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzMmUG7PDurLDvLWlNUqkKAGRAmkHuNhyStlUWbjJE4=;
 b=A20JQWqiLh5U+kSaZb4DkzEqjFq+/AKKAcjYwooVxNYZsTscHmxNdH4uLONMxhg4rVrQgYcSMfBJsNhTBu4MB0KC2sdUNAGvflOG8EsfHees76gr8FkTkzwel9GJMvHP5wd7RiVnAE2MZmfBfivV6jBmJl3Lhw21zaxSu7UDIpV/Y4JSGceRfxu6V2WsVkffAzUwjGZqeilosy57mUMDA2/WnQAJelhBCibjYKxeqQt0al86+C46yPEWCBDi7OYWsCFi9TjvTyFyuBhM6/yl6Cs3bt9mEA53nWoCUuJWLwizMsVsL688OBFNAuUsFCT1RylwBr/thMibrapA5e+fig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzMmUG7PDurLDvLWlNUqkKAGRAmkHuNhyStlUWbjJE4=;
 b=Ez1VYVQsbp3h8gDg6M4MPoY/b8v+2i320tIs0IDZsR6zQW3WEdJBbRNz/dd3u52BxgVu7kwKCLcggmock2wkDH+Bm28oZxAIHandZuFo7S2cdJjaXfsn1VAGnymOMyhX0g4Qmg+gjGysLLEC/i09qQS+wczHLIKn+sVYSr697B0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOVP265MB8855.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:48a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Sat, 4 Apr
 2026 21:23:32 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9769.016; Sat, 4 Apr 2026
 21:23:32 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 Apr 2026 22:23:31 +0100
Message-Id: <DHKOQBER5U5N.IHLHH5ORAZCQ@garyguo.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, <linux-kernel@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <driver-core@lists.linux.dev>
Subject: Re: [PATCH] rust: ACPI: fix missing match data for PRP0001
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Markus Probst"
 <markus.probst@posteo.de>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>
X-Mailer: aerc 0.21.0
References: <20260401-rust_acpi_prp0001-v1-1-f6a4d2ef9244@posteo.de>
 <2026040124-unbolted-timing-ce25@gregkh>
 <565d58a4b766bd4a63a45da81849ea178dce5f63.camel@posteo.de>
 <DHI5Y6PNVJSJ.SCAJL0A4W2TR@kernel.org>
In-Reply-To: <DHI5Y6PNVJSJ.SCAJL0A4W2TR@kernel.org>
X-ClientProxiedBy: LO4P123CA0599.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::11) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOVP265MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b34015d-f73d-41e4-2546-08de92906c21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	T+9gUiAFGSlqto09OdeJBcb3BTZyWix40GlkoU0gkRP2VhLlXFYf1brW69KWEzaTzcXC+rYL+HqhN329yIKemAvBqScnezEBemVK5vFYkj/Jdz9ehvU+6FiRpwG6QKYJbzrMqkUSCGZGI+90PyzKBViTRZwpdDNGEI+uegCGE13MuE5gHyvl8mhgPPTLUOIcb4dkdkUQDRhalzFMGP9e/uiKQzBsTDsszusP9QBfKAzGdJVMva+bUx419FennfFWHvg/yGH543VlXMGrHQRSOPEZuigpqW2HG1jhVMBa1HSvvWdZBwsYPoHCtaak9Yco6dAkernDd2tKp2LFLkDt/EDv9ln+nwj8a8A3gaZDYcW3rdIK+uaOyQ8U+XFbHi2uycuP9pOhc99Hf6Z3GY+D2TBH8BSStpX3vzkhxenhyjSCK28zyrQBYZlic9dHJbQ5ZEuIQQTFcuoOQkVe4annb9q3IH/1B7BIMaDNsMkymljLBFEpvSFKCD/WB0YugtZMCWhJotLC6riQAFddh0N/pIl41EaqhP1SdkkpCOmRhy0vUaPuuhr/TOkDptfktA8xZTOQrY6BvK4VmfMF9A/vZeuGT/9smerq3m8D9sqW6Qg9oexHpeXhiMwPV9e1U3egRS0eNagBMljsE7AmLbXtjMBpaLm0hiNE0GanFUeX1miRUWHguZTjEWXGhUUnn4D7nLeMPvXbHOQUfR3f4OrYYu43kum/xj697s1/1nxBH3c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVp3QWI5RHJtTXhnRDQyWmhpbE5YeUkzU2hmOTBnNkg2Z1FYK213V21McGFo?=
 =?utf-8?B?akhjRVpLZjZkQ0djbExjSFJMM2pKOHFkN0JoTWxKbjFvemRKRmdVOUl1cVFD?=
 =?utf-8?B?NWRVKzJKdS9xelF0c1kwR1BCNVNMdks3Z203L2c5djdEVUkxeEZFSDFYQkh5?=
 =?utf-8?B?RDRvbmZ2clV0ajBENkhQbkZoQWdXbnlnNG5FTkx2V2J5dVE1ZWhyOU1nVVB0?=
 =?utf-8?B?QTJjRnEraFFWWlNvSGRacG5HK2k4ZkpHbXN1bUtyVnY2d0pSQWRrN2FHS085?=
 =?utf-8?B?ckVIK3BSN0FndGxpQjFqWnBHRUJmNmsvOXg4ZmJJNGhyVTZDVnV5bmp4UUdY?=
 =?utf-8?B?YnhmSkhwelFNT21tei9PODdIV3ErZHpuaXBaTVpneDJIRCs5U2d3VTVBTkQ3?=
 =?utf-8?B?UXdsK0E4ZjRlVk5jN3VTUC8wM1VJZ2Rod2t4NVFjK3dLREF4bXJNS0RLckdk?=
 =?utf-8?B?VHFxR1JWL3NoMnZIOFhxb1RHa0RGYkhBaUFvb1VTeFFucVpoTTA5QXdHSU43?=
 =?utf-8?B?dmNqNzBhdWVyTTNQWSsrd1c5ZXZ5ejFNemQwSEpTczFTVkEyYmZXVUx2Uiti?=
 =?utf-8?B?Smk3c0VabGNRZWZudjk5YnVOZzBzeEpDQURkVm1GeG9CVDRaSE03ZFJOY1Rl?=
 =?utf-8?B?RVlkQ3FUakZFNldkMXQzT1pRcFlqdFZUODlHc1NhZGdnSTF5VkNtQk9lZnFC?=
 =?utf-8?B?ZnlmN2FydGcrTktBRkJYR25oeUEwSEZveXN6UmhjWWJnazl0MjBqaTdNZXBq?=
 =?utf-8?B?bk8yUzBBZmNRZDZyWUo1UXozYlRUenhWRFY1ckNyRElaSzB0RlNhelAxVXRD?=
 =?utf-8?B?RSsrODA0cndQaTRGYkI3dG9OOFpCcjgyZXlMNlRZK1RwV0MrZFZxVVpzamRy?=
 =?utf-8?B?Tjk1SGxtcW11V0h4aDRNOTlXeXFBYVpmWXMwVUdmT2ZWNEVsYXlzWDRsMFBZ?=
 =?utf-8?B?RnNaMUlDdk93SEJ1cHFlNG82ZkFsM2lkSHBFTUlIYlhwTjFRK2tjVHBmSzA2?=
 =?utf-8?B?ZGxUZGhXb1ZsZE1HdGVadUwwV2lGU2J1aDlrTGlQUHFqQk4wMHI2MXRLdkRw?=
 =?utf-8?B?N3ljKzFhTXI3d2lRTDdIc3A3V2dyd0tiNWkxeVVOOFU0ajNMU3dDYjVqdlJl?=
 =?utf-8?B?OXFtM1BFaStjQmtjT3NwTVlvOEl1QmVkaGZSS2JnUXJEMXVWNERJMm1nQ1hT?=
 =?utf-8?B?akhDV1lIRzRkWGZ3RUpsVUJoR2hTZmpEbWZaa2EyMXFjUlhVQmM3YkNJeGFW?=
 =?utf-8?B?REZVWmJWdlJPdHlPdktrYS9GU3BTTUJLQkl2OGRpQkRTZldUN2ZyVHRGMXFq?=
 =?utf-8?B?QnZTSy9Fd2d3NlNDVno5clVyMU9OemlwWkcra2dqUVo2SXlEVnJqUnVjSGZq?=
 =?utf-8?B?SEpaRDVISi9wbGpMY0dzdWd1VGlST0R0UjVXR0hzalptWWJyMGNnL0tIVmtK?=
 =?utf-8?B?aURac0JQZDBzSlR6bnVWd0tCNDZmaFFHNTkrNGRsNXFsNWltNW9jKzBoRG1M?=
 =?utf-8?B?dEcxamFIRlM0QnF4QS96RkxoaTA3NFlyYjZqbmhwRURBaUNYdUppdEY0V1RY?=
 =?utf-8?B?RXlJQWdFR0xVekpVUzFQOGRpTW5NaTc5bEFYWFQ3Z3UrdW15Wk5GMEZhc3VZ?=
 =?utf-8?B?ZEFmWGVFa2s4N1QvYnEvR2NxSERpZlU0TUt6azkrcjRwT083VC9yWW5DUTFz?=
 =?utf-8?B?bjZobmt1NTV5TVpLaFhMeGJFaDlCZEVPdHBycExGNjVIUXVTNHpxL21SdU8v?=
 =?utf-8?B?OEc4S1VpbHJNS2NNWmlNY2FOYlloc2xMYTVqT1BhVU9WQ1FiZWdQV0NZSVky?=
 =?utf-8?B?bUg0YW5lRzNVVjJnQjcwMTZqK2FuWDlSOWIyM2FZOUxMaHQ4WEFQQWFaVy91?=
 =?utf-8?B?dGFLMUFSVGMxU2dza3AvMjFjaTFVNEJuTlpLa3U2MTd0akh4WUVBbjk5VWNy?=
 =?utf-8?B?dGRNTzdoTFRwWm90dk9nNWJpeWwrTHU1bEhBUnhpSXFVRWJHUXBaVERrdEpp?=
 =?utf-8?B?aUdXZytrUHFiVWZIQ2wvTWJZME9UL0NtWU1CMDdiM0tvdzFZWDZzSGNzZ0RC?=
 =?utf-8?B?TnUyeC8vYm5GY0E5SjBpWXl3WVRyUGVlUnBWTVpueGl3WFZUR0pVKzF4SlMz?=
 =?utf-8?B?RmZ2RExFcXpycmtIUllER0pwTlpHK0R0aktsSlk2TnBrV1pOV3NqVFdmdlNV?=
 =?utf-8?B?OEdEK3hTb0lkUHpVd3RJVndUek1KdHdpTUc4S1ZJcTgrTXpidUlLeFVvYlhI?=
 =?utf-8?B?MkZLNGk5Z2Z2Q2hVaEYwVGxjRVk5eVl0L1NvTkMxR1o5WklOdG8veFNDMXBa?=
 =?utf-8?B?WGlYWnNjc29FYmpPMnpxejdaWFhYTFJwS3dSN040OW9ka1FpcEp2dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b34015d-f73d-41e4-2546-08de92906c21
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2026 21:23:32.0982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UvZCvzpUCrRaCPj0vn8aKgfTWTWpfR0hQ4ooFKr1D3SMa7uGz7QDG3MzLenG+Q422+NHqlhEdkeBj8BNsGU8cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOVP265MB8855

On Wed Apr 1, 2026 at 11:15 PM BST, Danilo Krummrich wrote:
> On Wed Apr 1, 2026 at 8:46 PM CEST, Markus Probst wrote:
>> On Wed, 2026-04-01 at 20:32 +0200, Greg Kroah-Hartman wrote:
>>> On Wed, Apr 01, 2026 at 02:06:25PM +0000, Markus Probst wrote:
>>> > Export `acpi_of_match_device` function and use it to match the of dev=
ice
>>> > table against ACPI PRP0001 in Rust.
>>> >=20
>>> > This fixes id_info being None on ACPI PRP0001 devices.
>>> >=20
>>> > Using `device_get_match_data` is not possible, because Rust stores an
>>> > index in the of device id instead of a data pointer.
>>>=20
>>> I'm confused, why are we open-coding this in the rust layer?  What do w=
e
>>> need to change in the C side to make both layers be able to call the
>>> same function instead?
>> No commit message I have seen has explained why it was done this way. I
>> don't think we would need to change anything on the C side.
>
> The Rust code stores an index into the array the contains the actual devi=
ce ID
> info in the driver_data field of a device ID instead of a raw pointer to =
the
> device ID info.
>
> The reason for this is that it was the only way to build this in a way th=
at
> results in an API that is convinient and obvious to use for drivers when
> declaring the device ID table, can be evaluated in const context (i.e. at
> compile time), and does not rely on unstable language features. Fulfillin=
g all
> three of those requirements at the same was a rather tricky one.
>
> The unfortunate consequence is that device_get_match_data() does not give=
 us a
> pointer to the actual device ID info, but it gives us the index of the de=
vice ID
> info in the device ID table.
>
> The problem is that this does not really help, because now we know the in=
dex,
> but not which table it belongs to.
>
> I.e. we wouldn't know whether to call
>
> 	Self::acpi_id_table().info(index)
>
> or
>
> 	Self::of_id_table().info(index)
>
> to obtain the actual device ID info.
>
> So, unfortunately, I think we have to open code this for now.
>
> But I think this is still a minor inconvinience for being able to fulfill=
 the
> requirements mentioned above.

I think there might be a chance that we can use const_refs_to_static to act=
ually
put pointer there. Of course, doing so is probably still quite tricky with
feature support given all const generics hackery that we're doing :)

I might have a go when I have time.

BTW, if most drivers use driver_data of ID as pointers, why is it defined a=
s
kernel_ulong_t instead of just `void*`?

Best,
Gary
