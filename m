Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.27
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486735;
	b=FcbclitrYrgO4ueFw23MaAQHvyoeXpUZRR1qL3KMwhXbDBVRlD58dDmhfughphS3M+4V
	 9iAQnrkgm6oahW925m5SlMqyEFWCFS/zxEyzhCeHzXeNxXfgkZq8AN7xVWmC2xkkVPyKY
	 zyH6rzVdduWcyRkEkLb3eh+ztLoury5iYMTtzOdfhUpHWmzreBRmY6UaEEDSJP4R0Iilv
	 MuaAybntFgaH6KvR7rP0iTpMcRIMl83t8agSZVpdBbAxksIngWB2X3m0ZTlJr6o0BaP3c
	 euTt3QBhOion6sOmLfVERs2vcw2vplxWr0PcGiUEIvDsAwBC/Q5pp0dXTz1iUSIbu3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486735;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=TOXxOKWso1TazH7ld7sFDjNk7p2tHy0y8okZLG5HPz4=;
	b=QUW8dQdprfJ7v1TkZYDIyAVWTafowykcQLVRQAlcDW8LWchKg2FA028LRgVpI73kXDU9
	 LZ57+SZSf1g9j8FoXzCPcB4N71j/FMaVlu4OZNb+T8rikTckzgCGbXSWir4GfFtMv12RP
	 HDrCwmqgSYersBRsZqC7cAYqCzjYezhxMX7vrdMUmIc3sw+Zqcy5H9Fq0nOA2S9C34+4Y
	 FXG0hdsli90kCEpQO+OW6g59cJq0yxKzdW41rak7g2vRX1GzWn4Hzod8aC1dF2smr1I+0
	 feXWYtUBfHoPY2q/wU2X0VApVnApAJzQueTrJxSrRFGNv5naD6k8qEkIDltZiCEeRIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jghg0KTe;
	arc=none smtp.remote-ip=95.215.58.27
Received: from mta1.migadu.com (out-27.mta1.migadu.com [95.215.58.27])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B83C606A32A
	for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 12:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B83C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jghg0KTe
X-Envelope-To: linux-acpi@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=C1VFcq6I0sFyOtf24jWVjMt72rPgj+CjBqrs04ic92A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794486729; v=1; x=1795091529;
 b=jghg0KTeZ4U//iXLJShxFLBERH0ml1GA7OgRjs0Q+f/ULhkEtSmby2Cg40qRoERYk8g+MPSu
 jmqdyjnxY9aymluIIlEFpUuKnqO2bWT863OVK1VCUx4bKNqzcZNZNlyK81+FHuatzRC8DxqtSvV
 R2th2L51l2Q2iFJmVV1BU9F8=
X-Envelope-To: linux-acpi@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0af92d601ae0eed7;
	Thu, 12 Nov 2026 12:32:09 +0000
X-Mizu-Trace-ID: 0af92d601ae0eed7
X-Migadu-Flow: FLOW_OUT
Date: Thu, 12 Nov 2026 13:32:04 +0100
From: Luka Gejak <luka.gejak@linux.dev>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>,
 Ulf Hansson <ulfh@kernel.org>
CC: linux-mmc@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/1=5D_mmc=3A_?=
 =?US-ASCII?Q?sdio=3A_Set_acpi=5Fdevice=2Epow?=
 =?US-ASCII?Q?er=2Eflags=2Eignore=5Fparent_flag_on_sdio=5Ffunc_companion?=
In-Reply-To: <20261112120204.98633-2-johannes.goede@oss.qualcomm.com>
References: <20261112120204.98633-1-johannes.goede@oss.qualcomm.com> <20261112120204.98633-2-johannes.goede@oss.qualcomm.com>
Message-ID: <339AA265-E4AF-4C6D-8886-AC14A8E32545@linux.dev>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Hans,

Thanks for the v2, it looks good to me.

On November 12, 2026 1:02:04 PM GMT+01:00, Hans de Goede
<johannes.goede@oss.qualcomm.com> wrote:

> @@ -402,6 +423,8 @@ int sdio_add_func(struct sdio_func *func)
>       ret = device_add(&func->dev);
>       if (ret == 0)
>               sdio_func_set_present(func);
> +     else
> +             sdio_acpi_clear_handle(func);

This clear seems redundant, since on any sdio_add_func() failure
mmc_attach_sdio() ends up in sdio_remove_func(), which clears the flag
again. It is harmless though, and I don't think it is worth a respin.

The commit message has a few typos:

        looses -> loses
        safe todo -> safe to do
        wills -> will
        inline with -> in line with

Ulf, would you be fine fixing these when applying, so Hans doesn't need
to resend?

Reviewed-by: Luka Gejak <luka.gejak@linux.dev>

Best regards,
Luka Gejak
