From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [PATCH 10/11] ACPI: Drop device flag wake_capable
Date: Thu, 6 Jan 2011 15:52:28 -0800 (PST)
Message-ID: <511724.91814.qm@web180315.mail.gq1.yahoo.com>
References: <201101062341.27705.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nm16.bullet.mail.ne1.yahoo.com ([98.138.90.79]:42213 "HELO
	nm16.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755074Ab1AFXw3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Jan 2011 18:52:29 -0500
In-Reply-To: <201101062341.27705.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>



--- On Thu, 1/6/11, Rafael J. Wysocki <rjw@sisk.pl> wrote:


>=20
> The wake_capable ACPI device flag is not necessary, because
> it is
> only used in scan.c for recording the information


Only  for ACPI, yes? Generically, it records data for any
wake-capable dvice, and is not ACPI-specific...

My bias is that ACPI should  work the way other PM
solutions/hardware work, not collect special cases
unique to ACPI (kind of like this.) ...

 that _PRW
> is
> present for the given device.=A0 That information is
> only used by
> acpi_add_single_object() to decide whether or not to call
> acpi_bus_get_wakeup_device_flags(), so the flag may be
> dropped
> if the _PRW check is moved to
> acpi_bus_get_wakeup_device_flags().

Only if you presume ACPI ....

I'm glad to see that generic-vs-ACPI duplication
of flags vanishing; way back when I started to add
wakeup support, I had to stop part way through ACPI
in large part because wake didn't work well yet in the Linux PM
framework, except for select non-ACPI HW.
(Starting with a USB subset: OTG and hub port sleep and ewakeup); oh, a=
lso GPIO wake on some HW, e.g.
or buttons, and switches like MMC/SD card detect. ISTR that stuff still=
 wierds out a bit as it goes
through Linux-ACPI.

Also, to the extent that the ACPI code was supposed
to be generic and not Linux-specific, I thought Len
or someone from Intel should drive such issues.

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
