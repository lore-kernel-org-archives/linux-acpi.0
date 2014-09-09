From: Jon Masters <jcm@redhat.com>
Subject: Re: [RFC PATCH for Juno 0/2] Drivers for Juno to boot from ACPI
Date: Tue, 09 Sep 2014 02:55:02 -0400
Message-ID: <540EA446.7010200@redhat.com>
References: <1409583961-7466-1-git-send-email-hanjun.guo@linaro.org> <353732273.2TKdyNJ83M@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:62768 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752434AbaIIG4X (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Sep 2014 02:56:23 -0400
In-Reply-To: <353732273.2TKdyNJ83M@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Will Deacon <will.deacon@arm.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.or

On 09/01/2014 11:29 AM, Arnd Bergmann wrote:
> On Monday 01 September 2014 23:05:59 Hanjun Guo wrote:
>> This patch set is example of the sort of driver changes needed to boot
>> Juno using ACPI tables, which using the ACPI tables devloped for MS
>> Windows and published by ARM [1].
> 
> What about platform support?

I think Juno is just serving as an example here since it's from ARM and
thus various people have access to it already, etc. It's not the best
example of a server platform out there, since that wasn't its original
design purpose (but it's a wonderful platform nonetheless). There is
work currently in flight to offer other reference ACPI examples.

Jon.

