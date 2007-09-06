From: Alan Hourihane <alanh@fairlite.demon.co.uk>
Subject: Re: obtaining acpi details outside of drivers/acpi
Date: Thu, 06 Sep 2007 12:47:01 +0100
Message-ID: <1189079221.7969.40.camel@localhost>
References: <1189073769.7969.32.camel@localhost>
	 <200709060743.42060.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fairlite.demon.co.uk ([80.176.228.186]:46402 "EHLO
	fairlite.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791AbXIFLrF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Sep 2007 07:47:05 -0400
In-Reply-To: <200709060743.42060.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Thu, 2007-09-06 at 07:43 -0400, Len Brown wrote:
> Hi Alan,
> 
> Yes, pathnames are arbitrary, don't use them.
> 
> Look in drivers/acpi/video.c for acpi_video_bus_check()
> As the video device has no HID, this routine is basically
> used to check all the drivers in the tree if they have _DOD
> and the other stuff a video device should have.

Mmm. It seems acpi_video_bus_check() is static and therefore not
available outside of video.c

> BTW. I'm curious what you are trying to do.
> There is actually quite a bit of movement in this code right now.

Think about fbdev drivers (or some video driver).... Rather than
bang on the hardware to try and do auto-detection of devices, it's much
easier (and sometimes required) to just ask the system BIOS via ACPI to
see what devices are available.

I want to parse _DOD myself to see what's available in kernel space.

What else can I use ?

Alan.

