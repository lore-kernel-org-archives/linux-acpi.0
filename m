From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Fri, 11 May 2012 13:11:24 -0700
Message-ID: <20120511201124.GF18754@xanatos>
References: <4FAD3A51.4010803@intel.com>
 <Pine.LNX.4.44L0.1205111302080.1865-100000@iolanthe.rowland.org>
 <20120511183543.GF7920@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:59015 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754380Ab2EKULb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 May 2012 16:11:31 -0400
Content-Disposition: inline
In-Reply-To: <20120511183543.GF7920@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Lan Tianyu <tianyu.lan@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org

On Fri, May 11, 2012 at 11:35:43AM -0700, Greg KH wrote:
> On Fri, May 11, 2012 at 01:44:26PM -0400, Alan Stern wrote:
> > On Sat, 12 May 2012, Lan Tianyu wrote:
> > > So I should work on the external ports without devices firstly and
> > > add the sys file for user to control?
> > 
> > Yes, I think so.  It will be less controversial and probably simpler.  
> > When that mechanism is ready, you should be able to use it
> > automatically for unconnectable ports.
> > 
> > One tricky thing: In theory, there should be a separate sysfs file for 
> > each port.  That seems like a lot of overhead though; is there any way 
> > to present the information in a single file that won't offend sysfs 
> > purists?
> 
> Why is that a lot of "overhead"?  It's what, 7-9 files max?  As Sarah
> points out, one file for all ports is racy and can get to be a mess.
> 
> But then again, I'm a "sysfs purist" :)

Theoretically there's no maximum number for xHCI root ports, so I
wouldn't be so sure you'll only have 9 files on future xHCI hosts.

Sarah Sharp
