From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [PATCH 3/3] ACPI / ACPICA: Disable GPEs during initialization
Date: Tue, 28 Dec 2010 08:50:55 +0800
Message-ID: <1293497455.2565.328.camel@minggr.sh.intel.com>
References: <1293403143-11922-1-git-send-email-lenb@kernel.org>
	 <5acdb1af907d5908b4942d425c0983f353dd8fc5.1293403093.git.len.brown@intel.com>
	 <201012272116.23678.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:56483 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752852Ab0L1AvA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Dec 2010 19:51:00 -0500
In-Reply-To: <201012272116.23678.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Moore, Robert" <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>

On Tue, 2010-12-28 at 04:16 +0800, Rafael J. Wysocki wrote:
> Hi,
> 
> The patch below is needed in the ACPICA core.

Thanks, and I'm also looking at below patch

ACPI / ACPICA: Fix global lock acquisition
https://bugzilla.novell.com/show_bug.cgi?id=637377#c82


Lin Ming

> 
> On Sunday, December 26, 2010, Len Brown wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > GPEs with corresponding _Lxx/_Exx control methods need to be disabled
> > during initialization in case they have been enabled by the BIOS, so
> > that they don't fire up until they are enabled by acpi_update_gpes().
> > 
> > References: https://bugzilla.kernel.org/show_bug.cgi?id=25412
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > Signed-off-by: Len Brown <len.brown@intel.com>
> > ---
> >  drivers/acpi/acpica/evgpeinit.c |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/acpi/acpica/evgpeinit.c b/drivers/acpi/acpica/evgpeinit.c
> > index 2c7def9..4c8dea5 100644
> > --- a/drivers/acpi/acpica/evgpeinit.c
> > +++ b/drivers/acpi/acpica/evgpeinit.c
> > @@ -408,6 +408,9 @@ acpi_ev_match_gpe_method(acpi_handle obj_handle,
> >  		return_ACPI_STATUS(AE_OK);
> >  	}
> >  
> > +	/* Disable the GPE in case it's been enabled already. */
> > +	(void)acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_DISABLE);
> > +
> >  	/*
> >  	 * Add the GPE information from above to the gpe_event_info block for
> >  	 * use during dispatch of this GPE.
> > 
> 


