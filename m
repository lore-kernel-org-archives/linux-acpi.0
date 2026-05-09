Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C09025EF87
	for <linux-acpi@vger.kernel.org>; Sat,  9 May 2026 15:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778340781; cv=none; b=GmBtvYDKMhPJJaWMY3exOJm1iVKiwyhq/dSWD1dgJBeQOeY4nf2FT9TiylgLiIHtOSLG7AKadC3s8BHw7j/DBqRG1jqsDlzAIZ9L1T1yyOOXaIUc7QUlMrXenR/9EFA5kJvepJ5IvXzoOybKmoSgEt493ged++8khhkE0RvUGHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778340781; c=relaxed/simple;
	bh=lLuiGHYD/ruGj3JDXr0BsoVWjb+ScD8GhejQk89x9cM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M+4wuEy7v0T6nIEjSQAbHA9K/ovp6QSIzPoZrz++zFxZd6VRAk0QKXF1ZA6m3FS5jGhaloswNS1g4QkYswVtlxTF/GLaFJDQ/D6TARHmAcHH5NIcFnCWznHSBav32GlvovXizeeBbhOnbQrHfOdOT6j9JAuek9wwpln5Udeh3bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9XP4gyn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9XP4gyn"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48909558b3aso32466455e9.0
        for <linux-acpi@vger.kernel.org>; Sat, 09 May 2026 08:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778340778; x=1778945578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LpJDxCQlb3K20BcVcWsmt2LxxQsGtrl9po3bpc6RSd8=;
        b=R9XP4gynMfZshYmVTZ8Sh9DF+qVucpHihnGqfqlZrghHT74t3v0ZuzSzCT0Zxma9lW
         ucfSkLrhPJKkkqOKRmFMraC1xVZPz+FrWWukXNpKegClzk71sO5iuHtXkTdUGy0pLDNg
         zCamQfZhpWR8L1PU2zhUj4D5PKqiEQE+IGvdtekaSj5igtCmAHLl7lkG/JNNl5Zhjf9N
         2oOaD9bNpgt1jH9/Sc7RprVC/CGAcaUX0v62E0476iAlhaBAI04IDCZZ3cJQs3BtkaZB
         SKlBpKqz/A3lpZzSQsFuQHc8Pph6GAqAC9KvawvApL7ic/cTZahHE+04gMHxqtpPQ65l
         as6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778340778; x=1778945578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LpJDxCQlb3K20BcVcWsmt2LxxQsGtrl9po3bpc6RSd8=;
        b=kECRPoPOg/BDmFmtjPGZ1C9D/WtReepocVpwe+esK9a1q3aHLIR9XggjQgXK3qvVQx
         fQ6tCx6rvt4/WBXEpj4k/oIX/HGZY/fFJa6PHymj8NIkI8q1J1MbuvSrLwOqtT9YXl6R
         Sh7U8YHCYI5dDFGFf4FIfFQbExLosd1IbOJ0dv9qo+pfz0pOlG+tzVyXGmSzqmRdVZc2
         +rlS0Ld6BEkaCutPH1FwlB6+r2BxDsGMFalvuUy440E7FFwtLxLzQqp3hE3zkojpjdeQ
         xbLfdjzpRMUyLhdYaUOLU3Cp7Zk4CovaTH18yH9JH0dVnX4HkO8ZRX+CJU20h8+YEHJ8
         5IwQ==
X-Forwarded-Encrypted: i=1; AFNElJ9YWtXYSdmFEb6Gxc5Sk5Q/2Z68BOQuyOisrFtmj7XigKmQlZSnochE652zr8tZ3Jf6jCcEp3Ky35is@vger.kernel.org
X-Gm-Message-State: AOJu0YzpNvsOeGWgKCgp/4EFJYgUMBdHS82Q7NC7oRJTp/Ji4gqkSD4r
	LTWDAOZyIV7IWZqUoUVqYggVd+IMLqPx+fA6T7jqpS69cWTYJA6IM4uCoIm7eg/kJd8=
X-Gm-Gg: Acq92OEaT1FrLY7+Ei6hxiVIzOjyDIhW1BV/CyhYLLtRa2Dog3+Osonm9y85PXktYgW
	OxLaVZtlQEYiK1qgWvuuiLOwr9/h8U7dju8t5x8jibhJfe0s9dbGBMYOaPxxvqJrN6Qf69GM9xM
	hmaKt5AqW0wydDWI+jq1i1u956aEUBCpT5OT7HVMAP/CRt1vInv9NgdzWznYCxYO/eXFqF/abvc
	wlKn91bZHagIn18L4unV9M4SPsoNWbkqfjXrMf2YZHWWthB1QRA3iT/6VpdiZJF9DRt5De/j1b0
	v6Ykqk7/5+loNCjqAeGGRJ9YZPPQd5GCHdqZ1CREG6x2l3tCeI8kIzbDyifTLxSF+CRR5x1Ys7V
	jlY2IYttE569tLSSFVWd7w/j/MWh1V2JXFFZaSuBJm4Gl5R4uH/WklK+Zms6XP89oqkGI0AH1hg
	0d+Pmsw1l21S5NdEBeRNGvwuWBweEmHoz2npjKD9/oXepfCw==
X-Received: by 2002:a05:600c:8585:b0:487:2439:b7be with SMTP id 5b1f17b1804b1-48e51e0b5c1mr227277465e9.6.1778340778155;
        Sat, 09 May 2026 08:32:58 -0700 (PDT)
Received: from [78.63.2.143] (serveris.dokumentika.org. [78.63.2.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702e0bf2sm98498325e9.4.2026.05.09.08.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2026 08:32:57 -0700 (PDT)
Message-ID: <7e9825d8-3180-4787-ab7a-456446b0cbb8@gmail.com>
Date: Sat, 9 May 2026 18:32:56 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: HTML message rejected: [REGRESSION] PCI: AMDIF031 ACPI resource
 conflicts cause bridge window allocation failure on X870E in
To: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1778340596-26078-mlmmj-08aae49b@vger.kernel.org>
Content-Language: lt-LT
From: "jodeliukas@gmail.com" <jodeliukas@gmail.com>
In-Reply-To: <1778340596-26078-mlmmj-08aae49b@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

# [REGRESSION] PCI: AMDIF031 ACPI resource conflict at host bridge 
window prevents PCIe device probe on X870E AI TOP / 6.18

## Summary

Starting with kernel 6.18, an ACPI device `AMDIF031` (declared in vendor 
SSDT
with a `Memory32Fixed` `_CRS` resource at an address falling inside a PCIe
bridge window) causes that bridge window to fail `pci_claim_resource()` with
"address conflict". The conflict cascades to all downstream bridges and
endpoints, leaving multiple devices without assigned BARs.

The same conflict is logged on kernel 6.12 (LTS) but is non-fatal there:
all devices receive resources and operate normally. On 6.18 the conflict is
fatal and a PCIe device behind the affected bridge fails to probe with
`-EIO (-5)`.

This appears to be a regression in the PCI resource allocator's handling of
ACPI-declared MMIO resources that overlap host bridge windows between 6.12
and 6.18.

## System

- Motherboard: Gigabyte X870E AORUS XTREME AI TOP, BIOS F12b (latest)
- CPU: AMD Ryzen 9 9950X3D (Granite Ridge, family 19h)
- Affected PCIe device: Aquantia AQC113C (10GbE), driver `atlantic`
   (one of two identical AQC113C controllers fails to probe; the other 
works)
- Distribution: Gentoo Linux
- Working kernel: 6.12.86 (gentoo-sources)
- Broken kernel: 6.18.28 (gentoo-sources)

## Reproduction

Boot the system on 6.18.28 with default kernel command line. The on-board
secondary AQC113C fails to probe.

`lspci` placement:

```
0a:06.0 PCI bridge: AMD 600 Series Chipset PCIe Switch Downstream Port
10:00.0 Ethernet controller: Aquantia AQC113C [Marvell Scalable mGig]
```

(Bus numbers shift slightly depending on whether the discrete GPU is 
installed;
the failure pattern is identical.)

## Symptoms (kernel 6.18.28)

```
pci 0000:0b:06.0:   bridge window [mem 0xdc400000-0xdc8fffff]
pci 0000:10:00.0: [1d6a:14c0] type 00 class 0x020000 PCIe Endpoint
pci 0000:10:00.0: BAR 0 [mem 0xdc800000-0xdc87ffff 64bit]
pci 0000:10:00.0: BAR 2 [mem 0xdc8a0000-0xdc8a0fff 64bit]
pci 0000:10:00.0: BAR 4 [mem 0xdc400000-0xdc7fffff 64bit]
pci 0000:10:00.0: ROM    [mem 0xdc880000-0xdc89ffff pref]
...
pci 0000:00:02.1: bridge window [mem 0xdc400000-0xddafffff]: can't claim;
     address conflict with AMDIF031:00 [mem 0xdd500000-0xdd500fff]
pci 0000:03:00.0: bridge window [mem 0xdc400000-0xddafffff]: can't claim;
     no compatible bridge window
pci 0000:0b:06.0: bridge window [mem 0xdc400000-0xdc8fffff]: can't claim;
     no compatible bridge window
pci 0000:10:00.0: BAR 0 [mem 0xdc800000-0xdc87ffff 64bit]: can't claim;
     no compatible bridge window
... (cascades to ~20 devices)
pci 0000:0b:06.0: bridge window [mem size 0x00500000]: failed to assign
pci 0000:10:00.0: BAR 0 [mem 0xdc800000-0xdc87ffff 64bit]: failed to assign
...
atlantic 0000:10:00.0: probe with driver atlantic failed with error -5
```

Result: only one of the two AQC113C interfaces is available.

## Behaviour on 6.12.86 (working baseline)

The exact same `address conflict with AMDIF031:00` line is logged, but no
`failed to assign` follows. Both AQC113C interfaces probe and operate.

```
pci 0000:00:02.1: bridge window [mem 0xdc400000-0xddafffff]: can't claim;
     address conflict with AMDIF031:00 [mem 0xdd500000-0xdd500fff]
... (subsequent BAR allocations succeed)
```

## ACPI source of the conflict

The conflicting region is declared by `Device(SPTO)` in vendor SSDT
(`OEM TableID "AmdTable"`, the second instance), located at the bottom of a
deep ASMedia PCIe-switch hierarchy:

```asl
Scope (\_SB.PCI0.GPP7.UP00.DP40.UP00.DP68)
{
     Device (SPTO)
     {
         Name (_HID, "AMDIF031")
         Name (_CID, "AMDIF031")
         Name (_UID, 0x02)
         Method (_CRS, 0, NotSerialized)
         {
             Name (RBUF, ResourceTemplate ()
             {
                 Memory32Fixed (ReadWrite, 0xDD500000, 0x00001000, )
             })
             Return (RBUF)
         }
         Method (_STA, 0, NotSerialized) { ... Return (0x0F) ... }
     }
     Device (ASMP)
     {
         Name (_HID, "ASMT0001")
         ...
         // Uses SPTO as GPIO provider
     }
}
```

The address `0xDD500000` falls inside the bridge window
`[mem 0xdc400000-0xddafffff]` declared by host bridge `0000:00:02.1`,
which is the upstream port of the chain hosting the second AQC113C.

The exact base address shifts (e.g. `0xddd00000` when the discrete GPU is
removed and the iGPU is in use) — the BIOS clearly computes it dynamically
relative to other PCI resources, but always inside an active host bridge
window.

## Mitigations attempted (all unsuccessful on 6.18)

1. BIOS update F11 → F12b — no effect.
2. `pci=nocrs` — caused USB/keyboard hang at boot (this AMD Inference Engine
    ACPI device shares the ASMedia PCIe-switch ACPI subtree with USB GPIO
    resources).
3. `pci=realloc` — relocates some BARs into 64-bit space (NVMe ends up at
    `0xf2100000`), but `atlantic` still fails to probe with `-EIO`.
4. `pci=use_e820` — option appears silently ignored in 6.18.
5. `acpi_enforce_resources=lax` — no effect.
6. `pci=hpiosize=0,hpmemsize=0,hpmmiosize=0,hpmmioprefsize=0` — no effect.
7. ACPI table override (initrd) replacing `_STA` → `Zero` for SPTO —
    override loaded successfully (`ACPI: Table Upgrade: install`), but the
    conflict persists. Disabling SPTO via `_STA` additionally hangs USB
    probably because ASMP depends on SPTO as GpioIo provider.
8. ACPI table override defining a Scope() that overrides only `_CRS` to
    return an empty `ResourceTemplate ()` — table loads successfully but
    conflict still present, suggesting the early PCI resource-claim path
    does not consult the override.
9. Re-Size BAR Disabled, Above 4G Decoding Enabled, IOMMU Auto — no effect.

## Hypothesis

Between 6.12 and 6.18, a change in
`drivers/pci/setup-bus.c` / `drivers/acpi/resource.c` made an ACPI-claimed
MMIO region inside a host bridge window block that bridge from being
claimed entirely, instead of allowing the rest of the window to be used
around the ACPI reservation. The vendor BIOS bug (declaring a
`Memory32Fixed` for a non-functional placeholder NPU device inside an
active PCIe bridge window) was harmless under 6.12 and is fatal under 6.18.

## Attached / available on request

- Full `dmesg` from 6.12.86 (working) and 6.18.28 (broken)
- `lspci -vvv` output
- `cat /proc/iomem` from both kernels
- Disassembled DSDT and SSDT17/SSDT18 (`iasl -d`)
- `/proc/cmdline`, `.config`

## Bisect

I have not yet bisected. Happy to run a bisect between v6.12 and v6.18 if
maintainers can suggest a likely subsystem to narrow the search
(`drivers/pci/`, `drivers/acpi/resource.c`?).


https://bugzilla.kernel.org/show_bug.cgi?id=221493

---


-- 
Aleksandras
IT Administrator
alex@bevielis.lt
tel: +37069947470

