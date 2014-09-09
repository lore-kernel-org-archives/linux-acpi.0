From: Jon Masters <jcm@redhat.com>
Subject: Re: [RFC PATCH for Juno 0/2] Drivers for Juno to boot from ACPI
Date: Tue, 9 Sep 2014 10:13:01 -0400 (EDT)
Message-ID: <507704665.9032709.1410271981816.JavaMail.zimbra@zmail15.collab.prod.int.phx2.redhat.com>
References: <1409583961-7466-1-git-send-email-hanjun.guo@linaro.org> <353732273.2TKdyNJ83M@wuerfel> <540EA446.7010200@redhat.com> <3840839.IPB3Ru8Evk@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:46143 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbaIIOT3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Sep 2014 10:19:29 -0400
In-Reply-To: <3840839.IPB3Ru8Evk@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Randy Dunlap <rdunlap@infradead.org>, linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hanjun Guo <hanjun.guo@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.or, Mark Brown <broonie@kernel.org>, Olof Johansson <olof@lixom.net>, Marc Zyngier <marc.zyngier@arm.com>, Robert Richter <rric@kernel.org>, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Charles.Garcia-Tobin@arm.com, Daniel Lezcano <daniel.lezcano@linaro.org>, Liviu Dudau <Liviu.Dudau@arm.com>, Grant Likely <grant.likely@linaro.org>, Jason Cooper <jason@lakedaemon.net>

I expect you will see followup email from a vendor in a few hours.

-- 
Computer Architect | Sent from my #ARM Powered Mobile device

On Sep 9, 2014 6:56 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tuesday 09 September 2014 02:55:02 Jon Masters wrote: 
> > On 09/01/2014 11:On Tuesday 09 September 2014 02:55:02 Jon Masters wrote:
> On 09/01/2014 11:29 AM, Arnd Bergmann wrote:
> > On Monday 01 September 2014 23:05:59 Hanjun Guo wrote:
> >> This patch set is example of the sort of driver changes needed to boot
> >> Juno using ACPI tables, which using the ACPI tables devloped for MS
> >> Windows and published by ARM [1].
> > 
> > What about platform support?
> 
> I think Juno is just serving as an example here since it's from ARM and
> thus various people have access to it already, etc. It's not the best
> example of a server platform out there, since that wasn't its original
> design purpose (but it's a wonderful platform nonetheless). There is
> work currently in flight to offer other reference ACPI examples.

Ok, I see. This is a bit disappointing because it's actually the third
attempt to come up with a reference platform (after Exynos and X-Gene),
and it always seems to come down to deciding that this particular
platform doesn't really work with ACPI beyond basic booting.

Which platform(s) are you talking about? Are you sure it will be better
suited than the first three?

	Arnd
