Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319057;
	b=YqgW21YlVco/AVNwk5xKVofiKOhXy9ZXmsuFAWdpyypY2d/tVl/JKqb2YSNuWGQRgTte
	 5lZwfdjxJFZ9zPBgMcEugbh4k/LbQmc+CtAT/iZuysvGkl9eXQWq8kPeOY16OzLLtY0Dq
	 ew5va/3mesrvEt04Fk0S/jzGGRgM1t2vzEhm4DkoHiE5+PDcSFv7XfhTDLvFwyzHl+Mxn
	 uqmaylFLVGIuojKn1tMQsHvD3jQrN91yQniszKghZ/S0rMHwQrAJZwe/w6ElnDzERdDOo
	 KVA9WdzK+beovKa3He35ZOA7iYKrgV0RTrawZ9oXTi7Q5g4SFVpH4NxUNXOo9JrNJYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319057;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=Mq25EesGHdSDvdRAKvduNtB0omKh6pT/kgafQ6gJ4+0=;
	b=A/XnDSB6gBPfWm4+sKpAxpYmjf9OUZVdyvuye3bMflPqXhbQUl10fq1/2Z5uqNAuKehU
	 0QkcgYJM1r0oZoRgUXPQrymgfHdMEbp4BGJZLmhLtQdlqSAD+q7+GXWeWDVVkeDAGPod8
	 dNDmjdK8eIXvCcbd5dVejUKHnrFNaO/e5X9/S3ATwz74GjtrQBJK00GPB9gxpH53M34qA
	 R/wLtm7+4s49whL7t56yo8VRzKMoXSwR6fLK4hj7bpLz5R/Rf57ugE0/T439kH85z3PRA
	 bZLQO64f5J/QautcM6E6X95KwOucrBcnoe6m7cPWONc5yBKtEBiYoyo6LclIofagJqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=QtMhDcDp;
	arc=none smtp.remote-ip=212.227.15.18
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20BF606A331
	for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 13:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E20BF606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=QtMhDcDp
DKIM2-Signature:  i=1; m=1; t=1794319055;
 mf=PFdfQXJtaW5AZ214LmRlPg==;
 rt=PGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnPg==;
 d=gmx.de;
 s=s31663417:rsa-sha256:uPoAZC999ZrXSw0ExBGfOcQHQxsv
   cTPE51WL3SmVJGAlhEg2/avrGLLphWChaNh6/7xOVzTpmsHA6KX+ByXU8MNQ3cr4GyLQcChfhOK
   YW6sZD+ErjSMFUcXWM9YktDUxYCcKCuob7HDj4FsJCtZGTVZ9eyvOjJfgP0g++dp3oahwuuA1Xz
   G2JVpXDPI1t/vt77P0qpM78v7n+OI/QTzhnUDP6uCiwOs3q87sDVUjKcRX9zYVJh3BLaIdcUOOv
   2Y9nUD37WGdjQ50NJlf4WeRWNqWVQZy8hrsmxpVYtOw9FGE+Fe2rMbwHURCtiF1uo3UbIKi1q4v
   tZ7OidWTZBIoMw==;
Message-Instance:  m=1;
 h=sha256:
   5rSfgRbRmpM0vlauUCpxc3ym9Qs92dcHC6wOpjI8sw4=:
   mm6LTbu2iqKJ78/a/7YZN9S25zLRLJaQ0dBX12zimdM=,
  sha512:
   p5BwSyAeydnBDQcRwbjTmVnnRH8MbS97tEMG7T2ZzoRGoL5m/d7bLfu06R5Hwj5KNtfaKrQuZMYykvQARY1ADQ==:
   UPGe+1eDquzukCoKYBMpkPlTIMWzzeLYPdUPwHx6AwYR3iCEzXJL/o5AwwxN5ngFGzHc2e4Pxxt8j1l66BYGBA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1794319038; x=1794923838; i=w_armin@gmx.de;
	bh=Mq25EesGHdSDvdRAKvduNtB0omKh6pT/kgafQ6gJ4+0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QtMhDcDpqIPcUdQHW2VIkD/QucuB8VUP8nIxCamTpEdffrFcozzeaON6f7QfdxRW
	 0MUbuyE9zbrAVBVShqE7Id9lcMTO5jUomVw9+G3pMr73lqxPhAYN9CDNbcOCSypkZ
	 p6ziGul68jYU1K1/i9dr7GKe3Wkl8e7sSonLkaNI1SaaypGfb+2LA/s+uuIA+V9jo
	 EyxTNT/6xO/Z1RgO7mgCEPFax1BDrnGD795d5Nq/CfjDyOqgNoXT0DWbsz5XAnWYL
	 iVAugx3Aj5rUw0RPcpaUUm/eEBd0GYJoexgJIMzADLOFMjmVpHIlj3fKFH9lkLN70
	 yWQB2H3oAZ2gFRFB1g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MK3Rs-1xC0eG0ny2-00NOfb; Tue, 10
 Nov 2026 14:57:18 +0100
Message-ID: <c9a078c9-3b95-47ce-86b1-feefe65a6eaf@gmx.de>
Date: Tue, 10 Nov 2026 14:57:13 +0100
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/wmi: Allow consumers to load without ACPI
To: Han Gao <gaohan@iscas.ac.cn>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org,
 linux-riscv@lists.infradead.org, Han Gao <rabenda.cn@gmail.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261110-wmi-no-acpi-v1-1-eebea07db551@iscas.ac.cn>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20261110-wmi-no-acpi-v1-1-eebea07db551@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oTXUkEmC82rgOxf8k6hJrCTk1/JqzAPEPzp4/DHKOg3zKL1Aczg
 9LNKhQMn4EIBT1lkRc19dLharPUXZZ0Kxp/mSJBSvbjxcRLNzvlI4gG0xzizeZ/SKmy+hB+
 rKnkdvLRECXuAPu572zqjM/GwEPfUTJ9Lw6EAOsd7GZzTLFsYOJoecYOZEYq+XPzM0jGUUt
 nRi+4mUo/ti6E46OAzB1A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9tvIdMPT/+k=;TymbxhA/EOKBRYcRu7x+da1CDaV
 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
 hmGT+e66htF78w

Am 10.11.26 um 14:43 schrieb Han Gao:
> Since commit 4ea18e604272 ("ACPI: video: Remove CONFIG_X86 handling from
> nvidia_wmi_ec_supported()"), the ACPI video module uses WMI on all
> architectures. When ACPI is disabled, e.g. on a devicetree boot,
> acpi_wmi_init() returns -ENODEV, so the wmi module fails to load and so
> do video, amdgpu and radeon, which depend on it.
>=20
> Return 0 without registering the WMI bus instead. The exported helpers
> then report that no WMI device exists. Skip the teardown on module exit
> accordingly.

AFAIK wmi_find_device_by_guid() requires that the WMI bus type is=20
initialized, so we should not skip bus_register(). I wonder whether we=20
really need to check acpi_disabled after all, because the platform=20
driver will not bind anyway if ACPI support is disabled.

Thanks,
Armin Wolf

> Fixes: 4ea18e604272 ("ACPI: video: Remove CONFIG_X86 handling from nvidi=
a_wmi_ec_supported()")
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> ---
> Tested on a HiFive Premier P550 booted with devicetree and an RX550,
> with ACPI_WMI, ACPI_VIDEO and DRM_AMDGPU built as modules. Without
> this patch, wmi fails to load and so do video and amdgpu. With it,
> wmi, video and amdgpu load and the RX550 is initialized.
> ---
>   drivers/platform/wmi/core.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/wmi/core.c b/drivers/platform/wmi/core.c
> index a99da9b7039d787ce3c1e0ece74ffbd79fafd3f7..6668789904a903c8d4e78109=
76f4e485d7a1b32a 100644
> --- a/drivers/platform/wmi/core.c
> +++ b/drivers/platform/wmi/core.c
> @@ -1598,8 +1598,9 @@ static int __init acpi_wmi_init(void)
>   {
>   	int error;
>  =20
> +	/* ACPI video still needs the exported helpers when ACPI is disabled. =
*/
>   	if (acpi_disabled)
> -		return -ENODEV;
> +		return 0;
>  =20
>   	error =3D class_register(&wmi_bus_class);
>   	if (error)
> @@ -1628,6 +1629,9 @@ static int __init acpi_wmi_init(void)
>  =20
>   static void __exit acpi_wmi_exit(void)
>   {
> +	if (acpi_disabled)
> +		return;
> +
>   	platform_driver_unregister(&acpi_wmi_driver);
>   	bus_unregister(&wmi_bus_type);
>   	class_unregister(&wmi_bus_class);
>=20
> ---
> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
> change-id: 20261110-wmi-no-acpi-159a4cf19580
>=20
> Best regards,

