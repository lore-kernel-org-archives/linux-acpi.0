From: Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH v4 18/18] Documentation: ACPI for ARM64
Date: Wed, 17 Sep 2014 04:58:10 -0400
Message-ID: <54194D22.7060706@redhat.com>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org> <1410530416-30200-19-git-send-email-hanjun.guo@linaro.org> <20140917014410.GC31214@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:29001 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753385AbaIQI7i (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Sep 2014 04:59:38 -0400
In-Reply-To: <20140917014410.GC31214@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>, Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>, linaro-acpi@lists.linaro.org, Liviu Dudau <Liviu.Dudau@arm.com>, Lv Zheng <lv.zheng@intel.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, Charles.Garcia-Tobin@arm.com, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org, Graeme Gregory <graeme.gregory@linaro.org>, Randy Dunlap <rdunlap@infradead.org>li

On 09/16/2014 09:44 PM, Matthew Garrett wrote:
> On Fri, Sep 12, 2014 at 10:00:16PM +0800, Hanjun Guo wrote:
> 
>> +Common _DSD bindings should be submitted to ASWG to be included in the
>> +document :-
>> +
>> +http://www.uefi.org/sites/default/files/resources/_DSD-implementation-guide-toplevel.htm
> 
> How are individuals/companies who aren't UEFI members supposed to do 
> this? Aren't there IP issues involved in taking submissions from 
> non-members?

Obviously, I'm not a lawyer, but I would note that the _DSD bindings
aren't going into the core ACPI document. I think the specifics for non
members of the UEFI to potentially contribute bindings need to be
addressed. That said, at this point, the population of the UEFI forum is
very well aligned with initial players (that this is the case is not
entirely an accident, I went around to a few folks a year or so ago and
made sure that they had become members in anticipation of this issue).

Jon.

