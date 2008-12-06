From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: samsung x360, acpi support
Date: Sat, 6 Dec 2008 11:43:58 +0000
Message-ID: <20081206114358.GA4821@srcf.ucam.org>
References: <200812041915.39971.mheinz@cs.uni-frankfurt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:56971 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbYLFLoG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Dec 2008 06:44:06 -0500
Content-Disposition: inline
In-Reply-To: <200812041915.39971.mheinz@cs.uni-frankfurt.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthias Heinz <mheinz@cs.uni-frankfurt.de>
Cc: linux-acpi@vger.kernel.org

On Thu, Dec 04, 2008 at 07:15:39PM +0100, Matthias Heinz wrote:

> 1) Backlight support: I cant control the brightness of the backlight with a 
> 2.6.28-rc7. It worked under mysterious circumstances with a 2.6.26. 
> Mysterious, because i had to use /proc/acpi/video/NVID/LCD/brightness to set 
> it, which obviously belongs to a nvidia driver (but theres nothing from 
> nvidia in there...)

Do you have the i915 module loaded? NVID is simply the vendor's name for 
the ACPI object representing the video controller.

> 2) Wifi LED: I dont know if this is a wifi driver issue or has to be 
> controlled by acpi. 

There's no standardised way for controlling LEDs via ACPI, so it's 
probably a wifi driver issue.

> 3) The keyboard is not sending acpi events for several switches. It sends 
> (unknown) keycodes that have to be interpreted by the OS.
> But there seems to be an option to change between acpi events and key events, 
> because i can control the backlight when grub is running and in the early 
> boot phase of the kernel. I dont know if this should be classified as 
> problem, but because X is catching all key events handling the wlan power 
> function is a problem of the actual user.

The brightness keys will be trapped by the BIOS and brightness change 
code run in system management mode before ACPI is enabled, which only 
happens part-way through the Linux boot process. So it's normal for the 
behaviour to change at that point. It's also not unusual for hotkeys to 
be sent via the ekyboard - ACPI doesn't have any specified way for 
handling generic hotkeys other than the sleep and power buttons.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
