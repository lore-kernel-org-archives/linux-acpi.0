Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793248189;
	b=RqALJnUJRRoCj/MghiaAoWgJDRW0QGuKjSALN2ssCFTPhjU7MKB8TF4dpehMRHTCCMr3
	 DnZjZ7Ge1hIk3gNMgiezDNXwLRT5SFYaatZYsM27XywsioHrS5H3Y81b+NGqog3WLti4o
	 7R9DS6jgFCwu5VL9rK0X7Sfssvvr2JBkqTCRq3wg6c/07GD6BcPy7Gx8ZP0l+VEwop+f8
	 KjvDgQkaCh8V2VfCxk2tkm79HxQ4kcojR/zxVuKkSiF0icOp7aMYzMg88li7/McD4b9BM
	 GqPJwELesNhdTx4RAxysDAAXnlVVP+Gm8QVZLA4uSdQ2fagp+9f6/xvC5pYkm5/P9Zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793248189;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=2v9X286eHXnfj7vVIBlrDtO4dvnU19pvNA3RaP6rKBw=;
	b=FfNSp8hXREWeJJyuZXXry6NYeUWwIGV6jYFOmoQIpfLr82VF2rn21m9z+6Enbc1K9MzW
	 0MrRhyslA36TJdI5okClO40IraXsyVY/5A+2wkxUG8wNy0SgHs3tsDE6gB3jlRlU10bYc
	 hDveO+PNi1+Lsqnyv7xMmtLr0E2s2Aa7aHiORuJm9KAXX4326ye7/dGeYixdGLAIIdP9H
	 SPFxRotDoe1pubGoCBYtQhJ4aOHsspBEvl/f02jymHDh1CYoT74BQG24PezoCjFAtZmfr
	 xWvl4/G4EQGZo+T4Pe/89/79pXUCL+R0cL6AQnlYKnpJyqKSwwsQEWtnJDP/Iz/oubg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="L/VUVHqc";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.46
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA37606A31A
	for <linux-acpi@vger.kernel.org>; Thu, 29 Oct 2026 04:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDA37606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L/VUVHqc
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5bfa65c8617so1071249e87.0
        for <linux-acpi@vger.kernel.org>; Wed, 28 Oct 2026 21:29:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793248187; cv=none;
        d=google.com; s=arc-20260327;
        b=AbNm74CRpF6RpK5iL+0ln3eagesT8TTVFTcw4CIZvnpCowNyxnxydO/w/tFtyliKj4
         eICbVCk6miDHXt9d5852JFSl/Qj5yoxH2kwAAOSJYYvVFy/09h9Eeddpushz/ruQuaQb
         rfG3qoabA80rO+gMWZozTQmGO1hMyJ8v0IdaaKRJdNjIgDzaxL5xhvGvxof1+D4Na2FP
         h8Dq9fYvLc/EHgQ4lS16hynJ8BCVfBekRy8N/O48jspqYGLvst7gY93qUJ6vEmnqyXJg
         u2qmTIw6Bi0tr5ughMdfys5I1RywBxz2SRMGnINXkbYNw1hKQW1NNir1yzKgmW6uxzMq
         ZYhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=2v9X286eHXnfj7vVIBlrDtO4dvnU19pvNA3RaP6rKBw=;
        fh=GmHMUp8a6GOiKZ6+asIK2DG3/LMvqMWGbX5mk5duJg4=;
        b=BYeaFgmQQjajOVL/vtF2XPAVmITPwgb8zTs4x2UOL1slPVIlmbqOrm4YQBPDUVqYfp
         UT0MrEgzGby5CXG1FCRd0abbg0LDSYE7NysBesoneHiiojErGWr2jOvJwzqdpqnR651F
         gcdctE/FKe4nHPI8IMrycuCF25WqFfqSC73M/LjnwAi7vwTaLaWozTmKvh0jXVK06yEc
         7Uj8WOoE7kSbTXcVGXcRmjH6FgNDxonGViyFl+H9Rrt8sO/GVryQ918jCk0AZP70Hh7h
         BpH2MX005Ma3xT0UJnip8ty4mtXtlFiHRyxNkFjw+Zx+5RP0RicNPQ9eS9qXsvJRsFq6
         dihg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793248187; x=1793852987; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2v9X286eHXnfj7vVIBlrDtO4dvnU19pvNA3RaP6rKBw=;
        b=L/VUVHqc5nPZk3zd48TDb8t1KU8rOMh6Q36z0y2dVTfm5jEg554Yu/Fo5O+PIcEiNy
         nA9KEvWjn6K4jJ3kIYwjJ/8CvfGClMcl7m5ipt2E427wiOrV1m/Nh0i9VQuTziN3Z0b8
         tw1G0Jl8xtgfb41vWCLe4B/aG3gjmOq5JvoKcgZnRq+sqpY+E7BFd0mrBtl8CEwKeNsp
         gjDZMtDDyim2fSZtbSmVpiN1xJ3VsnCm8pQQ5FuQskTRNaYzCf3mA/BZpEMuLBlPFhjn
         iPind/qi96fJQp8jnLHFbw8W9+roJbrQzF9Q08ZkJuHMM/om1eh4FJwOCG88WRodYU8i
         0dDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793248187; x=1793852987;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2v9X286eHXnfj7vVIBlrDtO4dvnU19pvNA3RaP6rKBw=;
        b=EF3F3bY12gwIMoe9qt47LMoTpGnOLnIa94FSlIJaovb57CRPr7zcE7v40hr5UPNgEu
         Q7J20xCf2aTojUcve7AyvoGI/aXh87G4S1DUUBJajWlg2mV0tpuWV5vQDRv7Vo7s5q0y
         GzcQjmqBQ/MMUmG0EKHD864TuJSLWfBL+BPfb2LRXEquKZwtloSr5m/ixObFy4i+Hyg1
         DWMJjvLSEA8nYz5EeROLKuosb/HlRgLYj3q7r6QMUZSEi+8DF3oB5gPKyhyHQzjV/u9b
         fLU0UY0PDws1VbwLGuKW36ytNuJ5sIf8LHvl5w9FQxS2E7UAh47ReXiUItNMpMFT31Jr
         6zVw==
X-Forwarded-Encrypted: i=1; AKwUvBw9Tthd6V/csuiHlKY52LeVIZiNsnVv7L+oYgE37Wrg7DF463JUn7jSIW7rbaHlkabcTOg1KHOKnwGW@vger.kernel.org
X-Gm-Message-State: AFq9FYLHb/WljW30ExzzA0aR/xfnCdmaIZeO5vK+6ZWvnCiI9lqSUSUA
	ZEXvYPgPuB/keDNQQiNpopfbaHTGwLI3LMUSQem82qiLCqNf55dO7Q4uW3H2q5t2LsTkuJxWTC/
	GpZErcaeZWhXySS33uOvah/sW/O85Q8NF1em8sKw=
X-Gm-Gg: AYBFou1m/F2RQZanZ7+sC0x2k0gKatvsmO785nBrojmxz4AFaHPapt0qRI8AUFBBoKq
	XjhUQ5L4WgPze+ygBK8XCzTt+v9PhdUFw8HUc3ECCKRenCNVHOuNg5X2kcUegMCA8t8IPHdcsc/
	Kk33aGUm1KKTM+ZGnyg/Pyb/levzQ++5oHXcCIW2Auq6H0PpTNBe2v40y2EMQQquQrmX38G4i1Y
	Jyys3VDly2MZbq9XEHsAjmLdlp7++iIO8rv6KC3oThykLZ4ptyXPgPabgKBEOM3BeFR4HycKNV/
	NZtVIxz40DDV4CwRpjzO4ZAFuJgcbKd6Kl9s32xg9e9HCVUpMxEoK+L64/zIxmmPosNnIwu1Z3e
	wnin4sB+bmMx6mcxrsBbcRpI7L38NRuGKf2FHjA3YqJfZH68PkhNVg0AeWuCRW9Gme36SymaEQk
	eLbsZsd4gau8A7ATEbKj0xu6dRqNsF9oIE5+QoO6ufPHnZ7oRMn9sl
X-Received: by 2002:a05:6512:3d93:b0:5bf:b8f1:80dd with SMTP id
 2adb3069b0e04-5bfcadfd193mr1449962e87.54.1793248186720; Wed, 28 Oct 2026
 21:29:46 -0700 (PDT)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?Q?Mart=C3=ADn_Murillo_Henr=C3=ADquez?= <martin.murilloh07@gmail.com>
Date: Thu, 29 Oct 2026 01:29:35 -0300
X-Gm-Features: AclHuK-GyyO0OVTy1R0rXZ9gZPd37tLuubQzEuDsRJ2PwOTdiuIIoftlp1gzPrA
Message-ID: <CA+Qax5=+tC_Us4sZ=QiKxVzYmYZ-W1+Sm8Abnderck4LNcnudQ@mail.gmail.com>
Subject: [BUG RESEND] ACPI: EC: Samsung DMI quirk breaks s2idle wakeup on
 Galaxy Book2 (NP750XED)
To: rafael@kernel.org, linux-acpi@vger.kernel.org
Cc: josh@joshuagrisham.com, "lenb@kernel.org" <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Resending as plain text, the list rejected my first message because
it had an HTML part. Sorry for the duplicate if you already got it.

For a few weeks my Samsung Galaxy Book2 (NP750XED) often failed to
wake up from suspend. After closing the lid the screen stayed black,
and the keyboard, the power button and opening the lid did nothing.
The only way out was a forced power-off. When it did wake up, it took
10 to 45 seconds. Windows on the same machine wakes up instantly.

I tracked it down to the Samsung quirk in drivers/acpi/ec.c
(ec_clear_on_resume, bugzilla 44161). It matches on DMI_SYS_VENDOR
only, so it also applies to this 2022 laptop, and here it has two
effects.

First, it sets ec_event_clearing to "status". With that, wakeup
events from the keyboard or the lid reach the kernel late or not at
all, and pm_wakeup_irq shows 9 (the ACPI SCI). After switching back
to the default at runtime with

echo query > /sys/module/acpi/parameters/ec_event_clearing

a key press wakes the system immediately ("PM: Triggering wakeup
from IRQ 1"), 3 out of 3 times, instead of 11 s or more. Setting
acpi.ec_event_clearing=3Dquery on the command line does not help,
because the DMI callback runs later and overwrites it, so I set it
from a tmpfiles.d entry after boot.

Second, EC_FLAGS_CLEAR_ON_RESUME makes acpi_ec_clear() send QR_EC on
every resume. This EC does not answer QR_EC when no event is pending,
so ec_poll() gives up after 5 tries of 500 ms each:

ACPI: EC: controller reset, restart transaction (5 times)
ACPI: EC: Command(QR_EC) stopped
ACPI: EC: 0 stale EC events cleared
PM: resume of devices complete after 2511.998 msecs

All 8 resumes I logged cleared 0 events. Only the drain at boot found
any (2). As a local test I cleared EC_FLAGS_CLEAR_ON_RESUME after
boot from a small out-of-tree module. Resume of devices went down to
about 153 ms, the screen comes back in about 1.4 s, and lid and
keyboard wakeup keep working.

Maybe the quirk could be limited to the models from the original
report (530U, 535U, 540U, 550P, 900X), or acpi_ec_clear() could stop
when SCI_EVT is not set instead of sending QR_EC. It would also help
if an explicit ec_event_clearing=3D on the command line was not
overwritten.

Machine details: board NP750XED-KC1CL, BIOS P15CFG.041.240910.HQ
(09/10/2024), Intel Core i7-1255U. Seen with 7.3.0 and 6.18.55 LTS
(CachyOS builds), with both s2idle and deep. The quirk is the same in
mainline.

I can send acpidump output and full logs, and I am happy to test
patches on this machine.

I used an AI assistant (Claude) to help with the analysis. All
measurements and logs come from this machine.

Regards,
Mart=C3=ADn Murillo Henr=C3=ADquez
Chile
