From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: linux-next: Tree for August 14 (sysfs/acpi errors)
Date: Sun, 17 Aug 2008 15:13:13 +1000
Message-ID: <200808171513.13611.rusty@rustcorp.com.au>
References: <20080814172945.250a27f2.sfr@canb.auug.org.au> <20080816044714.GA19886@kroah.com> <48A78D4A.70609@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <48A78D4A.70609@linux.intel.com>
Content-Disposition: inline
Sender: linux-next-owner@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: Greg KH <greg@kroah.com>, Kay Sievers <kay.sievers@vrfy.org>, Randy Dunlap <randy.dunlap@oracle.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sunday 17 August 2008 12:30:34 Andi Kleen wrote:
> Greg KH wrote:
> > On Sat, Aug 16, 2008 at 05:48:26AM +0200, Andi Kleen wrote:
> >>> They have been module options, not prefixed kernel parameters so =
far,
> >>> and the prefix was just the module name.
> >>> So it just strikes back, that acpi uses generic names for the mod=
ules,
> >>> there would have been no problem if "power" would be called
> >>> "acpi_power" and the options would just be =EF=BB=BF"acpi.acpica_=
version" and
> >>> "acpi_power.nocheck".
> >>> But well, there are driver modules just called "option", so acpi =
is not
> >>> that bad. :)
> >>>
> >>>> I think the generic params code should be fixed to handle this.
> >>>
> >>> We could try to look up existing directories to use instead of
> >>> expecting that we need to create and own them. I guess,
> >>
> >> sysfs does this anyways, doesn't it. We would just need to teach i=
t
> >> to not BUG() in this case, perhaps with a special entry point.
> >> Also a BUG() in general seems a little harsh for this, surely a WA=
RN_ON
> >> should be enough.
> >
> > It is a WARN() call, not a BUG().
>
> Ok. Can we remove it? Or add a new entry point that allows to disable=
 it?
>
> I don't think relying on link order like Rusty proposes is a good lon=
g term
> solution.

To be clear, I agree with Andi.  If this is for current kernel I'd just=
 fix=20
link order, for longer term we need something cleverer.

Cheers,
Rusty.
