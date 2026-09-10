Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296B138D3F1
	for <linux-acpi@vger.kernel.org>; Thu, 10 Sep 2026 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067669; cv=pass; b=FQZSSlpLJ3j/5/BQtoJkTXA7EaWhpMHYygbg0iydbYWJDMHLAuHfDiAVvnY0dhJa/ZWswfe5LXF2mT4jSAUt56JiemLnmlfIPX6KH4/wdxBVr65gl4WxkKqhjw0xIgpjcMA/fRosBUwCWdiqc2ozbcPIVYZjZ/q0xv0f2LEX2GI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067669; c=relaxed/simple;
	bh=cvS7IOof6i1Xi/NLdQmqFbT8Jx/Hm9q05dMIMNJ1fY4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=kDH3hLmaYlUMLjSWCqb1vrSKvUCRfdqqpoRCmqzIQqIsL9kAitSUjJimuaLWsLAv6rB/Tn3rkGgvuerKhQM+yoylB1qnUn48187hbODzQKL0y6zkt88d4tLbUV4qMuxC++zquO69vNhoQ6Y8+jgBsXzOXg3zjhO+zLUhVpY63MA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSTsPQ5h; arc=pass smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSTsPQ5h"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-939c8c6b114so1868785a.1
        for <linux-acpi@vger.kernel.org>; Thu, 10 Sep 2026 12:14:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789067666; cv=none;
        d=google.com; s=arc-20260327;
        b=m8xPOEPN99789L6sdIHgTSaGh3VvlHdbfqPTCT7z9d5AZZPfsMEEXJG9Dpk0C6coBS
         t1iC285t0BLstulQX7DSaglrYnAzXid3EQT7AKr+oyHUe4pPZC+fIEUeJKdLLvevVNQt
         RJL13Q50m+xiuN1NuMuuyaun9GDCpYweVGXFj4IGDBMFjgaMxKXB8g9l6tG1fWacdcgf
         AcVgYXB4m4vsB3XMf3OV6fPCfglBlao+5ZlYFAncU/rsnJ16j2Bs47xohToqfIZFsJ83
         M0uXJ3YiHiWI6WaDh+/FwWtPk+d5O+g+D1bGbnoxOHd/93hwra6L96pB0koIqnXNGHu4
         DINw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=CsmhAGZ511xLKCbhHrz0yBkxu65Fa7Is/5gx5cOswys=;
        fh=l/W9lwL9l6EIRHEYAa6oAmBJUx7zHCr5p8xSaqZN1vA=;
        b=Ch3N4kkcHq319eXMKAWk5RkE9rQHm1pcB2koA2LXxGS0XNevknJYpTm02yUMXAlTCU
         l5vvHwy1y7mxhH/RS8hDJYJOOUAdNIrNFCdJM2HmIYOjroTPPsEeYD1ptwkhfgyrn8CP
         LVLsehYf9a35t8SopSvYYkcRemYphFoX8IxCexC2mfZgIozKMjp913hH24q2Uz28wuQS
         zKIe2ntD4y2y4lIIQ0UUjpuvRzY2g+YvtxD4Q1PnPznoK3fUQ3ea1NEBKQoI+nCTFv+q
         XDcp6eiLXF14Z4zrQUFTY2YgwryoplqxvWgW8oTiYiiYzkN+Z4Ic4TNZ6ZOLQ8daklhR
         qxVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789067666; x=1789672466; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CsmhAGZ511xLKCbhHrz0yBkxu65Fa7Is/5gx5cOswys=;
        b=BSTsPQ5heUPyPVGRQkNYa+dzY3vB9iokgWwLOZ8q3pC/0pm3T8Yd4OHWyOtDdP8MFx
         DXJW5tQ8/qY+Kw92DaOYXi0DznhK4Qk84KIhXCv95m6GFW6BudxSajMPF+bxCAYxL2mP
         Nsm8jaqEIo5N/0GqR/z6drPdUDx/xnKp+zq0v47qe0/lB/kbSg+CnAh1MwfeH5sVFL/c
         72IFWfiVm9fjOy64VhLOym4BdOdks4+UuXBODuLz+02zZxVIfRuR/nkn2riOEgErQEIw
         fJhDZqS5FnDdnZ+q2rLCXreNGeR1mT5mewe57gZBcMMB7OJGUOP8RlvUfrIQsiCe02OI
         zDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789067666; x=1789672466;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CsmhAGZ511xLKCbhHrz0yBkxu65Fa7Is/5gx5cOswys=;
        b=fA2oD2+Li1rleXcjg4X5+ObZKIBJp3QPVvPnerP15qfI/0NKgBbdpT+s01GpbbSVcL
         HkEVcUBgWqdl6vb7ScXNnfETCvv7NajC2R8+GOWOJuKDiVDd5zlbq43OM2ndj8/Jh4ag
         Dj3i7AQyQbzw5J55Y1mz83QpeKBdFKz8rcR+TzzSLOl6JTp1vXX/z5nVJM/BQ8BdLupY
         bLigybrAJqOs6lop9E56HrXITcF/f73CRUjmsb+Oe5Ngxuf6DDCFs7DYhX6SzV07Ev+v
         Mv2u7IL3Fa7LHqmhq5nVASC++TNUfr0Kc/nEsVNU0yGP9ZUao607zo+NPv0zSbB3QRsr
         U1bQ==
X-Forwarded-Encrypted: i=1; AKwUvBwM8n48x+mntgjG3Hc3z2tHu9RDTtYi9xxEwj9V92VTT3qLB+Au5Dv1kp1emHvVmuRKKQpT45ITFFr9@vger.kernel.org
X-Gm-Message-State: AFuF++lQXJ4rdJKJxo6dz1RznB0XXb7fSWrhYN35mSij6O959BSjw4dp
	Cuh0Y/OM9mc+uRqy207o2cnphXsDBZ5/AZbpgsaD6NU/gb/peNKfjvrN6HQkp82vsJm/SG/RN5T
	CVyPLWS3H9Y9jLtLfCJ93T5fTxKv/AwThA9ycP+It1TGj
X-Gm-Gg: AYBFou21tqtZxJmLBG1CJlIhZgKPMCf8RE9vSvf1+sck2vcW2PiWD+O6tVYkowQOFmL
	Hw+kih5E8tBy4igMGMRrm2ytC1ek02Uiu0VkNEVjm4A4qqo2V0Z8Mj1/FdFjmEb7zL14/FuszSH
	UGYfaHR0i6iUHO21OXa/QdX1w8Zmbw/xXu9AxRcyI+Ehfa4bh1o4W2/UCvaQD7toqhRrOlqx94y
	1qefqFIHHfuSzuBe5pj1g/pt7IxUquKZZ+g1Q7dMuJ5dxg2SOXr90RqcMHukS2DbZqxNbI+OIr6
	dVItuUiAYZRxAViOWT9pmWUVoe7UD+yyZD6Eutyl2EVTTNsREm/51CShaDjS8TfMMwwpLPV+fxP
	pxJzENlOM5XnGw8UbuPRo
X-Received: by 2002:a05:620a:4446:b0:939:6c9a:8f8d with SMTP id
 af79cd13be357-939ea1dc406mr33474285a.28.1789067665479; Thu, 10 Sep 2026
 12:14:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Abdalrhman Ahmed Mohamed Refaat <mebecausehewasanoop72@gmail.com>
Date: Thu, 10 Sep 2026 22:14:14 +0300
X-Gm-Features: AcwNN1WdViNoEKbeDKLVw2OTEI4ERzTfRwDkB0kYb1w3_tFjvNpz3OAdYsYMYCA
Message-ID: <CAGJopWKOPVKpQKwh0J+NUig35gixh6eOJDxeXYyZSM83KGSk7w@mail.gmail.com>
Subject: =?UTF-8?Q?=5BBUG=5D_ACPI_=2F_NVPCF=3A_NPCF_SSDT_returns_zeroed_power_b?=
	=?UTF-8?Q?udget_=E2=80=94_Dynamic_Boost_stuck_at_VBIOS_default?=
To: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

**Problem Description**

On the Lenovo LOQ Essential 15IRX11 (83SC) with RTX 5050 (GB207M, 10DE:2D98=
),
Dynamic Boost never activates. The GPU stays at the VBIOS default 35W inste=
ad of
boosting to 65W (50W TGP + 15W PPAB).

The root cause is that the stock BIOS NPCF SSDT returns zeroed power
budget fields
in all NVPCF DSM subfunctions. The driver constructs the PMO
successfully (func 0x00
bit 0 IS set), but all downstream budget data is zeroed =E2=80=94 so Dynami=
c
Boost offsets
are computed as 0W and the GPU never leaves VBIOS defaults.

This was confirmed on Windows 11 with stock BIOS as well =E2=80=94 same 45W
flatline. The
bug is in the ACPI tables, not the driver.

**System Specifications**

    Machine:        Lenovo LOQ Essential 15IRX11, type 83SC
    BIOS:           SECN22WW (Insyde H2O, 2026-05-21)
    GPU:            NVIDIA GeForce RTX 5050 Laptop GPU, GB207M die
    GPU PCI ID:     10DE:2D98 (SubSystem 0x8FFE17AA)
    GPU Arch:       Blackwell
    GPU Memory:     8151 MiB GDDR7
    VBIOS Version:  98.07.27.00.43
    VBIOS Limits:   TGP 50W / CTGP 35W / PPAB 15W / Max 65W
    GPU Max Clocks: Graphics 3090 MHz / Memory 12001 MHz
    PCIe:           Gen5 x16 max, Gen1 x8 current
    CPU:            Intel Core i5-13450HX (Raptor Lake-HX, 10C/16T)
    CPU Power:      PL1 configurable 25=E2=80=9360W, PL2 configurable 40=E2=
=80=9385W
    Kernel:         7.2.3-1-cachyos (x86_64, CONFIG_ACPI_TABLE_UPGRADE=3Dy)
    NVIDIA Driver:  610.57.04 (open, nvidia-open)
    GSP Firmware:   610.57.04
    nvidia-powerd:  v2.0 (build 1)
    Bootloader:     Limine (UEFI)

**ACPI Table Inventory**

The firmware exposes 38 CB-01 tables via XSDT. Key tables:

    XSDT #  Type   Size      OEM Table ID  Contents
    ------  ----   --------  ------------  --------
    1       SSDT   86,813B   CB-01         Large peripheral SSDT
    2       SSDT   262B      CB-01         Small auxiliary
    3       SSDT   5,709B    CB-01         Peripheral config
    4       SSDT   7,946B    CB-01         NPCF + GPS + PEGP =E2=80=94 the =
buggy table
    12      DSDT   660,250B  CB-01         Main DSDT (has
External(NPCF) + Notify(NPCF))
    5=E2=80=9322    SSDT   varies    CB-01         Remaining CB-01 tables

All 22 CB-01 SSDTs share the identity tuple (SSDT, LENOVO, CB-01) with
OEM Revision
0x01. The NPCF-carrying table is SSDT #4 in XSDT order (0-indexed: #3).

**NPCF Table Structure (7,946 bytes)**

The NPCF SSDT contains:

1. PEGP OperationRegions =E2=80=94 VBOR, NOPR (0x7387C018, 0x2027 bytes), H=
GOP
2. PEG1/PEGP scope =E2=80=94 RPCX config space, PEGP methods including GPS
3. Scope(\_SB) Device(NPCF) =E2=80=94 NVDA0820, \_DSM with UUID
   36b49710-2483-11e7-9598-0800200c9a66
4. PEGP \_DOD/MXMX/MXDS/MXM =E2=80=94 display output methods

The GPS method (lines 406=E2=80=93536) is inside PEGP scope. The NPCF devic=
e
(lines 844=E2=80=931186)
is at \_SB scope.

**Root Cause Analysis**

***NPCF _DSM Structure***

The NPCF device (\_SB.NPCF) implements
_DSM(UUID=3D36b49710-2483-11e7-9598-0800200c9a66,
rev=3D0x200) with these subfunctions:

    Subfunc  Name                          Purpose
    -------  ----                          -------
    0x00     GET_SUPPORTED                  Bitmask of supported subfunctio=
ns
    0x01     GET_STATIC_CONFIG_TABLES       Static config (checksum-validat=
ed)
    0x02     GET_DYNAMIC_PARAMS             Dynamic power budget
(TGPA/TPPA/MAGA)
    0x08     GET_DC_SYSTEM_POWER_LIMITS     DC battery power limits (JPAC)

***What the Driver Does With Each Subfunction***

func 0x00 (client_resource.c:2942-3002):
- Returns Buffer(4) =E2=80=94 bitmask of supported subfunctions
- Driver tests only bit 0
(FLD_TEST_DRF(..._FUNC_GET_SUPPORTED_IS_SUPPORTED, _NO, ...))
- If bit 0 =3D 1 =E2=86=92 PMO constructs, driver proceeds to func 0x02
- Stock BIOS returns Buffer(4){0xBF,0x06,0x00,0x00} =E2=80=94 bit 0 IS set
- So driver enters dynamic boost path, but all data is zeroed

func 0x02 (client_resource.c:3100-3173):
Returns a 49-byte buffer with this layout:

    Offset  Size  Field         Description
    ------  ----  ------------  -----------
    0x00    1     headerSize    Must be 0x05
    0x01    1     commonSize    Must be 0x10
    0x02    1     entrySize     Must be 0x1C
    0x03    1     version       Must match driver's requested version
    0x04    1     entryCount    Number of controller entries (1 on LOQ)
    --- common section (0x10 bytes) ---
    0x05    2     TGPA          CTGP AC offset in 125mW units
    0x07    2     TGPD          CTGP DC offset
    --- entry section (0x1C bytes per entry) ---
    0x19    2     TPPA          Target PP AC offset
    0x1B    2     TPPD          Target PP DC offset
    0x1D    2     MAGA          Max AC GPU offset
    0x21    2     MIGA          Max idle GPU offset
    0x25    2     DROP          Delta response offset
    0x29    4     LTBC          Long-term budget cap
    0x2D    4     STBC          Short-term budget cap

The driver validates at client_resource.c:3121-3135:

    if ((headerOut.headerSize !=3D 0x05) ||
        (headerOut.commonSize !=3D 0x10) ||
        (headerOut.entrySize  !=3D 0x1C))
    {
        status =3D NV_ERR_INVALID_DATA;
    }

Stock BIOS returns all-zeroed fields =E2=80=94 TGPA=3D0x0000, TPPA=3D0x0000=
, MAGA=3D0x0000.
The driver computes:

    ctgpOffsetmW =3D 125 * 0 =3D 0W       =E2=80=94 no CTGP boost
    targetTppOffsetmW =3D 125 * 0 =3D 0W   =E2=80=94 no PP offset
    maxOutputOffsetmW =3D 125 * 0 =3D 0W   =E2=80=94 no max output boost

Result: Dynamic Boost is "supported" (bit 0 set) but all offsets are
0W. GPU stays
at VBIOS default 35W.

func 0x01 =E2=80=94 14-byte static config with two's complement checksum:
- Sum all bytes except the last
- Negate: (~sum) + 1 (one-byte two's complement)
- Must equal the last byte
- Stock BIOS: checksum 0xAB, data correct

func 0x08 =E2=80=94 22-byte DC system power limits (only used on battery, n=
ot
relevant to
AC dynamic boost)

***GPS Pipeline Issues (Secondary)***

The GPS (GPU Power Steering) method in the same SSDT has three
additional problems:

1. GPSS guard blocks GPS calls: PEGP's _DSM checks If ((GPSS !=3D Zero)) be=
fore
   dispatching to GPS(). GPSS is a field in an OperationRegion (NOPR
at 0x7387C018)
   that may not be mapped when _INI runs. The nvidia driver probes GPS at b=
oot
   before NPCF's _INI sets GPSS=3D1.

2. Missing GETPPL (func 0x24): The GPS switch statement has no Case(0x24), =
so it
   falls through to Default =E2=86=92 Return(0x80000002). The driver's
   platform_request_handler_ctrl.c:629-641 expects a 12-byte buffer
   {Version=3D0x00010000, PL1, PL2}. Without it, NV_ERR_INVALID_DATA fires =
at
   line 2174.

3. GPSP buffer too small: The SSDT allocates Buffer(0x28) (40 bytes), but t=
he
   driver's PFM_REQ_HNDLR_PSHAREDATA struct is 44 bytes (0x2C). The ppmd fi=
eld
   at offset 0x28 is outside the buffer. The PPMD sensor is never populated=
,
   causing NV_ERR_INVALID_DATA at line 2117.

**Evidence**

Stock BIOS func 0x02 return (49 bytes):

    TGPA (offset 0x05): 0x0000 =3D 0W    =E2=86=90 should be 65W (0x0208)
    TGPD (offset 0x07): 0x0000 =3D 0W
    TPPA (offset 0x19): 0x0000 =3D 0W    =E2=86=90 should be 135W (0x0438)
    MAGA (offset 0x1D): 0x0000 =3D 0W    =E2=86=90 should be 120W (0x03C0)

func 0x00 return: Buffer(4){0xBF,0x06,0x00,0x00} =E2=80=94 bit 0 IS set, so
PMO constructs.
But all downstream func 0x02/0x01 fields are zeroed.

nvidia-smi after boot (stock):

    Current Power Limit:  35.00W  (VBIOS default =E2=80=94 never boosts)
    Default Power Limit:  35.00W
    Max Power Limit:      65.00W  (hardware maximum, never reached)
    Requested Power Limit: N/A    (nvidia-powerd never requests boost)

nvidia-powerd: Runs, DBus connected, zero activity logs. Falls back to
"SBIOS support not found for NVPCF GET_SUPPORTED" =E2=86=92 default TPP.

dmesg:

    NVRM: GPU0 PlatformRequestHandler failed to get target temp from SBIOS
          @ platform_request_handler_ctrl.c:2174
    NVRM: GPU0 PlatformRequestHandler failed to get platform power
mode from SBIOS
          @ platform_request_handler_ctrl.c:2117

GPS func 0x24 (GETPPL): Returns 0x80000002 (not implemented =E2=80=94
Case(0x24) missing)

GPS func 0x2A (PSHAREPARAMS): Returns 40-byte buffer but RETN=3D0x00000000 =
=E2=80=94 no
sensors declared, PPMD never populated

**Fix Description**

ACPI SSDT override via CONFIG_ACPI_TABLE_UPGRADE initrd mechanism. Two chan=
ges:

***1. NPCF Device Embedded in DSDT***

Embed Device(NPCF) at Scope(\_SB) in the DSDT. The nvidia-acpi driver hardc=
odes
pathname "\_SB.NPCF._DSM" (nv-acpi.c:785-793) =E2=80=94 NPCF must be at \_S=
B scope.

Complete NPCF device with corrected budgets:

    Scope (\_SB)
    {
        Device (NPCF)
        {
            Name (\_HID, "NVDA0820")
            Name (\_UID, "NPCF")
            Name (\_STA, 0x0F)

            Method (\_INI, 0, NotSerialized)
            {
                If (CondRefOf (\_SB.PC00.PEG1.PEGP.GPSS))
                    ^^PC00.PEG1.PEGP.GPSS =3D One
                If (CondRefOf (\_SB.PC00.PEG1.PEGP.NPCS))
                    ^^PC00.PEG1.PEGP.NPCS =3D One
            }

            Method (\_DSM, 4, Serialized)
            {
                If ((Arg0 =3D=3D ToUUID ("36b49710-2483-11e7-9598-0800200c9=
a66")))
                {
                    Return (NPCF (Arg0, Arg1, Arg2, Arg3))
                }
                Return (Buffer (One) { 0x00 })
            }

            Method (NPCF, 4, NotSerialized)
            {
                Switch (ToInteger (Arg2))
                {
                    Case (Zero)
                    {
                        Return (Buffer (4)
                        {
                            0x07, 0x01, 0x00, 0x00
                        })
                    }
                    Case (One)
                    {
                        Return (Buffer (0x0E)
                        {
                            0x20, 0x03, 0x01, 0x00, 0x25, 0x04, 0x05,
                            0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0xAB
                        })
                    }
                    Case (0x02)
                    {
                        Name (PBD2, Buffer (0x31)
                        {
                            0x25, 0x05, 0x10, 0x1C, 0x01
                        })
                        CreateWordField (PBD2, 0x05, TGPA)
                        CreateWordField (PBD2, 0x07, TGPD)
                        CreateWordField (PBD2, 0x19, TPPA)
                        CreateWordField (PBD2, 0x1B, TPPD)
                        CreateWordField (PBD2, 0x1D, MAGA)
                        CreateWordField (PBD2, 0x21, MIGA)
                        TGPA =3D 0x0208   // 65W
                        TPPA =3D 0x0438   // 135W
                        MAGA =3D 0x03C0   // 120W
                        Return (PBD2)
                    }
                    Case (0x08)
                    {
                        Return (Buffer (0x16)
                        {
                            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                            0x00
                        })
                    }
                }
                Return (Buffer (One) { 0x00 })
            }
        }
    }

Budget values explained:

    TGPA =3D 0x0208 =E2=86=92 520 =C3=97 125mW =3D 65,000mW =3D 65W (TGP + =
CTGP + PPAB)
    TPPA =3D 0x0438 =E2=86=92 1080 =C3=97 125mW =3D 135,000mW =3D 135W (tot=
al platform
power budget)
    MAGA =3D 0x03C0 =E2=86=92 960 =C3=97 125mW =3D 120,000mW =3D 120W (max =
AC GPU allocation)

The driver extracts these at client_resource.c:3160-3173:

    pParams->ctgpOffsetmW =3D (NvS32)125 *
(NvS16)DRF_VAL(..._CMD0_CTGP_AC_OFFSET, commonOut.param0);
    pParams->targetTppOffsetmW =3D (NvS32)125 *
(NvS16)DRF_VAL(..._CMD0_SIGNED0, entriesOut.param1);
    pParams->maxOutputOffsetmW =3D (NvS32)125 *
(NvS16)DRF_VAL(..._CMD0_SIGNED0, entriesOut.param2);

***2. GPS Pipeline Fix (SSDT#4)***

The GPS method in the NPCF SSDT needs three patches:

a) Remove GPSS guard from _DSM dispatcher (line 232):

    // BEFORE:
    If ((\_SB.PC00.PEG1.PEGP.GPSS !=3D Zero))
    { Return (\_SB.PC00.PEG1.PEGP.GPS (Arg0, Arg1, Arg2, Arg3)) }

    // AFTER: (guard removed)
    Return (\_SB.PC00.PEG1.PEGP.GPS (Arg0, Arg1, Arg2, Arg3))

b) Add Case(0x24) for GETPPL:

    Case (0x24)  // GPS_FUNC_GETPPL
    {
        Return (Buffer (0x0C)
        {
            0x00, 0x00, 0x01, 0x00,  // Version: Major=3D1 (0x00010000)
            0xC8, 0xAF, 0x00, 0x00,  // PL1: 45000 mW (45W)
            0xE8, 0xFD, 0x00, 0x00   // PL2: 65000 mW (65W)
        })
    }

The driver validates at platform_request_handler_ctrl.c:629-641:

    if (FLD_TEST_DRF(0000_CTRL_PFM_REQ_HNDLR, _PPL_ARG0_VERSION, _MAJOR, _V=
1,
                     acpiParamsEx.output[0]))  // output[0] bits 31:16 must=
 =3D=3D 1

c) Enlarge GPSP buffer from 0x28 to 0x2C and set PPMD status bit:

    Name (GPSP, Buffer (0x2C) {})  // was 0x28 (40 bytes)
    CreateDWordField (GPSP, 0x00, RETN)
    CreateDWordField (GPSP, 0x04, VRV1)
    CreateDWordField (GPSP, 0x08, TGPU)
    CreateDWordField (GPSP, 0x0C, PDTS)
    CreateDWordField (GPSP, 0x10, SFAN)
    CreateDWordField (GPSP, 0x14, SKNT)
    CreateDWordField (GPSP, 0x18, CPUE)
    CreateDWordField (GPSP, 0x1C, TMP1)
    CreateDWordField (GPSP, 0x20, TMP2)
    CreateDWordField (GPSP, 0x24, CTGP)  // NEW: maps to driver ctgp
at offset 0x24
    CreateDWordField (GPSP, 0x28, PPMD)  // NEW: maps to driver ppmd
at offset 0x28

    // In Case(Zero) =E2=80=94 SUPPORTED_FIELDS query:
    RETN =3D 0x00010100  // bit 8 =3D TGPU, bit 16 =3D PPMD
    // was 0x00000000 =E2=80=94 no sensors declared

The driver reads PPMD at platform_request_handler_ctrl.c:1208-1219:

    if (0 !=3D DRF_VAL(..._PSHARE_PARAMS_STATUS, _PPMD, pPShareParams->stat=
us))
    {
        _pfmreqhndlrUpdatePpmdLimit(pPlatformRequestHandler, pGpu, NV_TRUE)=
;
    }

***3. OEM Revision Bump (All 22 CB-01 SSDTs)***

Every CB-01 SSDT must have OEM Revision >=3D 0x02. The kernel's
acpi_table_initrd_override() silently skips if firmware_rev >=3D initrd_rev=
.
Factory SSDTs have rev 0x01. Hex-patch byte offset 24-27 from
01 00 00 00 to 02 00 00 00 and recalculate the ACPI checksum.

**After Fix**

    Current Power Limit:  65.00W  (Dynamic Boost active)
    Synthetic load:       65W sustained (cuda-matmul 30s)
    Genshin Impact avg:   53.1W (with CPU -75mV undervolt on shared heatsin=
k)
    AE_ALREADY_EXISTS:    0 (was 242)
    Touchpad:             working (preserved)
    GPS GETPPL:           {V1, PL1=3D45W, PL2=3D65W}
    GPS PSHAREPARAMS:     44-byte buffer with PPMD=3D7 sensor

**Key Driver Paths**

- nv-acpi.c:785-793 =E2=80=94 hardcodes pathname "\_SB.NPCF._DSM" for all
NVPCF DSM calls
- nv-acpi.c:361-365 =E2=80=94 namespace walk discovers NPCF, overwrites
globals unconditionally
  (last-wins)
- client_resource.c:2942-3002 =E2=80=94
cliresCtrlCmdSystemNVPCFGetPowerModeInfo_IMPL dispatches
  via osCallACPI_DSM
- client_resource.c:2992-2994 =E2=80=94 GET_SUPPORTED checks only bit 0 of
supportedFuncs
- client_resource.c:3100-3173 =E2=80=94 func 0x02 validates header (0x05/0x=
10/0x1C),
  extracts TGPA/TPPA/MAGA
- client_resource.c:2898-2940 =E2=80=94 func 0x01 _validateConfigStaticTabl=
e_2x two's
  complement checksum
- dynamic-power.c:1202-1223 =E2=80=94 os_get_dynamic_boost_support probes v=
ia func 0x00
- platform_request_handler_ctrl.c:601-643 =E2=80=94 GETPPL (func 0x24) vali=
dates Major
  version =3D 1
- platform_request_handler_ctrl.c:1060-1088 =E2=80=94 pfmreqhndlrCallACPI_E=
X copies
  input=E2=86=92output, calls osCallACPI_DSM
- platform_request_handler_ctrl.c:2174 =E2=80=94 TGPU sensor update fails w=
hen
  PSHAREPARAMS incomplete
- platform_request_handler_ctrl.c:2117 =E2=80=94 PPMD sensor update fails w=
hen
ppmd field
  missing
- os.c:2934-3048 =E2=80=94 osCallACPI_DSM maps function IDs to GUIDs and re=
visions

**Questions for Maintainers**

1. Driver-side fallback: When func 0x02 returns all-zero budget
fields, the driver
   silently falls back to VBIOS defaults with no warning. A pr_warn when
   ctgpOffsetmW =3D=3D 0 && maxOutputOffsetmW =3D=3D 0 (after func 0x00 rep=
orts support)
   would help users diagnose this class of firmware bug. Is this intentiona=
l?

2. Should the driver validate func 0x02 budget values? Currently
client_resource.c
   validates the header structure (sizes, version) but not whether the extr=
acted
   TGPA/TPPA/MAGA are non-zero when bit 0 of func 0x00 indicates
support. Adding a
   check like:
     if (pParams->ctgpOffsetmW =3D=3D 0 && pParams->maxOutputOffsetmW =3D=
=3D 0)
         pr_warn(NV, "NPCF: zeroed power budget detected");
   would surface Lenovo's firmware bug at boot.

3. PPMD sensor initialization: The PlatformRequestHandler
NV_ERR_INVALID_DATA errors
   at lines 2174/2117 fire when PSHAREPARAMS doesn't populate the PPMD fiel=
d. Is
   this expected for laptops without platform power mode support, or should=
 the
   driver handle the missing PPMD gracefully?

---

Full patched SSDT source, scripts, and power measurement data available at:
https://github.com/Punch-Pain/loq-npcf

System: Lenovo LOQ Essential 15IRX11 83SC | BIOS SECN22WW | RTX 5050 GB207M
Kernel 7.2.3-1-cachyos | nvidia-open 610.57.04
