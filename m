Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445674;
	b=IpmYn0T71Nve7PTb8Zj2xcA4Y0Sl5ScuodRwl50+BCByLpoMaRkWO9BshMqsR7nChBJW
	 hMTckFDt+/jdPhtXYF6jJorYnfcWrLxiiRvsqlVqeETM8vU9ZbjZx70pYDoBXe2v5axzt
	 j6JEaVk71C+KNHaSmst91WCNfJUwgP2sMxljGdhfpeNCVsfAmkvoBdSzNFC8sW292VmOg
	 ryz2HL+cvIeJ3Sx4WTWwmFtt5Q6QOpguky9lDopAPVXnDMeZiLthVO26W6w/k2t39sTgB
	 K7ukHnBF+0XsTMGJbgC+Upf9W8uqL/yeuCNZ7DDDyRPqxC8XIq+Vf8nK5teZ828dRIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445674;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=BkdWKi37cNQtdND3czz3bHcTKvEyEK3UxzuEQK+SOCk=;
	b=RoGFabr6EP09lCj0SUNpKy86F/QOFKs24y7SCcQoWpdCLq7pybWVGjhcKu8ps4tcK67u
	 1pBcGdr/P4g8gNLHMUsnNahcw7JIoon8ZzDKq7k9xGkROTiqbE/rGGx/s1H8OKMw1Drz9
	 wClRpSN2VMQTeAcTD72SyKV3Htci4H9xP2juC8x4760kMyBxioMSmPWrDYYNxsqpEkf4u
	 BuEn9jzfpREZhJNTWduuuVZRvydQUJ9+jC+Aj/haCilyoDL02XGbEOUBYlHfdaHGgEUyq
	 pZR+inyuc6JGuIMBOuRNcahbBdQtYpfnDcSbvcvO9nrmYPimj+5lXdfJtgZnE0hynPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=HdNusHGw;
	arc=none smtp.remote-ip=212.227.15.18
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96236606A321
	for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 01:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96236606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=HdNusHGw
DKIM2-Signature:  i=1; m=1; t=1794445671;
 mf=PFdfQXJtaW5AZ214LmRlPg==;
 rt=PGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnPg==;
 d=gmx.de;
 s=s31663417:rsa-sha256:h4+ZQJarbMueJREC97dvAEpa35/4
   vGx8MeYnp0iRHyh5RVXJXWo7dJh1u7TjePBpUK/Xr+z1y8hl7OUVJXBR8jn0PCc2eO2VM+RcvHO
   tR3nnGsmJj++z0+atd5xpumuzq50Z4Uj+XqVe+qiue7hshbZnGDULIy3mopJoP8Mryd1BF93hCJ
   8xFAoUwMLwKP3nc+05MC60Vw+JMY24i0OXBPguiEVZ2gPeiEtZA0h4OmEQoHqeoHTlSisStNekG
   JROTVmAeG7QQLzlbZDXE0SfZagAO6ovOqEaQTkOPsgRIulQrPuaawldpoxWdpMGfGf3arr4i1tq
   rXIYUo/UzEH5ZQ==;
Message-Instance:  m=1;
 h=sha256:
   rc+Iq0T5tApvxLzSzkWc5oFIxOsCiCsstOmP4j7balg=:
   eu4gZ3uDQKSa4n0wG92y4Fr150IO/F8JML82px7DvQk=,
  sha512:
   k2xlbNuovF5uL9jiw5gwnk6EPeH98LxWn0z4tHz4U6MPcN+QNvn/VxQ53DOo2QMgDxCy0CFk1c3ITSOpfbeq2Q==:
   AO6xr5hKyccYgo3k0gFhbASVR23CMSrDd0eQuRq8Ben6s2W2HF5D19yzHtuYemcURW08ZIqoieQC7cV8ak5zlQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1794445660; x=1795050460; i=w_armin@gmx.de;
	bh=BkdWKi37cNQtdND3czz3bHcTKvEyEK3UxzuEQK+SOCk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HdNusHGwcxhZSeTkgZBrZgNxWeFDlDJxfX7Q+OXasDYAvYM08NMpzYL955cxfBM+
	 svqIkHeG/7sdMn0Y7AF8/T0dl7vBYclKIaLghEFolC9OWqQ7uAk/OorfYGug+jC2P
	 zzn4WbeGcB++1s4vINGofvcwLpW6nrLrn/jFr/hUGveONPTRCm2jxo7GpwUxv2Bp3
	 9g6pluluokc/f4SlNAGG4MkjYGey+DkjD1py89OBYVK+B0NJnUu76P6QchUuDorEA
	 isPopQFrd2d5VNSnJ51GvUFqgmNv4MzbTSSodCLldNLjeBgkCQpPEkyA8mM4cgf8c
	 BNUAcRAf1iT/ICv8OA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MplXz-1wfuBV2KQn-00iQEO; Thu, 12
 Nov 2026 02:07:40 +0100
Message-ID: <7614bfa8-4072-4695-81cc-ae3e95a7a7de@gmx.de>
Date: Thu, 12 Nov 2026 02:07:37 +0100
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
Subject: Re: [PATCH] platform/wmi: Allow wmi module to load when acpi_disabled
 is set
To: Hans de Goede <johannes.goede@oss.qualcomm.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, Han Gao
 <gaohan@iscas.ac.cn>, Han Gao <rabenda.cn@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20261111131613.6290-1-johannes.goede@oss.qualcomm.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20261111131613.6290-1-johannes.goede@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wdNj9+np7QfCe9C8auQsYLWAOBYQYkYODyHg90x63SwHiyY513Z
 A72icqaBz3g/BOYqNPuxmElh8kS3/RJ1bMR2tySQyXAe6zkrB6HvZKR+zBxg8sl7X2vbOmy
 LR4YSgqthIxBa4lg13fnjt94KuEmMvZ2wk7ZcvgJUJkBRIymfcUtzQKmJfaUDwwfjayQKfU
 3wibN0scHFfh6tlagDISg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kWvP1Ah2QXY=;CuVfkByJflQSCDYgL+9DL5YloKI
 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
 REdhGk+ogu3ysGOFGhrbzdgPc3HcMbuz10Qg==

Am 11.11.26 um 14:16 schrieb Hans de Goede:

> The core wmi module provides symbols which may be used by other modules.
> These other modules may still function when acpi_disabled is set, but
> the current behavior of acpi_wmi_init() returning -ENODEV when it is set
> causes loading these modules to fail because the wmi module these depend
> on fails to load with -ENODEV.
>
> One example of this is booting a kernel with both DT and ACPI/WMI suppor=
t
> on an arm64 systems with devicetree which will lead to acpi_disabled bei=
ng
> set. Trying to load the amdgpu module will fail in this case because it
> uses symbols from the drivers/acpi/video module which in turn uses symbo=
ls
> from the wmi module. Note the video module itself already contains handl=
ing
> to still load when acpi_disables is set for similar reasons.
>
> Fix this by allowing the wmi module to still load and also register
> the class and bus instances since some exported functions like
> wmi_driver_register() rely on these being valid.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> ---
>   drivers/platform/wmi/core.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/platform/wmi/core.c b/drivers/platform/wmi/core.c
> index 529825dcfbfe..412f2e23b01d 100644
> --- a/drivers/platform/wmi/core.c
> +++ b/drivers/platform/wmi/core.c
> @@ -1573,9 +1573,6 @@ static int __init acpi_wmi_init(void)
>   {
>   	int error;
>  =20
> -	if (acpi_disabled)
> -		return -ENODEV;
> -
>   	error =3D class_register(&wmi_bus_class);
>   	if (error)
>   		return error;
> @@ -1584,6 +1581,9 @@ static int __init acpi_wmi_init(void)
>   	if (error)
>   		goto err_unreg_class;
>  =20
> +	if (acpi_disabled)
> +		return 0;
> +
>   	error =3D platform_driver_register(&acpi_wmi_driver);
>   	if (error) {
>   		pr_err("Error loading mapper\n");
> @@ -1603,7 +1603,8 @@ static int __init acpi_wmi_init(void)
>  =20
>   static void __exit acpi_wmi_exit(void)
>   {
> -	platform_driver_unregister(&acpi_wmi_driver);
> +	if (!acpi_disabled)
> +		platform_driver_unregister(&acpi_wmi_driver);
>   	bus_unregister(&wmi_bus_type);
>   	class_unregister(&wmi_bus_class);
>   }
