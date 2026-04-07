Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6462E719B
	for <linux-acpi@vger.kernel.org>; Tue,  7 Apr 2026 20:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775595266; cv=pass; b=gGSl4JlFRg0GAylG2BMn6WDId45EDhWEFFccdzyHFEb12w9lklC9LhrVcqmRm0tEM+Ii/wmMMsffWjOW70vRhJuQrd45ugaRWWjIsckdy8UfOGo0zdFQil3M3kEeXkZbEaQEVntOghAQkTD2bR4rhoC/MBHsPuRAXtSf7bMa7lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775595266; c=relaxed/simple;
	bh=GbqZWK6hmD58nXcOhqaZTh5og7wqKMlwZDNwWjoc9Bc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=HSOuXfGope7b9yuU9iSE9ppx3487gOJrsq/5q3EiDU7i3sXB+jokSWprcmgu17dujBvJzFdBu48T9+pqNU/8/hAOIZFpf/L5/6PR43HZb4B4ARPwRrlZuCPnUwoFfs8OmX46isl5moXK4vYmLXtWkU1myWPQjEgsXIMl7uaPMpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khr1mTiP; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khr1mTiP"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6500040ef83so3844600d50.2
        for <linux-acpi@vger.kernel.org>; Tue, 07 Apr 2026 13:54:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775595264; cv=none;
        d=google.com; s=arc-20240605;
        b=RlN1QpQM8pOqkUMGo4jX9E7GLmlbqN7TGmUSCZVLypugxdoCRlgXceQ7f826GUto4/
         fFwgUQuPfOZln9WqUCCDsdopyX19dxJzFFxInZDws3n++zbbtzJwzGoJHjnTMRplAViO
         ZsExkYIwqddsIEsaq6WKZAQjfXj6eYJXy+0ce9NJKwBTqITEB/l68/A9sEX2TNDsXzrj
         GINFqytkEU6LDxQ8EJm81MALUaV1nJfvusaPdXiKFCvut5MwAW31GAc9aI/g8rgW9LR/
         FGjCQckCSt9qboIM2Tj13+bOsM1mlWADvfn/+fxtm5CwAkK4BSlVeTsjPjQKXm2GXJn7
         G+lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=FB32mt/InDVL1RdAiT/LiCcwAuWSPBgRDI9AIQasW48=;
        fh=GmFy5nA39On4RWbrn/GETH8dUHq8oY5XORs93v5i3qg=;
        b=WSsAwxlpj87xBv4xazagHNokiy+UrJyCjOIk7nEqnImW3Ehnpo9+7Cj6e8GukBkhGg
         w4zrlOScS1HBXlWXZgIXvE5wKHVocQea9iG1fSPS8HRjP52OH+oiMacaF/iS91Bxzx9K
         g/xi8Cad7qTPHbO0KbL9A5VuamOPtnpvXSlTPw6kkjI1jrPzQE18zTV90MS9dxE5sH1V
         wmw1W/QLDCivBd43TADcpzQ1B7OH6Oxh83rsXnLiG8s6wwhkOQeVbZd5hgMKt84Qr4bp
         50TlSN2YljZM3C1wvWL4gP0JyewFEBXXDEV/dafkgUmxvIwy5SfbCDPUwYlcb7UH/YcO
         xxvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775595264; x=1776200064; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FB32mt/InDVL1RdAiT/LiCcwAuWSPBgRDI9AIQasW48=;
        b=khr1mTiPAiyJHHpwjZrDDqaqhcXDuvnOvzg7hTmqwchN6kd5szdBfkyJdM+A4gbGzS
         R3urpWNhaOLiuAxSCWm38W0zj6iRi6z+czwd20WjDUtP/sXgqtFhVYjaLOyKJGH4p0Fx
         +8Bjg3+RYTZtRmo9RlO9WYXCeAycuUCT9H/J4Q2Nd8M/3PM8m9gfYUbfJ9J/TL4paemf
         i13Hn1iX65IeuUFAK398OU5sFmrBUHmSNmyq1aURAMr+Eu5cU53RL+Wwc0whI6CsPq+c
         XqFibrDl0iMuD5XJ/GisbwFGrpjakJGq0mF7T1DNu5w12OysZkcNuCeuXlCvqBEcm/el
         HE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775595264; x=1776200064;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FB32mt/InDVL1RdAiT/LiCcwAuWSPBgRDI9AIQasW48=;
        b=byCcIPkkIr1dXnxpom8Qja/GDoNu1C98EjOQdCLXYoO+jIYQxFatk6IrCKmgtVbeon
         MA11eytQ+4Mw6hSAcXNm1KaCDVk1KhXAIwhfTpjfsgT/HYFQIM+bjuoFxCawrpy2wGZV
         4UNkdW2lRRR0jKVohwyaYzHMy/V89Hjz5KMCKEvwuwvL1DB6GT2IzhBTFVvXUz1rsJk2
         xZMqgc0dHrIPdL1zaQvZSYfapt8p4c962yB10aRxSQiKU42RAqg6J90MDCOO2pzxaf1A
         N/ZxQawg2c9k0/0tlFCMX6k0TZ+qcs7WKu8YkIp/B/VcQbMqIyKZnjScFEBV/mZKXGTO
         cjtw==
X-Gm-Message-State: AOJu0YyKhhtMt05eS5JIhE6YhZt6SMvQ9FBQRjKAvmL3BdEj2y7nVnF/
	vgnXc8ahUMtArwOUgSeBh0MRL77SUnIf3/Xpq/enABy/RQYynIlwB3hu+w/7fFmUWgKWHmCiYf+
	BD4QjK72epWjXvW95vWDxBHF4vWmUu9BTqAeI
X-Gm-Gg: AeBDieuazhxlAzd57okb4b3LXifuPHYMYDM1k0z5M4z0t53rVuAC+PaZKEXGZj1A3H2
	Gd3LRJ+BFT/SX33djrzLUzPx1iGrDlg1Tk6CSmhe0E6eeLt2cKGrcUIvxMNkBDKVLPwBueWfY5t
	WJSS8ULg9C9l9Ar3o5ZdGgEbOAA+0Hw8EuLxPmFl8r1Wx3QQtZ+0MsrFsAfHz8PT9PoOpXFQUHp
	/EbHqv2EenyD6i7J/15GK7+rZt3lGOoNzE9NVLqlx0bQF5GSwuMf604ZCl8aBd3YXIzrO36ncJQ
	2PIDSCRboWOlYY0j+hACV4Mik59yMFebl5fy4tjnO7yeWDo+0MTeWHpCnrHMwsJYQNo8DUIVJgR
	a0WE0JYy5/ZPWTurirnCOiFba2w==
X-Received: by 2002:a05:690e:4849:b0:650:2ff9:d678 with SMTP id
 956f58d0204a3-650487277f2mr14027671d50.29.1775595264419; Tue, 07 Apr 2026
 13:54:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexander Zubkov <zubkov318@gmail.com>
Date: Tue, 7 Apr 2026 22:53:44 +0200
X-Gm-Features: AQROBzCiLek94RxAsY8iH9Yjf7CtNWUTECNhWnxZxI9_06Ct0ycMduI0_IacEBE
Message-ID: <CABXn0zehxT90bNogCu44fRu4ANZmjjrcd8WzX_ms-Bb_JxA2Kw@mail.gmail.com>
Subject: [BUG] ASUS Vivobook M1502NAQ: ACPI DSDT namespace collision (ASMI)
 causes early boot hang
To: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I'd like to report an ACPI issue on an ASUS Vivobook 15 M1502NAQ-BQ067
(AMD Ryzen 5 150 - Zen3+ / Rembrandt platform). UEFI version:
M1502NAQ.302.

Linux kernels (tested with recent mainline live images of Alpine,
Void, NixOS and Fedora) hang immediately after bootloader when ACPI is
enabled. No output is produced, even with earlycon/earlyprintk:
earlycon=efi,keep earlyprintk=efi,keep loglevel=8 ignore_loglevel
initcall_debug acpi.debug_level=0x2 acpi.debug_layer=0xFFFFFFFF

I've tried various ACPI-related options, boot works only with:
* acpi=off (but system resets with no error several seconds after the
boot, keyboard does not work)
* acpi_no_static_ssdt (system boots, keyboard does not work)

Notebook's firmare was upgraded to the latest available version. I've
also tried to boot a windows installer, just to check it is not a
hardware issue. It boots normally.

I'm not an expert in ACPI, so I used ChatGPT to lead the debug.
Although I suppose it misleaded me sometimes, it turned out to be
useful, because I found a DSDT patch that fixed the issue. Most of
debugging was done using Alpine's kernel 6.18.21-0-lts.

The issue was traced to a namespace collision in DSDT:
* Method \ASMI defined in global scope
* Method _SB.ASMI also defined

ChatGPT presumes that unqualified calls to ASMI appear to resolve
incorrectly under Linux (ACPICA), leading to a firmware-level failure
during early ACPI initialization. I dumped ACPI tables from UEFI shell
and tried different overrides.

The minimal fix I found is renaming the global method in DSDT and its
single call. After applying this dsdt.aml override, the kernel boots
well without additional acpi options, does not reset after boot, and
the keybord initializes and works well. The patch looks like this (and
I also increased the revision number):

--- a/dsdt.dsl    2026-04-07 18:31:52.727022684 +0200
+++ b/dsdt.dsl    2026-04-07 21:30:04.393990891 +0200
@@ -10138,7 +10138,7 @@
             SMCM = Arg0
         }

-        Method (ASMI, 1, Serialized)
+        Method (ASMX, 1, Serialized)
         {
             AL_D = Arg0
             SMCM = 0xD6
@@ -10151,7 +10151,7 @@
             DB_2 = Arg1
             DB_3 = Arg2
             DB_4 = Arg3
-            ASMI (0x80)
+            ASMX (0x80)
         }
     }

Is this a known ACPICA behavior difference vs Windows, or should this
be considered a firmware bug only? I can provide full acpidump / DSDT
if needed.

Thanks,
Alexander Zubkov
