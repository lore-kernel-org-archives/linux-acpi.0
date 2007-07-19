From: Len Brown <lenb@kernel.org>
Subject: Re: [RFC][PATCH 0/5] ACPI: acer_acpi
Date: Wed, 18 Jul 2007 20:58:40 -0400
Message-ID: <200707182058.40193.lenb@kernel.org>
References: <200707171544.57004.cathectic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40395 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756473AbXGSA6o (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Jul 2007 20:58:44 -0400
In-Reply-To: <200707171544.57004.cathectic@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <cathectic@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Tuesday 17 July 2007 10:44, Carlos Corbacho wrote:
> Hello all,
> 
> The following five patches (against acpi test) add support for Acer laptops
> (2005 and newer) that define the PNP0C14 _HID device in ACPI (aka the Windows
> Management Instrumentation Device).

no, PNP0C14 is not specific to acer,
and a platform-specific driver should not be necessary to handle it.

I started a wmi.c a while back, and planned to get it out on the
list by the end of July.  I've got only one laptop that I can
test it on (an HP).  Perhaps you can help me test a generic wmi.c
on your Acer?

thanks,
-Len

> There are two known, supported ACPI devices so far that are attached to
> PNP0C14 in the DSDTs of supported laptops that I've seen:
> 
> 1) \_SB.AMW0 (some 2005 - 2006 laptops)
> 2) \_SB.WMID (some 2006 - present laptops)
> 
> acer_acpi can enable and disable the wireless and bluetooth devices on these
> laptops through the methods with this _HID device (especially useful since
> many Acer laptops ship with software controlled switches for these). On AMW0
> laptops, we can also enable the mail LED, and on WMID, alter the brightness
> of the backlight.
> 
> For one laptop, we also apply an old quirk with the keyboard controller to
> make the multimedia keys emit scancodes.
> 
> Any comments, thoughts, criticisms, etc are all welcome - if it isn't painfully
> obvious already, this is my first kernel driver.
> 
> -Carlos
