Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022140.outbound.protection.outlook.com [52.101.96.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3A1366070;
	Sat,  4 Apr 2026 22:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775340508; cv=fail; b=UdhboMT4JFMyWOKirybuapSibub1BTndYEXyB1OoOinFo1XoD7yPH/0Hl4Nu/QpPKhDpHWX/SzK2KOdxMCjUM/9SAa2qgbI7SqFiwPxKMc788TxGUWG6bh2/ALWe1CO1xmRMm4JvpV6ZhZYzwNEp6C+78JRiNniNQ0fKTscS3f4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775340508; c=relaxed/simple;
	bh=r/7IwSlvSWCnJelmS/bgkk5sNOmbtuLWnamVd276e3U=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=ekPz5oQZ8zSgzbZyFTLNq6978JmZICKP08qoTt87MKK0kls6kaqxdUXCdLoOFdKoG7hZnqftiVMLW+UkHu4v1w6OmIqZVLYAOuk3PjDJ6coBqdsadMU3r0qYW6z3xnwdf7yBcbKu/oNdznUOnladWFix+EdohuvpLsDftFAodf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=wsTEHPuP; arc=fail smtp.client-ip=52.101.96.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="wsTEHPuP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4vaidiz5BMQiCOvxEgKwrTrEW9JDeilppKszWqOishfbTX0/IQqPI/oUtrSsMQBFlPZmzEX19lnR+CkPKurXoDx+a+rGekgNR9Qmk9YTPlPrBLKaNAbasDQBTQ4BfNHrkJJIzjAVRjki/Rknjw4guohnNU3y2a9dKTogB74fPbHTyeK18degWlGjBLyBpuSsFj2kmstFiohfu7HT6WNG3/WRq6J5I75FoDnmndhpI+kMQxXMkl19JwmikYn+PqHQbeBnFWSxtx5smQh3h7NE5nFpmDiQR5moa2zB8VWVmR/COr9v/zJb/hdGuCsh+WREVvhHNinh1iEREFqLCa46A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/7IwSlvSWCnJelmS/bgkk5sNOmbtuLWnamVd276e3U=;
 b=BHb03TV/XfSh3ehjuwmF8PV3lD/k/ySCFwAjSmqtT6+MUfjLonle06luE7rY9yp0jr1+aWtkOcSM+JfUODfRshZIDIwRQ6yUXZ/ckmWcW1vNUc/xb6kuQ1yVLIO+cgq147iSB4tuJRfrQ9MuGlIm6Ey4KPnW5+Pz1t1jc/ciAHnK+WGcsFvrBaNC00/iHzG6EOCgWb39fZpf7Ca3obS5zlh2adBsp13U0P7r/3BSnPgwobhbTsZ40YPPc9vxzzGUAPdEosGA//lgKIYj7gdHv94sNwv1eN4vJ5OqH0XtnQyaXw8Ej/XHAigg58fZoq5UvZEEsyr9ZkegTV6sFRvWvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/7IwSlvSWCnJelmS/bgkk5sNOmbtuLWnamVd276e3U=;
 b=wsTEHPuPQNOYwzO/bSl0T/7ABmNEtjFroSrOk6g7K2ayNDCDnmmc9u44NKpmNsELMqnUZZzh8BRPHOWRZPLca/YD9XjTd1zdovDRTQIeHBpYX9X7sSow6aR6jrKnVTLrn4C2433Mt4EItw0KaM69BB8Gfs7jVnV2u7mECpLTu+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB7175.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:335::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Sat, 4 Apr
 2026 22:08:24 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9769.016; Sat, 4 Apr 2026
 22:08:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 Apr 2026 23:08:23 +0100
Message-Id: <DHKPOO58D4U3.TYXAM7ANQ4UO@garyguo.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <driver-core@lists.linux.dev>
Subject: Re: [PATCH] rust: ACPI: fix missing match data for PRP0001
From: "Gary Guo" <gary@garyguo.net>
To: "Markus Probst" <markus.probst@posteo.de>, "Gary Guo"
 <gary@garyguo.net>, "Danilo Krummrich" <dakr@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
X-Mailer: aerc 0.21.0
References: <20260401-rust_acpi_prp0001-v1-1-f6a4d2ef9244@posteo.de>
 <2026040124-unbolted-timing-ce25@gregkh>
 <565d58a4b766bd4a63a45da81849ea178dce5f63.camel@posteo.de>
 <DHI5Y6PNVJSJ.SCAJL0A4W2TR@kernel.org>
 <DHKOQBER5U5N.IHLHH5ORAZCQ@garyguo.net>
 <398ba2627148b9224ed41d383c906ca23427986f.camel@posteo.de>
In-Reply-To: <398ba2627148b9224ed41d383c906ca23427986f.camel@posteo.de>
X-ClientProxiedBy: LNXP265CA0055.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::19) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB7175:EE_
X-MS-Office365-Filtering-Correlation-Id: e67cf40e-7b29-4d83-84a5-08de9296b0c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6yqiTFFHwau0J5SXZD+9BzTHq9RtL5PK0bbRDldIJLi9B6eGbVRpFdO5HDPjOCmvKZWQa3VxkUJ7fku6SjnIG26kWlv2uikcMsoGEF8UpEipeHmwnNwsNuK4oEZUVF+zDfPoGD+f29I1NhcPJp8t9GiRGDm9ouJe2ZCU0d7k9529GMrCgJ/fCmULk5eUFmKSfplvARa4HNmoG5ikxy67IuF2iTGZZ234b0x3WMmKXhqpPsveyMEEvOYLmj0KBpufat3C51FxXZxwL8TsWht/XLVGUwX+JJnpcK4zNAVQuWLvaVZpW6akTaa4BdQ4XHM4lT4JwnLRSqPwT8IscnLd68TlKzE++zhwFjyJmMaBo3h3UEliT1msXf3ycybld6J30oFs6swg3Mrlc+sXg+i1aMtpkvUoSNqUkyxjQddmU5MlZj173TU5mGGS0wO9VyVIbYOl5pc3rvnaZsmFBUlGlfR6sYtzKVGnBuLib+E6yZihR2lEAUyadUyMqTsXYown7hgjo0FqskAz8Q0QIxsDFpPeY5gdQZCtEDGSuHgGlwV+xk3vsj2qVTyU4NfB5H6eXT6acl7fAJgbIbSin7ytp8dXlW8bCwnflUlmkImVFblxI07Ol7KRVdnZuQ4fFpDG46IJW7BNGPr/vI4KGijjLng4n64QOxgeAroQU6ON9T3NLDXWjZ7eqRDM4fZ+ldPYNfJy8NZSsPYpx3rFzhHZ9+us6gOf2S4ZsZS2XDubKHA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnpZdiswOXdSQWtESVd4bHN4b0lYL0g1MjJGM05UVy9SQnNBYjEzQ291MWov?=
 =?utf-8?B?eTNzTGZXVitIaGdrV2UvUWh5dXZ0cjlGekFsc2QzSkszOUJETW1yU2lLTWt3?=
 =?utf-8?B?dUR0TWpHcjE4TVlDcDlsbGZtaFc3Y28zNmdZazhIU0N1SDhRVjZVb0k0Y0JI?=
 =?utf-8?B?SFBuNVh4WlJEcEtqZHdMVEI5SS9KcGlHNEwvUHJPd05PRzRpdVp6cGlKQmZh?=
 =?utf-8?B?cStMNlVWRXU1QXNlQ1FZZU5pbkZqckQwd0dLc3UwdE5IZU5PTXBtZG1YUGdv?=
 =?utf-8?B?cC9VempOZUxJYmdxUG90bjJSZXJvWFE4RWZuK1dhK2JtUi9rUHlmVEFpNStN?=
 =?utf-8?B?ZkNXdXhPMkVSdFNmanArUHRhK29NcWN5K1RESDdiWXcyOHU2bWkwWGdBWXdV?=
 =?utf-8?B?TWY3S0JBSDlBdExTWUptWHJUdTJKbm5FaHE5ZnJYOFNwMWxCNy9aRTdBdVpn?=
 =?utf-8?B?NU9SVlZQSWxESXN2L1ZiZG1OMnhQUmJBaHFlMWVvZk9NZkhSY2dWY2xSK3Zt?=
 =?utf-8?B?Qi9LNis0OUs2V3pwVUdsUVgzVUgrOTJOdHRnTDk5SGpYSEZ6WGRhek9DWERr?=
 =?utf-8?B?WEJyNXUrOFJST1pmYkg1ZDdBZjhGV0dGRHhEcEJVb1ZiMVFSR0tDTTR2SVBN?=
 =?utf-8?B?UVZxaEdQeFQrMlJNQjZmRDBMYWpUdS85QU9TcFBmV3RDOU9USWpBekVzZE1R?=
 =?utf-8?B?cHpFM0pzdEpIMkNlZDl1bzBtWnFMS3Y2czI3MXQwb1lnL011MmxsSXRSVHVr?=
 =?utf-8?B?Vk95NEd0L1MzQ1BodjNTQ3dabWZ5bWZSRTFsd29Fc0RLNVFBZ1pvcW9Db0NT?=
 =?utf-8?B?OXB4bGpCK2hzZWZVNFNvOVdNelVxQTByd1FYVjY1M2kxaW9GNWNHVHdGcmFR?=
 =?utf-8?B?MDQ3YVR3bS9QV0RiSk1Hb2RMbldwMlRBekM0OUhvcnM4L2p2WDJXZkUxaEU3?=
 =?utf-8?B?VHd3Nks2SmptM3dSbnJlZ24zempkREZ1YXBUc2xKMUZMeU9yK1ZBaVdGRkpM?=
 =?utf-8?B?ZURrUDlrOWtkTTk2YnlCVnlsN2xKR3ZGc0twbHVlN0x3YTVkb0dmT1ZUWW9I?=
 =?utf-8?B?eTJpQlIvRDgvUVNoR0ZLVm5MWlNVbDNBMEloYlV3MGZhWmQ5TXFneVQ0L3FF?=
 =?utf-8?B?TTZuZys2ZnN1c3BScFFBbEoyTVZGeGsxQkRvUTVUVndvdDdUQUhrQ2RicUty?=
 =?utf-8?B?ZXJVMmVVV1NKdG5JUVlMdkxwYmpwQTI1N2I0NlBBR29UdHJQZm9pVzhmTGFE?=
 =?utf-8?B?KzdEbnRLeHphbjZZamEvNzVPdld5RnJJVEw3TktSVm9pMlIvUHh3ejRxT2pC?=
 =?utf-8?B?aThMY21LTHlGUGFaYkFuSFA4NldKYTF1ekZzOTFkRys3MFZkUisrdllVZ1pO?=
 =?utf-8?B?dFByb1NxZkN5RnVRNEROY2hUMDZibmxaT0NlbmVHdUJRbTk3bngzYTBySmNw?=
 =?utf-8?B?dWY3c3RNd1pvNVpYeXUrak03OTBydTFmVU1obERobDkrLzRONjVWNlZ3N1E0?=
 =?utf-8?B?SEdIUW1SM2ZEUml5ekUrU3hIem1HM1NtZmVmcjdDZ3J2cHdpTjhGcDVEZjll?=
 =?utf-8?B?ZlBLczFvVXpKb1hIZHZvNS95dFRTbWNtZWsxOUNtWEQ1QmxERThxSUMweG5N?=
 =?utf-8?B?Sk9IMytnSDNkOTlRdFlpaGZuK25mR01aeUl5RmNpYlQ4ekhYYlBmOFh6K0tQ?=
 =?utf-8?B?eFJzNHdGaGplS0tIWWlYZERNZ0lhRWNRU1NLSmpEb3duYXkwUUM2UWZma1V5?=
 =?utf-8?B?azFuVDlLT1JzZG1LY29Kd2ZpbGdhbXF3RTkyemx3Q2tQSnZpZUgvUGZDaU5p?=
 =?utf-8?B?SjZ0aFBKSzNwbGI5V0JUT09ZR1VBWmJJSTVBK21MeGpsZmJZeWduZ0xmVGhN?=
 =?utf-8?B?Z3pRaVNBL0EzSzNOOVlZSmxiRHc1WVdCWU11bURmdkJtMEZzYzhlc2M2SDVh?=
 =?utf-8?B?a3BQc0ZlOWhWdG1XOXQrd1ZWMEk0a3ZaS1VBMUZrb1g1eWZJSytpWklWemsr?=
 =?utf-8?B?N0xtZkFsQ2tUT3dWamlkZHNlVk1FbEFQaG9xSWFLZDNSeDZjSWVwaXB2Z2lm?=
 =?utf-8?B?U3hmUCs5c0Jod3NwWCtIbDlOa3V5OVlKNjhTSXF2aHMwTTJKN3EvR3NZMHg2?=
 =?utf-8?B?NlYzZDBORFJhUEdqNUlDVU9xN0xnN2VMaUxiOWNzLzRucUFPSGdqRlByV3g2?=
 =?utf-8?B?aWZ5S3FsbTV1cnBONDNUZ0RsZGVmR1lZa1ZxRkZ0OFlnOTA2cGtubXR6WCt4?=
 =?utf-8?B?elpyVnpYc09xYm9TL0gwcEdtS05NYkpncjBxSGJNOFJtaHhjRXRTZHFheWVw?=
 =?utf-8?B?VGs0M3RJSHNhYnBoR2t4Tit5QWMzZDYxOW9ac2luZzZGS24zbWlHZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e67cf40e-7b29-4d83-84a5-08de9296b0c3
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2026 22:08:24.2126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tl2buxRUahXat/UySdMLUIf8oulhldAVPgVe8udv6ZIQ68aFHYgrbB0aZseDqdH1O0E7aNjDrVYY64dvbF9sRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB7175

On Sat Apr 4, 2026 at 10:33 PM BST, Markus Probst wrote:
> On Sat, 2026-04-04 at 22:23 +0100, Gary Guo wrote:
>> BTW, if most drivers use driver_data of ID as pointers, why is it define=
d as
>> kernel_ulong_t instead of just `void*`?
>
> The return type of `device_get_match_data` is `const void *`.
> `of_device_id->data` has type `const void *`.
> `acpi_device_id->driver_data` and `pci_device_id->driver_data` has type
> kernel_ulong_t.
>
> Kernel doc of pci_device_id:
> "
> Data private to the driver.
> Most drivers don't need to use driver_data field.
> Best practice is to use driver_data as an index
> into a static list of equivalent device types,
> instead of using it as a pointer.
> "
> suggests it was intended for use as index in the first place.
>
> Thanks
> - Markus Probst

I would have believed it if I haven't seen a huge number of drivers just us=
ing
pointers and do a cast :)
of_device_id/dmi_system_id is also just using void* for its driver_data.

I mean, blaming through git history it looks like this documentation predat=
es
git, so I'm not really sure how relevant this still is.

Best,
Gary
