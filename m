From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 3/3] ACPI: ARM64: support for ACPI_TABLE_UPGRADE
Date: Mon, 23 May 2016 17:49:10 +0100
Message-ID: <20160523164909.GF4976@leverpostej>
References: <1463486765-31827-1-git-send-email-aleksey.makarov@linaro.org>
 <1463486765-31827-4-git-send-email-aleksey.makarov@linaro.org>
 <20160517124629.GE14955@leverpostej>
 <f0bf43ef-0be5-484c-5066-ab1929105b82@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52454 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752087AbcEWQt0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 May 2016 12:49:26 -0400
Content-Disposition: inline
In-Reply-To: <f0bf43ef-0be5-484c-5066-ab1929105b82@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jon Masters <jcm@redhat.com>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>, Russell King <linux@arm.linux.org.uk>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Graeme Gregory <graeme.gregory@linaro.org>, "Zheng, Lv" <lv.zheng@intel.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, leif.lindholm@linaro.org

On Tue, May 17, 2016 at 12:44:02PM -0400, Jon Masters wrote:
> Hi Mark,
> 
> On 05/17/2016 08:46 AM, Mark Rutland wrote:
> > On Tue, May 17, 2016 at 03:06:03PM +0300, Aleksey Makarov wrote:
> >> From: Jon Masters <jcm@redhat.com>
> >>
> >> This patch adds support for ACPI_TABLE_UPGRADE for ARM64
> > 
> > This feels like a tool to paper over problems rather than solve them.
> 
> Generally, it's an arrow in the quiver used to triage problems, and then
> solve them by getting firmware updates made.

Ok. The feature is _hideously_ misnamed for that purpose, however.

> > If vendors are shipping horrendously broken tables today, clearly no
> > software has ever really supported them. So why add workarounds?
> 
> That's not (always) the case. These patches help with:
> 
> 1). During development of a platform, it is much easier to debug
> problems with tables if you can test replacement ones without having to
> respin the firmware. In the server world, you usually don't have the
> firmware source code, so to get it respun could be days-weeks even if
> you are working with the authors closely. We have practically used this
> feature on a number of platforms already and it will continue.

I was under the impression that that was already possible with GRUB
today (though I see below this may not be the case).

> 2). They empower (advanced) users and developers to work around problems
> that they find on platforms. Sure, we want firmware to always be fixed
> and working well, but it is better if folks have the tools.
> 
> > Why is this necessary? Is there a particular case for this, or is this
> > just for parity with x86?
> 
> The use cases are as above. It's also required for parity with x86
> functionality on servers.

Parity for case 1 above, or is this used in other scenarios on x86
today?

> > IMO it would be better to put pressure on vendors to fix their FW and
> > provide sensible OS-agnostic update mechanisms.
> 
> It's easier to put pressure on them after we know what the problems are.
> I agree that alternative update mechanisms are also good. We also have
> the ability (but it is not implemented on ARM) in GRUB2 to override ACPI
> tables, BUT it's kinda atrophied on all arches and requires that you
> rebuild GRUB with an additional module.

This feels like something that could/should be rectified.

> The reality is that by incorporating this feature we are able to
> provide the same capability that already exists on x86 systems for
> ACPI table triage.

To be clear, I do not disagree that this feature can be useful for that
case. I am just concerned that this is easily abused, and the
description implies a more general set of use cases than we would like.

Thanks,
Mark.
