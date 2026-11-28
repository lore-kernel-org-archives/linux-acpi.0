Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795889733;
	b=B2k8aFmDZPAPQpAWZwHGhrYuRj79YiwtlfLO0A61KhcnmjHuJnjK1tOR/k7pN7c/kImP
	 i0CIfINfP59nl9KTKs/5ZKwCaP7SduzY3oAgW/6BjkJzHLbFde2YrIVgPS1aZiSAPFcCb
	 EuAvlgfeXXZiXnFbDcfLTX02WltQH0QHFE4TjD/GfnLD2mnRQaIxHwSB8fp8Ve/D3O5/O
	 NZqr8qOeoh9IPH8qeKaG6a4MlHDPyn1hVk30Jh0arl4PYgoJn/8L3q8w1FQ6Mr2ph2WMd
	 05yz4iROWqAkAEihNyy+GuSQEDExcTEIuV6v18qZD8NcHt1ia4jWIGX/PW69Grru7qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795889733;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Content-Language:To:Cc:From:Subject:
	 Content-Type:Content-Transfer-Encoding;
	bh=8e9qqOEpXrj/eTH8RQhNmi3E6FLTRYSNfsQXxcgkIGU=;
	b=YL9FBSkYTGtGWZ0DVMLZGY1A/RACIgVvV0KrtjaC3Xg9m5ulDdj2+fE/rN28fV72Lh8h
	 th/bp6WI73RqOxkaVzV2T0SdUNgJ/THvnQhHNmkbEYoooixkQLI32VuWNTp18OYEB5Ke7
	 U/smWllDmvL9OoKC7Ea+Mjbu0Qnn8l3xhr8hWATgjrdbW3XBlxezCVb1cy15WtcOISCOG
	 e1AnjwEoHmWhAqvMtp/CjuMGBcGh9OiT6Hzc+yOXCF/5IKvn/98EPKHxpvn7jDoXHyMXJ
	 8Hl9Uo9v/gNll3TrXf4uf6Z7/1qH5Lvjwx+vsHqRwEtAWdtoBZNivXQH/iNhZ/geoaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z3NLin2C;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3360B606A31C
	for <linux-acpi@vger.kernel.org>; Sat, 28 Nov 2026 18:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3360B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z3NLin2C
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-490d59c3edaso6145780f8f.1
        for <linux-acpi@vger.kernel.org>; Sat, 28 Nov 2026 10:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795889731; x=1796494531; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8e9qqOEpXrj/eTH8RQhNmi3E6FLTRYSNfsQXxcgkIGU=;
        b=z3NLin2C4yDimVi0ca6Pq7owA1dhWw0fT/MP2gPWjBsBzjmRWxaW1cI3cisjA24ix8
         P+rQFeyZFqwQXCUXxV0/T6uPSI1l/REh7V+1ZJwoxvyQNvUxlgeA11HvUMFUw1vwkSCB
         yDbK3CNKR9DEEu3MyrdqLU0/V0DLQ/3kDWIyke1vNuHv6AbFh+2KMqcs6Ip92Cmzy9hL
         GVOwguRmU5gbQFGVQqDQUa8j4/LfWqagWs5h3rt0OIkyDW/TRPF0VK0vSTL9TwUFKVHJ
         P1JUV1j+4xvNcVZqxO6z8On4jHYTZBNGF/e0AIGJkI7n2bg1d2v9bqM1K+sZ3pcr56P0
         Qgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795889731; x=1796494531;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8e9qqOEpXrj/eTH8RQhNmi3E6FLTRYSNfsQXxcgkIGU=;
        b=2vjHH6adTpojWJBEZFySZAr+9EFxrqpbV4vI0S1MeBxIYPk0gnZHQMrtX2yJCadA7y
         Ca5vs7mwl1fcZ7aPi0ajYX+kAWwG6VZy72Ah2e2vZPxjAZP2I3sCQyOhC7D7uUUhpTiE
         OCl2bieYZ6nxt+BUOlU89WYCiWqhPKHfwJ6+3A0GdccYRDoVYxoX9q9owei+ipM058xH
         6ra0RkIxrg9U6maLyokLRy9YT1THiUfVpGuUPaeI0wikFi9PrfzGzY9TiSFmlIbX4hZI
         mfkZfcu+5+opP70VpOUxfDxx7mqxt4VHjYRZFdd73rNfvCPdnfy2SzcjU8t3HmIbLfdK
         dVNg==
X-Gm-Message-State: APuU4Z/ejEW4zcgR09pjIPzB5n+LYjYPZHqWAc/HENSQ9cCQChWKULbv
	D/OS/MwgjzUlpTCOGtQUxEWcYNYLGTaHZfiNMhUbt3wr03yLeh7j4YUkd6+5bw==
X-Gm-Gg: AZFdTZdHpfWTawVUR4L6YoicZQs1uCoZdc21RCp9pdDTp2OnUCcrbkOZcQcl4cMBZFx
	3jn2NpMQOTd/6Y3UebS9p98g4Xaj+4vgrgov0ZHCYc1Y0MQwLi+xnCsrP7IUGc8gpCQqnjHn2DJ
	ql5ChLsIfLIDUs2G1Nzxm726l4bOyNedRafe38K610Tdi3dRZzXEhZq1In7fCuK2DG8KBs+Svgh
	PR8QsCl+5cvl6CrMf/wS8ILtLCx988KMP7tQKmx9SYrXDbMoRmiMf9CE49U73RB7oNCbjcDiYLe
	xjM75g0IxQvnyrVQSrBvI2LTkMTiukw8fdnUhsg7ADCcE2Ue2vPgEtOy3m1YJ3yA0Gb9NKbh/8z
	Em3OAx/ImL41gwCi4JwSkiMb0whz5HnrLdh0qYKgJ6datWJ5AwGIJd4CQRFRaiJRusQV+6b0ZfI
	PW9ZOo59s/w7W7/YB0ZQM1kze8wwXbKUYot7cw/5r0Mt5fPvEd/PLI/Sgdn5qclr0cKuovpRRiF
	sITjPiNRotYWtUvaDiezPLt6tJXO7BCQ/kXJc9sc2zxBtMqWH6ZF4CxzShbSP+x+Yc/z8owILwL
	API4xhpSnkihREfIu4FD1p3cTD3GXF+oDM+VDDIy+p7qA6EzhRH8WdGqP5N7cOkigpVfkx9Rx3i
	ljuOmkNadddw=
X-Received: by 2002:a05:6000:2382:b0:4a7:1fca:e537 with SMTP id ffacd0b85a97d-4abb0886cbamr56887656f8f.9.1795889731238;
        Sat, 28 Nov 2026 10:15:31 -0800 (PST)
Received: from ?IPV6:2a0c:d242:901e:5e00:b1bd:f932:3d1c:3638? ([2a0c:d242:901e:5e00:b1bd:f932:3d1c:3638])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110c50sm53631704f8f.37.2026.11.28.10.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Nov 2026 10:15:30 -0800 (PST)
Message-ID: <1dab8610-d369-4eb8-af3d-9bf5591f49ac@gmail.com>
Date: Sat, 28 Nov 2026 19:15:30 +0100
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: de-DE
To: leonard@lausen.nl
Cc: linux-acpi@vger.kernel.org
From: Christopher Bormann <wuffeljunior90@gmail.com>
Subject: [BUG] ACPI: fan: Broken FAN0._FST on Samsung Galaxy Book5 Pro 360
 (960QHA)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Leonard and Linux ACPI developers,

I would like to report a reproducible ACPI fan status issue affecting 
the Samsung Galaxy Book5 Pro 360 (960QHA).

The issue causes recurring ACPI errors during normal operation, fan 
status changes and hardware monitoring. The physical fans appear to 
operate correctly, but the ACPI fan status method fails with 
AE_AML_OPERAND_TYPE and, occasionally, AE_AML_PACKAGE_LIMIT.

*1. Hardware and software environment*

  *

    Manufacturer: SAMSUNG ELECTRONICS CO., LTD.

  *

    Model: Samsung Galaxy Book5 Pro 360

  *

    DMI product name: 960QHA

  *

    DMI product version: P17ALY

  *

    Processor: Intel Core Ultra 7 256V

  *

    BIOS version: P17ALY.390.260616.03

  *

    BIOS date: 2026-06-16

  *

    Distribution: Ubuntu 26.04.1 LTS

  *

    Kernel: 7.0.0-43-generic

  *

    Architecture: x86_64

  *

    ACPICA version reported in kernel errors: 20251212

  *

    Secure Boot: enabled

  *

    Kernel lockdown: integrity

  *

    Samsung Galaxy Book driver: in-tree samsung_galaxybook

  *

    Current platform profile: performance

No custom ACPI kernel parameters are in use.

The system also uses out-of-tree DKMS modules for camera, audio and 
video functionality. No causal relationship between these modules and 
the ACPI issue has been established.

*2. Problem description*

The ACPI fan driver repeatedly reports failures while evaluating:

|\_SB.PC00.LPCB.FAN0._FST|

The following error occurs frequently:

|ACPI Error: Needed [Integer/String/Buffer], found [Reference] 
(20251212/exresop-388) ACPI Error: AE_AML_OPERAND_TYPE, While resolving 
operands for [Add] (20251212/dswexec-433) ACPI Error: Aborting method 
\_SB.PC00.LPCB.FAN0._FST due to previous error (AE_AML_OPERAND_TYPE) 
acpi-fan PNP0C0B:00: Error retrieving current fan status: -5|

An additional error occasionally occurs:

|ACPI BIOS Error (bug): AE_AML_PACKAGE_LIMIT, Index (0x000000005) is 
beyond end of object (length 0x4) (20251212/exoparg2-393) ACPI Error: 
Aborting method \_SB.PC00.LPCB.FAN0._FST due to previous error 
(AE_AML_PACKAGE_LIMIT)|

These errors occur both during explicit hardware monitoring and 
independently of periodic sensor polling.

*3. Steps to reproduce*

 1.

    Boot Ubuntu using kernel 7.0.0-43-generic.

 2.

    Allow the system to reach a temperature or workload at which the
    fans are active.

 3.

    Read the ACPI fan speed attribute:

|for hw in /sys/class/hwmon/hwmon*; do if [ "$(cat "$hw/name")" = 
"acpi_fan" ]; then cat "$hw/fan1_input" fi done|

 4.

    Inspect the kernel log:

|sudo journalctl -k -b --no-pager|

Fan status notifications can also trigger the errors without manually 
reading the sensor.

*4. Expected behavior*

The ACPI fan status method should return a valid fan status package, or 
the driver should gracefully handle unavailable fan speed information.

Invalid AML operands and out-of-bounds package accesses should not 
generate recurring kernel errors.

*5. Actual behavior*

  *

    Fan speed telemetry is unreliable.

  *

    The _FST method aborts with ACPI interpreter errors.

  *

    Fan status notifications can generate repeated kernel log messages.

  *

    Physical fans remain operational based on observed fan noise and
    thermal behavior.

*6. Firmware analysis*

I extracted the ACPI tables using acpidump and acpixtract and 
disassembled the DSDT using iasl version 20251212.

The relevant firmware code is located in:

|\_SB.PC00.LPCB.FAN0|

The fan lookup table is defined as:

|Name (FANT, Package (0x04) { 0x0DAC, 0x0EE2, 0x1144, 0x127A })|

The status package is defined as:

|Name (SFST, Package (0x03) { Zero, 0xFFFFFFFF, 0xFFFFFFFF })|

The complete relevant _FST method is:

|Method (_FST, 0, Serialized) { Local0 = ^^H_EC.FANS Switch (ToInteger 
(Local0)) { Case (One) { Local0 = One } Case (0x02) { Local0 = 0x02 } 
Case (0x03) { Local0 = 0x03 } Case (0x04) { Local0 = 0x03 } Case (0x05) 
{ Local0 = 0x04 } } SFST [One] = Local0 If ((Local0 == Zero)) { SFST 
[0x02] = Local0 } Else { Local0-- Local1 = FANT [Local0] Local1 += 0x0A 
SFST [0x02] = Local1 } Return (SFST) }|

The embedded controller defines FANS as a four-bit field:

|Offset (0x87), FANS, 4,|

Two potential issues are apparent:

A. Reference operand handling

The expression:

|Local1 = FANT [Local0] Local1 += 0x0A|

appears consistent with the observed AE_AML_OPERAND_TYPE error.

Explicit dereferencing may be relevant, although I have not tested a 
modified method. It is unclear whether this behavior should be 
attributed to firmware AML or ACPICA reference handling.

B. Missing bounds checking

The FANS field can represent values from 0 to 15, but the switch 
explicitly handles only values from 1 to 5, with zero handled separately.

An unexpected value such as 6 would remain unchanged, be decremented to 
5 and then be used as an index into the four-element FANT package.

This is consistent with the observed AE_AML_PACKAGE_LIMIT error. The 
actual raw EC value has not been independently measured.

*7. Fan notification mechanism*

The embedded controller also defines:

|Method (_Q76, 0, NotSerialized) { Notify (FAN0, 0x80) }|

This appears to explain why _FST may be evaluated even when userspace is 
not explicitly polling the fan sensor.

*8. Physical cooling behavior*

The physical fans audibly increase their speed during demanding 
workloads, including gaming.

A short CPU stress test using two workers showed:

  *

    Highest observed CPU package temperature: 81°C

  *

    Subsequent CPU package temperature: 47°C

  *

    Temperature decrease between the final load observation and
    subsequent measurement: 34°C

This suggests that basic automatic cooling remains functional, despite 
the broken fan status reporting.

Long-duration maximum-load cooling behavior has not been tested.

*9. Related upstream work*

I found the following potentially related patch discussion:

ACPI: fan: Ignore broken _FST on Samsung Galaxy Book 930XDB

https://lists.openwall.net/linux-kernel/2026/10/19/2287 
<https://lists.openwall.net/linux-kernel/2026/10/19/2287>

The reported reference operand error appears similar to the issue 
observed on the 960QHA.

I also found the subsequent discussion concerning potential ACPICA 
reference handling:

https://lists.openwall.net/linux-kernel/2026/10/22/1944 
<https://lists.openwall.net/linux-kernel/2026/10/22/1944>

Related ACPICA issue:

https://github.com/open-acpica/acpica/issues/908 
<https://github.com/open-acpica/acpica/issues/908>

*10. Questions for maintainers*

  *

    Could the Samsung Galaxy Book 960QHA be affected by the same _FST issue?

  *

    Would extending the proposed model-specific workaround to this
    device be appropriate?

  *

    Could ACPICA reference handling account for the operand type error?

  *

    Would a separate firmware workaround be required for the
    out-of-bounds package access?

  *

    What additional diagnostic information would be useful?

I have not applied any ACPI override, modified the BIOS, disabled Secure 
Boot or changed the ACPI fan driver.

This report is based on the Ubuntu distribution kernel. The issue has 
not yet been tested on a current unmodified upstream kernel, and the 
first affected kernel version is unknown.

Relevant ACPI tables and filtered kernel logs can be provided upon request.

Thank you for your work on Linux hardware support and for investigating 
this issue.

Best regards,
Christopher Bormann


