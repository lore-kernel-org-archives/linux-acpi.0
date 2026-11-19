Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795085851;
	b=GEMID7JBMjV0vSsfWep8UIHV3oJu1XcPLdYalzMQ1H6Z/bJbXLBOqZEcr5riWJDSlrQE
	 KulnSTPdtXIySEhzxjleym8FL9yhevNgM0OtqjDEN7nbxfJL2Zj3BAor0ldH7fC8t9GeU
	 TjvtdLt5umrJAoGCAQfK9cG9zSAe+A9zZBF0XukG3VVFjaktqxClhzzLQtXHc98rtrlPy
	 LNr/pSl0zkpBPBSPY0fQCZWNwpcCQNDM7nUFARF/YUrhotRlKUa/kUTLmWsnNiNcFxltP
	 K0GBEFprFm5SIBQ+E2IxFo3rV206K6FbVanXGbh+zCLVEnID9IRVFOLGyU+mURmPqZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795085851;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type:
	 Content-Transfer-Encoding;
	bh=+UlGy2kv8nsbtWgAkdrcFzV0plo18IhYMfJiQhlHQls=;
	b=PBxitY838xW5jHkaNYOhr7GsttQmA02NkboznFpe2UIuzPS85BHrOTtE+KjQlGQOSg7l
	 i9sLhNiSOx/0iI9z7nbnEEIlDhV88C2SGnX4m8FVfAH9cVM1z5sg1jXbBmQS0B/Te/dmY
	 R/4u5cWQM8+xbva9BJfI7jwwWxu4Qq1bz/pOVKPBl75oc0lLJzEs+daLME2gOn3w6k2Th
	 m2wZg7u+xKZakkKzD8+ZUKW3wEKPXX9hl/omRIDkZQer3/WrDfyCYLP262O4WWSccmvdU
	 jyPtDkfLYL/Mz0pJ/dOvcF1p5z/Nm+PFdnvFWkM84mi8UjwuC2wyi/jOfVgxNsoiboA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J2Zmlvus;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0593606A320
	for <linux-acpi@vger.kernel.org>; Thu, 19 Nov 2026 10:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0593606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J2Zmlvus
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5ee2ad94713so1380276e0c.0
        for <linux-acpi@vger.kernel.org>; Thu, 19 Nov 2026 02:57:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795085850; cv=none;
        d=google.com; s=arc-20260327;
        b=ZXFljULe2b5H/ak7nnwqoBRkS85v5pnrfXpXkoQHWWu2KKZzVnvUJBlS9hys1UfCRf
         LCBlHKoallSSdj9uxGAUuqz1Lov075Cb7ExMBSqc3NTZrbT19SuV2e9H5PLW3qb5alsJ
         VyPuUeOkI6O7bah3iX4HjWJu1s9NhuFBuMPJvyqJa/FRR3FHPdRTQFoOrWlobdQniELd
         s0b7vUB6D9JktLPq06k+yWWgbdPwy01Iho0JKNNy2Rh+Rpu1O64H6/TmfozZ6/vjUmUy
         3Nkew+sAkpTDOHV/DzuFU0JMyhwDdQKaCSVbYrf4/MNcsvbmFXj+QW46AwNg5nJ3WiMH
         GM7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=+UlGy2kv8nsbtWgAkdrcFzV0plo18IhYMfJiQhlHQls=;
        fh=GmFy5nA39On4RWbrn/GETH8dUHq8oY5XORs93v5i3qg=;
        b=AMYM0mV/zPrdxgN0tocFp26OA8cRupeq8x8Ru7s+omGF5bDRE6SdgTaMmNZT3QHQGP
         MPpV9GPntZ1x+w2TEomlye9XTdy9kTIfPWXTw5hvJ5jW9RseHUnd7sr03Hk7GxlSUjad
         vEUZABt/hTj6AlhpfxR04sh2eGq9Kj6Zls0ruX4EGQJTcYTaMt7vo5I3exddKmsMqcmJ
         jHGEdCd3xMiFbx6iKBOW0aZc05t2cWNZafBq4E0mkyx6hJTze5q9AB/aWlpI0nzpBa0M
         Tf+dTJylkHTUgsSLthVgkiNL+GA/0SIo1tUJEFSgMERkqMunow30SoniW4bhwwJ2j6Vn
         7j7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795085850; x=1795690650; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+UlGy2kv8nsbtWgAkdrcFzV0plo18IhYMfJiQhlHQls=;
        b=J2Zmlvusir35TIV248atHxt7pkG39+jc//E/M7IhByfMPx1VDCBuqodDARmqTj/spD
         oUi9g0qF7OYdXN7QNVGtGHrKMjddb4uiaC520ze5zHrPrrC03OJPngGZH6LbWLx3HceI
         q4Y/yW50/uo426gdvo+aypOCtsfTB5q+wv4sy2fBQRWYK+oT9BV+eNcdvZkrLJ9F2MC5
         O3r8gDdoRBprCrXyPFH+f1GpbXV4FIdqbuQQwrIonnXFowMsLF7G+8ZYOFbb6H1j0g24
         5V3Q7f8CBVFIz6oC0atggD7n9a2P/APaYhcpmI0oOLqhVEYJ3DxjZ6fLoApcQOT1UTvp
         oeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795085850; x=1795690650;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+UlGy2kv8nsbtWgAkdrcFzV0plo18IhYMfJiQhlHQls=;
        b=IWd9sWAA6rIUlV5Olw/T+QlbxxvWRMt0MMh/tCGeid4Qv8f3z7bxjWU3Mk699m1mNe
         hLZaB0qLzurS+rIL9d+lvITcZcLVO7rvxE2+9gNmoq+47PJ7Qg8TDsNZtWT2SJnpGbwl
         Q6XQxzBlxVXnaWfzcFeEtdhw2ECDKq7/DucNrupIY0pubIJ/S7DrNkpt1TfcISGbN4v1
         EcUXdTkyRKgU4Q1lpuT2Ay9MX7+QgoG4ZL+0nmuZThu5oAwV5kByfQDgA1v4QXScvZ+e
         8rViwv7ju+LYUfVOQstH2UsV+a8o1owVcZ8jJ+HaCE+phQ5s2MKXUcG2RBxRHbjATsNy
         EewA==
X-Gm-Message-State: APuU4Z+kaigcEjsmpzw5RhOJ/NZRKWVUn8x7LkSHdB/dKpL/nvd2xojQ
	pqzjoG7cDjvJ0dOhAdTQYGvuEL/4M8W23mLjTiKklJMiVAIgmlf+yd10Pph71GBZJxaVza1hYDL
	OLR2Ag52l8WGLo2p/7NdoTTAA7YjA57nk9diC
X-Gm-Gg: AYBFou0AfKuzGm2A/pK62edccgrWbXvFHPC2wVXlT9TN5yONpFmpnm7O8SIs6/sFZlh
	C5R8HxDT6RiQipdhs4L3krTvdQWVFFp9botCCs1UMtsv5bqwTNKUGMCP8WJdP54ldpjci9EBnFz
	Kg2sm2kP/D2w5AXy33Dpba27ieMKASg6870CnGIky/HLLPrY66HYo8ExDT4s4CMXWxG3Kwz4ZCD
	ka4K9DQNaZBPspTJ2HZbS6VxVigrUf1du3vWggbJ9oYFPRglWq4GFI+TAPPcJx2r1JMLu4j+EPt
	SBj4p33LK7etGYkBSlaFRwd/tBXHj6VwQqdu8WUqlYvCf6S6ga/gusGyAoRWprwgtQdDqSpzLAf
	aC6bme4SWeGe4k8BpOudCoT1FdIiQ4DxsBwIxa64KbWFy2U/zv07xwiEZSWINywePUtw00CQ=
X-Received: by 2002:a05:6122:4b1a:b0:5ee:4235:8a74 with SMTP id
 71dfb90a1353d-5ee6478e1a1mr2887897e0c.22.1795085849832; Thu, 19 Nov 2026
 02:57:29 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Naren Reddy <narenreddy981@gmail.com>
Date: Thu, 19 Nov 2026 16:27:17 +0530
X-Gm-Features: Aa3M54raYHtAcFgNqbLZRZDRyYUcIBKPT0cSrk2hRmqw-hBwLooY0lF6bk3IJjI
Message-ID: <CAFXDuspZ5_cBV+fEua3vzd-bYWaHGT38CEmt3L0mfgJ6o4ArCw@mail.gmail.com>
Subject: ACPI GXFP501C fingerprint sensor on SPI1: _STA fails with
 AE_NOT_EXIST, no driver bound
To: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Summary
The Goodix GXFP501C fingerprint sensor on VAIO SE14 is declared in the
ACPI namespace at \_SB.PC00.SPI1.FPNT but the _STA evaluation fails
with AE_NOT_EXIST during early boot. The SPI child device
spi-GXFP501C:00 exists but remains unbound because no kernel driver
matches acpi:GXFP501C: .
dmesg evidence
[    0.166278] ACPI Error: Aborting method \_SB.PC00.LPCB.H_EC.ECRD
due to previous error (AE_NOT_EXIST) (20251212/psparse-543)
[    0.166282] ACPI Error: Aborting method \_SB.PC00.SPI1.FPNT._STA
due to previous error (AE_NOT_EXIST) (20251212/psparse-543)
[    0.166286] ACPI Error: Method execution failed
\_SB.PC00.SPI1.FPNT._STA due to previous error (AE_NOT_EXIST)
(20251212/uteval-68)
[    3.813270] spi-nor spi1.0: supply vcc not found, using dummy regulator
System details
- Laptop: VAIO SE14
- Kernel: 7.0.0-43-generic (Ubuntu 26.04.1 LTS)
- ACPI device: GXFP501C:00 / GXFP501C:01
- SPI controller: pxa2xx-spi.2 on PCI 0000:00:1e.3
- SPI child device: /sys/bus/spi/devices/spi-GXFP501C:00 (unbound,
modalias: acpi:GXFP501C:)
- SPI flash (do not confuse): spi1.0 bound to spi-nor =E2=80=94 this is the
BIOS flash, not the fingerprint sensor
ACPI resource details (from decompiled tables)
The FPNT device declares:
- SpiSerialBus on \_SB.PC00.SPI1, chip select 0x00, speed 4 MHz, mode 0, 4-=
wire
- GpioIo on pin 0x0008 of \_SB.GPI0 (output only =E2=80=94 likely power/res=
et)
- Interrupt: Level, active low, exclusive and wake
_STA returns 0x0F (present, enabled, functioning) only when:
- FPTT !=3D 0 (firmware sensor configuration select)
- SPIP =3D=3D 1 (firmware flag)
- EC register FPRE reads 0xAA
_INI drives GPIO outputs GFPI and GFPS high via SHPO.
Question
Is there a plan to add a kernel driver for Goodix GXFP501C fingerprint
sensors on SPI/ACPI? Alternatively, should the ACPI SPI enumeration be
more resilient to _STA evaluation failures so that a spidev or
out-of-tree driver can bind to the device?

The sensor works in Windows with the Goodix wbdispi UMDF driver, so
the hardware is functional under Linux if the correct driver and SPI
protocol were available.
