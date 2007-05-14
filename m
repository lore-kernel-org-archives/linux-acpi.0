From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [announce] Intel announces the PowerTOP utility for Linux
Date: Mon, 14 May 2007 22:22:50 +0200 (MEST)
Message-ID: <Pine.LNX.4.61.0705142221440.9570@yvahk01.tjqt.qr>
References: <4644F726.1050806@linux.intel.com> <200705122212.43653.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailer.gwdg.de ([134.76.10.26]:46678 "EHLO mailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756412AbXENUY2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 May 2007 16:24:28 -0400
In-Reply-To: <200705122212.43653.s0348365@sms.ed.ac.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Arjan van de Ven <arjan@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org


On May 12 2007 22:12, Alistair John Strachan wrote:
>On Saturday 12 May 2007 00:07:18 Arjan van de Ven wrote:
>> What's eating the battery life of my laptop? Why isn't it many more
>> hours? Which software component causes the most power to be burned?
>> These are important questions without a good answer... until now.
>
>This is a really great tool and presents a very intuitive alternative to the 
>timer stats file..
>
>On a Core 2 Duo Macbook, Linux always gets around 3.2h battery, OS X about 
>4.2h. This tool has identified that uhci_hcd is where 75% of the ticks are 
>going when X is not loaded. Unloading uhci_hcd drops the battery life back to 
>around 4.2h, but I lose the keyboard.
>
>Is there any way to find out what USB driver is causing usb_uhci to be this 
>busy?

At its worst, it _is_ the USB chip that draws the power when it is active
(when uhci_hcd is loaded); does not need to be usbhid or so.


	Jan
-- 
