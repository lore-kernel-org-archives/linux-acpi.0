From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 8/8] acpi: fix BDC handling in drivers/acpi/sleep/proc.c
Date: Wed, 03 Oct 2007 08:58:18 -0700
Message-ID: <20071003155818.ED86C219D82@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <200710022024.l92KOBXq020474@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.re3.yahoo.com ([66.196.96.96]:46996 "HELO
	smtp123.sbc.mail.re3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752104AbXJCQE4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Oct 2007 12:04:56 -0400
In-Reply-To: <200710022024.l92KOBXq020474@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: torvalds@linux-foundation.org, lkml@rtr.ca, linux-acpi@vger.kernel.org, borntraeger@de.ibm.com, akpm@linux-foundation.org

By the way, another longstanding bug in this /proc/acpi/... code is:

> @@ -336,11 +328,11 @@ acpi_system_write_alarm(struct file *fil
>  	 * to the RTC area of memory.
>  	 */
>  	if (acpi_gbl_FADT.day_alarm)
> -		CMOS_WRITE(day, acpi_gbl_FADT.day_alarm);
> +		cmos_bcd_write(day, acpi_gbl_FADT.day_alarm, rtc_control);
>  	if (acpi_gbl_FADT.month_alarm)
> -		CMOS_WRITE(mo, acpi_gbl_FADT.month_alarm);
> +		cmos_bcd_write(mo, acpi_gbl_FADT.month_alarm, rtc_control);
>  	if (acpi_gbl_FADT.century)
> -		CMOS_WRITE(yr / 100, acpi_gbl_FADT.century);
> +		cmos_bcd_write(yr / 100, acpi_gbl_FADT.century, rtc_control);

The "century" field is unrelated to the alarm.  It's purely
a way to distinguish 19xx vs 20xx (and 21xx, etc).

>  	/* enable the rtc alarm interrupt */
>  	rtc_control |= RTC_AIE;
>  	CMOS_WRITE(rtc_control, RTC_CONTROL);
