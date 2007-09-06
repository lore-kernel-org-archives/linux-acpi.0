From: Alan Hourihane <alanh@fairlite.demon.co.uk>
Subject: Re: obtaining acpi details outside of drivers/acpi
Date: Thu, 06 Sep 2007 14:53:53 +0100
Message-ID: <1189086833.7969.58.camel@localhost>
References: <1189073769.7969.32.camel@localhost>
	 <200709060743.42060.lenb@kernel.org> <1189079221.7969.40.camel@localhost>
	 <200709060922.50337.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fairlite.demon.co.uk ([80.176.228.186]:47551 "EHLO
	fairlite.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932191AbXIFNx4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Sep 2007 09:53:56 -0400
In-Reply-To: <200709060922.50337.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Thu, 2007-09-06 at 09:22 -0400, Len Brown wrote:
> On Thursday 06 September 2007 07:47, Alan Hourihane wrote:
> 
> > Mmm. It seems acpi_video_bus_check() is static and therefore not
> > available outside of video.c
> > 
> > > BTW. I'm curious what you are trying to do.
> > > There is actually quite a bit of movement in this code right now.
> > 
> > Think about fbdev drivers (or some video driver).... Rather than
> > bang on the hardware to try and do auto-detection of devices, it's much
> > easier (and sometimes required) to just ask the system BIOS via ACPI to
> > see what devices are available.
> > 
> > I want to parse _DOD myself to see what's available in kernel space.
> 
> It would be good to have this code in only one place
> and export it from there to other parts of the kernel that need it.
> I'd like to be able to not have fbdev drivers depend on the acpi video driver,
> so perhaps we could have some generic interface where fbdev is the consumer
> and in this case acpi/video.c is the provider?

That sounds good. I'm open to suggestions on interface.

But is there anything better available now to scan the namespace in
current released kernels for _DOD ?

Alan.

