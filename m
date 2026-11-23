Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795476437;
	b=ll5Nul/NoZLnRL9hnJ0HB/ihNtzbT5Ks/HE/Kciir+YMPfpxc7QMyTKJ0k7K5rDp1+dP
	 UAHazyWTp6ah48itH4U8PGxxTW8QDli2a/0AdXs5ymETRGeNRESFrw/IMFkwsu5LdcJ+G
	 AyQMu+TwWEMGxJQkIBokVukPbMb+gpOCQZcVuOlME9vz1NmbZ3VOXtZoqDoom4OYtQZLU
	 uiF41KbvzJvAX3H6IlxEfsLnlSg8r6LiMhCdgWzBuNVgIgwSzzPXznNGPgAPS9/TYmUOe
	 aVZip1t2Do8fQA+x43fjPNyKMOoW8PPXqStt5enego9H+PKn+qUEeg5l11r5R541keA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795476437;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=ZuaNBh6pkcJ/82GdHcWJ4tfu5uUzu4/Xw5l2qcnwFHA=;
	b=z5nC5IHaT0aoknROs0ugYtNI2XxbrDNXnhmmk2/Uh6I2WX48KNea537ExTJusdVyF0bd
	 epo0x+9Ynhv0Gj8LLKbvPlVSQLnpvJ+Oqm/i+c5TDJ964niXMraO8z7WnegkXvoScnSFF
	 k3M+XFEdyCRhEGUeCJFAQlWYCiqodZkx9Ht9rzjUnD8jqh4bGo6Two4/5LYXi42sZBUxX
	 eaABJkVINg98fJ3Bz8Of84FQBrT3tVlkmNS6KXlAfjxD+AeMf7MXcbtqV9/4Fleq8d/kX
	 2RWA5tc7tXjrTDacx5eRsguUqTQqZnRpozFOzUtcYPqEsGDR3a4BiWH1vWYP14pB8FQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lFezoO2N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5DC606A31E
	for <linux-acpi@vger.kernel.org>; Mon, 23 Nov 2026 23:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE5DC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lFezoO2N
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-67583c777abso4004474d50.1
        for <linux-acpi@vger.kernel.org>; Mon, 23 Nov 2026 15:27:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795476436; cv=none;
        d=google.com; s=arc-20260327;
        b=eXSluTM2srtWZgHrBU776WbBPg24+06JN+lPGXrnSQM5LurYso7MEm/OgJlwz7hlNh
         D2lW09/eBifh19WdcwFvLjeeA51zOh+0guyo6LdtgDQe0DSFXEdltv2pPe/O29uEiE49
         zwg61zXM/UeBar1pFT7DFbnRosFWspPe+d4HqBSuZTP72VLNXM8HSpf372iHfl2jJM4I
         UKyVCu1SCMvliEOnRJzLNF/zRKhDYXcnPyWGJ9ZXbAWO2H7D0HWyNC6bQ9AENBOzOZbH
         b8mitBK4Bv1GrR5JWSE/1prDdIHBOBh7v2PoU3FcmNeC//CBtMcNBj5CC+OZJLLa7LXj
         viCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ZuaNBh6pkcJ/82GdHcWJ4tfu5uUzu4/Xw5l2qcnwFHA=;
        fh=Vw/aoikC/RD2J2Ba124WJuQFkDxjh5mpq/erawUhgo8=;
        b=CiOeu6Qel0VQ1Wg0y65D0OpGxMzJxuYB2X2bLyTh5CvHDTvzsFgdF5h+/JCzAJ0Ar3
         TwAr2MU/r4FcWgMFB7cilrIt8vE4QwkOXztK27XJOkVQAc0+VbddPj23aqocpjAtuY7S
         vY9BXr8+drDYlMLJYECulReIX2xalaUdx8rgvbPepfdnOznjS5OICc0eMhWtPcW6f0je
         6XIoHHkrJUkBDlRCjBZx/eqKVa2FdK5XKH0p6uLCu669Y3mYCJ+qNyWlQWpm00gVLywG
         0k3ENhdG705G20GqbER/M/IiL54MPYD17GxRXKY7dG5Uxw9vekrzIibde6oOuq7lmIMA
         OB9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795476436; x=1796081236; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZuaNBh6pkcJ/82GdHcWJ4tfu5uUzu4/Xw5l2qcnwFHA=;
        b=lFezoO2NBjbOSWwbx9cyt2GR9xQ6nOxGpKuE2wAuIoVbVbOFVeSxKKa/xvLGdsLQxa
         n6lzgTAANX+ex7kKU1KCf6QIoZXUcn/QxzJKdHn2OUmhrVcDS6kgSrCTHV9Hqg0UprlK
         z1YIR1ZH503kFhBSG/L1yvAOnN0xQD69dJr7o5X92KKXzZGDSEXYM4qi+WonbVkUwy19
         U/ANFEMEZeZrAzYtE4dQ0Vx6hTBLHiaMN7H+LAXXi1NecGB8lYnZtWnvGfFGVLSJgak2
         ullyR8MrRAt2PFwNljaWmqvWzTIDzu3L6GpO2O07aSGWUUE+XwhQNTlLk3115NtA+aP9
         Zo+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795476436; x=1796081236;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZuaNBh6pkcJ/82GdHcWJ4tfu5uUzu4/Xw5l2qcnwFHA=;
        b=A8CSkEsECACcw7j+SRgkVb4EMaIe8GybMNbgo2yq0g/SceGYsLVihwUt2OF7Dhpcb4
         Ata0TDOjKKAQc/gs94OZPgxgrAj2T6DL5FfPjCNoZaHF0mEVmq+PzDPR5sM4Lp6wTDRg
         BwhljQ3O8D/n+5MqCjJayVpxu6aGhzyN/m7VSjUxDwmv4HVXE4TOF6nCSMC6cuL2F8jM
         WXWDWDeUZfODurmWe7AU3lMn7hCI379wH3b7i0rC+TlYUVTNwRIOocVcIrIGgCc49O+c
         tb7vPyV4M22XY8fXwSeyic6y8EuWYESEucAN1V1Z5rQXqKNl36w6c6Kmi/L0K3jF+C/o
         1pag==
X-Forwarded-Encrypted: i=1; AL+hErF743cPBs3ZIFuGFl8TvnYsyFkzQiRIhQ7Ol2oGbfhAmOtYGrjFfH6IdbXTCzNp63gDwOUEPrN2adYH@vger.kernel.org
X-Gm-Message-State: APuU4Z//Llhd2pMq5QIALjmkEM2rqlp8r4Pob54VwToFr6Ey3r97d4Pn
	ufUdolXvdnbyTr88PB0Ki8kvfGl7jy2JQFzyFko4yuOPadYx9gqx+KEHy1LobAN1L+tgiZ+uuGP
	KlIzMzmMGdqu9nPRC5gjFSTWL8KmDMC0=
X-Gm-Gg: AZFdTZerCJexTtE3oPCPpdbURvPJo6uPrxoHuvbJOtbA/TLcAXYxSr3anfaxw5YfzZa
	DLrqmIDZuU7dxdcaEk/grbISHSUiWGamoxP446NQubkrRSdEVliL/nN+tfiZrN0twXq1ltDYn7a
	g0F7IHksRCUK1yD39zBM9XTSY3IJafdqqbMK047g1GFBLh98SwS4V6zVu8QHB0U9jVwQos/MsAo
	YeFG46X93q/5/ykH3ADMC7UQNQ0qr22UsWMaw/XCqQ69rbbKbkMdF6I/cq3pApPOrhZaEgl06gd
	YuitaE1Fxm2nO5cNUMqXLWWCW1c4CNcKgN06b0r/LywRGaTa2FumH2cVWDjcR3c+UiVdALOR9Mh
	58l+sesQd1/GlLWjgcuEyCpIf+MNWEDwgjoCfGg==
X-Received: by 2002:a05:690e:4814:b0:67d:d7ec:565 with SMTP id
 956f58d0204a3-67dec420419mr3923630d50.13.1795476436059; Mon, 23 Nov 2026
 15:27:16 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?Q?Riccardo_Zangh=C3=AD?= <riccardo.z.dev@gmail.com>
Date: Tue, 24 Nov 2026 00:27:04 +0100
X-Gm-Features: Aa3M54o5GEwOqBfEtPm2l2KM1CFzpqc22tehqKHIdacZtC0LqG3L8T2gE5Q7iOo
Message-ID: <CAMnz_-Dgg2eCgZxcCaGuKPV=3-kCfg7ajd9w=vs2fGL-Cb6hvw@mail.gmail.com>
Subject: [BUG] ASUS TUF Gaming A16 FA608UM: working backlight device differs
 between MUX modes
To: platform-driver-x86@vger.kernel.org
Cc: hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	"luke@ljones.dev" <luke@ljones.dev>, denis.benato@linux.dev, 
	"ddadap@nvidia.com" <ddadap@nvidia.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

On an ASUS TUF Gaming A16 (AMD iGPU + RTX 5060 Max-Q, MUX switch) no
single kernel command line gives working brightness control in all
graphics modes.

Laptop: ASUS TUF Gaming A16 FA608UM_FA608UM
BIOS: FA608UM.311
Kernel: 7.3.5-2-cachyos
NVIDIA: nvidia-open 620.73.04 (nvidia-drm modeset=Y)
Distro: CachyOS, KDE Plasma (Wayland)

asus-nb-wmi exposes gpu_mux_mode on this machine.

Observed ("type" in parentheses where recorded):

1. Integrated and hybrid, no backlight parameters:
   /sys/class/backlight contains only nvidia_wmi_ec_backlight
   (firmware). Brightness control works.

2. dGPU (MUX), no backlight parameters:
   Same single device (firmware, max 200). Writes are accepted but
   the panel does not change. The kernel log contains:
   "nvidia-modeset: ACPI reported no NVIDIA native backlight
   available; attempting to use ACPI backlight."

3. dGPU with acpi_backlight=native:
   Only nvidia_0 exists (raw, max 100), and it controls the panel.
   The message above no longer appears in the kernel log. If
   nvidia_wmi_ec_backlight.force=1 is added as well,
   nvidia_wmi_ec_backlight (max 200) also appears, but only
   nvidia_0 changes the panel.

4. Integrated with acpi_backlight=native:
   Only amdgpu_bl1 exists. It accepts writes but the panel does not
   change.

So integrated and dGPU need opposite settings: the default works in
integrated (and hybrid), while dGPU needs acpi_backlight=native, and
each setting breaks the other mode. I have not tested hybrid with
acpi_backlight=native. In dGPU mode the NVIDIA driver appears to ask
ACPI for a native backlight, get "no", and fall back to a device that
does not control the panel.

Similar reports on other A16 models:
https://github.com/OpenGamingCollective/asusctl/issues/118
https://bugs.launchpad.net/ubuntu/+source/linux-hwe-6.14/+bug/2134615

Would a MUX-aware backlight choice be acceptable here, or is a DMI
quirk the expected route? I can test patches and provide dmesg or
acpidump output if that helps.

Thanks,
Riccardo
