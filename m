From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 18/18] Documentation: ACPI for ARM64
Date: Thu, 18 Sep 2014 01:22:10 +0200
Message-ID: <201409180122.10631.arnd@arndb.de>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org> <20140917014410.GC31214@srcf.ucam.org> <20140917160508.GA2464@xora-yoga-13>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:57349 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754253AbaIQXXa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Sep 2014 19:23:30 -0400
In-Reply-To: <20140917160508.GA2464@xora-yoga-13>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Graeme Gregory <graeme.gregory@linaro.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>, linaro-acpi@lists.linaro.org, Liviu Dudau <Liviu.Dudau@arm.com>, Lv Zheng <lv.zheng@intel.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, Charles.Garcia-Tobin@arm.com, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org, Randy

On Wednesday 17 September 2014, Graeme Gregory wrote:
> It sounds like from the discussions in other threads that ARM64 should
> be following x86 and re-using DT bindings here. In which case there is
> not need to submit things to UEFI organisation.
> 
> What I got a little lost in has there been a formal decision about DT
> bindings in _DSD?

I think this is a discussion that still needs to happen: either we should
recommend everyone to use _DSD in favor of the alternatives, or we
should prohibit the use of _DSD. I have heard arguments both ways, but
hopefully we can find an easy answer.

	Arnd
