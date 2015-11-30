From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH] wmi: Set wmi devices' parents
Date: Mon, 30 Nov 2015 10:51:26 -0800
Message-ID: <20151130185126.GB30553@malice.jf.intel.com>
References: <7c58f0a208e0c903008989aec457230e5e58608e.1448306649.git.luto@kernel.org>
 <20151123193709.GZ7413@malice.jf.intel.com>
 <CALCETrW8SuyZkzogg01gb6SXhPUU__H5_697EavwkEGorG9uJw@mail.gmail.com>
 <18585447.G9NSpqgJyj@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:49009 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754061AbbK3Svc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Nov 2015 13:51:32 -0500
Content-Disposition: inline
In-Reply-To: <18585447.G9NSpqgJyj@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Lutomirski <luto@amacapital.net>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Lutomirski <luto@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org

On Thu, Nov 26, 2015 at 03:09:29PM +0100, Rafael Wysocki wrote:
> On Wednesday, November 25, 2015 05:28:54 PM Andy Lutomirski wrote:
> > On Mon, Nov 23, 2015 at 11:37 AM, Darren Hart <dvhart@infradead.org> wrote:
> > > On Mon, Nov 23, 2015 at 11:25:30AM -0800, Andy Lutomirski wrote:
> > >> Without this patch, wmi devices are in /sys/virtual/wmi.  They're
> > >> logically children of the ACPI WMI device, so slot them into the
> > >> device hierarchy.  With this change, on my laptop, they end up in
> > >> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C14:00/wmi and
> > >> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C14:01/wmi.
> > >>
> > >> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> > >
> > > I'd like to hear from some of the main contributors to this driver:
> > >
> > > Matthew?
> > > Carlos?
> > > Len?
> > >
> > > Any cocnerns on this change?
> > >
> > > My initial concern is about changign how we expose this to userspace, but I
> > > believe where it appears in the /sys/devices FS is NOT part of the
> > > kernel-userspace interface commitment (per sysfs-rules.txt).
> > 
> > 
> > Let's drop this, actually.  I have mostly-working patches to make wmi
> > into an actual bus driver, and this intermediate step seems like it'll
> > just confuse people.
> > 
> > Question, though: where do the WMI devices belong?  Multiple choice:
> > 
> > /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C14:01/[GUID]
> > 
> > /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C14:01/wmi/[GUID]
> > 
> > /sys/devices/platform/PNP0C14:01/[GUID]
> > 
> > /sys/devices/platform/PNP0C14:01/wmi/[GUID]
> > 
> > Currently I've implemented the first one because it's the smallest diff.
> 
> That probably is not the right choice, though.
> 
> ACPI "devices" are counterparts of DT device nodes and having other things
> exported under them would be quite confusing.  In fact, you can argue that
> the whole /sys/devices/LNXSYSTM:00/ directory should be located under
> /sys/firmware/acpi, but it turns out to be difficult to move it there
> for various reasons.
> 
> Personally, I'd go for the last one.

That looks like a logical place to me.

-- 
Darren Hart
Intel Open Source Technology Center
