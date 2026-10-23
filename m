Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792790771;
	b=JbNiu8chujgvaLDX+Ng+gonNyPer5aqfOgkKwSKJyLSkMMpS0DT5KdBraPV1iMDoFlwO
	 t3voIMpG8EpH3JQPHQ7SMd3LeHB4c+mf46dFuUkbdWSrnrsLaROm24zqVQwaS4du37OH5
	 ng8fvxGxjVG79cjwk9XQxaGFaZJe1+OFfeNMzciBO6WCvwW3D7KV0QSpPvTrQJv24rEwS
	 zXqkguF6M9AFvJVjj4ZKqPGpIRG0+8U0+S7bQ9y7zRgiZ4hFJUhv9x1FfKYHHAYEu0fAG
	 /+QF9oE+ac9OQ0CSAh2gVGK/Ghn3o6lcLFOlJRij6kYS9MSdkveN2zNyd1MvohXq8og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=cVmZ56NB9aG28sLGYzd7bHR+bL7G3c0qWg6/HUYtCb8=;
	b=pIBPT1QUU9VFsDzSPgyKwg+rfP8NbIrROVYtZhkGsf8nv9B4x259tKjMB16zpQdiTNeR
	 w1gv0YJv+8EfBmM5u/DdjBNU+1G8Z5b+ay0/wEgv2TrPP20pdDhufhFxieKZkDbOjQhY7
	 KmYOkM8aZYkrEAGsY4QBZOixl1xX3Ww1b1WPb8O0EoTGlo8mAAtA8yRCuHPR/1SKzQbJS
	 rE/G6AQa2Ka4VLCGXef3u7+7XfRcB0jhzevOkO03196p9/CsaUrurI8P3O7WA5LKzVhQW
	 7FAumBcuJOCBsQzpZS0Oma8kH+OHu8YRVutQjg8m4DyaK6wi1sNNIq0JKDQFlfuDhxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=rutmanip.com;
	spf=none smtp.mailfrom=rutmanip.com;
	dkim=pass header.d=rutmanip-com.20251104.gappssmtp.com header.i=@rutmanip-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=KzNEmhwR;
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA97606A31D
	for <linux-acpi@vger.kernel.org>; Fri, 23 Oct 2026 21:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AA97606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rutmanip.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rutmanip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rutmanip-com.20251104.gappssmtp.com header.i=@rutmanip-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=KzNEmhwR
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6dd4f3f696aso799613eaf.1
        for <linux-acpi@vger.kernel.org>; Fri, 23 Oct 2026 14:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rutmanip-com.20251104.gappssmtp.com; s=20251104; t=1792790770; x=1793395570; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:cc:to:from:subject:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cVmZ56NB9aG28sLGYzd7bHR+bL7G3c0qWg6/HUYtCb8=;
        b=KzNEmhwRJjcu+N/FwlZFkfyXsTYmJkd3UIqPOatmNUW73mhDSdPWIJLGf/BJc8uj2W
         hCyhwFsu+DeOJEs3eYRR3/7WJrLirFxlUh4rmxYIkag0Z0sbXTbah4ZuXOv+wbO3PS8d
         kssFki1mU+wvhr+0ShoRmvWTcztE7hyOpk7SfbdGshrnDrPgA3dl7Yg0zTcG2qBQF7KB
         5/jkbmCjn5hySMOoL1pvCkc26RvNydWe0gXlk1ymxYFIfHfUhBhlFkod3YTVgXk1rnr0
         fx8VxhjsZg4IF4/te+ifukHbQP25gWpt+jxapqeSvR3HwO0Fpf7ap7O4jeTP+NxMeWHR
         CYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792790770; x=1793395570;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:cc:to:from:subject:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cVmZ56NB9aG28sLGYzd7bHR+bL7G3c0qWg6/HUYtCb8=;
        b=fDchniqB7Ocv3+9ssQv2d8kuYXZH0ZeijADqaoU2sWgsiQppPZwaYdExnOGBoEjK0v
         4+ovUcEno5AlR/WPUchFWN5EEoATmhLAl5EEsiBej/IVFfEuYRdMEy0T/Gzy81PQd4aN
         qHoVqNSQJsV3WbKVEjE3eXmBSQR6V/o0vbuiDv7nobckZLl+kyy5LCxxEMYjVsczvJQz
         GqCRrCH0+0Z+o9756gYtcBXcPPNbNDHlvEf2M/gES8dHTEFp09DabzjTtflIMSj/KhsO
         gSTfOnymofyIFND2VK2G7M8Ls17Hew8Mk8WWWp93ajYmWB/APoscHN/6vAR5WWH7yjyF
         zu5A==
X-Gm-Message-State: AFq9FYIPypbgQZQMRl7UMPHi0n9R/f8KH8ANmhKCOSfv0Q3rnoJGjECv
	JIJn/8oqIvXItnE/PHdmUWw2uXhczk/K9nloTmA7XdpRdPK5bpSMWZYwWhbEId9yuBz4Lc4Zhov
	Ete56RBo=
X-Gm-Gg: AYBFou3oauDUNhV3Zmxme0bGmllxWV4SMLLzeNOnHQHSqlmydzZNeOGFYaH6dgKwJ/P
	dd3tGUILsaJ0/4v2aarOHJYWihBa2WTZJs8ARExn5Y+V6dLHVpm2kkDtkRWO5dVYAOR0FhYVov2
	kIMa/wCdRoXZHUaObaUiO7LdEqM6vQ1YG+Glhi31nbvrFf2ehwc4U7IlgxI+HT3ltZgjgHL8fkG
	wUKZzgVxDSBiParGGG9pk4/BBCksEyYEzSN9roIQURmBarukQH41eYCVJnhwOaiVvzGGgK75ynY
	H4vLhjaYAoqEc4QWxszbcNWf4jeWfogjlLkR9xWhibpHeRaLRPE68s5aTZc6qohKyuVjqIgEQXj
	vf+zmO0cuPfw97dr1+cHBTWS467FxcOldZ2D68m/HAWPeFL3+y/KTzoJwkIiKvclK1gKwpkJIeF
	nUBrWLkUkO2P5iIuvop3TglHaNgPe+UVZm0tIoFQMzXkSr417xhmqMXT2/r104MhoBqXpM8R1j/
	iPpc37JSDgCXv+pp8zBBhhsXQHPNPHCNnOiDyteQN94sjml0QeUJnqdeZKFOKskZIR4a3c5wgqV
	1yI/jEVoIQ6acFKab6wyJqTp1uxLl+AQBvI9aFCX7RqxVswc32lH6F2gIKL3ocdSo7feRMygoLE
	g9qUPHCOvGIT2BsM9lKkEoGFjZWNV4yReS202/Qw3+M6+0Ee9miE35rw9AoXtHlYNQxDty4d8DL
	zbK4sHF3hoJJkbJzbh+SVlJDwBCBs9jJ73Tm9u/A==
X-Received: by 2002:a05:6820:a298:20b0:6de:3bb0:aa41 with SMTP id 006d021491bc7-70ba0f93c34mr48329eaf.87.1792790769734;
        Fri, 23 Oct 2026 14:26:09 -0700 (PDT)
Received: from [127.0.1.1] (rc-lower-2.wireless-pat.ou.edu. [129.15.64.250])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70b9df06f1asm365199eaf.5.2026.10.23.14.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 14:26:09 -0700 (PDT)
Message-ID: <6adbd0f1.963fedab.b2414.0d2b@mx.google.com>
Date: Fri, 23 Oct 2026 14:26:09 -0700 (PDT)
Subject: Re: [Bug 221842] ACPI: EC/battery AML deadlock also on HP ZBook Fury
 16 G11; triggered at the end of a battery recharge
From: Jeremy Rutman <jeremy.rutman@rutmanip.com>
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
In-Reply-To: <6ad059a4.b906deeb.1cd909.6880@mx.google.com>
References: <6ad059a4.b906deeb.1cd909.6880@mx.google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hello,

A follow-up with the root cause, found in the DSDT. It is the same in
BIOS W96 01.05.01 and in the new W96 01.06.00 (06/15/2026, EC 9.70),
which still hangs: the first boot on it deadlocked within minutes.

Root cause
----------
\_SB.PC00.LPCB.EC0.GBAP is Serialized and takes ECMX inside it:

    Method (GBAP, 0, Serialized)
    {
        Acquire (BTMX, 0xFFFF)
        If ((GACP & 0x02))
        {
            GACP &= 0x05
            Release (BTMX)
            Acquire (ECMX, 0xFFFF)
            If (ECRG)
            {
                NBAP = BATP
            }
            Release (ECMX)
        }
        Else
        {
            Release (BTMX)
        }
        Return (NBAP)
    }

_Q09, and the second half of _Q08, take ECMX first and then call it:

    Method (_Q09, 0, NotSerialized)
    {
        PWUP (0x04, One)
        If (BTDR (0x02))
        {
            Notify (BAT0, 0x80)
        }
        Acquire (ECMX, 0xFFFF)
        Local0 = GBAP ()
        ...
        Release (ECMX)

Every other caller enters GBAP without ECMX: the battery methods
through BSTA (_STA; _BIX -> BTIX; _BST -> BTST), the first half of
_Q08, _Q18, _REG -> ECRI, and \HWAK. So:

  A: _Q09 holds ECMX and waits for GBAP's method mutex
     (acpi_ds_begin_method_execution)
  B: a thread inside GBAP waits in Acquire (ECMX)
     (acpi_ex_acquire_mutex)

That matches both shapes in my traces:

- Battery: _Q09 sends Notify(BAT0, 0x80) just before it takes ECMX,
  and the battery driver's notify handler evaluates _STA/_BST/_BIX ->
  BSTA -> GBAP in parallel. This is the shape of six of my hangs and
  of the #221842 report.
- EC against EC: on 2026-10-23 at 15:10, with the ACPI battery driver
  unbound, the cycle was two kec_query workers, one holding ECMX in
  acpi_ds_begin_method_execution and one in Acquire() inside GBAP
  (from a sysrq-w dump; NVIDIA's NVPCF notify workers and thermald
  were queued behind it). So unbinding the battery driver is not
  enough, and this half needs _Q08/_Q09/_Q18 to run at the same time.

Every Mutex in this DSDT is SyncLevel 0, so ACPICA's
AE_AML_MUTEX_ORDER checks cannot catch the inversion. The same
pattern appears once more, so far not seen in a trace:
\_TZ.GFVE (Serialized, takes ECMX) is called by GTMD with ECMX held,
and by GTMS and WQBI without.

Fix
---
Firmware (HP): make GBAP and GFVE NotSerialized. Neither creates
named objects; ECMX and BTMX still guard what they touch, and an AML
Mutex is re-entrant for its owner, so the ECMX holder can enter them.
Alternatively, in _Q08/_Q09, call GBAP before Acquire (ECMX).

On this machine: an initrd DSDT override with exactly that change. It
touches two MethodFlags bytes, bumps the OEM revision from 0 to 1 and
fixes the checksum; the disassembly differs in those three lines only.
I am installing it now and will report back after a few weeks. A
caution for anyone copying it: HP ships the DSDT with OEM revision 0
in both BIOS versions, so a revision-1 override would also replace a
future BIOS's DSDT; tie it to the BIOS version.

Kernel side: the EC-against-EC half needs concurrent _Qxx
evaluation, so acpi.ec_max_queries=1 should block it for users who
cannot override the DSDT (Secure Boot, lockdown). The battery half
needs the battery methods not to run while _Q08/_Q09 does: unbinding
the battery driver, or the acpi_ec_flush_work() idea in my first
mail. Whether a DMI quirk for these HP models is acceptable is your
call; the real fix is HP's.

A correction to my first mail: the trigger is a battery status change
at either end of a recharge. The 8th hang, on 2026-10-22, came at the
start of one.

The ZBook Firefly 14 G10 in #221842 probably shares this EC code; its
reporter could look for GBAP in their DSDT.

Analysis prepared with the help of an AI assistant (Claude,
Anthropic), from this machine's tables and logs.

Thanks,
Jeremy Rutman
