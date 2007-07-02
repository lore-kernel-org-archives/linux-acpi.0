From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC][PATCH -mm 0/9] PM: Update global suspend and hibernation operations framework
Date: Sun, 1 Jul 2007 21:28:40 -0700
Message-ID: <200707012128.41742.david-b@pacbell.net>
References: <200706302257.17556.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:28388 "HELO
	smtp114.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750981AbXGBGKv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Jul 2007 02:10:51 -0400
In-Reply-To: <200706302257.17556.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Shaohua Li <shaohua.li@intel.com>, Johannes Berg <johannes@sipsolutions.net>, Igor Stoppa <igor.stoppa@nokia.com>, Paul Mackerras <paulus@samba.org>, Russell King <rmk@arm.linux.org.uk>, Nigel Cunningham <nigel@nigel.suspend2.net>

On Saturday 30 June 2007, Rafael J. Wysocki wrote:
>=20
> The patches make the following changes:
> * make ACPI use the new .set_target() method in 'struct pm_ops'
> * add an ACPI helper function for the devices to determine the power =
state
> =A0 to put the device into
> * move the definition of 'struct pm_ops' to <include/suspend.h>
> * change the name of 'struct pm_ops' to 'struct platform_suspend_ops'=
 and
>   modify the names of some related functions and global variables acc=
ordingly
> * modify 'struct platform_suspend_ops' so that .prepare() and .finish=
() don't
>   take arguments (.enter() still takes the state argument, because so=
me
>   platforms don't need to implement the other callbacks)
> * make some functions normally defined in kernel/power/main.c be also=
 defined
>   when CONFIG_PM is unset
> * make suspend_ops be a static variable
> * rework 'struct hibernation_ops' to add the new method analogous to
> =A0 .set_target()
> * rename 'struct hibernation_ops' to 'struct platform_hibernation_ops=
' (in
>   analogy with 'struct platform_suspend_ops')

These look like good cleanups and, in some cases, enhancements.
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
