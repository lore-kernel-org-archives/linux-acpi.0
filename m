Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FCD52E079
	for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074088; cv=pass; b=RySAjTQKztIymQtIxYY83lWnpBwSzcNeQ6h8RUf+pyQnhuufIPJ4RsSkGTDfyuKRjdau4lEB5ZrYkfIrBnaYHJlgD7avqhGPrA3E0S3Irs7eYgeZ0xoelV+HGsMnH0ht+cLWzbkfquvUsYcFbB8g5Pv7DdNuRH2kiQEZXjjQZt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074088; c=relaxed/simple;
	bh=HayAmmLBI/WF/AkMleopvPrrdy1dOmE7xAMyDaxUghs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rqbB3CWNrlReAovcPZOXZvJ6fOLYBR14EdzJiePOZXjFKhX+YNzjzF+4xzvSWIAte0V04Dfnc8fGEh8VskH7Qi2yi8bkksAUbRoENwTLHtVu6JHISWR/t9yjOSfvsD1EnjhLwucZR7uhrhKFcG/hgfFtRnuycI7MY2IPN/D+2L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9t4XZf4; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9t4XZf4"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c263415982eso695610866b.0
        for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 07:21:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792074084; cv=none;
        d=google.com; s=arc-20260327;
        b=MbrEJi7sO15FENxWw/KaNxOiLEJuT/zsU5zQywcoe8RnJZoWAExZD+WbsZS3Gy1AEX
         7O6zAS2T51TJWrgkYIQ9BaI84u8P4EMcegsYW8IYprPYG9E9+XSJElkapKvVlOTq05zJ
         Lfcms7xzsPA7uRnR6r16Z5Gub2fKfs4xb9a+oW/Wjne/hX0PFst626u3jm5O7DHMfBqa
         sHAFB1MOQE7ybD7uvQDzDzrNVkMzpAjs0xHrMwZWDOz9JhkwXl9y3gKoatq4b2xKJWcb
         oq90ihzAgUI0VsN6aP08xhWWcEus1wcM2m3cESmvXwAi+HuVA3fSqxnTBKknQ6jGHMb3
         i/jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=/8EK0KxjKp+jZTxkjps+lH3/bw/OLb+7lXjV6iL/Kg0=;
        fh=hM5OexnVYy/8jq6aX4MvEuDpUUNLQgdoWzpAFEHH3y0=;
        b=gMAGNFmHffIA5O0fdUGppDLkghR2Plvwp3N/o0CensldN2Bt7QksWORBBNblRF7H4P
         N/uHehWllCKtEpgsUxWJcaxe4TzVX8pA+eKKsUa+SPVdypAQTulr8hBTLXaGlO0VHDkG
         qMKs8OFzNEzfx58jtLFjZhJLIhkeIVnk21lnVV3s3fpBf0eln3T6zeRuzj6S7zMFR1Yj
         +4JC6QycFSotANhUqWGNdfi6uOJ3jWZKEXWFG5BaesPlMO/ne+5NATpIUWgBn3Ye6Jls
         CFkEPNMC8ddGY1opq0BVC96aZzjH0LpS0uUgK98Cs/IUpGpdO+ijUuFLRU/FvidUiUlC
         R3KQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792074084; x=1792678884; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/8EK0KxjKp+jZTxkjps+lH3/bw/OLb+7lXjV6iL/Kg0=;
        b=a9t4XZf4lD2RH6Opnxarq8DY5cG8RuKSSxlox17uQS16Q1eTCERhSxvhLUPsiFVY/f
         2AQI7VRn7qPkDK+U8qg7Ch0yWttplnGd91uu1yYM1uCqcFo0/Nhxodg8OTgOps649y71
         q+g6QY0RlacumowbPGNj4m/JvCtA++xWMxxpXvTld8gtjTWCC6GumNaCSzxiOTIcC2nG
         TMu5r/6RrUgRRK91kFx4fnzueF0RQlJrDbaGOVC1/JMeDfpwwMOLbwMddjg9ztlCOTAH
         C2zgFqGRrRgx6ag6Gmsb/0oBDV/SyncCiJKM20np9K2b/lqEDe3Bd8rsNDuteF2nO1mk
         7sQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792074084; x=1792678884;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/8EK0KxjKp+jZTxkjps+lH3/bw/OLb+7lXjV6iL/Kg0=;
        b=hMR59A3YyQ0W9RaunVOqalihKKR28D4NC/ufO70k0dFMw6GFcZZw5ds6qnaGOcNDY8
         tehrqxjC+fzGoF0C5NAeHESZ/63oC+kcphl5BVTOaJvhEDRdlSFOkWsW3raHbgdiJgTy
         Kz++67dOFeTapxe7UTK8iI4ye2RC1+hapMwVI9gInuLDgVubKA+tHgR6DQ5R4OVeo3s4
         S3lxWnwS59dA6nrHPyv36INNuuBAMV32PL/KihpWYfx5IhiRQ33T1qKBwSwH5Zg1Mktf
         8Pj2UscipaDGBAA52cV5Uhgujq08HDwVvhDZvqXwI7bpOTkixQJi7kPEAUpuxj1XrpKx
         tDRw==
X-Forwarded-Encrypted: i=1; AKwUvByNRPNdvhjqDDxzHzoOY9dbewmE/Dho09YyxgCO3txetkK+LsHvY9BmcJB3aWDdDclgrQ5IWrIbvd8+@vger.kernel.org
X-Gm-Message-State: AFq9FYJjorCHhUnZvpn2/HcdVEd2hKGk54/7E2NDHlHBpSf6vgJ7t6PW
	gtdIHOgedcTUvLnQpH6jP2gnBD/Rw6rHvtU9XnUXX4Wr1w8q8s9wHHptt6LlHaU3BwYQob4KpaV
	5OEcQYsh6ZlOdsdYbTkf46aciLsOmE0s=
X-Gm-Gg: AYBFou1cuK/Mq/553vkssQQ76dGXnHXF0UOwj2UZQ5hFfgge7SIb8F215pIsI4YllOL
	k+to2QSXQsUUOsJ/vz3fXGUIfn0OumXFKQHXW8LP851GBtHOUGpjo5NclRIM2E5fhtfH8I4xPSN
	0xK8b0M/61j4WuGtNcRSt5/YS6/4fGTOJgYUuOev2VpF2xYZFzva9J9AEjMh7fz6ObPV7r0VAAZ
	PrQGYm3BGuMSbl7jcZpSvsUe71/OFA8r8G5MTzME6blOGooIp/zH6sGJjx7PEbhiYmV33cGv0dH
	9YN3l9dyv1efa8IUolT/HjnWH1FLilC1vM33vYpTecjqUoTmautyQ0bOOZksXQau088NHiA44lO
	rryvc8Q6vCg==
X-Received: by 2002:a17:907:7ba3:b0:c29:f5d5:5aa1 with SMTP id
 a640c23a62f3a-c31aa097acdmr1897928666b.43.1792074084318; Thu, 15 Oct 2026
 07:21:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nikodem Sanecki <nikodemsanecki@gmail.com>
Date: Thu, 15 Oct 2026 15:21:11 +0100
X-Gm-Features: AclHuK-uMeM2OT-1SvHDE5B8L4CFd9ifGhVLzzenOjl_5vJC1fOzzee1rHAuyPI
Message-ID: <CAAUQFROUNCJo7EUn4eiDxSTd6pfPcQDP1_ma0G2k73DJtMnNVw@mail.gmail.com>
Subject: Hello, I'm reporting a Caps Lock LED issue on my Lenovo ThinkPad L13
 Gen 2 AMD running Arch Linux. I found a workaround that completely fixes it,
 and I hope the findings might help implement a permanent kernel fix. **A
 quick note:** This is my first time using Linux, and I'm a complete beginner
 when it comes to kernel development. I used ChatGPT (GPT-6) to guide the
 troubleshooting process, analyse my laptop's ACPI firmware, and interpret the
 results. I personally ran the diagnostic commands and verified the observed
 behaviour, but the technical explanation below is AI-assisted. Please correct
 me if any of the analysis is inaccurate. ## Problem Under Linux, the physical
 Caps Lock indicator LED never illuminates, even though the Caps Lock key
 itself works normally. The LED works correctly under Windows and during
 certain stages of boot, so the hardware itself is functional. After
 investigating, GPT-6 identified what appears to be a conflict involving GPIO
 11 on the AMD AMDI0...
To: westeri@kernel.org, andriy.shevchenko@linux.intel.com
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Resending this report in plain text because my original email was
rejected by the linux-gpio and linux-kernel mailing lists for
containing HTML formatting. Apologies if you received the original
message twice.


Hello,

I'm reporting a Caps Lock LED issue on my Lenovo ThinkPad L13 Gen 2
AMD running Arch Linux. I found a workaround that completely fixes it,
and I hope the findings might help implement a permanent kernel fix.

A quick note: This is my first time using Linux, and I'm a complete
beginner when it comes to kernel development. I used ChatGPT (GPT-6)
to guide the troubleshooting process, analyse my laptop's ACPI
firmware, and interpret the results. I personally ran the diagnostic
commands and verified the observed behaviour, but the technical
explanation below is AI-assisted. Please correct me if any of the
analysis is inaccurate.

Problem

Under Linux, the physical Caps Lock indicator LED never illuminates,
even though the Caps Lock key itself works normally.

The LED works correctly under Windows and during certain stages of
boot, so the hardware itself is functional.

After investigating, GPT-6 identified what appears to be a conflict
involving GPIO 11 on the AMD AMDI0030 controller.

Booting Arch Linux with this kernel parameter completely fixes the problem:

gpiolib_acpi.ignore_interrupt=AMDI0030:00@11

The Caps Lock LED now works normally, and I haven't noticed any other
hardware issues.

System information

Device: Lenovo ThinkPad L13 Gen 2 AMD

DMI product name: 21AB004LSP

DMI product version/family: ThinkPad L13 Gen 2a

DMI vendor: LENOVO

DMI product SKU: LENOVO_MT_21AB_BU_Think_FM_ThinkPad L13 Gen 2a

Kernel: 7.2.9-arch1-1

Distribution: Arch Linux

BIOS: R1QET54W (1.40)

BIOS date: 2026-04-14

DSDT OEM ID: LENOVO

DSDT OEM Table ID: TP-R1Q

Diagnostic findings

The following is GPT-6's analysis of the diagnostic output and
decompiled ACPI tables.

1. Linux sends the correct keyboard LED commands

Using bpftrace, we observed that atkbd_set_leds() consistently returned 0.

Tracing ps2_command() for command 0x10ED produced:

SETLEDS: value=4, caps=1
SETLEDS: value=0, caps=0
SETLEDS: value=4, caps=1
SETLEDS: value=0, caps=0

The driver reports success and sends the expected Caps Lock states,
but the physical indicator stays off.

2. The embedded controller tracks Caps Lock correctly

The DSDT defines the CPLS field at EC offset 0x0F, bit 7.

Reading that byte through the read-only ec_sys interface showed it
changing from 0x00 to 0x80 when Caps Lock was toggled.

Enabling dynamic debugging in drivers/acpi/ec.c confirmed that each
Caps Lock press triggered EC query 0x78, which was scheduled, started
and stopped successfully.

3. Lenovo's firmware controls GPIO 11

The DSDT contains:

Method (_Q78, 0, NotSerialized)
{
    If (CPLS)
    {
        WFIO (0x0B, 0x00)
    }
    Else
    {
        WFIO (0x0B, 0x01)
    }
}

The WFIO method writes bit 22 using WMEM(), targeting address
0xFED81500 + (11 * 4) = 0xFED8152C.

This appears to control the Caps Lock indicator using GPIO 11.

4. The same GPIO is declared as an ACPI interrupt

In SSDT12, _SB.GPIO._AEI declares GPIO 11 as an edge-triggered,
active-low, exclusive wake interrupt.

Its _EVT handler includes:

Case (0x0B)
{
    MSTP (0x3911)
    Notify (\_SB.PCI0.GPP1, 0x00) // Bus Check
}

This appears to conflict with the firmware's use of GPIO 11 as an output.

5. GPIO registers confirm the suspected conflict

Without the workaround, /sys/kernel/debug/gpio showed:

#11 ... input ... 0x457a00
#11 ... input ... 0x057a00

Pressing Caps Lock changed bit 22, but bit 23 (output enable) remained cleared.

After booting with:

gpiolib_acpi.ignore_interrupt=AMDI0030:00@11

The result was:

#11 ... output ... 0xc50000

The output-enable bit was now set, and the physical Caps Lock LED
worked flawlessly.

The system was already using atkbd.reset=1 for a separate
keyboard-backlight problem. That parameter alone had not fixed the
Caps Lock LED.

Possible explanation

GPT-6's interpretation is that Linux's ACPI GPIO handling configures
GPIO 11 as an interrupt input because of the firmware's _AEI
declaration.

That disables the output driver, even though the firmware continues
updating the GPIO output-value bit when Caps Lock changes.

Ignoring the interrupt allows the pin to remain configured as an
output, restoring the indicator.

Related upstream fix

This seems very similar to the Acer Nitro V 16S AI issue addressed by:

6da1f3437435c82eaa15b121022474bb358ffe20

"gpiolib: acpi: Ignore GPIO 11 interrupt on Acer Nitro V 16S AI"

https://lists.openwall.net/linux-kernel/2026/10/02/1029

However, there is an important difference.

On my ThinkPad, the GPIO 11 _EVT handler issues a PCIe bus-check
notification. I therefore don't know whether permanently ignoring the
interrupt could interfere with PCIe-related events, hot-plugging or
wake behaviour.

So far, normal use with the workaround appears unaffected, but I
haven't exhaustively tested those scenarios.

Question

Would a DMI-specific gpiolib ACPI quirk be appropriate for this
ThinkPad, or should the conflicting GPIO declaration be handled
differently because of the PCIe notification?

I can provide the relevant decompiled DSDT/SSDT excerpts, additional
diagnostic logs, or test a proposed fix if that would help.

Thanks very much for your time, and apologies if I've misunderstood
any of the technical details. I'm happy to run further tests with
guidance.

Best regards
