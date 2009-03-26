From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: "ACPI: EC: missing confirmations, switch off interrupt mode"
	wastes time on startup
Date: Thu, 26 Mar 2009 16:58:36 +0000
Message-ID: <9b2b86520903260958r790e5459r553308311522e88f@mail.gmail.com>
References: <4e5e476b0903260847m1de3e976ne20279df359176cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:44169 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756800AbZCZQ6j (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Mar 2009 12:58:39 -0400
In-Reply-To: <4e5e476b0903260847m1de3e976ne20279df359176cf@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corrado Zoccolo <czoccolo@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux acpi <linux-acpi@vger.kernel.org>

On 3/26/09, Corrado Zoccolo <czoccolo@gmail.com> wrote:
> Hi,
> I found that on my netbook (acer aspire one 110), kernel boot time
> (kernel 2.6.29) is severely affected by the EC boot procedure, since
> it is first fooled by a spurious interrupt in thinking that interrupts
> work, and then gets a timeout waiting for an interrupt that never
> arrives:
> [    0.351161] calling  acpi_init+0x0/0x236 @ 1
> [    0.361052] ACPI: EC: Look up EC in DSDT
> [    0.367754] ACPI: BIOS _OSI(Linux) query ignored
> [    0.368984] ACPI: EC: non-query interrupt received, switching to
> interrupt mode
> [    0.860013] ACPI: EC: missing confirmations, switch off interrupt mode.
> [    0.866062] ACPI: Interpreter enabled
>
> There is a bug report for this issue
> http://bugzilla.kernel.org/show_bug.cgi?id=12001 ,  marked as fixed on
> an old kernel, but I'm still getting it with 2.6.29 (maybe my
> controller is flaky?), so I'm looking for a workaround: is there a way
> to force the ACPI using polling?

[CC linux-acpi]

Thanks for reporting this bug / issue.  Your hardware is probably
defective by design - that is, it doesn't follow the ACPI spec.  But
we can't blame users for that :-).

I take it this isn't a regression, i.e. if you've tried earlier
kernels, it's never worked any better?

You say this is a severe delay - but your logs show 0.5 seconds only,
is that right?  Just to get it clear.

Currently there is no option to force polling, sorry.  I'm _guessing_
this was a deliberate omission.  But I can sympathise that even 0.5s
boot delay is bad on a netbook.

Feel free to create a new bugzilla entry.  You can attach the full
output of dmesg, but acpidump is probably not required.  What would be
really helpful is if you could file on bugzilla, and attach a full
debug trace.  I.e. as well as the normal dmesg, attach the dmesg
output after recompiling with this change:

drivers/acpi/ec.c:
29: /* Uncomment next line to get verbose printout */
30: /* #define DEBUG */

change to

30: #define DEBUG

Thanks again
Alan
