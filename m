From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: introduce kernel parameter acpi_sleep=s3_set_sci_en
Date: Tue, 27 Oct 2009 11:15:00 +0100
Message-ID: <200910271115.00487.rjw@sisk.pl>
References: <1256610232.19142.77.camel@rzhang-dt> <200910270921.42618.rjw@sisk.pl> <1256633187.19142.82.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:35307 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752700AbZJ0KNa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Oct 2009 06:13:30 -0400
In-Reply-To: <1256633187.19142.82.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Brown, Len" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tuesday 27 October 2009, Zhang Rui wrote:
> On Tue, 2009-10-27 at 16:21 +0800, Rafael J. Wysocki wrote:
> > On Tuesday 27 October 2009, Zhang Rui wrote:
> > > Introduce kernel parameter acpi_sleep=s3_set_sci_en
> > > 
> > > some laptop requires SCI_EN being set directly on resume,
> > > or else they hung somewhere in the resume code path.
> > > 
> > > We already have a blacklist for these lattops but we still need
> > > this option, especially when debugging some suspend/resume problems,
> > > in case there are systems that need this workaround and are not yet
> > > in the blacklist.
> > > 
> > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > 
> > I'm generally fine with this, but ...
> > 
> > > ---
> > >  Documentation/kernel-parameters.txt |    5 ++++-
> > >  arch/x86/kernel/acpi/sleep.c        |    4 ++++
> > >  drivers/acpi/sleep.c                |    6 ++++++
> > >  include/linux/acpi.h                |    3 +++
> > >  4 files changed, 17 insertions(+), 1 deletion(-)
> > > 
> > > Index: linux-2.6/drivers/acpi/sleep.c
> > > ===================================================================
> > > --- linux-2.6.orig/drivers/acpi/sleep.c
> > > +++ linux-2.6/drivers/acpi/sleep.c
> > > @@ -182,6 +182,12 @@ static void acpi_pm_end(void)
> > >   */
> > >  static bool set_sci_en_on_resume;
> > >  
> > > +void __init acpi_set_sci_en_on_resume(void)
> > > +{
> > > +	set_sci_en_on_resume = true;
> > > +	return 0;
> > > +}
> > > +
> > >  extern void do_suspend_lowlevel(void);
> > >  
> > >  static u32 acpi_suspend_states[] = {
> > > Index: linux-2.6/arch/x86/kernel/acpi/sleep.c
> > > ===================================================================
> > > --- linux-2.6.orig/arch/x86/kernel/acpi/sleep.c
> > > +++ linux-2.6/arch/x86/kernel/acpi/sleep.c
> > > @@ -162,6 +162,10 @@ static int __init acpi_sleep_setup(char 
> > >  #endif
> > >  		if (strncmp(str, "old_ordering", 12) == 0)
> > >  			acpi_old_suspend_ordering();
> > > +#ifdef CONFIG_SUSPEND
> > > +		if (strncmp(str, "s3_set_sci_en", 13) == 0)
> > > +			acpi_set_sci_en_on_resume();
> > > +#endif /* CONFIG_SUSPEND */
> > 
> > ... do we really need these #ifdefs?
> > 
> 
> #ifdef CONFIG_SUSPEND
> ...
> static bool set_sci_en_on_resume;
> ...
> #endif /* CONFIG_SUSPEND */
> 
> Or else I have to move set_sci_en_on_resume out of this #ifdef.

Please do.

Best,
Rafael
