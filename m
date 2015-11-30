From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: ACPI device without physical node (pnpacpi oddity?)
Date: Mon, 30 Nov 2015 12:15:27 -0800
Message-ID: <CALCETrVSywZt9=_axGu9GYarkezd+j7mKJJ_TS9NXZZg7qAZ0A@mail.gmail.com>
References: <CALCETrXcJN-nKLVzuWj_pbqwO+g0i1sfg2vCr=Y6_Gn_7XT=gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34756 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753746AbbK3UPr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Nov 2015 15:15:47 -0500
Received: by obbbj7 with SMTP id bj7so136840212obb.1
        for <linux-acpi@vger.kernel.org>; Mon, 30 Nov 2015 12:15:47 -0800 (PST)
In-Reply-To: <CALCETrXcJN-nKLVzuWj_pbqwO+g0i1sfg2vCr=Y6_Gn_7XT=gw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Sun, Nov 29, 2015 at 9:19 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> I have this device:
>
>         Device (HIDD)
>         {
>             Name (_HID, "INT33D5")  // _HID: Hardware ID
>             Name (_CID, "PNP0C02" /* PNP Motherboard Resources */)  //
> _CID: Compatible ID
>             Name (HBSY, Zero)
>             Name (HIDX, Zero)
>             Name (HMDE, Zero)
>             Name (HRDY, Zero)
>             Method (_STA, 0, Serialized)  // _STA: Status
>             {
>                 If ((OIDE () < One))
>                 {
>                     Return (Zero)
>                 }
>
>                 Return (0x0F)
>             }
>
>             Method (HDDM, 0, Serialized)
>             {
>                 Name (DPKG, Package (0x04)
>                 {
>                     0x11111111,
>                     0x22222222,
>                     0x33333333,
>                     0x44444444
>                 })
>                 Return (DPKG) /* \_SB_.HIDD.HDDM.DPKG */
>             }
>
>             Method (HDEM, 0, Serialized)
>             {
>                 HBSY = Zero
>                 If ((HMDE == Zero))
>                 {
>                     Return (HIDX) /* \_SB_.HIDD.HIDX */
>                 }
>
>                 Return (HMDE) /* \_SB_.HIDD.HMDE */
>             }
>
>             Method (HDMM, 0, Serialized)
>             {
>                 Return (HMDE) /* \_SB_.HIDD.HMDE */
>             }
>
>             Method (HDSM, 1, Serialized)
>             {
>                 HRDY = Arg0
>             }
>
>             Method (HPEM, 1, Serialized)
>             {
>                 HBSY = One
>                 If ((HMDE == Zero))
>                 {
>                     HIDX = Arg0
>                 }
>                 Else
>                 {
>                     HIDX = Arg0
>                 }
>
>                 Notify (HIDD, 0xC0) // Hardware-Specific
>                 Local0 = Zero
>                 While (((Local0 < 0xFA) && HBSY))
>                 {
>                     Sleep (0x04)
>                     Local0++
>                 }
>
>                 If ((HBSY == One))
>                 {
>                     HBSY = Zero
>                     HIDX = Zero
>                     Return (One)
>                 }
>                 Else
>                 {
>                     Return (Zero)
>                 }
>             }
>
>             Method (NRBT, 2, NotSerialized)
>             {
>                 If ((OIDE () >= One))
>                 {
>                     If ((HRDY == One))
>                     {
>                         HIDX = 0x08
>                         Notify (HIDD, 0xC0) // Hardware-Specific
>                     }
>                 }
>             }
>         }
>
> _STA returns 0x0f, and the device is functional if I attach to it
> directly.  But I want to write a proper driver for it and to attach to
> the correct device, and the ACPI and PnP bus code isn't cooperating.
>
> From inspection of the code, acpi_pnp.c determines that the device is
> a pnp device because pnp0c02 is in acpi_pnp_device_ids.  This causes
> the device to have a concrete handler, so no platform device is
> created.  However, pnpacpi/core.c rejects it because it has no _CRS
> method.  As a result, it's in limbo.
>
> What's the right thing to do here?  I could modify acpi_pnp.c to
> reject the device, which will let the generic platform fallback claim
> it.  I could modify pnpacpi to accept the device despite the lack of
> _CRS, so a pnp device will be created.  I could bind directly as an
> ACPI driver (somewhat suboptimal because apparently that's frowned
> upon).  I could also write *both* an ACPI driver and platform driver
> and call acpi_create_platform_device from the ACPI driver, but that
> seems a bit ugly.
>
> Thoughts?

If this is firmware bug (the ACPI spec suggests that _CRS may be
mandatory for non-natively-enumerable things like this), then there's
also a chance that the vendor will fix it.  On the other hand, maybe
this is already compliant and we should just interpret missing _CRS as
an empty set of resources.  (By inspection of the ASL, it really does
look like this thing has no resources beyond the ACPI methods in it.)

--Andy
