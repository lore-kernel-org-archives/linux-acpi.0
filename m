From: Oliver Schinagl <oliver@schinagl.nl>
Subject: Fwd: Re: PROBLEM: USB 1.1 (and up) not working on AMD R900 Series
 chipset
Date: Wed, 07 Sep 2011 19:48:51 +0200
Message-ID: <4E67AE83.1010007@schinagl.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 7of9.schinagl.nl ([88.159.158.68]:36970 "EHLO 7of9.schinagl.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753309Ab1IGR7v (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Sep 2011 13:59:51 -0400
Received: from localhost (7of9.schinagl.nl [127.0.0.1])
	by 7of9.are-b.org (Postfix) with ESMTP id 0AA51E0E6
	for <linux-acpi@vger.kernel.org>; Wed,  7 Sep 2011 19:48:53 +0200 (CEST)
Received: from 7of9.schinagl.nl ([127.0.0.1])
	by localhost (7of9.schinagl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id CEqiPNOmtCQF for <linux-acpi@vger.kernel.org>;
	Wed,  7 Sep 2011 19:48:51 +0200 (CEST)
Received: from [10.2.0.97] (unknown [10.2.0.97])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by 7of9.schinagl.nl (Postfix) with ESMTPSA id A5586DD0D
	for <linux-acpi@vger.kernel.org>; Wed,  7 Sep 2011 19:48:51 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi list,

On the linux-usb mailinglist Greg said that I may have an ACPI interrupt 
routing issue and should try linux-acpi.

I've created a bugzilla entry[1] with all required files I think are needed?

I'll try to extract the dsdt later and see if it has any compiler bugs 
and attach that later to the mentioned bug report. Also I will try 
acpi=noirq and see if that enables basic IRQ/USB support. In the 
meantime, anybody have any other thoughts as to what I can try?

Thanks,

Oliver


[1] https://bugzilla.kernel.org/show_bug.cgi?id=42502

On Tue, Sep 06, 2011 at 09:41:50PM +0200, Oliver Schinagl wrote:
>  This summer I've purchased a new motherboard, the Asus M5A97 running an
>  AMD Phenom(tm) II X6 1090T Processor.
>
>  The moment I've received this board, I took my trusted Ubuntu 32bit
>  bootable USB stick (11.04) and loaded up to test if everything was
>  working. There appeared to be no problems so I continued for a few weeks.
>
>  As time went on, I decided it was an idea to install a 64bit OS and
>  booted the system using a 64bit version of Ubuntu on a USB stick (also
>  11.04). The system booted extremly slow with any USB devices connected.
>
>  Reading up on several lists I've tried all tricks to disable USB 2 and 3
>  support as that may cause issues, to no avail. So I went back to the
>  32bit install and stayed there for a while.
>
>  Back home from my vacation I installed my favorite distro, Gentoo and
>  used a 64bit variant. After spending some time setting up the system I
>  found I had the exact same USB issues. I disabled USB 2 and 3 in the
>  kernel and built with USB1.1 only to still see the same errors when
>  connecting anything over USB. Booting works fine, if nothing is
>  connected. I've searched far and low but have not found anything that
>  solved or related much to my errors, since everything appears to be
>  working just fine when switching back to 32bit mode.
>
>  Thanks for your time reading this and any thoughts Idea's and pointers.

This really looks like an interrupt routing issue for your hardware and
a 64bit kernel.  Nothing the USB developers can do about this, sorry.

Try contacting the acpi developers by filing a bug at
bugzilla.kernel.org and they can work on this.

thanks,

greg k-h

