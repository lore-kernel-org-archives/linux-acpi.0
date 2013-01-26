From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Problems with gpe13 interrupt storm.
Date: Sat, 26 Jan 2013 14:29:57 +0100
Message-ID: <1906135.qKhvgoex2Z@vostro.rjw.lan>
References: <CAAMvbhGcEPgfGFQt-Y1T+OzG9=Moa97W-XL8+qnW7sOWVqfCDw@mail.gmail.com> <CAAMvbhFRvNpJ3h138grZugAH+Lb74+DSSD4sg0RxADOXvVHEcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:56434 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074Ab3AZNXw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 26 Jan 2013 08:23:52 -0500
In-Reply-To: <CAAMvbhFRvNpJ3h138grZugAH+Lb74+DSSD4sg0RxADOXvVHEcA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Saturday, January 26, 2013 09:46:24 AM James Courtier-Dutton wrote:
> Some more detailed context can be found here:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/887793
> 
>     Scope (_GPE)
>     {
>         Method (_L13, 0, NotSerialized)
>         {
>             If (LEqual (PFLV, FDTP))
>             {
>                 Return (Zero)
>             }
> 
>             Store (Zero, GPE3)
>             Or (GL08, 0x10, GL08)
>             Notify (\_SB.PCI0.SAT0, 0x82)
>             Return (Zero)
>         }
>     }
> 
> This is the DSDT code for GPE13 on a Samsung Series 7 700Z5C laptop.
> There error reported by the Linux kernel is:
>  ev_queue_notify_reques: No notify handler for Notify, ignoring (SAT0, 82)
> 
> Now, my question is:
> How do I find out what device is causing the GPE13 interrupt and why?

You can look into the ACPI tables, for example.

Please file a but at bugzilla.kernel.org against ACPI and assign it to me.
Please put the output of acpidump on your system as an attachment to the bug
entry.

> How do I work out what code (which device register bit to reset) I have to
> put in this Notify handler in order to silence the interrupt storm?

You need to find out what the cause of the Notify is first.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
