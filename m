From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [PATCH 2/2] ACPI: fix broken usage of acpi_ut_get_node_name()
Date: Thu, 05 Mar 2009 09:56:09 +0800
Message-ID: <1236218169.28542.1.camel@minggr.sh.intel.com>
References: <1235486898-27756-1-git-send-email-hmh@hmh.eng.br>
	 <1235486898-27756-2-git-send-email-hmh@hmh.eng.br>
	 <20090305014058.GC12234@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:62215 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328AbZCECBi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 4 Mar 2009 21:01:38 -0500
In-Reply-To: <20090305014058.GC12234@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>, "stable@kernel.org" <stable@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, 2009-03-05 at 09:40 +0800, Henrique de Moraes Holschuh wrote:
> PING...
> 
> This is a cosmetic fix, but it still avoids random binary crap leaking
> into debug messages, for the price of an obvious 3-char change.
> 
> Can I get an ACK for it, please?  I'd like to see this go into
> 2.6.28.y...

Looks good.

Ack-by: Lin Ming <ming.m.lin@intel.com>

> 
> On Tue, 24 Feb 2009, Henrique de Moraes Holschuh wrote:
> > acpi_ut_get_node_name() returns a four char fixed-size array, not
> > NULL-terminated.
> > 
> > This issue was fixed indirectly in mainline by commit
> > 60a4ce7f4148155d3f28eea4a213f7ee47cd57b7.
> > 
> > This is the minimal fix for stable 2.6.28.
> > 
> > Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> > Cc: stable@kernel.org
> > Cc: Lin Ming <ming.m.lin@intel.com>
> > ---
> >  drivers/acpi/power.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> > index bb7d50d..ad55db1 100644
> > --- a/drivers/acpi/power.c
> > +++ b/drivers/acpi/power.c
> > @@ -151,7 +151,7 @@ static int acpi_power_get_state(acpi_handle handle, int *state)
> >  	*state = (sta & 0x01)?ACPI_POWER_RESOURCE_STATE_ON:
> >  			      ACPI_POWER_RESOURCE_STATE_OFF;
> >  
> > -	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Resource [%s] is %s\n",
> > +	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Resource [%4.4s] is %s\n",
> >  			  acpi_ut_get_node_name(handle),
> >  				*state ? "on" : "off"));
> >  
> 

