From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] ACPI thermal: Don't invalidate thermal zone if
 critical trip point is bad
Date: Mon, 22 Feb 2010 09:33:37 +0800
Message-ID: <1266802417.2608.1463.camel@rzhang1-desktop>
References: <1266357351-20224-1-git-send-email-trenn@suse.de>
	 <1266662667-3013-1-git-send-email-trenn@suse.de>
	 <1266720682.2608.38.camel@rzhang1-desktop>
	 <201002220002.49341.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44721 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754119Ab0BVBeJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 21 Feb 2010 20:34:09 -0500
In-Reply-To: <201002220002.49341.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "clarkt@cnsp.com" <clarkt@cnsp.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, 2010-02-22 at 07:02 +0800, Thomas Renninger wrote:
> On Sunday 21 February 2010 03:51:22 am Zhang Rui wrote:
> ...
> > > @@ -379,17 +379,19 @@ static int acpi_thermal_trips_update(struct
> > > acpi_thermal *tz, int flag) * Below zero (Celsius) values clearly aren't
> > > right for sure.. * ... so lets discard those as invalid.
> > >  		 */
> > > -		if (ACPI_FAILURE(status) ||
> > > -				tz->trips.critical.temperature <= 2732) {
> > > +		if (ACPI_FAILURE(status)) {
> > > +			tz->trips.critical.flags.valid = 0;
> > > +			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> > > +					  "No critical threshold\n"));
> >
> > No critical threshold is also a violation of ACPI spec.
> > what about using FW_BUG here as well?
> 
> Could you point me to where this is stated, please.
> I only found Chapter 11.5 (ver. 3.0b):
>  Thermal Zone Interface Requirements:
>    A thermal zone must contain at least one trip point
>    (critical, near critical, active, or passive)
> 
> If at another place they state that a critical trip point is
> required, this would contradict with each other.
> 
you're right.
I thought I saw such statements somewhere in the ACPI spec but
apparently I'm wrong. Sorry for the noise.

Acked-by: Zhang Rui <rui.zhang@intel.com>


> Thanks,
> 
>     Thomas
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


