From: Danny Baumann <dannybaumann@web.de>
Subject: Re: Brightness buttons broken on Toshiba Satellite Proc A100
	in	kernel 2.6.23 (Fedora8)
Date: Tue, 30 Oct 2007 18:21:21 +0100
Message-ID: <1193764882.6380.1.camel@rechenknecht.peppercon.de>
References: <loom.20071016T122903-517@post.gmane.org>
	 <4714CB1A.7010300@redhat.com>
	 <1193746910.18110.1.camel@rechenknecht.peppercon.de>
	 <472737BB.2000609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmmailgate03.web.de ([217.72.192.234]:40254 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992AbXJ3RVY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Oct 2007 13:21:24 -0400
In-Reply-To: <472737BB.2000609@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: linux-acpi@vger.kernel.org

Hi,

> > Ok, I played around with it some more. It seems that on my Laptop the
> > firmware sends out notifications on Fn+F6/7 press.
> > Kernel 2.6.23-rc2 worked fine, -rc3 is broken. Reverting ec.c in the
> > current Fedora kernel to the version in 2.6.23-rc2 makes brightness
> > control work again. After finding that, I tried the current HEAD version
> > of ec.c - unfortunately to no avail.
> > 2.6.23-rc3 doesn't show up the (unwanted) key events for Fn+F6/7 though
> > - this behaviour was introduced in -rc4.
> > 
> > Is it possible to fix the problem with the amount of information
> > provided? If no, what additional information can I provide?
> Please check if attached patch changes situation.

Yes, it does. With that patch, everything works as intended.
Gnome-power-manager doesn't seem to work properly with it, but that's a
different story ;-)

> Also, please open a new bug entry in bugzilla.kernel.org and put all the data you've collected there.
> Please also attach full output from acpidump.

Done: http://bugzilla.kernel.org/show_bug.cgi?id=9262 .
Sorry I didn't open it in the first place, but I wasn't sure if it was a
distro kernel problem, a hardware problem or a vanilla kernel problem.

Thanks,

Danny

