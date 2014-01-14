From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v6 4/6] ACPI: in HW reduced mode, using FADT PM information is not allowed.
Date: Tue, 14 Jan 2014 01:06:14 +0100
Message-ID: <15980172.euCUnnaQYR@vostro.rjw.lan>
References: <1389394340-2680-1-git-send-email-al.stone@linaro.org> <4248842.kTIlfoGImy@vostro.rjw.lan> <52D46CE2.8020300@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58487 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751608AbaAMXwR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Jan 2014 18:52:17 -0500
In-Reply-To: <52D46CE2.8020300@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <al.stone@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org, patches@linaro.org, linaro-kernel@lists.linaro.org

On Monday, January 13, 2014 03:46:58 PM Al Stone wrote:
> On 01/10/2014 04:31 PM, Rafael J. Wysocki wrote:
> > On Friday, January 10, 2014 03:52:18 PM al.stone@linaro.org wrote:
> >> From: Al Stone <al.stone@linaro.org>
> >>
> >> Per the ACPI 5.0 specification, section 5.2.9, none of the power
> >> management fields in the FADT are to be used.  Short-circuit using
> >> any of those fields in acpi_processor_get_power_info_fadt().
> >
> > So the spec says that we're supposed to ignore the information in
> > certain FADT fields if the HW_REDUCED_ACPI flag is set.
> >
> > However, what about systems in which that information is actually
> > valid even though HW_REDUCED_ACPI is set?
> >
> > Does it break things if we attempt to use that information?
> 
> The way I see it in the spec, we just don't use that info _if_ we wish
> to remain compliant with the spec.  If we insist on using it anyway, we
> can't say we're implementing hardware reduced mode correctly.  That
> being said, from my read of the code it appears things would operate
> the same as they did before if this part of the spec was ignored _and_
> the info in the tables was still valid (same control register addresses
> and content and so on).

Yes.

And we are at the point where we've already been violating the spec
(formally) by not ignoring that information for quite a while, so we risk
regressions if we suddenly try to become "exactly compliant".  That's
my main concern here.

> >> Signed-off-by: Al Stone <al.stone@linaro.org>
> >> ---
> >>   drivers/acpi/processor_idle.c | 8 ++++++++
> >>   1 file changed, 8 insertions(+)
> >>
> >> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> >> index eac984a..89f0a0f 100644
> >> --- a/drivers/acpi/processor_idle.c
> >> +++ b/drivers/acpi/processor_idle.c
> >> @@ -270,6 +270,14 @@ static int acpi_processor_get_power_info_fadt(struct acpi_processor *pr)
> >>   	if (!pr->pblk)
> >>   		return -ENODEV;
> >>
> >> +	/*
> >> +	 * Using power management information from the FADT is not
> >> +	 * allowed when in HW reduced mode.  See ACPI 5.0, section
> >> +	 * 5.2.9.
> >> +	 */
> >> +	if (acpi_gbl_reduced_hardware)
> >> +		return -ENODEV;
> >> +
> >>   	/* if info is obtained from pblk/fadt, type equals state */
> >>   	pr->power.states[ACPI_STATE_C2].type = ACPI_STATE_C2;
> >>   	pr->power.states[ACPI_STATE_C3].type = ACPI_STATE_C3;
> >>
> >

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
