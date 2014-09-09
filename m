From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH for Juno 0/2] Drivers for Juno to boot from ACPI
Date: Tue, 09 Sep 2014 12:55:09 +0200
Message-ID: <3840839.IPB3Ru8Evk@wuerfel>
References: <1409583961-7466-1-git-send-email-hanjun.guo@linaro.org> <353732273.2TKdyNJ83M@wuerfel> <540EA446.7010200@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:49830 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932200AbaIIKzd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Sep 2014 06:55:33 -0400
In-Reply-To: <540EA446.7010200@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jon Masters <jcm@redhat.com>, Hanjun Guo <hanjun.guo@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Lv Zheng <lv.zheng@intel.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, linux-kernel@vger.kernel.or, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Charles.Garcia-Tobin@arm.com, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Graeme Gregory <graeme.gregory@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <Sudeep.Holla@arm.com>, Olo

On Tuesday 09 September 2014 02:55:02 Jon Masters wrote:
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
