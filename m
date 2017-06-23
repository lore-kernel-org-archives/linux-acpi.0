From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [PATCH 5/7] platform/x86: fujitsu-laptop: do not update ACPI
 device power status
Date: Fri, 23 Jun 2017 09:46:59 +0930
Message-ID: <20170623001659.GF24368@marvin.atrad.com.au>
References: <20170616044058.30443-1-kernel@kempniu.pl>
 <20170616044058.30443-6-kernel@kempniu.pl>
 <20170621201727.GC25900@fury>
 <20170622210235.GC4194@kmp-mobile.hq.kempniu.pl>
 <20170622235843.GC27213@fury>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170622235843.GC27213@fury>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Micha?? K??pie?? <kernel@kempniu.pl>, Andy Shevchenko <andy@infradead.org>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Jun 22, 2017 at 04:58:43PM -0700, Darren Hart wrote:
> On Thu, Jun 22, 2017 at 11:02:35PM +0200, Micha?? K??pie?? wrote:
> > > On Fri, Jun 16, 2017 at 06:40:56AM +0200, Micha?? K??pie?? wrote:
> > > > Calling acpi_bus_update_power() for ACPI devices FUJ02B1 and FUJ02E3 is
> > > > pointless as they are not power manageable (neither _PS0 nor _PR0 is
> > > > defined for any of them), which causes their power state to be inherited
> > > > from their parent devices.  Given the ACPI paths of these two devices
> > > > (\_SB.PCI0.LPCB.FJEX, \_SB.FEXT), their parent devices are also not
> > > > power manageable.  These parent devices will thus have their power state
> > > > initialized to ACPI_STATE_D0, which in turn causes the power state for
> > > > both FUJ02B1 and FUJ02E3 to always be ACPI_STATE_D0 ("on").
> > > > 
> > > 
> > > How confident are we that all implementations of these two ACPI devices lack
> > > _PS0 and _PR0 ?
> > 
> > I looked at DSDT dumps of four different Fujitsu laptops released in the
> > past ten years or so for which at least one of these two ACPI devices is
> > present and found no traces of either of these methods being defined for
> > them.  I do not think we have a way of ensuring that the above holds
> > true for every other model out there, but I will point out that
> > fujitsu-laptop is the only user of acpi_bus_update_power() outside of
> > drivers/acpi.
> 
> OK, thanks. Queueing to testing.

Thanks.  In case it was missed, I supplied my reviewed-by message and
sign-off in an earlier post.

Regards
  jonathan
