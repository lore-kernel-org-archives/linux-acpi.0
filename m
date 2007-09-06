From: Len Brown <lenb@kernel.org>
Subject: Re: obtaining acpi details outside of drivers/acpi
Date: Thu, 6 Sep 2007 07:43:41 -0400
Message-ID: <200709060743.42060.lenb@kernel.org>
References: <1189073769.7969.32.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60504 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756333AbXIFLjw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Sep 2007 07:39:52 -0400
In-Reply-To: <1189073769.7969.32.camel@localhost>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Hourihane <alanh@fairlite.demon.co.uk>
Cc: linux-acpi@vger.kernel.org

Hi Alan,

Yes, pathnames are arbitrary, don't use them.

Look in drivers/acpi/video.c for acpi_video_bus_check()
As the video device has no HID, this routine is basically
used to check all the drivers in the tree if they have _DOD
and the other stuff a video device should have.

BTW. I'm curious what you are trying to do.
There is actually quite a bit of movement in this code right now.

cheers,
-Len

On Thursday 06 September 2007 06:16, Alan Hourihane wrote:
> I'm looking at the currently exported function calls to other kernel
> modules to obtain ACPI data.
> 
> For example, if I want to access _DOD for graphics, the pathname would
> be something like...
> 
> \\_SB_.PCI0.GFX0._DOD
> 
> And I'm currently doing this...
> 
> 	status = acpi_evaluate_object(NULL, PATHNAME, NULL, &buffer);
> 
> where PATHNAME is the path above.
> 
> But there's no guarantees that it's called PCI0, or even GFX0.
> 
> What's the best way to search the namespace and get this data ??
> 
> Alan.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
