Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693916;
	b=ul7QPg8SQVsgQtQH7aYmPCcNGFItw3eL/GH7EdNa1pPdRQZLInasN+d0I5Sk5XCTCcjQ
	 LIFuNjyKB5ViuVsTWHs7FGc1hl1TbhBSKblVzA8as3TDYTVhLzh4Tnvwraur0ZPhBhYLx
	 c7A46RwiwAyflJKzuZX4dam4MAoDjNLBvyHUuSK+D/ELG6zHF84rC2PCE4uj2rcSmzc+x
	 PAaayJULhr2TK9/LLO2AglmhWuXSvgRv/kfFOGCbcAVq/zcOy21/2nhHuoYokqHnvRW/j
	 XKF1KQh1Rrw4b8npIOPqtVMTP9RI0vU8GAf2/7LMCmG/NyYyZ3sSaXTZJzmtsz6QDjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693916;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=F5gjUXqfA53K2Tyu/zCKQdTU7AS+XZASEc1xXiZ2tb0=;
	b=pH9oXoHgDYjRcvoB+ApvSHIWkedantBf+MSe17OKt5lSGi5VACVAWQ7J1la+W6Gb5khD
	 gSZbEB37FnNkrh+J+SKc3WqoESZTY0fu+Q8eRcPxAaODC8qSlNqQrtgtf64IEi6Sn5s+6
	 shdlqI77X35Tym7QculuzPoB2o09FTVx2goIgfJYTU6YfCyCzuRrcHEWOPaIYwSGQeCeJ
	 CCMSbgFpqPhVvdBNcTP/SoNkQVfAfVyEKyF9EixlrrSo/MOn4ZkXJqlNnpcN896lu5YBL
	 7cZVEADDjcrTHfrLc6NC7JSFLPsnZUEyuGRBUQm4TfaxLz9AwEHjMSBHbPR2CpjjYfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Gm3ptCbl;
	arc=none smtp.remote-ip=212.227.15.19
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A0A606A904;
	Thu, 22 Oct 2026 18:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40A0A606A904
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Gm3ptCbl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1792693894; x=1793298694; i=w_armin@gmx.de;
	bh=F5gjUXqfA53K2Tyu/zCKQdTU7AS+XZASEc1xXiZ2tb0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Gm3ptCblNje/yHBNWzDw0CefLPK48RWpsw1V0+2AW6klIWuSl0iieTI5+ewgn0sT
	 BCyUmGvKXLiWF9DjYkNsyWeHuakRz6gMzlESR8hqrYyEiFmqAH2T2MZLjkTbx9GwG
	 y4nET/Vv4vehnV9IzjjjJww40SJrKXb0caFkdRAFSKOYUMx//h/ELb4plhw9tRrqi
	 WRXYzjwFt7I0gzZ07obAtbd+RsvzMlsvMF82GQPczfKDrphqmkcFMCB70YglVrGIv
	 jLj10eeXX8MQHCk844IVCpUwhKAswtFC+vxgB77iMK2ISDEmQgyUa8zo/BADeqIXk
	 3Mu43kmVRZJIFjBaJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeCpR-1wlicL21El-00ixXI; Thu, 22
 Oct 2026 20:31:34 +0200
Message-ID: <35c80ebb-fb5c-45cd-b6e9-d6b73e305432@gmx.de>
Date: Thu, 22 Oct 2026 20:31:32 +0200
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
Subject: Re: [PATCH 2/3] ACPI: fan: Ignore broken _FST on Samsung Galaxy Book
 930XDB
To: Leonard Lausen <leonard@lausen.nl>, linux-acpi@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 acpica-devel@lists.linux.dev, Len Brown <lenb@kernel.org>,
 Ivan Hu <ivan.hu@canonical.com>, Joshua Grisham <josh@joshuagrisham.com>,
 linux-kernel@vger.kernel.org
References: <20261019145421.47181-1-leonard@lausen.nl>
 <20261019145421.47181-3-leonard@lausen.nl>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20261019145421.47181-3-leonard@lausen.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8Ka9qePHNyy8t3GvtuWr3//mgXUjUPxOvCYAD/mYoqK8GgV/MRw
 1RXMcDaj6NQcscnvdRBdSXaCXEU5XsUHNhVfE0W9cprL7+rctpVPd/2lMFEjT6XAmmniAOq
 7qXCbAik0+CHehpXtbmmEpEOfbx5F/N+NECPstnkMz2EfjjJsRdIgbS5NEySmPYAjH1dvhv
 dhNC7nGCovCccRYVE0LYw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Vgv54VwXlIs=;RWxZKKcUNxYoeP9FhVz1Yo3LZyx
 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
 tpMffGpQWZg89LvZJQw==

Am 19.10.26 um 16:54 schrieb Leonard Lausen:
> FAN0._FST on the Samsung Galaxy Book 930XDB stores the reference
> returned by Index() in a local variable and passes that reference to
> Add(). ACPICA rejects the operand with AE_AML_OPERAND_TYPE when the fan
> is running. The zero-speed path does not execute the faulty Add() and
> can succeed.

This is very likely connected to=20
https://github.com/open-acpica/acpica/issues/908. The ACPI spec says=20
that Increment/Decrement is "Equivalent to Add (Addend, 1, Addend)", so=20
i suspect that Add() should try to automatically dereference the reference=
.

I would suggest that you report this issue to the ACPICA guys instead.

Thanks,
Armin Wolf

> The Microsoft fan extensions added a notification handler that evaluates
> _FST on each fan status change. On this machine, fan notifications now
> produce repeated ACPI errors, particularly around s2idle suspend/resume.
> Speed telemetry also fails whenever the faulty path is taken.
>=20
> Ignore _FST on this model. This skips the unusable speed telemetry and
> Microsoft notification handling while preserving the legacy firmware fan
> control. Match the vendor and full DMI product string,
> 930XDB/931XDB/930XDY. The firmware was inspected on BIOS
> P11RFX.067.230331.SP.
>=20
> Fixes: a5c2fcd82e04 ("ACPI: fan: Add support for Microsoft fan extension=
s")
> Signed-off-by: Leonard Lausen <leonard@lausen.nl>
> ---
>   drivers/acpi/fan_core.c | 31 +++++++++++++++++++++++++++----
>   1 file changed, 27 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
> index 624d0736b581..48a6818e6282 100644
> --- a/drivers/acpi/fan_core.c
> +++ b/drivers/acpi/fan_core.c
> @@ -8,6 +8,7 @@
>    */
>  =20
>   #include <linux/bits.h>
> +#include <linux/dmi.h>
>   #include <linux/kernel.h>
>   #include <linux/limits.h>
>   #include <linux/math.h>
> @@ -50,6 +51,24 @@ static const struct acpi_device_id fan_device_ids[] =
=3D {
>   };
>   MODULE_DEVICE_TABLE(acpi, fan_device_ids);
>  =20
> +/*
> + * The _FST method on these machines stores an Index() reference in a l=
ocal
> + * variable and then uses that reference as an Add() operand when the f=
an is
> + * running.  This aborts the method with AE_AML_OPERAND_TYPE.  The Micr=
osoft
> + * fan extensions install a notification handler that evaluates this br=
oken
> + * method on each fan status change, producing repeated ACPI errors.
> + */
> +static const struct dmi_system_id acpi_fan_broken_fst_dmi_table[] =3D {
> +	{
> +		.ident =3D "Samsung Galaxy Book 930XDB/931XDB/930XDY",
> +		.matches =3D {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "930XDB/931XDB/930XDY"),
> +		},
> +	},
> +	{}
> +};
> +
>   /* thermal cooling device callbacks */
>   static int fan_get_max_state(struct thermal_cooling_device *cdev, unsi=
gned long
>   			     *state)
> @@ -511,10 +530,14 @@ static int acpi_fan_probe(struct platform_device *=
pdev)
>   	platform_set_drvdata(pdev, fan);
>  =20
>   	if (acpi_has_method(device->handle, "_FST")) {
> -		fan->has_fst =3D true;
> -		fan->acpi4 =3D acpi_has_method(device->handle, "_FIF") &&
> -				acpi_has_method(device->handle, "_FPS") &&
> -				acpi_has_method(device->handle, "_FSL");
> +		if (dmi_check_system(acpi_fan_broken_fst_dmi_table)) {
> +			dev_warn(&pdev->dev, FW_BUG "Ignoring broken _FST method\n");
> +		} else {
> +			fan->has_fst =3D true;
> +			fan->acpi4 =3D acpi_has_method(device->handle, "_FIF") &&
> +					acpi_has_method(device->handle, "_FPS") &&
> +					acpi_has_method(device->handle, "_FSL");
> +		}
>   	}
>  =20
>   	if (fan->acpi4) {

