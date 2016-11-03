From: Daniel Drake <drake@endlessm.com>
Subject: Support for ACPI0011 Generic Buttons Device
Date: Thu, 3 Nov 2016 07:24:03 -0600
Message-ID: <CAD8Lp4553c8U=XfzbiXsKYgj_PKnVjmk9MdB3j=O-pPt9yi7BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37660 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752131AbcKCNYF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Nov 2016 09:24:05 -0400
Received: by mail-wm0-f50.google.com with SMTP id t79so100785431wmt.0
        for <linux-acpi@vger.kernel.org>; Thu, 03 Nov 2016 06:24:04 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc: Linux Upstreaming Team <linux@endlessm.com>

Hi,

We are working with a new consumer laptop model which has physical
volume up/down keys on the left side of the chassis.

It appears that these buttons are driven by the ACPI0011 Generic
Buttons Device defined in section 9.19 of the ACPI spec. The _DSD has
entries for the appropriate HID codes for volume up/down which can
also be seen in examples here:

https://msdn.microsoft.com/en-us/windows/hardware/drivers/hid/acpi-button-device

I can't see a Linux driver for this ACPI0011 interface, is one planned?

Thanks
Daniel
