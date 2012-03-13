From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V2 1/4] ACPI: Fix up _PLD methods
Date: Tue, 13 Mar 2012 14:49:41 -0700
Message-ID: <20120313214941.GA4534@kroah.com>
References: <1331588747-1247-1-git-send-email-mjg@redhat.com>
 <20120313213207.GA23216@kroah.com>
 <20120313213850.GB22956@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55434 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759903Ab2CMVto (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Mar 2012 17:49:44 -0400
Received: by iagz16 with SMTP id z16so1329304iag.19
        for <linux-acpi@vger.kernel.org>; Tue, 13 Mar 2012 14:49:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120313213850.GB22956@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, lenb@kernel.org

On Tue, Mar 13, 2012 at 09:38:50PM +0000, Matthew Garrett wrote:
> On Tue, Mar 13, 2012 at 02:32:07PM -0700, Greg KH wrote:
> > On Mon, Mar 12, 2012 at 05:45:44PM -0400, Matthew Garrett wrote:
> > > _PLD is defined as returning a package of buffers, but many implementations
> > > simply return a buffer. Fix this up.
> > > 
> > > (Original patch by Bob Moore <robert.moore@intel.com>)
> > 
> > Does that mean the "From:" line should be set to Bob?
> > 
> > Any objection from the ACPI developers for me to apply this series?
> 
> Bob's asked me to hold off on this - he has a better patch for acpica 
> that he'll post later this month.

Ok, so I'll drop the whole series, I guess this will miss 3.4 then :(

greg k-h
