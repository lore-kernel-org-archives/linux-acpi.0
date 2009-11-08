From: Ken Corbin <kencx@peak.org>
Subject: Re: Suspend locks up Toshiba Satelite L355-S7915 (no longer)
Date: Sat, 7 Nov 2009 19:30:50 -0800
Message-ID: <200911071930.50420.kencx@peak.org>
References: <200911051928.38825.kencx@peak.org> <200911070809.23947.kencx@peak.org> <alpine.LFD.2.00.0911072138260.4291@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailscanner1.peak.org ([69.59.192.37]:46478 "EHLO
	mailscanner1.peak.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832AbZKHDb4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Nov 2009 22:31:56 -0500
In-Reply-To: <alpine.LFD.2.00.0911072138260.4291@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, linux-acpi@vger.kernel.org



On Saturday 07 November 2009 18:44:46 Len Brown wrote:
>
> > There are other problems, but they are minor and can be lived with.  Most
> > hotkeys do not work.  And the computer doesn't flash the power button
> > when it is suspended.  There is a omnibook module that purports do do
> > these functions, but it isn't coded to work with the Satelite L355-S7915.
> >  I've been looking into fixing that.  But it has occurred to me that that
> > driver is largely duplicating standard acpi functions.  And that it might
> > be a better use of my time to look into configuring acpi to work with
> > this laptop.  Any recommendations?
>
> Generally the platform drivers implement support for non-standard
> features that are not included in the generic ACPI support.
> Often the non-standard support is implemented with vendor-specific
> extensions to ACPI.
>
> Unfortunately, except in a few cases, hotkeys are non-standard.
> So extending the platform driver for boxes similar to your own
> to talk to your box may be the way to go..
>
> The LED indicator on sleeping, however, is generally standard
> (there is a method called "_SST" that we invoke that tells the BIOS
>  to start & stop blinking the suspend LED)
>
> Do you know if the LED blinked when Windows suspended on this laptop?
>
> cheers,
> Len Brown, Intel Open Source Technology Center

The LED blinks when suspended under Windows.  It also blinks, at a much slower 
rate, when suspended in Ubuntu of I have the omnibook module loaded.  I'm 
still looking at how it does that.   Is this something that we should expect 
the stock acpi process to take care of?

Have a nice day,
-Ken

> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html




