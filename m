From: Len Brown <lenb@kernel.org>
Subject: Re: obtaining acpi details outside of drivers/acpi
Date: Thu, 6 Sep 2007 09:22:50 -0400
Message-ID: <200709060922.50337.lenb@kernel.org>
References: <1189073769.7969.32.camel@localhost> <200709060743.42060.lenb@kernel.org> <1189079221.7969.40.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54656 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755977AbXIFNTH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Sep 2007 09:19:07 -0400
In-Reply-To: <1189079221.7969.40.camel@localhost>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Hourihane <alanh@fairlite.demon.co.uk>
Cc: linux-acpi@vger.kernel.org

On Thursday 06 September 2007 07:47, Alan Hourihane wrote:

> Mmm. It seems acpi_video_bus_check() is static and therefore not
> available outside of video.c
> 
> > BTW. I'm curious what you are trying to do.
> > There is actually quite a bit of movement in this code right now.
> 
> Think about fbdev drivers (or some video driver).... Rather than
> bang on the hardware to try and do auto-detection of devices, it's much
> easier (and sometimes required) to just ask the system BIOS via ACPI to
> see what devices are available.
> 
> I want to parse _DOD myself to see what's available in kernel space.

It would be good to have this code in only one place
and export it from there to other parts of the kernel that need it.
I'd like to be able to not have fbdev drivers depend on the acpi video driver,
so perhaps we could have some generic interface where fbdev is the consumer
and in this case acpi/video.c is the provider?

-Len
