From: Lambdadroid <lambdadroid@gmail.com>
Subject: Override DSDT table with varying GNVS OperationRegion
Date: Fri, 1 Sep 2017 13:09:23 +0200
Message-ID: <CAOmiHeL=-rwwqHS+y96WQKYUCwyZyoqHA4PLMVLpSmd_2Qc7gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:33655 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751856AbdIALJZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Sep 2017 07:09:25 -0400
Received: by mail-qt0-f177.google.com with SMTP id e2so9118851qta.0
        for <linux-acpi@vger.kernel.org>; Fri, 01 Sep 2017 04:09:25 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I'm trying to fix some issues on a old Android Baytrail tablet caused
by a broken ACPI DSDT table. To do that, I've fixed some of the device
entries (e.g. added missing GPIOs or moved a device to the correct
parent) and re-compiled the DSDT table. I override the original DSDT
table at runtime by placing the fixed version into initrd. This is
working well for my own device, however it seems like the DSDT tables
from different devices of the same model vary by a few bytes. When I
decompile DSDT tables from these devices, they differ only by an
address in the "GNVS" OperationRegion, e.g.:

 DefinitionBlock ("", "DSDT", 2, "ALASKA", "A M I ", 0x00000003)
 {
     /* ... */

-    OperationRegion (GNVS, SystemMemory, 0x395FEA98, 0x0340)
+    OperationRegion (GNVS, SystemMemory, 0x395F1A98, 0x0340)
     Field (GNVS, AnyAcc, Lock, Preserve)
     {
         OSYS,   16,
         /* ... */
     }

     /* ... */
 }

This value appears to be different on each device and even changes
when changing certain BIOS options. It also seems like it is important
that this value is correct (e.g. see
http://www.spinics.net/lists/linux-acpi/msg56985.html) to avoid
additional problems.

I'd like to apply my fixes to all devices of the same model, without
requiring every single user to manually decompile, fix and re-compile
the DSDT table of the device. Is there any way to use a single fixed
version and apply the correct value for the OperationRegion
dynamically at runtime?

Thanks in advance,
Lambdadroid
