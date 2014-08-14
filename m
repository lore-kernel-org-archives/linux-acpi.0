From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 1/2] USB: Use ACPI device information
Date: Thu, 14 Aug 2014 08:45:32 +0800
Message-ID: <20140814004532.GA26547@kroah.com>
References: <1407950132-15863-1-git-send-email-sameo@linux.intel.com>
 <20140813220309.GE7908@kroah.com>
 <2225297.jp5n9UkMJt@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:52489 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752307AbaHNAqP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Aug 2014 20:46:15 -0400
Content-Disposition: inline
In-Reply-To: <2225297.jp5n9UkMJt@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-acpi@vger.kernel.org, Faouaz TENOUTIT <faouaz.tenoutit@intel.com>

On Thu, Aug 14, 2014 at 02:17:59AM +0200, Rafael J. Wysocki wrote:
> On Thursday, August 14, 2014 06:03:09 AM Greg Kroah-Hartman wrote:
> > On Wed, Aug 13, 2014 at 07:15:31PM +0200, Samuel Ortiz wrote:
> > > From: Faouaz TENOUTIT <faouaz.tenoutit@intel.com>
> > > 
> > > Use ACPI device pld information instead of calling
> > > acpi_get_physical_device_location.
> > 
> > Why?  What does this do "better" than the existing code?
> 
> Well, you've acked this patch before. :-)

I can't remember what I ate for Lunch yesterday, let alone previous
patches I've acked :)

> It just doesn't execute AML from within the USB core.  I thought that would
> be a sufficient reason, wouldn't it?

Yes, that's fine, but a little more description of "why" would have been
helpful here...

thanks,

greg k-h
