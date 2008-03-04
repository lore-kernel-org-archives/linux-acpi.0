From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 4/4] ACPI PCI slot detection driver
Date: Tue, 4 Mar 2008 10:18:28 -0800
Message-ID: <200803041018.29035.jbarnes@virtuousgeek.org>
References: <20080229002341.GA21420@ldl.fc.hp.com> <20080301144307.GD24386@parisc-linux.org> <20080304054927.GA15566@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-40.bluehost.com ([69.89.20.194]:43848 "HELO
	outbound-mail-40.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1765719AbYCDSTE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Mar 2008 13:19:04 -0500
In-Reply-To: <20080304054927.GA15566@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Matthew Wilcox <matthew@wil.cx>, Alex Chiang <achiang@hp.com>, Gary Hade <garyhade@us.ibm.com>, kaneshige.kenji@jp.fujitsu.com, warthog19@eaglescrag.net, kristen.c.accardi@intel.com, rick.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-acpi@vger.kernel.org

On Monday, March 03, 2008 9:49 pm Greg KH wrote:
> On Sat, Mar 01, 2008 at 07:43:07AM -0700, Matthew Wilcox wrote:
> > On Fri, Feb 29, 2008 at 09:25:42PM -0800, Greg KH wrote:
> > > What is the guarantee that the names of these slots are correct and do
> > > not happen to be the same as the hotpluggable ones?
> >
> > That would be a bug -- and yes, bugs happen, and we have to deal with
> > them.
>
> My main concern is that BIOS vendors will not fix these bugs, as no
> other OS cares/does this kind of thing today.  The ammount of bad
> information out there might be quite large, and I think this was
> confirmed by some initial testing of IBM systems, right?

Yeah, but there's a flip side to this too:  if no one uses the data, no one 
will complain when it's wrong.  If Linux starts making it easy to see this 
stuff, there's a chance system vendors will start taking an extra 5 min. 
before shipment to make sure that the BIOS info is up to date...

OTOH, I'm not sure which is worse, bad data or no data.

Jesse
