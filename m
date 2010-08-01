From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] acpi ec_sys: Be more cautious about ec write access
Date: Sun, 1 Aug 2010 11:15:44 -0300
Message-ID: <20100801141544.GA14426@khazad-dum.debian.net>
References: <201007292216.13568.trenn@suse.de>
 <1280435424-19656-1-git-send-email-trenn@suse.de>
 <20100730163717.GB32120@khazad-dum.debian.net>
 <201008010213.56501.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201008010213.56501.trenn@suse.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: mjg59@srcf.ucam.org, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, astarikovskiy@suse.de
List-Id: linux-acpi@vger.kernel.org

On Sun, 01 Aug 2010, Thomas Renninger wrote:
> On Friday 30 July 2010 06:37:17 pm Henrique de Moraes Holschuh wrote:
> > On Thu, 29 Jul 2010, Thomas Renninger wrote:
> > > - Only allow root to read/write io file (sever bug!)
> >
> > I'd go further, and only allow CAP_SYS_RAWIO.
> I'll have a look and eventually come up with something on-top.
> 
> > > +	  The kernel accesses the EC through ACPI parsed code provided by BIOS
> > > +	  tables. This option allows to access the EC directly without ACPI
> > > +	  code being involved.
> >
> > This is not really true.  Kernel drivers can, and do access the EC without
> > help from the AML firmware (DSDT, SSDT...).
> Yes, the native laptop driver hacks which should not exist...

But which DO exist.  Let's not go there.

> Generally the EC should only be accessed via ACPI interpreted code, is it 
> really worth to mention these exceptions at this point?

Why state incorrect information?  No kernel driver needs this new Kconfig
option to work, it is required only for *userspace* access to the EC
register space.  IMHO, it would better to say this:

"This option allows userspace direct access to the EC registers, for
debugging and kernel driver development purposes".

Which is entirely correct and gets the proper idea of its intended usage
across (it is not intended to be used for userspace drivers, AFAIK).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
