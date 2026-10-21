Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792558722;
	b=uvlaJqzhlEzf5PucMnDElgk2u47SVp7RHhfHBCEajt4iuamvkr08L594dWNreRohr7f0
	 xyBacr/dbFJZl3A1sEGb6TbYfI1VzDxKNPHnHJEibKxfuKt8lY0Jovj/6ZhvYb8Q+QdpD
	 yKugDE6+F8Z0wnaXUxQ2YoF8V8LsNljM+acdNcUlRSNRSbz6ZLdWx+f/Hpqlos3tStz2N
	 kSfBNIZf3dpiQd6VblInGn0RLuqtBPaKGnA6bbQAf6FNz9e0TlmNYuLfbfq6pMG5Prh1K
	 L0MCXiv2INnQvDcEyZNKSvuPlpPoMCchaZHyAxaEWZu7CGyoeqr0OY2XpVxOeL3jKIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792558722;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=1A5vWPfzXmURnJh3IOMTPK7uEh1Ro9Aj0hKW+NQ7k5M=;
	b=fDzZYQesnArgapxmG/tl0zFqzvkQaOmVLbYx3JvmDsfHXdelhnIfSxVrmKEXh6cz4cDE
	 FZHE4cCa52CSfmy6/6T4ubetrV3iaW4srNQT9ylmfZy1wCKOY376YP4KJlqYGmX1WK2+5
	 K6rfvsKkvyx9UmvJI1ERAhvTbT330sKVdY7xM8Bg6xFLNmH6xhB/x8Evu3ZgtoK60HwTF
	 j/oUTnOWRuOWWXVNya+e578LpagtiwUx7qN6vjyL0dNxmLKJ4XI7Z7P10mMnNIxEmWD5S
	 Xuam56czsVmv21VfrxA9/bOPh2vzJrIUOhlqlCLYUuWZf7fMahO6/V7jcOzq5Y9kdLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="GDe/NFTj";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE43606A31B
	for <linux-acpi@vger.kernel.org>; Wed, 21 Oct 2026 04:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAE43606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GDe/NFTj
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso337674a12.1
        for <linux-acpi@vger.kernel.org>; Tue, 20 Oct 2026 21:58:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792558720; cv=none;
        d=google.com; s=arc-20260327;
        b=gkA04Updqdeviyg2SyorDOyz1dg3fxIeL+MdiP3u/r0ohWwjDBfqguYDhSji4vzB2/
         SEkVf7FixeEi1K9ej/CXN1MA5IAjx/KW9bf0NPNCK4dAG+UDRoCp9L4b2zjHDvIkKRWb
         pNkEZHBdQx7Z05/whNFVwuDQi/v2ESzAMJERTae/KNXOcs8/ZDrDgdEW8/ujbrGh2Q2T
         4Y7DBRV2QEnLJgAgUS4CXhSCMJJiogsAhNM8S9xts+9b8JwPIk4mezy0KHQy0SjFZnZM
         Lkvvl/1Y5Nw4FLCNYiYpl9CdSucVeRULrjyi2R7rult/G7VRZBp1jP5zSm06BDA4Qi+p
         cM/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=1A5vWPfzXmURnJh3IOMTPK7uEh1Ro9Aj0hKW+NQ7k5M=;
        fh=QWb+bMVM57RCf6O5oWQcwJ3IipT5bV1f0adVi0mFSK0=;
        b=LT6kIaR3y3N/ztytvt5H3T5495e/3wptsyNwWnNCvnmlnNNFjudK7OUPJA6jLJTKfl
         34fYC5xtrC4g3DsA6Q4xl7FCrAwmO3OeiHLn5GzxdcMsc767EucnIF4Sdx+1WSKXiYBv
         OUZXlU+BeMFL1hX4d6CuXlhrzAafxBJ1vIQ9TmYPlRKPSo8IPQDq8fHvsSItPXQWsL1O
         QMrAEdluzOZr70zQPwNOfpBaBQxutPikow8tas4TtQH1rBax3Thf3pmjlLZCL1mKXLFa
         hBECbcT0IJTyU9U6G9c3ja4JVebadFwrez5HOVgPcCPrhuLbhFihQNvEKGJDOIXpLUw+
         C6JQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792558720; x=1793163520; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1A5vWPfzXmURnJh3IOMTPK7uEh1Ro9Aj0hKW+NQ7k5M=;
        b=GDe/NFTj9YIGLIgeB3tlXXf5gmjIk8gSzbebF6kz4aN2YuDoVRytx09zHP+24DnniS
         Rbx7pU4+aS/HAgkuBdP+C4xoeqnBiHdUJHvwWV+Rs/y8R5WpgR1ju8TX2b2TdvUEcUqy
         ZxjXk/sy4XyfsuBhoZUozCwmR1TyCh5pJ8LyKyvOYERkU8QiXAwMmaKKrMwme1T/ASxT
         IepWKEvLA1et+mZoNfLj8ImLnSHopiESMNZVnxzIzyMTUO7DnwZyh9/4NONn3o+XzF6i
         ODjAMjLVepguf8vMPoTQbN4wPQoX9ORj1ogXm3zUlxunx1sgCoJbxGj4wBklcXlhlLbf
         IFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792558720; x=1793163520;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1A5vWPfzXmURnJh3IOMTPK7uEh1Ro9Aj0hKW+NQ7k5M=;
        b=ZbbOtro1tzZQjLOCdpyK3HbJwUCFZWUh6ohB/QON+Mo4KX8AZrMvIHj4GE2ajETVtm
         +G2nhMN81DY1R91MSs7dj80sw+ZbZab4AkLuFVvtrRVlhX7ssksTEa9KZdl2u7goU20X
         OdYCfnGpoytfaojQdtAL//CpgeW3mot+sat+ffnQ4o1xQWBMI6DkpV+UgPBUlQl2ekmO
         jRXu8iTnLvXTC9WGT+Hu3a4INNUEk/5CkXCJNLZzTk/IYRX9v8Td6pmn4rGUcYyLz28L
         lAFuXRCAldndgP2NkkOc/ahQLW5Bmd0/YYg64dWs2Txk0auvS0RWev3RxrcOjd7EfuE9
         uI4A==
X-Gm-Message-State: AFq9FYJtDdlumfH/lOExHsFhoQAjkLGQyRIHX1s9NLIqul+gcKK1BdM1
	kXtwL56cZ0Vre6d7EbnKTVttOEE5efThVEdCH3FtwbK6K6raAS3PNtCB4OWxXXxQwJNs/bBjq2v
	l0S4+Zx3JWHQ+TXsUwcklHALS2TizTjVulTTE
X-Gm-Gg: AYBFou1NfbzUWivfjQPtygk5qh6xVp11fyxH34KCy9QCKxqBjVNW4fQO313YdJPVIbw
	gjaZAb7GPwzjY9nfTV4umNNqzi1C267RCtebzKIBjj8A5JyGxcoJ3b/uDI2pxXLoZOBXMlrUlht
	HytXWJg4010vS9L2j14NWnJWlGhfs1NBnR3FrabDFe92VCUQkcURgBfUeieT6fxMT0H6zMmVEKm
	ij8MQR1EeidwRZ6yptDgpM8WA2oXAES0k+qmVW4OSU5JnRDqvUWZ+DVO90Xy8S7ypVtv9V1kU+e
	OVuZaZLbBvpvPuPLSDu/OyltlHDM7sGqcoj8YLmgRp6WjdkKZZo5DH8ho3EPP22kWUvVLkmicT4
	Knvjz481GNyCyreLq8Gmim9ktrfpnApN2I9V9
X-Received: by 2002:a05:6402:461a:b0:6ac:7868:b690 with SMTP id
 4fb4d7f45d1cf-6b408ea0819mr370267a12.8.1792558720180; Tue, 20 Oct 2026
 21:58:40 -0700 (PDT)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Sneako <dogg123456789@gmail.com>
Date: Wed, 21 Oct 2026 00:58:24 -0400
X-Gm-Features: AclHuK9BwCRQ9D5n7cgXqtTagXZ0FVJpq2wT9TZyouAzuCvT-oX37znOxUsdfVw
Message-ID: <CABXKy5Ln7m_ixqn_hi4WRH8N4Jx7FFn9GMqTzkKz-FamCf0ZaQ@mail.gmail.com>
Subject: [BUG] ACPI: s2idle: Microsoft LPS0 _DSM revision mismatch prevents EC
 standby on Acer PHN16S-71
To: linux-acpi@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I would like to report a reproducible ACPI suspend-to-idle problem on
the Acer Predator PHN16S-71, for which I have identified and
experimentally verified a specific firmware compatibility issue in
drivers/acpi/x86/s2idle.c.

Hardware and software

Acer Predator PHN16S-71, Intel Core Ultra 9 275HX (Arrow Lake-HX)

Acer/Insyde BIOS version 1.28

CachyOS kernel 7.2.11-1-cachyos

Suspend-to-idle (S0ix); no ACPI S3 support

Problem

On Linux, suspend blanks the display but leaves the fans, power
indicator and performance-mode lighting active. Windows correctly
shuts these components down.

The Microsoft Modern Standby _DSM interface (UUID
11e00d56-ce64-47ce-837b-1f898f9aa461) is detected, and the kernel
reports successful sleep-entry and sleep-exit notifications.

However, kprobe traces of acpi_evaluate_dsm() show:

revision=1 function=7  (sleep entry)
revision=1 function=8  (sleep exit)

Simultaneous tracing of acpi_os_write_port() shows none of the
expected EC commands during these callbacks.

Firmware investigation

I extracted and decompiled the laptop's BIOS 1.28 DSDT.

The Microsoft _DSM implementation executes its function dispatch only
when ToInteger(Arg1) == Zero.

Function 7 performs:

EC0.E3CS(0xEC)
PGPI.SGOV(0x00160C8B, 0)
EC0.E3CS(0xE4)

Function 8 reverses the GPIO state and calls EC0.E3CS(0xE5).

E3CS writes to an ACPI SystemIO region at physical port 0x6E.

Suspected kernel issue

In lps0_device_attach(), the Microsoft _DSM is probed using revision
0. However, the shared rev_id variable is subsequently set to 1 for
Intel's separate LPS0 interface.

acpi_sleep_run_lps0_dsm() uses this same variable when invoking both interfaces.

Microsoft's Modern Standby firmware notification documentation
explicitly specifies revision 0 for functions 3 through 9.

Consequently, Acer's Microsoft _DSM receives revision 1 and returns
without executing its EC sleep commands.

Experimental confirmation

I constructed a temporary Linux early-initramfs DSDT override,
changing only the Microsoft _DSM revision condition to accept
revisions 0 and 1.

With that override:

All affected fans and lights shut off during suspend.

The system wakes normally and the fans and lighting restore correctly.

The same machine, without the override, retains the original faulty
physical standby behavior.

No BIOS flash, direct EC commands, or fan-control manipulation was involved.

This provides strong evidence that the revision mismatch is
responsible for the missing platform standby behavior.

Proposed fix

Use revision 0 when invoking the Microsoft platform-agnostic _DSM,
while retaining the existing revision selection for Intel- and
AMD-specific _DSM interfaces.

I believe a generic UUID-specific fix may be preferable to a
machine-specific DMI quirk, since the Microsoft interface documents
revision 0. I would appreciate the maintainers' assessment of
compatibility implications.

Separate NVMe issue

This laptop independently requires nvme.noacpi=1 to accumulate Intel
S0ix residency. With the DSDT override but without that parameter,
fans and lights correctly turn off, but S0ix residency remains
essentially zero. With both changes, physical standby behavior and
Intel S0ix residency work.

I am treating the NVMe issue separately; the proposed _DSM fix is not
claimed to resolve it.

I can provide the original ACPI tables, kprobe traces, before/after
Intel PMC captures, and the precise DSDT override.

The issue was reproduced with a CachyOS kernel, and the revision
mismatch was independently confirmed in upstream source. I have not
yet boot-tested a kernel rebuilt with the proposed source change.

Microsoft specification:
https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/modern-standby-firmware-notifications

Thank you for your consideration.
