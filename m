From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH] wmi: Set wmi devices' parents
Date: Mon, 30 Nov 2015 12:49:41 -0800
Message-ID: <20151130204941.GC30553@malice.jf.intel.com>
References: <7c58f0a208e0c903008989aec457230e5e58608e.1448306649.git.luto@kernel.org>
 <20151123193709.GZ7413@malice.jf.intel.com>
 <CALCETrW8SuyZkzogg01gb6SXhPUU__H5_697EavwkEGorG9uJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrW8SuyZkzogg01gb6SXhPUU__H5_697EavwkEGorG9uJw@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Lutomirski <luto@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Nov 25, 2015 at 05:28:54PM -0800, Andy Lutomirski wrote:
> On Mon, Nov 23, 2015 at 11:37 AM, Darren Hart <dvhart@infradead.org> wrote:
> > On Mon, Nov 23, 2015 at 11:25:30AM -0800, Andy Lutomirski wrote:
> >> Without this patch, wmi devices are in /sys/virtual/wmi.  They're
> >> logically children of the ACPI WMI device, so slot them into the
> >> device hierarchy.  With this change, on my laptop, they end up in
> >> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C14:00/wmi and
> >> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C14:01/wmi.
> >>
> >> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> >
> > I'd like to hear from some of the main contributors to this driver:
> >
> > Matthew?
> > Carlos?
> > Len?
> >
> > Any cocnerns on this change?
> >
> > My initial concern is about changign how we expose this to userspace, but I
> > believe where it appears in the /sys/devices FS is NOT part of the
> > kernel-userspace interface commitment (per sysfs-rules.txt).
> 
> 
> Let's drop this, actually.  I have mostly-working patches to make wmi
> into an actual bus driver, and this intermediate step seems like it'll
> just confuse people.

Dropped.

-- 
Darren Hart
Intel Open Source Technology Center
