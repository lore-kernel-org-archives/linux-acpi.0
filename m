From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [RFC PATCH for Juno 0/2] Drivers for Juno to boot from ACPI
Date: Mon, 15 Sep 2014 15:57:35 -0700
Message-ID: <20140915225735.1C5A9C40B84@trevor.secretlab.ca>
References: <1409583961-7466-1-git-send-email-hanjun.guo@linaro.org>
	<353732273.2TKdyNJ83M@wuerfel> <540EA446.7010200@redhat.com>
	<3840839.IPB3Ru8Evk@wuerfel>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:33786 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759704AbaIOW5h (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Sep 2014 18:57:37 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so7220386pdj.22
        for <linux-acpi@vger.kernel.org>; Mon, 15 Sep 2014 15:57:36 -0700 (PDT)
In-Reply-To: <3840839.IPB3Ru8Evk@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc: Jon Masters <jcm@redhat.com>, Hanjun Guo <hanjun.guo@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Lv Zheng <lv.zheng@intel.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, linux-kernel@vger.kernel.or, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, Charles.Garcia-Tobin@arm.com, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Graeme Gregory <graeme.gregory@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <Sudeep.Holla@arm.com>, Olof Johansson <olof@lixom.net>

On Tue, 09 Sep 2014 12:55:09 +0200, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 09 September 2014 02:55:02 Jon Masters wrote:
> > On 09/01/2014 11:29 AM, Arnd Bergmann wrote:
> > > On Monday 01 September 2014 23:05:59 Hanjun Guo wrote:
> > >> This patch set is example of the sort of driver changes needed to boot
> > >> Juno using ACPI tables, which using the ACPI tables devloped for MS
> > >> Windows and published by ARM [1].
> > > 
> > > What about platform support?
> > 
> > I think Juno is just serving as an example here since it's from ARM and
> > thus various people have access to it already, etc. It's not the best
> > example of a server platform out there, since that wasn't its original
> > design purpose (but it's a wonderful platform nonetheless). There is
> > work currently in flight to offer other reference ACPI examples.
> 
> Ok, I see. This is a bit disappointing because it's actually the third
> attempt to come up with a reference platform (after Exynos and X-Gene),
> and it always seems to come down to deciding that this particular
> platform doesn't really work with ACPI beyond basic booting.
> 
> Which platform(s) are you talking about? Are you sure it will be better
> suited than the first three?

Juno is actually working out as a good reference platform. It works and
there aren't horrible things that need to be done to get the system into
a working state. AMD Seattle is a second system that will boot with
Hanjun's ACPI series with a couple of device driver patches (the SBSA
driver which is common with Juno and an Ethernet driver IIRC).

g.

