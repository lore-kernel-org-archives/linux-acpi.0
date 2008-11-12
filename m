From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: ACPI reads wrong temperature
Date: Wed, 12 Nov 2008 22:27:35 +0000
Message-ID: <20081112222735.GA21797@srcf.ucam.org>
References: <20081031210913.3180@gmx.net> <1225951972.3989.99.camel@yakui_zhao.sh.intel.com> <20081106091126.GA25849@srcf.ucam.org> <200811121620.44520.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:35528 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754758AbYKLW1m (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Nov 2008 17:27:42 -0500
Content-Disposition: inline
In-Reply-To: <200811121620.44520.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Zhao Yakui <yakui.zhao@intel.com>, Len Brown <lenb@kernel.org>, Peter Mahlknecht <mali100@gmx.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, khali@linux-fr.org

On Wed, Nov 12, 2008 at 04:20:43PM -0600, Thomas Renninger wrote:
> On Thursday 06 November 2008 03:11:26 am Matthew Garrett wrote:
> > On Thu, Nov 06, 2008 at 02:12:52PM +0800, Zhao Yakui wrote:
> > > On your box after the i2c-i801 driver is loaded, the smbus controller
> > > will be used by the AML code and i2c-i801 driver. Unfortunately there is
> > > no synchronization between them. IMO this is the BIOS fault. The SMbus
> > > will be accessed by the two different modules. But it is exported by
> > > BIOS.
> >
> > No, loading i2c-i801 is harmless. The breakage occurs when you attempt
> > to drive the smbus.
> >
> > >     So the better solution is that:
> > >     a. SMBus is hidden in BIOS. In such case the Linux OS can't detect
> > > the SMbus controller . Of course it won't try to load the device driver
> > > for it.
> > >     b. Linux OS won't load the device driver for it.
> >
> > The solution is for users not to load smbus drivers unless they know for
> > certain that it's safe to do so, or alternatively for us to refuse to
> > load i2c drivers if they overlap with ACPI resource allocations.
> 
> We already have that:
> >  or alternatively for us to refuse to load i2c drivers
> in drivers/acpi/osl.c:
> 
> #define ENFORCE_RESOURCES_STRICT 2
> #define ENFORCE_RESOURCES_LAX    1
> #define ENFORCE_RESOURCES_NO     0
> 
> static unsigned int acpi_enforce_resources = ENFORCE_RESOURCES_LAX;
>
> lax means print out warning which i2c driver conflicts with which ACPI 
> Operation Region.
> Did you get such a message:

According to his logs, the warning was printed.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
