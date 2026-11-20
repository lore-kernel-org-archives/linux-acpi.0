Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795170314;
	b=H6TtRilufru1upoAr7hfHYMU9dV/TOQNx5MFpRb/tDrquJnCDZ9q5evTEvw7QzMVzwv2
	 t/MCO45N9xRfDao9C2WH4WniY/93PvGVuNomMMz11gQBGMtj/DEOROlggbdaMPIBapwXc
	 ebWFEtDkCCoxX2HLkGocQjV3xAhGQlChaKY7ADYt/aV2/DUvJsJaFMnV95Wvf60q7efEY
	 6T4sikegrWGIxD34ymGFDq830YpelGms9SX9nUkr04h0gS/6ivK5+fY7fYW45yX4OkIWO
	 zESgGeS5E+26qgkTmacgwShvKSIAQPOy8EO7DUiwkFzrV7THgm6lGaWAK1SCFzHdDKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170314;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=pZlvHTLTfIebAHO6v3eRu3cIOpPlVSOeCwNOBNCLa/8=;
	b=x57n80MvMcSuj+2tEcYekmJc9fZh0euAtjfnPIMiDNDRtEAJWj5CJU5wz57SV7bOPP2S
	 Q6L/zHSWZAR3m7i7OT1oIVtmAZj6hxwOsdmti6gwJ3z05qK6yOvlU0V+jBtbbOsfug3zJ
	 9xCYjCxELjjfCcgU7MUFtv9QQLaw65LhpDlvQ4SGLhc0sllxQ57Q2aBHoNcY1gvl+fIx1
	 K3mHWo/ni9CoIwMTHlmEnItDaP2gQNQUS8vjafA68eZHbiqZD/rIRMYSAd5qEPgF4wq0R
	 gtchY1coDdqpNdVN2DHLaUAJue/rLIjv8yWW2W8eWFWV+LA9Ttvz+88KLumJO5jnzMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=fail header.from=clicseo.com;
	spf=none smtp.mailfrom=clicseo.com;
	dkim=pass header.d=clicseo-com.20260707.gappssmtp.com header.i=@clicseo-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Zh1mAx3U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4AE606A320
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 10:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB4AE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=clicseo.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=clicseo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clicseo-com.20260707.gappssmtp.com header.i=@clicseo-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Zh1mAx3U
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-677d35fd1d2so781213d50.1
        for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 02:25:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795170313; cv=none;
        d=google.com; s=arc-20260327;
        b=U4wQf6tZolhYi6MRcFBsHuO8wiJrF7knj4gW939wzxl1/6Euh2ETWTUPNgeiKLEDxM
         /NkHEpF9p3cMlioZYPfUCCp4zGS6XaQPYUGMcwQi9P349RZStdJfOsadU3HnVoD/dLhy
         u9fK14h8VpDdI9gSzKfcDvH1ffYCYh/JOdEp4PfB/opnkqnINfP2CBjHhcKP+8ne45ht
         ixx2Yqr+iQApbYMICN1Sd/m23pzg4rndW1VF+46HcMW1r0cN+RQBXlYARI9fKnkjyqgW
         C8GfDP4p6bKHwOU5yeLbz3GsbOv2H6BLxSi+d/A5rxhnZfGOKAESYdYmeOMrix4NQUOd
         A0VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=pZlvHTLTfIebAHO6v3eRu3cIOpPlVSOeCwNOBNCLa/8=;
        fh=nuSIhYuo9Rj95BKxlBfQiXH3hkbt1NDVhYaGsY3qzng=;
        b=Y56OHgu9GS/P+ckIBoQzxZ21hZbYKsvJydtiXwqnTi8i2+xHn/6vlyAI/oBDpN5Cx2
         oZZerrRxLvHncSnVjGNasxDQsJ75VmQScibS4OGFlRn4bA8ixTqoE70i6VhXyZFqNso0
         VVJxYb7KpQt+XUBJlw81LceWSkrWZWPMhLED70/LmV6TX+TQHhPPnaz5D80G2XYESOga
         p5kchnZv6Q4v9SjBySOhbr6tVJvsBtGHffby7ALRE4VfKR7J951VJHKt4+h0QYPDADbv
         XD8hgHCn5x+dxlZKVbvktcuaGYR6iGM/Y0/qtLUsdbZ2dLxQPTeD6K+1FU0iVRS5NvGJ
         yDSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clicseo-com.20260707.gappssmtp.com; s=20260707; t=1795170313; x=1795775113; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pZlvHTLTfIebAHO6v3eRu3cIOpPlVSOeCwNOBNCLa/8=;
        b=Zh1mAx3Upzuqv/g9rjuXKFGRqB0RvSaVhDXcWGFxWLu4KmhyoFowzLssb84V4ggjR0
         LgvH1igwmxMCQzBRdDR/gbby7znnByXWdNyrH3znGV0oK/POXFmP1qNqmS2DB4+OTffy
         xR/7meqlqPu9byI9rNe8CHEVI0r/3WAYN3Ughgg7qgdubvwo3Me5CHKguVEK7ZyOZPxb
         v/yWkD4Q2wHP3SbxCDyZxRK3qWTG83GTd731xIC/ndw2+vf23ZsjfKldV1M4az3PiLYP
         94Zy/PX8GGYeaFU01sY0T3Vfe3mkuSD/Ih3z0xzahOedZheQifwz21YUHMyx+BrSmvER
         jrzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795170313; x=1795775113;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pZlvHTLTfIebAHO6v3eRu3cIOpPlVSOeCwNOBNCLa/8=;
        b=JmfV0J04ZJy3BUxvv0UZNJeufIw0Jua/xPHjee2Z7wwJksYFtOW2/F99pdmYn8uqzK
         rKF1BO7iklkwg4bH+nxk+hAYOwvRGbj5N/paFVjO355aZx+JWe+roLmSeNSF+FAcekFQ
         N7yhYkem9ZZ4oaVHjHWjVxVdH6//bIRCOW2WB5sM1wt7PDxiCjDJ8giC6hRV0+KqMdj9
         YmJDihe1qggyrBNYfh6OPvujg/2uJi4+LndQVsBW/EKjG269I+7TbaogcW3ekasKLpsB
         2IQRGSSE/tFc+qKAwLjHnVinGEUjuNRkCBiXMD9vMZAQKKEb0K5nmn8t3k1ecDU320RJ
         adBw==
X-Gm-Message-State: APuU4Z8lQ+sJ8uoSyNkc08eOFRNc9ch9lZ58KhQzaBrZlo+LruAX3L9C
	KZjqPfRO5eZLXNGnL62dLhdGlNSEwX51Kvdc9rISz2uUbuK531IF16RwYH/yXbRPc4E6nl4j0M0
	LMd3f/KqbeycJOGBxAOlUkul615yzO26+Rt65zA0sxP/m5hPTWky+Iqo=
X-Gm-Gg: AZFdTZe3ad96kdx+ocAbB8ql0orWdRNzzfxI1teKvNl/TjgQ4k/N+z7kDyLvT4vTnmP
	HXESFMmXQPMY0N/s3wrqBt8w9oUICMD4bJDMopIIEnTOeBm6B1fLeNq8a75Pb4bRwEO1vMNdWpv
	wU5o6nbiBz5vlCdx9uHUkKfao7thxFLtVQkQ8ifbt1JOTz91pmqHoc0XnMuPBXtZimo35oGucZ7
	7vwYtU3teOq5VjAFt4hiZ3SfrAE7I+NuUsx1nv9Ddv7xZqsq2O0eHKAnTjW57Ax13zfuzXlvH4u
	GfwI6MdwuwiO4RAy2IMzn+oGWpL3cduBdL8Dg5i6gEldsvzhw1MvcQHvDjU3G4tpsxP9HPSxyXK
	wzUXheYPe3Gt1bQoMuPDO5j68Ef8AHJ2EOoMTTh5zBONvtzlpHsyfWwSBc4O+1C159/V1laoRih
	lkGJvYKPuNf8oVx3+fwbzhVhOX7UKLzBsq/ayG8INuIhcFbZo7LQ==
X-Received: by 2002:a05:690e:1248:b0:67d:b995:a5c3 with SMTP id
 956f58d0204a3-67df44b55admr1157942d50.70.1795170312913; Fri, 20 Nov 2026
 02:25:12 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Gabriel Giner <gabriel@clicseo.com>
Date: Fri, 20 Nov 2026 11:25:02 +0100
X-Gm-Features: AclHuK9O6zIimy8Qbylja7VqeRx6PFKkK2N4pX2B4Xr-B09ja7r0uqWhWu1Esbo
Message-ID: <CAKfe=Pq86f11-_GJNRwCN-m_TAMu-Dc6B0RvgqVk28=waXkVow@mail.gmail.com>
Subject: Re: [PATCH RFC v3] ACPI: PM: Use EFI power off on Lenovo ThinkPad T14
 Gen 5
To: linux-acpi@vger.kernel.org
Cc: george.kokolakis.ece@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi George,

I see the same power-on after S5 on a ThinkPad T14 Gen 5 (21MM, Core
Ultra 5 125U, BIOS N47ET30W 1.19, kernel 6.18.63). An EFI power off
handler, built as a module along the lines of this patch, did not help
here either.

On my machine it depends on e1000e being bound to the onboard I219
(00:1f.6, 8086:550b) at poweroff:

- "modprobe -r e1000e && systemctl poweroff" stays off
- "Ethernet LAN" disabled in BIOS Security > I/O Port Access stays off
- with e1000e bound it powers back on every time, without a cable and
  on battery

Ruled out here:

- WoL (systemd .link with WakeOnLan=off, confirmed applied)
- every power/wakeup flag under /sys/bus/{pci,usb,thunderbolt}
- every /proc/acpi/wakeup entry (LID, SLPB, AWAC included)
- Thunderbolt, USB, WLAN, WWAN and Bluetooth disabled in the BIOS
- xhci_hcd.quirks=0x42000

The state survives a warm reboot: after "systemctl reboot", a poweroff
from the boot loader (systemd-boot) also bounces back on, while after a
cold start the same boot loader poweroff stays off. Hibernate (S4)
stays off.

00:1f.6 has power/control=auto and is runtime-suspended while the
system is up, so at shutdown it is runtime-resumed and then goes
through e1000_shutdown(). I have not narrowed it further than that.

Could you try "modprobe -r e1000e" before poweroff on your 21ML? If it
also stays off there, the quirk probably belongs in e1000e rather than
in the ACPI poweroff path. I can test patches or collect more data.

Thanks,
Gabriel
