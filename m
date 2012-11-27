From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 04/15] ACPICA: Fixes code maintenance divergences.
Date: Tue, 27 Nov 2012 12:46:46 +0100
Message-ID: <1413291.sYrZCFJfs2@vostro.rjw.lan>
References: <cover.1353491652.git.lv.zheng@intel.com> <1A7043D5F58CCB44A599DFD55ED4C94828D4CEA0@FMSMSX108.amr.corp.intel.com> <1AE640813FDE7649BE1B193DEA596E88BD37DB@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:34195 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753533Ab2K0LmD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Nov 2012 06:42:03 -0500
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E88BD37DB@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>

On Tuesday, November 27, 2012 05:33:55 AM Zheng, Lv wrote:
> > > This patch will not affect the generated vmlinux binary.
> > 
> > If this is the goal, then please VERIFY that the goal was met by building both
> > ways and comparing the kernel.
> 
> It's not the goal of this patch, it should be better stated as no function changes.
> 
> > due to the hunk below, we know that this patch DOES change the kernel, and
> > not in a correct way:
> > 
> > > diff --git a/drivers/acpi/acpica/tbutils.c
> > > b/drivers/acpi/acpica/tbutils.c index 285e24b..b4469a6
> > > 100644
> > > --- a/drivers/acpi/acpica/tbutils.c
> > > +++ b/drivers/acpi/acpica/tbutils.c
> > > @@ -384,10 +384,6 @@ void acpi_tb_check_dsdt_header(void)
> > >  		acpi_tb_print_table_header(0, &acpi_gbl_original_dsdt_header);
> > >  		acpi_tb_print_table_header(0, acpi_gbl_DSDT);
> > >
> > > -		ACPI_ERROR((AE_INFO,
> > > -			    "Please send DMI info to linux-acpi@vger.kernel.org\n"
> > > -			    "If system does not work as expected, please boot with
> > acpi=copy_dsdt"));
> > > -
> > >  		/* Disable further error messages */
> > 
> > Please retain this difference between Linux and ACPICA -- it is there for a
> > reason.
> 
> Agreed.
> I shouldn't make this vanished.
> I will add this back to Linux during the next release if this is needed.

No, the next release would be too late.

Please do it now.  Please address all of the Len's comments in all of the
patches and resend the whole series.  And _please_ be more careful, I asked
you for that last time already.

I'll drop it from linux-next for now and will wait for the new submissoion.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
