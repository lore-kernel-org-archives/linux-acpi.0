From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI:remove panic in case hardware has changed after S4
Date: Mon, 15 Jul 2013 14:09:48 +0200
Message-ID: <5661798.ugunu0kQNf@vostro.rjw.lan>
References: <1373888637-20737-1-git-send-email-oliver@neukum.org> <1984598.ZdG0izCZul@skinner.arch.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:43398 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755900Ab3GOL7z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Jul 2013 07:59:55 -0400
In-Reply-To: <1984598.ZdG0izCZul@skinner.arch.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: oliver@neukum.org, lenb@kernel.org, linux-acpi@vger.kernel.org, Oliver Neukum <oneukum@suse.de>

On Monday, July 15, 2013 01:55:56 PM Thomas Renninger wrote:
> On Monday, July 15, 2013 01:43:57 PM oliver@neukum.org wrote:
> > From: Oliver Neukum <oneukum@suse.de>
> > 
> > Some BIOSes change hardware based on the state of
> > a laptop's lid. If the lid is closed, the touchpad is
> > disabled and the checksum changes. Windows 8 no longer
> > aborts resume if the checksum has changed.
> I expect more machines will show up and ignore s4_hardware_signature
> if Windows does not check it and we should do the same.
> 
> So no objections from my side.
> 
> Rafael: If you agree, could you queue this one up, please?

Yes, I'm going to do that, although for 3.11 only, not for -stable.

If you need it in -stable, please send a separate inclusion request.

Thanks,
Rafael


> > 
> > Signed-off-by: Oliver Neukum <oneukum@suse.de>
> > ---
> >  drivers/acpi/sleep.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> > index 9c1a435..14744e5 100644
> > --- a/drivers/acpi/sleep.c
> > +++ b/drivers/acpi/sleep.c
> > @@ -664,11 +664,9 @@ static void acpi_hibernation_leave(void)
> >  	/* Reprogram control registers */
> >  	acpi_leave_sleep_state_prep(ACPI_STATE_S4);
> >  	/* Check the hardware signature */
> > -	if (facs && s4_hardware_signature != facs->hardware_signature) {
> > -		printk(KERN_EMERG "ACPI: Hardware changed while hibernated, "
> > -			"cannot resume!\n");
> > -		panic("ACPI S4 hardware signature mismatch");
> > -	}
> > +	if (facs && s4_hardware_signature != facs->hardware_signature)
> > +		printk(KERN_CRIT "ACPI: Hardware changed while hibernated, "
> > +			"success doubtful!\n");
> >  	/* Restore the NVS memory area */
> >  	suspend_nvs_restore();
> >  	/* Allow EC transactions to happen. */
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
