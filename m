From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 02/12] ACPI: bus master reload not supported in reduced HW mode
Date: Thu, 21 Nov 2013 01:31:51 +0100
Message-ID: <8554645.8Wdocqjnq9@vostro.rjw.lan>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org> <2902248.9mmxm8tccy@vostro.rjw.lan> <528D2586.7010503@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52879 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751558Ab3KUATM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Nov 2013 19:19:12 -0500
In-Reply-To: <528D2586.7010503@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <al.stone@linaro.org>
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>

On Wednesday, November 20, 2013 02:11:34 PM Al Stone wrote:
> On 11/17/2013 02:56 PM, Rafael J. Wysocki wrote:
> > On Saturday, November 09, 2013 06:36:12 PM al.stone@linaro.org wrote:
> >> From: Al Stone <ahs3@redhat.com>
> >>
> >> Remove the saving and restoring of bus master reload registers in
> >> suspend/resume when in reduces HW mode; according to the spec, no
> >> such registers should exist
> >>
> >> Signed-off-by: Al Stone <al.stone@linaro.org>
> >> ---
> >>   drivers/acpi/processor_idle.c | 8 +++++++-
> >>   include/acpi/acpixf.h         | 6 ++++++
> >>   2 files changed, 13 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> >> index 35c8f2b..28079a6 100644
> >> --- a/drivers/acpi/processor_idle.c
> >> +++ b/drivers/acpi/processor_idle.c
> >> @@ -210,6 +210,7 @@ static void lapic_timer_state_broadcast(struct acpi_processor *pr,
> >>   #endif
> >>
> >>   #ifdef CONFIG_PM_SLEEP
> >> +#if (!ACPI_REDUCED_HARDWARE)
> >
> > Why don't you use #ifndef CONFIG_ACPI_REDUCED_HARDWARE here?
> >
> > And I believe we don't need acpi_processor_syscore_ops in that case at all?
> >
> > So why don't you put the whole section under
> >
> > #if (IS_ENABLED(CONFIG_PM_SLEEP) && !IS_ENABLED(CONFIG_ACPI_REDUCED_HARDWARE)) ?
> 
> My original thinking was that ACPI_REDUCED_HARDWARE is the flag
> being used in the ACPICA code.  On re-thinking it (and I'll use
> your suggestion, if you don't mind), is it fair to say that there
> is essentially a policy of keeping the Linux acpi driver and the
> ACPICA code as separate as possible?

We generally avoid mixing the code bases so that ACPICA upstream can make
changes without worrying (too much) about breaking Linux inadvertently.

In any case it is better to use Linux' symbols rather than ACPICA's symbols
wherever possible.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
