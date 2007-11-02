From: Danny Baumann <dannybaumann@web.de>
Subject: Re: Brightness buttons broken on Toshiba Satellite Proc A100
	in	kernel 2.6.23 (Fedora8)
Date: Fri, 02 Nov 2007 14:40:53 +0100
Message-ID: <1194010853.4726.1.camel@rechenknecht.peppercon.de>
References: <loom.20071016T122903-517@post.gmane.org>
	 <4714CB1A.7010300@redhat.com>
	 <1193746910.18110.1.camel@rechenknecht.peppercon.de>
	 <472737BB.2000609@gmail.com>
	 <1193764882.6380.1.camel@rechenknecht.peppercon.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmmailgate01.web.de ([217.72.192.221]:36528 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529AbXKBNk4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Nov 2007 09:40:56 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 586C3ACAC33A
	for <linux-acpi@vger.kernel.org>; Fri,  2 Nov 2007 14:40:55 +0100 (CET)
Received: from [212.80.250.154] (helo=[192.168.1.26])
	by smtp05.web.de with asmtp (TLSv1:RC4-MD5:128)
	(WEB.DE 4.108 #208)
	id 1Inwla-0004MM-00
	for linux-acpi@vger.kernel.org; Fri, 02 Nov 2007 14:40:54 +0100
In-Reply-To: <1193764882.6380.1.camel@rechenknecht.peppercon.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

> > > Ok, I played around with it some more. It seems that on my Laptop the
> > > firmware sends out notifications on Fn+F6/7 press.
> > > Kernel 2.6.23-rc2 worked fine, -rc3 is broken. Reverting ec.c in the
> > > current Fedora kernel to the version in 2.6.23-rc2 makes brightness
> > > control work again. After finding that, I tried the current HEAD version
> > > of ec.c - unfortunately to no avail.
> > > 2.6.23-rc3 doesn't show up the (unwanted) key events for Fn+F6/7 though
> > > - this behaviour was introduced in -rc4.
> > > 
> > > Is it possible to fix the problem with the amount of information
> > > provided? If no, what additional information can I provide?
> > Please check if attached patch changes situation.
> 
> Yes, it does. With that patch, everything works as intended.
> Gnome-power-manager doesn't seem to work properly with it, but that's a
> different story ;-)

Well, it is a different story. A fix for the gpm problem is at
http://bugzilla.kernel.org/show_bug.cgi?id=9277, but the underlying
problem is a different one that I need some help with:
The root problem is that I get two notifications per brightness hotkey
press. One is for video bus VGA, device LCD; the other one is for bus
GFX0, device LCD. The LCD device on GFX0 is of type 0x400 (internal
flat-panel), the one on VGA is of type 0x110 (external CRT - for
backwards compatibility). So I can somehow understand why Toshiba
duplicated the device in two busses, but the outcome of that is somewhat
inconvenient because it halves the amount of brightness levels I have
available ;-)

Now my question is: Can anything be done inside the kernel against this
kind of problem? I can hardly imagine that Toshiba is the only company
that duplicates the LCD device for backwards compatibility (as this is
even given in the example IDs in table B-3 in the ACPI spec). I thought
about that for some time, but didn't come up with a good idea so far.
Maybe an idea would be to prevent the inclusion of certain ACPI paths
into the namespace by a kernel command line parameter?

Thanks,

Danny

