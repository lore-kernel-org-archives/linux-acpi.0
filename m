From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Linaro-acpi] [PATCH v5 1/2] Mailbox: Add support for Platform Communication Channel
Date: Thu, 04 Sep 2014 21:00:11 +0200
Message-ID: <4354903.8scPjxmpFT@wuerfel>
References: <1409782760-3958-1-git-send-email-ashwin.chaugule@linaro.org> <5470309.KpxVtJyk9p@wuerfel> <CAJ5Y-eYj4vv3rmyaEiO5e9fmbeHX0eM1S9OuNn5R=9dPza_39Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:52499 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755125AbaIDTAX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Sep 2014 15:00:23 -0400
In-Reply-To: <CAJ5Y-eYj4vv3rmyaEiO5e9fmbeHX0eM1S9OuNn5R=9dPza_39Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linaro-acpi@lists.linaro.org
Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Thursday 04 September 2014 13:24:25 Ashwin Chaugule wrote:
> On 4 September 2014 04:56, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> >> +     /* Write to the shared comm region. */
> >> +     iowrite16(cmd, &generic_comm_base->command);
> >> +
> >> +     /* Write Subspace MAGIC value so platform can identify destination. */
> >> +     iowrite32((PCCS_SS_SIG_MAGIC | ss_idx), &generic_comm_base->signature);
> >> +
> >> +     /* Flip CMD COMPLETE bit */
> >> +     iowrite16(0, &generic_comm_base->status);
> >
> > using writel_relaxed/writew_relaxed should be more efficient here.
> >
> 
> x86 doesn't seem to have the write*_relaxed variants? They seem to
> have read*_relaxed though.

That sounds highly inconsistent and should probably be fixed.

You could also use writew here, which would be the same as iowrite16
on ARM, but more efficient on x86.

	Arnd
