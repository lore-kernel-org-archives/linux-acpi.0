From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 4/4] cpuidle - support multiple drivers
Date: Sun, 07 Oct 2012 23:09:41 +0200
Message-ID: <5874070.u8crxYxFx3@vostro.rjw.lan>
References: <1348526634-19029-1-git-send-email-daniel.lezcano@linaro.org> <506D9CA9.8000308@linaro.org> <20121004143442.GM13834@tbergstrom-lnx.Nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:35278 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750833Ab2JGVGO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 7 Oct 2012 17:06:14 -0400
In-Reply-To: <20121004143442.GM13834@tbergstrom-lnx.Nvidia.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "lenb@kernel.org" <lenb@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>

On Thursday 04 of October 2012 17:34:42 Peter De Schrijver wrote:
> > >>
> > >> eg.
> > >> cpu0: acpi_idle
> > >> cpu1: acpi_idle
> > >>
> > > 
> > > Is this allowed? I thought sysfs files can output only 1 line of data?
> > 
> > Ah yeah :)
> > 
> > Does it make sense to put the following files:
> > 
> > /sys/devices/system/cpu/cpu0/cpuidle/driver
> >  => acpi_idle
> > /sys/devices/system/cpu/cpu1/cpuidle/driver
> >  => acpi_idle
> > 
> 
> Sounds like a reasonable idea.
> 
> > and the content of the file:
> > 
> > /sys/devices/system/cpu/cpuidle/current_driver will show the driver
> > associated with current cpu ?
> > 
> 
> I think that's ok.

Yes, that sounds good.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
