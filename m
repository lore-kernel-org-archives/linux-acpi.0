From: Daniel Drake <drake@endlessm.com>
Subject: Windows/Linux mismatch in _OSI return value for supported OS
Date: Thu, 11 Aug 2016 09:22:07 -0600
Message-ID: <CAD8Lp45WX9c3EaiQbTyazPy3sbvSZNnZocUfh4UdAmqdPGUGug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:33923 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbcHKPWJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Aug 2016 11:22:09 -0400
Received: by mail-oi0-f42.google.com with SMTP id l203so9380414oib.1
        for <linux-acpi@vger.kernel.org>; Thu, 11 Aug 2016 08:22:08 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Linux Upstreaming Team <linux@endlessm.com>

Hi,

Asus are pushing BIOS updates that include the following code:

    If (~_OSI ("Windows 2012"))
    {
        SRXO (0x0203000D, One)
    }

This is supposed to be a bugfix for Windows 7 and previous, SRXO
should run there. But if that SRXO call runs on Windows 8 or newer, or
Linux, the laptop's touchpad stops responding.

However, on Linux, even though we do claim support for Windows 2012,
that SRXO code is running and breaking the touchpad. Why? They are
using bitwise not. _OSI on Linux returns a 32-bit value 0xffffffff to
mean "supported" (as stated in the ACPI spec). But ACPI integers are
64 bits.

So, ~_OSI(Windows 2012) = ~0x00000000FFFFFFFF = 0xFFFFFFFF00000000.
Non-zero, so this will always evaluate to TRUE.

This is a pretty strong suggestion that Windows is disobeying the ACPI
spec here and is returning 0xffffffffffffffff (64 ones) from _OSI.
(can someone double check?)

Should Linux be modified to follow Windows behaviour too? Any hints on
how to do that? acpi_ut_osi_implementation return type is acpi_status,
32 bit, so it's not even immediately obvious how to make this change.

Thanks,
Daniel
