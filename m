From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 8/8] thinkpad-acpi: log temperatures on termal alarm
Date: Mon, 7 Dec 2009 10:06:29 -0200
Message-ID: <20091207120629.GE20076@khazad-dum.debian.net>
References: <1259840485-2516-1-git-send-email-hmh@hmh.eng.br>
 <1259840485-2516-9-git-send-email-hmh@hmh.eng.br>
 <20091206210126.GD10184@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:42816 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754205AbZLGMGZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Dec 2009 07:06:25 -0500
Content-Disposition: inline
In-Reply-To: <20091206210126.GD10184@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Sun, 06 Dec 2009, Pavel Machek wrote:
> > Log temperatures on any of the EC thermal alarms.  It could be
> > useful to help tracking down what is happening...
> 
> Thanks, I applied it locally.
> 
> >  static bool hotkey_notify_thermal(const u32 hkey,
> >  				 bool *send_acpi_ev,
> >  				 bool *ignore_acpi_ev)
> >  {
> > +	int known = true;
> > +
> 
> Oops?

Yeah, will fix and resend the entire stack, as it has grown a few more
patches during the weekend :)

> > +	for (i = 0; i < n; i++)
> > +		t.temp[i] = t.temp[i] / 1000;
> > +
> > +	/* Fill missing sensors with N/A marker */
> > +	for (i = n; i < TPACPI_MAX_THERMAL_SENSORS; i++)
> > +		t.temp[i] = -128;
> 
> -273 would be better "N/A" marker :-).

No can do.  The firmware uses -128 (it is a signed 8-bit value), so there is
an internal driver ABI *and* an userspace ABI since 2.6.13 or thereabouts
that forces N/A sensors in thinkpad-acpi to return -128...

In sysfs, I return an error code instead, which is arguably a much better
way of doing that.

But I do agree -273 would be a cooler value to return for N/A :-)

> > +	/* FIXME: it is ugly */
> > +	printk(TPACPI_NOTICE
> > +		"temperatures (Celsius): "
> > +		"%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d\n",
> 
> But this indeed is ugly. Why not sometihng like
> 
> 	printk(TPACPI_NOTICE "temperatures (Celsius): ");
> 	for (i = 0; i < n; i++)
> 		printk(KERN_CONT "%d ", t.temp[i]);
> 	printk(KERN_CONT "\n");
> 
> ...you'd get rid of #ifdef above, ugly -128 markers, and nasty %d series...

Can't get rid of -128, unless I print N/A instead, which your for() loop
would allow.

However, while using KERN_CONT is nicer, that printk is important and needs
to get out to the logs with no reordering, no long delay, and preferably, no
other printks interleaved with it.  Please excuse my lack of knowledge on
this, but wouldn't KERN_CONT make it far more likely that a problem happens
to the printk that will make it hard to read/useless (if reordering
happens)?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
