From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 8/8] thinkpad-acpi: log temperatures on termal alarm
Date: Sun, 6 Dec 2009 22:01:27 +0100
Message-ID: <20091206210126.GD10184@elf.ucw.cz>
References: <1259840485-2516-1-git-send-email-hmh@hmh.eng.br>
 <1259840485-2516-9-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45561 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757743AbZLFVBa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Dec 2009 16:01:30 -0500
Content-Disposition: inline
In-Reply-To: <1259840485-2516-9-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

Hi!

> Log temperatures on any of the EC thermal alarms.  It could be
> useful to help tracking down what is happening...

Thanks, I applied it locally.

>  static bool hotkey_notify_thermal(const u32 hkey,
>  				 bool *send_acpi_ev,
>  				 bool *ignore_acpi_ev)
>  {
> +	int known = true;
> +

Oops?


> +	for (i = 0; i < n; i++)
> +		t.temp[i] = t.temp[i] / 1000;
> +
> +	/* Fill missing sensors with N/A marker */
> +	for (i = n; i < TPACPI_MAX_THERMAL_SENSORS; i++)
> +		t.temp[i] = -128;

-273 would be better "N/A" marker :-).

> +	/* FIXME: it is ugly */
> +	printk(TPACPI_NOTICE
> +		"temperatures (Celsius): "
> +		"%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d\n",

But this indeed is ugly. Why not sometihng like

	printk(TPACPI_NOTICE "temperatures (Celsius): ");
	for (i = 0; i < n; i++)
		printk(KERN_CONT "%d ", t.temp[i]);
	printk(KERN_CONT "\n");

...you'd get rid of #ifdef above, ugly -128 markers, and nasty %d series...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
