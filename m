From: Scott Dylewski <scott@dylewski.com>
Subject: Re: lenovo ideapad s12 dsdt errors...
Date: Mon, 12 Oct 2009 10:20:39 -0700
Message-ID: <1255368039.12236.334.camel@localhost>
References: <1255116847.12236.272.camel@localhost>
	 <4ACFE685.1020209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hapkido.dreamhost.com ([66.33.216.122]:58455 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757120AbZJLRWc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Oct 2009 13:22:32 -0400
Received: from blingymail-a2.g.dreamhost.com (caibbdcaaaaf.dreamhost.com [208.113.200.5])
	by hapkido.dreamhost.com (Postfix) with ESMTP id F192F184C35
	for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2009 10:21:54 -0700 (PDT)
In-Reply-To: <4ACFE685.1020209@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

I don't see any obvious errors in dmesg, but using "acpi=off" on boot
seems to work much faster (no delays)...  I'll have to diagnose these
problems tonight when I get home, but do you have any suggestions for
how to debug the long boot pause and/or the fact that the boot process
continues as soon as I touch the touchpad or keyboard?

 On Fri, 2009-10-09 at 19:42 -0600, Robert Hancock wrote:
> On 10/09/2009 01:34 PM, Scott Dylewski wrote:
> > I just bought a Lenovo S12 netbook (atom processor) and installed Ubuntu
> > Karmic netbook remix on it, and I'm having some issues.  I'm getting
> > some long boot times, and wonder if it's related to the ACPI stuff.
> >
> > So I found some stuff online that suggests that my dsdt may have some
> > errors, and when I checked, it used a MSFT compiler and had a bunch of
> > warnings and errors, but I don't know how to fix them.  Can someone
> > direct me a bit and either help me fix the errors if needed, or let me
> > know what to do?
> 
> That's probably outdated advice - the kernel normally tries to deal with 
> such issues itself (or handle them the same way as Windows does, which 
> presumably works) and so replacing the DSDT isn't likely to help much. 
> Anyway, it's far from clear that your problem is at all related.
> 
> Are there any errors showing up in dmesg?

