Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795790649;
	b=o++y4JA+4q902/hKXlgJ15ckhV97pe21q0P3yl2XaejAIXJaMYNYr9iFGUfShcvhZjIo
	 6P7gaj714T2shoc2LScuima3ifrx5KBlZWztv/yPtYCk6TaZ8LxgbfV0NeoRdnCcMSfUK
	 fyAvKDGSiNhkxH+YGlhHwcWxmY0t1l49AxNKi01eef0YWfAIFx2Il8RVpqbnNC6CghVqA
	 deQsNqLdappD70aqOQsitTLmN6AlUUKymg8MqVzIOgL/CEMA9bjoxgsyH5uedPL+RoubK
	 67e2NSNvYVYHr+Z4z5X89rdftZz+IRYBui0K+DPOpWQawfRAstGLCtp1Y5ildd+2EPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790649;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=8fWmJjgPbxIUKCTGzOe0a4Eos2iKjxVCfgqaeMXCphk=;
	b=5H7QFz5pHjtgzcXbLbGjBY14TV9CFLyUUwgcpGx2N57zKQns6ZwrUuurSjLEaGq1R4ns
	 mPqfjxs+cFNiJFe+nUB8vrK0o9mOl2ylx5IFXtPREAXCieFBPp5H4sYT4P9URd+WKsLDM
	 Nki8waBVE8sqmRMQ6nmSk3WNVbEBqpEBEiThQSrWvCcJ6Q0vYABMAlyMe1mrqdDPfZMGQ
	 AgJNPXr9XXGrGIoeu/LZmFHctF/NP82HLcBeMy10RZ4LLBlYFiRfVOxegbBJiev+uOVAz
	 zAF3W2WS8BoxAENvO4xIN/otuSWPAUZ6U+DXrB08YhN7qqJfLUYBg9/RYYBy21vvvMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n+rP5MD4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bzSwTZvP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA4F606A688
	for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2026 14:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEA4F606A688
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n+rP5MD4;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bzSwTZvP
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE1Q5N686141
	for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2026 14:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8fWmJjgPbxIUKCTGzOe0a4Eos2iKjxVCfgqaeMXCphk=; b=n+rP5MD4czaDZqzl
	J/Gxmm7QvtDaMgxzE/xVipGHdwLg9Qc5qzHYQuTEXFQZtFrUdIgEK803v/WJa8s3
	UdUF3f6EfFVNiYd6OiAWv6zPw0Vy69sVKowhIdufOQKKSyoW84i/Bom+mYZSVuTT
	ugN5fzMhxx4FSb/IvuCOoCIuohndlRHgHzc+HYieYj61vVtnfOx8G83ubwm8a4UP
	1YNBBAXSMlJFlwdWpEHJBeB4FNtaEs/uUkZXkvtdGEh7V3S+zOrLeecE0IWERJUQ
	CDu6p9p6y1FAFp8gKhLBDiSZdTXATInA5Fxglm5L0ULVRHWrCiwwoqomPn1je2+U
	B6VlmA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u49bf7c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2026 14:44:07 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b3a74ee77fso5162965a91.0
        for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2026 06:44:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795790647; cv=none;
        d=google.com; s=arc-20260327;
        b=IyzNpP3DSt94X9b7W/GjNOQ1bwOlXAWCsTMUrI1nFsGJTP84iptVw9p8qWTEZbIOdr
         Gc+adp8N3QE0WDxMNdJ4BcFruGy8VIC+z8/PJuuxKbGGfJkgCXnhuNnEFdALbATFPaRj
         BafxJb9BUMVA2QjpIgNnk64G21FJ7F7Vin/VkiL9qYQvLFux+99v8vyzG4FIn4+ckh0d
         jLiZrlQReiqYqtdOydSbIS+0Wm9c1eJ262OS+Q6QUdjcdeKlKmZFySUgKEYmnRbgphrR
         LXC3glYcR+IVSW+3LrU555gkMX71GBLYB3RgeUBn0Ep+v4KQzyoTsTTQqxbe3jK8ZtgO
         OLmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8fWmJjgPbxIUKCTGzOe0a4Eos2iKjxVCfgqaeMXCphk=;
        fh=A+5fjDP2nY5NdYD2AqnGTXj09R8n72nXC/Z81wopsXI=;
        b=ESIqZpfzcwYU0az5UpO0HCuXsUUt7ZYOkUiQCRedwT00DAqGcrIOYkF1vKYvjAf5lI
         1752w2mP2jgzFJtGgbB5giprpBEvx606EJxDgBZDBZ8z1v3g981WieUBXqw1KfkL4fD1
         Q7WQ3ulFTK2kgPKQjRmkej10W/+DzUsaDj+ZJw2XB6Yzxze8zCSipKeSacHusFmCHgzO
         qYRwGAho7SNJ4k+5O4iZGQBNvhM77jjB/EqUJCFThGWjkWZnbTPlhlDMVS8Ixjf8vkw9
         SBgb9ZF7T7eXPR0ZLaVUSXa8ZM1ig7JaMrOHDHqADjyGYIADk5uq+LCqYSoTma7IYdOW
         +VRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795790647; x=1796395447; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8fWmJjgPbxIUKCTGzOe0a4Eos2iKjxVCfgqaeMXCphk=;
        b=bzSwTZvPQmGGu8Mm4Vso/hibqoLWrIDGMKSvxKJkgEk4ZV2bnBymGFpbfh71h5j3wM
         c3rcWK8D7X6sy4HNKeOsQiDNm4pgMeXQvlFi5nM9xQ26Yz0XIhwNaSxCUL8eVBuUvtJv
         QhQj8LJfx8zQEjqBFmTNxmP8FAMID1NMpnnumXlHRSrcUhg/Mjg0HyKjWKof630nds8S
         tJUYm7DCOsbxPXrK9As7q9ZbOY2MXeRSM+uH+zoU0Ew0cNevKG36a+UikX2ObEI5yT6x
         ucvKIcPfI/JqTI2dpvYCjEQfAhHv0RbyGhC/7lyO3O8OH6tX6Z81/r5lZbttB5zP3q9E
         UFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795790647; x=1796395447;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8fWmJjgPbxIUKCTGzOe0a4Eos2iKjxVCfgqaeMXCphk=;
        b=y0jEBToZHmXcmvx9uklQBKdff2HpzhX2DKpi4ksLUhoKoxkh2b14GOp+rS1YmDVvID
         KO2Qg81v3JX7vNylSSHpIJku/stDZjcc3mLXhrBp2SRpc/2O2/wfvuDpbcvdXOXzzFmS
         24//zGx6fAIMxUdmLTDXEL79VbGaMPmc1On/ohnkQsLD0u1RVhIAlsJkEtwizadI+P6u
         I5tHgZCFKDMQ2Mc1y9ziYKCgzyqOiMdhT4QO/PrwZHQsXSyPvvcH1GRd4fwXT0H2pxCr
         wzfdSOOCuGYQ4YUtqsFl2iA3Vw9Kosjt2PT8A19QjNL6dQYZ/vJgvTUkv2mxdQknEH2P
         Wh+w==
X-Forwarded-Encrypted: i=1; AL+hErEPQqRkbvsXwawzZB2ddIL1GzcMPPUX7JtkUTKiHIHTNCIcSxgwes1nyb8P1yVflpqJSOr7D2h2c9M2@vger.kernel.org
X-Gm-Message-State: APuU4Z+A4YIh94I3t6M732vByKV2q5NekdldgFiHNpYaORz68Msnf8KP
	AU6Db8u5wclyLivjz8zGQcVHmjvmN2coVjcHi7F0Kp3kXMAzEJGUy0qTrdLUe3K+vXgfrIsT3by
	77VoS7NeURKGohh8TCAn3zFomnhmsx/E7F3FLjkk32mFjvngBHGTZ0GlDnv8vvjojinqA6N3EO3
	LwmWF8T+/6ch6E7DYCWDubbBtvgvmaVRctNvCFNeE=
X-Gm-Gg: AZFdTZe+UC75UD31OYT187aC2eDccH4ENfM8vpkH7KzaDZBxE+EGlwBLRJu8MurHNsC
	/VO0rSfUoJENhT7borGF5/heFAvMewg1BPKhXi69O5lCZlfkk4U6eR2AYakdJ29KIzTGyaFOWaH
	VzS5VAB0csS+a17g+qgLT1CxInuJRvgzdKxiqeCbjV86BKkOIgm+KwBqV4yA==
X-Received: by 2002:a17:90b:4b05:b0:3a0:516d:9f88 with SMTP id 98e67ed59e1d1-3b41c911c9emr22651782a91.26.1795790647062;
        Fri, 27 Nov 2026 06:44:07 -0800 (PST)
X-Received: by 2002:a17:90b:4b05:b0:3a0:516d:9f88 with SMTP id
 98e67ed59e1d1-3b41c911c9emr22651754a91.26.1795790646565; Fri, 27 Nov 2026
 06:44:06 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112124430.110629-1-johannes.goede@oss.qualcomm.com> <20261112124430.110629-2-johannes.goede@oss.qualcomm.com>
In-Reply-To: <20261112124430.110629-2-johannes.goede@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 15:43:54 +0100
X-Gm-Features: Aa3M54qk4bwCpPsnUmyVfc-bvQG8ppESh3VRSOGzyqFs2PO3uFGfxwQzQmGY3R8
Message-ID: <CAPx+jO8boi=E6BhvCB-CS+Kuy8B109wGfcZeJqC7yEK-eLz7+A@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: sdio: Set acpi_device.power.flags.ignore_parent
 flag on sdio_func companion
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Luka Gejak <luka.gejak@linux.dev>,
        linux-mmc@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: VlLWDoXnj03fePwXkz_e6GEe195ySZaa
X-Proofpoint-ORIG-GUID: VlLWDoXnj03fePwXkz_e6GEe195ySZaa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX6B3KWE4LjvBb
 l07Ju8g4Yvnm+HeiKS/tZsBkC5dyicsCLZ3fd0gRb6k1iNFlcCNuTv4ECe7INpuBcUM/lj927oP
 NN+KsHlr4pZLKzdp2jPqT+l3u6m/6Dc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX763bVyghT8B/
 +gdDwfbHHpR0uDWjMckYAXx4quZtqNmXj19tVE+rXYucv3JrKVJ+xW4pE+kEEIhMMD/FRU+tP+s
 ESeQ/Ar4dtKlIOchoTcWFQBWhVzJAvIPuFg75sJdTynbF0xdXeApj0ouCnA4eVVWqSgSniKqlTW
 fVjf8Eau8Wh6J5HIeP5qZLvc091vWARDh1ErH9JS5d9XgOaxFkXB27XXYU7LO8VDG3wDns4YWCR
 ep3VM5oKkltuT5Qn/wYpgDDyXpzBRd1gf74Vn1ZLs47ZoRfDBvxz6VwF4uex5na3MrZwjDPSmsz
 ap+t7fWo+G9vKJBK9NOT+awcUV4vLrs8/fPGgmCe9nKaVWEA85rCQKnLtRrCgqYDIgHDHRkGws+
 VTLbrdzma1pGnpUcfuFRlI/C8aDHmT6Hkfy+QXUGemmBB1FP2fDV3/w56N8hiXco6sedveeHEof
 uKU9uqAz8eK/PKBqzIA==
X-Authority-Analysis: v=2.4 cv=A875rKWG c=1 sm=1 tr=0 ts=6b099737 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=axVEnJ4QPotxFK-0UZkA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 clxscore=1011 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270058

On Thu, Nov 12, 2026 at 1:44=E2=80=AFPM Hans de Goede
<johannes.goede@oss.qualcomm.com> wrote:
>
> Many MMC host drivers call pm_suspend_ignore_children() which allows
> to keep MMC cards and SDIO-functions on while the host is suspended.
>
> For SDIO functions which are in the ACPI power-domain this causes a race
> where the host may end up runtime-suspended before the driver for a SDIO
> function loads and probes it. When the probe() loses this race this cause=
s
> the pm_runtime_get_sync() in sdio_bus_probe() to fail in the ACPI pm-doma=
in
> code with e.g. the following error:
>
>  ACPI: \_SB_.SDHB.WLAN: Cannot transition to D0 for parent in D3hot
>
> Busses using pm_suspend_ignore_children() for their children should set
> acpi_device.power.flags.ignore_parent on the ACPI companion device of
> their children to avoid this.
>
> This is safe to do because drivers for sdio_func devices should always
> call sdio_claim_host() before doing any IO and that runtime-resumes
> the host.
>
> Add the missing setting of the acpi_device.power.flags.ignore_parent flag
> to fix probing of SDIO functions sometimes failing on ACPI systems with
> the error mentioned above.
>
> This brings the SDIO func handling in line with the SPI and I2C handling
> of ACPI fwnodes which both also call pm_suspend_ignore_children().
>
> Also add a sdio_acpi_clear_handle() function to undo this, since the ACPI
> companion device will stay around after removing the sdio_func device.
> This re-does the ACPI handle lookup because acpi_device_notify_remove()
> runs on some device_add() errors and from device_del() clearing func->dev=
's
> fwnode pointer.
>
> Fixes: eed222aca8d0 ("mmc: sdio: bind acpi with sdio function device")
> Closes: https://github.com/MocLG/rtw/issues/2/
> Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> Changes in v3:
> - Drop unnecessary clear on error in sdio_add_func(), sdio_remove_func()
>   will get called on errors and do the clear
> - Some spelling fixes for the commit message
>
> Changes in v2:
> - Do not clear func->dev's (ACPI) fwnode pointer before calling
>   device_del() so that acpi_device_notify_remove() properly removes
>   the physical-device links from the ACPI fwnode.
> ---
>  drivers/mmc/core/sdio_bus.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> index 4b07098c33c3..2cba8c45c8ed 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -373,11 +373,32 @@ static void sdio_acpi_set_handle(struct sdio_func *=
func)
>  {
>         struct mmc_host *host =3D func->card->host;
>         u64 addr =3D ((u64)host->slotno << 16) | func->num;
> +       struct acpi_device *adev;
>
> -       acpi_preset_companion(&func->dev, ACPI_COMPANION(host->parent), a=
ddr);
> +       adev =3D acpi_find_child_device(ACPI_COMPANION(host->parent), add=
r, false);
> +       if (adev) {
> +               adev->power.flags.ignore_parent =3D true;
> +               ACPI_COMPANION_SET(&func->dev, adev);
> +       }
> +}
> +
> +static void sdio_acpi_clear_handle(struct sdio_func *func)
> +{
> +       struct mmc_host *host =3D func->card->host;
> +       u64 addr =3D ((u64)host->slotno << 16) | func->num;
> +       struct acpi_device *adev;
> +
> +       /*
> +        * Re-lookup adev because acpi_device_notify_remove() runs first =
and
> +        * clears the fwnode pointer of func->dev.
> +        */
> +       adev =3D acpi_find_child_device(ACPI_COMPANION(host->parent), add=
r, false);
> +       if (adev)
> +               adev->power.flags.ignore_parent =3D false;
>  }
>  #else
>  static inline void sdio_acpi_set_handle(struct sdio_func *func) {}
> +static inline void sdio_acpi_clear_handle(struct sdio_func *func) {}
>  #endif
>
>  static void sdio_set_of_node(struct sdio_func *func)
> @@ -417,6 +438,7 @@ void sdio_remove_func(struct sdio_func *func)
>         if (sdio_func_present(func))
>                 device_del(&func->dev);
>
> +       sdio_acpi_clear_handle(func);
>         of_node_put(func->dev.of_node);
>         put_device(&func->dev);
>  }
> --
> 2.56.0
>
