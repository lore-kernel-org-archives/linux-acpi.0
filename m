From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [RFC PATCH 1/6] ACPICA: Hardware: Reduce divergences for sleep
 functions.
Date: Fri, 30 May 2014 02:15:04 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E880256CC63@SHSMSX101.ccr.corp.intel.com>
References: <38907770.bupFXhytsS@vostro.rjw.lan>
 <cover.1401210684.git.lv.zheng@intel.com>
 <f8980f7d9788d609314a8ac5b6b4b1ef4a39bd89.1401210685.git.lv.zheng@intel.com>
 <20140529102455.GA18151@ugly.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1048 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752165AbaE3CPK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 29 May 2014 22:15:10 -0400
In-Reply-To: <20140529102455.GA18151@ugly.fritz.box>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, Lv Zheng <zetalog@gmail.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi, Oswald

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Oswald Buddenhagen
> Sent: Thursday, May 29, 2014 6:25 PM
> To: Lv Zheng
> Cc: Wysocki, Rafael J; Brown, Len; linux-acpi@vger.kernel.org
> Subject: Re: [RFC PATCH 1/6] ACPICA: Hardware: Reduce divergences for sleep functions.
> 
> series confirmed to work on top of linux-pm-next.

Thanks for the confirmation.
Since this is not urgent as we have the stable material shipped.
I'll push it to ACPICA upstream so that it can reviewed properly.

Thanks and best regards
-Lv

> 
> On Wed, May 28, 2014 at 01:27:37AM +0800, Lv Zheng wrote:
> > From: Lv Zheng <lv.zheng@intel.com>
> >
> > This patch is generated to reduce source code differences between Linux and
> > ACPICA so that further sleep related modifications can be applied directly
> > without human interventions. Lv Zheng.
> >
> > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> > Cc: Oswald Buddenhagen <ossi@kde.org>
> > ---
> >  drivers/acpi/acpica/hwxfsleep.c |    2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
> > index 6921c7f..103d9a7 100644
> > --- a/drivers/acpi/acpica/hwxfsleep.c
> > +++ b/drivers/acpi/acpica/hwxfsleep.c
> > @@ -138,7 +138,6 @@ acpi_status acpi_set_firmware_waking_vector64(u64 physical_address)
> >  {
> >  	ACPI_FUNCTION_TRACE(acpi_set_firmware_waking_vector64);
> >
> > -
> >  	/* Determine if the 64-bit vector actually exists */
> >
> >  	if ((acpi_gbl_FACS->length <= 32) || (acpi_gbl_FACS->version < 1)) {
> > @@ -154,7 +153,6 @@ acpi_status acpi_set_firmware_waking_vector64(u64 physical_address)
> >
> >  ACPI_EXPORT_SYMBOL(acpi_set_firmware_waking_vector64)
> >  #endif
> > -
> >  /*******************************************************************************
> >   *
> >   * FUNCTION:    acpi_enter_sleep_state_s4bios
> > --
> > 1.7.10
> >
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
