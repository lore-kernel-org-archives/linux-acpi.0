From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] ACPI / osi: add DMI quirk for Dell systems
Date: Tue, 06 Feb 2018 15:45:31 +0200
Message-ID: <1517924731.22495.51.camel@linux.intel.com>
References: <1517388005-14852-1-git-send-email-alex.hung@canonical.com>
         <1517388005-14852-2-git-send-email-alex.hung@canonical.com>
         <20180205141447.6e1442ac@endymion>
         <1517840100.22495.25.camel@linux.intel.com>
         <5de252ed95ee48eab3bd8deeea5c610a@ausx13mpc120.AMER.DELL.COM>
         <20180205224531.GA46524@dtor-ws>
         <e30274b31bda47c5972621607cf3b605@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:46402 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750818AbeBFNpk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 6 Feb 2018 08:45:40 -0500
In-Reply-To: <e30274b31bda47c5972621607cf3b605@ausx13mpc120.AMER.DELL.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario.Limonciello@dell.com, dmitry.torokhov@gmail.com
Cc: jdelvare@suse.de, alex.hung@canonical.com, rjw@rjwysocki.net, lenb@kernel.org, gregkh@linuxfoundation.org, davem@davemloft.net, mika.westerberg@linux.intel.com, f.fainelli@gmail.com, kishon@ti.com, karniksayli1995@gmail.com, linux-acpi@vger.kernel.org

On Tue, 2018-02-06 at 00:45 +0000, Mario.Limonciello@dell.com wrote:

> > > > Playing with OSI string is a bad idea. I wouldn't do anything
> > > > while
> > > > Rafael, or even Len can confirm that is the right thing to do.
> > > > 
> > > > For me, AFAIK we need to be bug-to-bug compatible with Windows
> > > > (at least
> > > > on ACPICA side), so, what Windows exactly does on such laptops?
> > > > 
> > > 
> > > The issue that's being worked around isn't an ACPICA interpreter
> > > issue, but it's
> > > a graphics device configuration issue.

Then clearly nothing to do with OSI strings here, right?

> > > Windows expects to use RTD3 on the NVIDIA GPU but Linux drivers
> > > don't.  It leads to system hangs on the Linux side.
> > 
> > Can we adjust Linux drivers to do the right thing?

+100

> >  Or is it regarding
> > the binary NVIDIA blob?

nVidia vs. Linux again? :-)

> 
> Neither Nouveau nor the NVIDIA blob have support for RTD3.
> 
> Last I heard it's waiting on NVIDIA releasing something Nouveau
> needs.  So.. Eventually?  For now it's better to not hang though.

Hmm... While you are talking sense, the patch itself looks like an ugly
hack.

> That's part of why we wanted to enable this via a transient OSI
> string,
> to let this be removed by Linux whenever the driver does grow support.

So, means "never" then? (Assume a bit of irony here)

I don't know how it feels for maintainers, for me it's quite unlikely to
go (at least in this shape).

I'm sorry I can't be much constructive here, I heard Len once about OSI
huge abuse by almost every party. I would rather let him speak on the
matter.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
