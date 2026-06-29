Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70F2416D09
	for <linux-acpi@vger.kernel.org>; Mon, 29 Jun 2026 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742549; cv=pass; b=X6pYyTL+oQBjWih5WJKHs6LHymxbL++L/YYtVhMvgH5JGCE1xx8ZN1OCaB9PZP3foaBGYTYD7VsEDk/eUpfjV5LGczKStU6TxmfEZPiq7LpxjWLsjMgL6U2csYkU0nYKqmiIVoIUbyabtMxK8XxcuoFZo+qHele51MqiftE7rkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742549; c=relaxed/simple;
	bh=OtZHlosSQyn1xZEj4FbD20xEl2Zg6R/HhfdZz9XIx8g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=IkGaIhDsPfR5+vO3acXsJXZwx5OGERWGGILU2AcaX3HQoEENpu88Dqh8zOwcd+AfP5XBSAucvcFVfiZ5e1glg7h3JXol2AdRD6VpJ6ajUqVkO+E24X9SMliM6Rqkvl/7cSyNv9unSteKjJxj/05Hcd9fIj6k+0hSp41MFNt9GSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n33VHGyN; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n33VHGyN"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aea5e2a361so2262957e87.1
        for <linux-acpi@vger.kernel.org>; Mon, 29 Jun 2026 07:15:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782742546; cv=none;
        d=google.com; s=arc-20260327;
        b=NJ/b9QyfmF+0CDMH6IpQXIQMQuby0ShStKE+qzk+ahWqymMOnA4fpo+slWtNGTdvPG
         KM2y/Mrld8SzA7UVSoHpRo1NtAVp+emv5/h0TIYOcHNPlk/cn9wxro1tTCV2atjzmuxM
         OxiDo851osgtvRljD2S/BFg4a1ijs1KRF6b2O/Rdi0/7a6a+f37y9q21UEECd/3AIKRt
         eK/yFyXrGytNzGylFep1MMWTX/Sg2j05fXpDoENQrsc8SH/+SGgnIvGCk6Uj5/Bdv8QG
         35K0R293aD+AqlTmuYx2Ab2omn4EYUl7lmAv/ZUXauHyCOwiIrmyaXQQ37jrdyqn+b66
         a40A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=59kKtSnZyepLfYP5fS5VCom4sURma9Duve+AdYcsFp8=;
        fh=loer9u6XGn2/5izu8haVqtooBKm/iyv/3qbth0ry97k=;
        b=INdmQun1Yl9/3xjldnMeANZ3S5HaR7XncbD2GUCYVKyUUMcKJiwhYTQTx/7F18nDyz
         e7zGT3Wlcack7zjNDdw3+cbzpuWJobaoOe3mGif7YtWgRU0Ah9ZejV1MPiPsI45kkCOq
         Obj3Rp47OSi5LgP3kKfMh+E0vHN+2H1NlAy+aCuvjwKs2yAszWi4JlP+CjWP2l+R0k+A
         jbWXYat2coZ5NYNCcgbc4AZ21whFkNT9TW/D2X0Wnrb8ru0BPyp6VFmc3xjSK6ozwdtM
         Agc0ZgLKF1SVA1fdsFawjGt2hfFtPehVmhabXxzO0ltjPFpjgkD4AdsSVJq/Tzh9pver
         vy/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782742546; x=1783347346; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=59kKtSnZyepLfYP5fS5VCom4sURma9Duve+AdYcsFp8=;
        b=n33VHGyNRhhg6V2ukiHyuylPTj0yF2chSqR4UrQLU+PcO9DBVZRMJYw2HvrYxJFCXn
         Ols/xxQvAqk9M7nazKiG4RDLbGHkbTilyq3uwK6ZVlK+K3cx2IXyIQ1CHLfV41m4Jn/0
         IprzgknbhpYZsM3ypptw/UO8Kfd7T9QX6OW+KQFP8Zi4OY8EpmnVVVbfIZxAJeO/5qe1
         vlFwz94t1OWM/5yeY7MwAnRwwV5wGObQF0MF6uxHfYijcc4ciLjnU8sRpYtqooVqf6ab
         rJrIEHAXlO9jy/1dIxR3BFWSYf8V/01upD3zrBTzZ2bbwB3aSr0qZIz6PMR3cwNTivDi
         cnnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782742546; x=1783347346;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=59kKtSnZyepLfYP5fS5VCom4sURma9Duve+AdYcsFp8=;
        b=KcXTilW2OhI6jFeP6pejoPFd4DOMxRkQOFMDcxt6FBu5XvIaXTY48T9OqsYBBCLWSp
         qehCTxpbBP5viHKS5YStZ+dCAzN47Cf/aWDTA71Rzm0F/Jdo5Qpgi3m9KiCNJvdMMVyp
         HmuNcaCx4hfR1Yg5wG0Cxl7bcuUuJbY3d7s3W9RovIPVTq1vGNd/zZ0vltTB+fYoZ6zW
         Bddit7Q0lYUscQRNY7zmOpHGyMdqnnl70zh+DByWW0TwyjHSZW0GcDSzEqsp8/uqorJA
         wXjdGzSK2KWYXK2mLo68Mm/W3GbeE0JXOZGa5mgxTcx2ODVQifP0fxeueUYFf1aJKCQU
         dXqQ==
X-Forwarded-Encrypted: i=1; AHgh+RoC3FMiBGjqFNd7pvLcCC2oxJ0vZmAfuWJevWyVcH7fh7qK784KFu5G7mD9ZLBv8oGzMWql31woMple@vger.kernel.org
X-Gm-Message-State: AOJu0YwcGxkZB9JOrdiCM7tf8AC81HvoO66XcBbNldW3CYeUMrJQRCdc
	OSBzxDUVc4ZSWjfhRMmMYgc6KnTmsf7bXG0UjN9JQBJPKTu0IJH78qYF81aLt0dMuisP06jNMxQ
	k16ud3nUjbIDkO9b0IW/HDnTeG2wq9zczfERjCjJrHU3S
X-Gm-Gg: AfdE7clhnQaOxzZ2wQbFfluvzz3RiJPT/KccQRPmijA18PiOGss6XebH4MWyHSwZqKj
	2s9KYmEZjcL3dhdv9yCHbez7wA4J9iolOyzTgQPgY/VzT7++8EHOD0B/5TUITlRDkMMhWbPvlZ8
	ju3OYjPXyfQLVL3pnaX38nrDVAmsx0a6lz68HZXDjq7nbwuEwNrpCQ8LgBrXXvAFu4YiBDqAaWJ
	pqcJpVeJB81vgkinsBL4b/AtO6oTWuaXoWT9eRplmOUYON+QtcJyBh3Yl/x4f/IIl5Kc8zuIQac
	DWTDNtg0sWAqmjVcOas7QZG+kJxhZk1rfC+7MaxpBDxg1sdfr2JjCpUv
X-Received: by 2002:a05:6512:2c8c:b0:5ae:b542:434a with SMTP id
 2adb3069b0e04-5aeb5424384mr1370778e87.34.1782742545486; Mon, 29 Jun 2026
 07:15:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve Yang <steveyang137@gmail.com>
Date: Mon, 29 Jun 2026 22:15:33 +0800
X-Gm-Features: AVVi8CesCnwacAYxOkZCQnuvvoq6KByS_Mn3G3IGfj6ATQqqNfAwuGq04hFjbXE
Message-ID: <CAMNbjot1DD9p2rouzQq_SGjuo0L6WpuX215HaNOcWV7TZpueBQ@mail.gmail.com>
Subject: [BUG] I2C HID touchpad BLTP7853:00 347D:7853 enumerates but reports
 no events on MECHREVO XINGYAO Series-P916F-PTL
To: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

Resending as plain text; sorry if this is a duplicate. My previous
message was rejected by linux-acpi because Gmail sent a HTML part.

I am seeing a non-working internal I2C HID touchpad on a new MECHREVO
laptop. The device enumerates, binds to i2c_hid_acpi + hid-multitouch,
and userspace sees it as a touchpad, but touching/clicking it produces
no input events. The GPIO interrupt counter also does not increase
while touching the pad.

I am new to kernel debugging, but I have the machine here and can test
patches, ACPI overrides, debug kernels, etc.

Hardware
========

DMI, with serial/UUID intentionally omitted:

  BIOS Vendor: MECHREVO
  BIOS Version: 1.00
  BIOS Release Date: 03/14/2026
  Firmware Revision: 1.48
  EC Firmware Revision: 1.0
  System Manufacturer: MECHREVO
  Product Name: XINGYAO Series
  Family: Panther Lake
  Base Board Product Name: XINGYAO Series-P916F-PTL

Software
========

  Linux archbook 7.0.14-arch1-1 #1 SMP PREEMPT_DYNAMIC Sat, 27 Jun
2026 16:15:10 +0000 x86_64 GNU/Linux
  linux-firmware 20260622-1
  libinput 1.31.3
  hid-tools 0.12
  acpica 20251212

Kernel command line at initial capture time:

  BOOT_IMAGE=/vmlinuz-linux root=UUID=<omitted> rw rootflags=subvol=@
loglevel=3 quiet

Device identification
=====================

/sys/bus/i2c/devices/i2c-BLTP7853:00/uevent:

  DRIVER=i2c_hid_acpi
  MODALIAS=acpi:BLTP7853:PNP0C50:

/sys/bus/hid/devices/0018:347D:7853.0001/uevent:

  DRIVER=hid-multitouch
  HID_ID=0018:0000347D:00007853
  HID_NAME=BLTP7853:00 347D:7853
  HID_PHYS=i2c-BLTP7853:00
  MODALIAS=hid:b0018g0004v0000347Dp00007853

udev for /dev/input/event5:

  DEVNAME=/dev/input/event5
  ID_INPUT=1
  ID_INPUT_TOUCHPAD=1
  ID_INPUT_WIDTH_MM=115
  ID_INPUT_HEIGHT_MM=72
  ID_BUS=i2c
  ID_INTEGRATION=internal
  ID_INPUT_TOUCHPAD_INTEGRATION=internal
  LIBINPUT_DEVICE_GROUP=18/347d/7853:i2c-BLTP7853:00

Symptoms / tests
================

1. dmesg shows the device binding successfully:

  input: BLTP7853:00 347D:7853 Mouse ...
  input: BLTP7853:00 347D:7853 Touchpad ...
  hid-generic 0018:347D:7853.0001: input,hidraw0: I2C HID v1.00 Mouse
[BLTP7853:00 347D:7853] on i2c-BLTP7853:00
  input: BLTP7853:00 347D:7853 Touchpad ...
  hid-multitouch 0018:347D:7853.0001: input,hidraw0: I2C HID v1.00
Mouse [BLTP7853:00 347D:7853] on i2c-BLTP7853:00

2. evtest on /dev/input/event5 shows normal-looking touchpad
capabilities, for example
ABS_X/ABS_Y/ABS_MT_POSITION_X/ABS_MT_POSITION_Y/ABS_MT_SLOT/ABS_MT_TRACKING_ID
and BTN_TOUCH/BTN_LEFT. However, during physical touch/click tests it
prints no events after:

  Testing ... (interrupt to exit)

3. /proc/interrupts has an IRQ for the touchpad in the original ACPI
configuration:

  intel-gpio 18 BLTP7853:00

While physically touching/clicking the touchpad, the counter did not increase.

4. debugfs gpio shows this line as claimed by the touchpad and high:

  gpiochip1: 51 GPIOs, parent: platform/INTC10BC:01, INTC10BC:01:
   gpio-18 ( |TPD0 GpioInt(0) ) in hi IRQ

5. KDE/libinput sees a touchpad-class input device, but the pointer
does not move and clicks do not work.

Things already tried
====================

None of these changed the behavior:

  - acpi_osi=Windows 2021
  - BIOS option named "Enable Windows OSI"
  - unbind/bind i2c-BLTP7853:00 from i2c_hid_acpi
  - echo on > /sys/bus/i2c/devices/i2c-BLTP7853:00/power/control
  - unloading huawei_wmi
  - setting HID feature Inputmode=3 with hid-feature
  - setting HID feature Surface Switch=1 and Button Switch=1

ACPI override experiments
=========================

The kernel supports ACPI table upgrade, and I confirmed the modified
SSDT was loaded each time via dmesg, for example:

  ACPI: Table Upgrade: override [SSDT-XXXXXX-I2C_DEVT]

I tried these changes to the touchpad GpioInt resource:

  original: GpioInt(Level, ActiveLow, ...)
  test 1: GpioInt(Level, ActiveHigh, ...)
  test 2: GpioInt(Edge, ActiveLow, ...)
  test 3: GpioInt(Edge, ActiveHigh, ...)

All three GpioInt variants still resulted in an intel-gpio IRQ for
BLTP7853:00, but the IRQ counter did not increase while
touching/clicking the touchpad.

I also forced _CRS to return the SBFI Interrupt() resource instead of
the SBFG GpioInt() resource. That changed the interrupt to:

  IR-IO-APIC 84-fasteoi BLTP7853:00

but it caused an apparent interrupt storm, with the counter increasing
by thousands over a few seconds, and still no evtest events. So the
Interrupt() path does not look correct either.

ACPI notes
==========

The touchpad ACPI device appears in SSDT under:

  \_SB.PC00.I2C5.TPD0

Relevant decompiled pieces from ssdt18.dsl:

  Scope (\_SB.PC00.I2C5)
  {
      Device (TPD0)
      {
          Name (HID2, Zero)
          ...
          Name (SBFG, ResourceTemplate ()
          {
              GpioInt (Level, ActiveLow, ExclusiveAndWake, PullDefault, 0x0000,
                  "\\_SB.GPI1", 0x00, ResourceConsumer, ,)
                  { 0x0000 }
          })
          Name (SBFI, ResourceTemplate ()
          {
              Interrupt (ResourceConsumer, Level, ActiveLow,
ExclusiveAndWake, ,, _Y08)
              {
                  0x00000000,
              }
          })
          CreateWordField (SBFB, \_SB.PC00.I2C5.TPD0._Y07._ADR, BADR)
          CreateDWordField (SBFB, \_SB.PC00.I2C5.TPD0._Y07._SPE, SPED)
          CreateWordField (SBFG, 0x17, INT1)
          CreateDWordField (SBFI, \_SB.PC00.I2C5.TPD0._Y08._INT, INT2)

          Method (_INI, 0, NotSerialized)
          {
              INT1 = GNUM (\TPIT)
              INT2 = INUM (\TPIT)
              If ((TPDM == Zero))
              {
                  SHPO (\TPIT, One)
              }
              SGRA (\TPIT, TPDM)
              If ((TPDM == One))
              {
                  SGII (\TPIT, Zero)
                  GRXE (\TPIT, Zero)
              }
              If ((\TPTY == One))
              {
                  _HID = "BLTP7853"
                  HID2 = One
                  BADR = 0x2C
                  SPED = 0x00061A80
                  Return (Zero)
              }
          }

          Name (_HID, "XXXX0000")
          Name (_CID, "PNP0C50")

          Method (_CRS, 0, NotSerialized)
          {
              If ((TPDM == Zero))
              {
                  Return (ConcatenateResTemplate (I2CM (I2CX, BADR,
SPED), SBFG))
              }
              Return (ConcatenateResTemplate (I2CM (I2CX, BADR, SPED), SBFI))
          }
      }
  }

ssdt13.dsl defines the NVS fields used by that code:

  OperationRegion (LCNV, SystemMemory, 0x6FDE4000, 0x0300)
  Field (LCNV, AnyAcc, Lock, Preserve)
  {
      EDID, 4096,
      TPTY, 8,
      TPST, 8,
      TPIT, 32,
      ...
  }

A possibly relevant observation from the same SSDT: under
\_SB.PC00.I2C5, TPD0 seems to use the PXTC power resource, and the
Arg0==0 path in PON() appears to only route/configure IRQ. The Arg0==1
path, apparently for the touch panel PTPL resource, is the one that
toggles TPWR/TRST GPIOs. I have not tested overriding TPD0 to use that
power resource yet.

Question
========

Does this still look like an ACPI GPIO/resource issue, or should I now
focus on an i2c-hid/hid-multitouch quirk or a missing vendor-specific
reset/init sequence for HID 347D:7853?

I have a full debug bundle available, including acpidump, decompiled
SSDTs, dmesg, udev info, evtest output, hid-recorder output,
dmidecode, and /proc/interrupts snapshots. I can provide any specific
files or test patches you want.

Thanks,
Steve
