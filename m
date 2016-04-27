From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 4/6] ACPI / osi: Fix default _OSI(Darwin) support
Date: Wed, 27 Apr 2016 23:24:47 +0200
Message-ID: <2223787.tzTyTqLAjo@vostro.rjw.lan>
References: <cover.1461656216.git.lv.zheng@intel.com> <e8ea6e8841adce9e10e5bd0b278b47a7c799c276.1461736123.git.lv.zheng@intel.com> <36DF59CE26D8EE47B0655C516E9CE64028748233@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47611 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752666AbcD0VVp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Apr 2016 17:21:45 -0400
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE64028748233@shsmsx102.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>

On Wednesday, April 27, 2016 09:45:21 AM Chen, Yu C wrote:
> Hi Lv,
> 
> > -----Original Message-----
> > From: Zheng, Lv
> > Sent: Wednesday, April 27, 2016 4:55 PM
> > To: Wysocki, Rafael J; Rafael J. Wysocki; Brown, Len
> > Cc: Zheng, Lv; Lv Zheng; linux-kernel@vger.kernel.org; linux-
> > acpi@vger.kernel.org; Chen, Yu C
> > Subject: [PATCH v2 4/6] ACPI / osi: Fix default _OSI(Darwin) support
> > 
> > From: Chen Yu <yu.c.chen@intel.com>
> > 
> > The following commit always reports positive value when Apple hardware
> > queries _OSI("Darwin"):
> >  Commit: 7bc5a2bad0b8d9d1ac9f7b8b33150e4ddf197334
> >  Subject: ACPI: Support _OSI("Darwin") correctly However since this
> > implementation places the judgement in runtime, it breaks acpi_osi=!Darwin
> > and cannot return unsupported for _OSI("WinXXX") invoked before invoking
> > _OSI("Darwin").
> > 
> > This patch fixes the issues by reverting the wrong support and implementing
> > the default behavior of _OSI("Darwin")/_OSI("WinXXX") on Apple hardware via
> > DMI matching.
> > 
> > Fixes: 7bc5a2bad0b8 ("ACPI: Support _OSI("Darwin") correctly")
> > Cc: <stable@vger.kernel.org> # 3.18+
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=92111
> > Reported-by: Lukas Wunner <lukas@wunner.de>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> > ---
> >  drivers/acpi/blacklist.c |   23 ++++++++++++++++++
> >  drivers/acpi/osl.c       |   58 ++++++++++++++++++++++++++++++++++++++++---
> > ---
> >  include/linux/acpi.h     |    1 +
> >  3 files changed, 75 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c index
> > 96809cd..e947d3e 100644
> > --- a/drivers/acpi/blacklist.c
> > +++ b/drivers/acpi/blacklist.c
> > @@ -133,6 +133,11 @@ int __init acpi_blacklisted(void)
> >  	return blacklisted;
> >  }
> >  #ifdef CONFIG_DMI
> > +static int __init dmi_enable_osi_darwin(const struct dmi_system_id *d)
> > +{
> > +	acpi_dmi_osi_darwin(1, d);	/* enable */
> > +	return 0;
> > +}
> >  static int __init dmi_enable_osi_linux(const struct dmi_system_id *d)  {
> >  	acpi_dmi_osi_linux(1, d);	/* enable */
> > @@ -331,6 +336,24 @@ static struct dmi_system_id acpi_osi_dmi_table[]
> > __initdata = {
> >  		},
> >  	},
> > 
> > +	/*
> > +	 * Enable _OSI("Darwin") for all apple platforms.
> > +	 */
> > +	{
> > +	.callback = dmi_enable_osi_darwin,
> > +	.ident = "Apple hardware",
> > +	.matches = {
> > +		     DMI_MATCH(DMI_SYS_VENDOR, "Apple INC."),
> > +		},
> > +	},
> > +	{
> > +	.callback = dmi_enable_osi_darwin,
> > +	.ident = "Apple hardware",
> > +	.matches = {
> > +		     DMI_MATCH(DMI_SYS_VENDOR, "Apple Computer, INC."),
> > +		},
> > +	},
> > +
> The  vendor id should be 'Apple Inc.' and 'Apple Computer, Inc.' instead.

If this is the only problem with this patch, I can fix it up.  No need to resend.

Thanks,
Rafael

