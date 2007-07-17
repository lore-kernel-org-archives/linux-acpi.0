From: Carlos Corbacho <cathectic@gmail.com>
Subject: [RFC][PATCH 0/5] ACPI: acer_acpi
Date: Tue, 17 Jul 2007 15:44:56 +0100
Message-ID: <200707171544.57004.cathectic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.233]:18236 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbXGQOoq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jul 2007 10:44:46 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1531062wxd
        for <linux-acpi@vger.kernel.org>; Tue, 17 Jul 2007 07:44:45 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello all,

The following five patches (against acpi test) add support for Acer laptops
(2005 and newer) that define the PNP0C14 _HID device in ACPI (aka the Windows
Management Instrumentation Device).

There are two known, supported ACPI devices so far that are attached to
PNP0C14 in the DSDTs of supported laptops that I've seen:

1) \_SB.AMW0 (some 2005 - 2006 laptops)
2) \_SB.WMID (some 2006 - present laptops)

acer_acpi can enable and disable the wireless and bluetooth devices on these
laptops through the methods with this _HID device (especially useful since
many Acer laptops ship with software controlled switches for these). On AMW0
laptops, we can also enable the mail LED, and on WMID, alter the brightness
of the backlight.

For one laptop, we also apply an old quirk with the keyboard controller to
make the multimedia keys emit scancodes.

Any comments, thoughts, criticisms, etc are all welcome - if it isn't painfully
obvious already, this is my first kernel driver.

-Carlos
-- 
E-Mail: cathectic@gmail.com
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
