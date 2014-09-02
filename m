From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [Linaro-acpi] [RFC PATCH for Juno 1/2] net: smsc911x add support for probing from ACPI
Date: Wed, 03 Sep 2014 01:00:23 +0200
Message-ID: <2913007.3xRNb2X4ts@vostro.rjw.lan>
References: <1409583961-7466-1-git-send-email-hanjun.guo@linaro.org> <4816592.tj3on6vUaC@wuerfel> <20140902162606.GX29327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61844 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755274AbaIBWlG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Sep 2014 18:41:06 -0400
In-Reply-To: <20140902162606.GX29327@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linaro-acpi@lists.linaro.org, Catalin Marinas <catalin.marinas@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, Liviu Dudau <Liviu.Dudau@arm.com>, Lv Zheng <lv.zheng@intel.com>, Rob Herring <robh@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Will Deacon <Will.Deacon@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Darren Hart <dvhart@linux.intel.com>

On Tuesday, September 02, 2014 05:26:06 PM Mark Brown wrote:
> 
> --s3puAW9DMBtS2ARW
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> 
> On Tue, Sep 02, 2014 at 03:42:53PM +0200, Arnd Bergmann wrote:
> 
> > The way I recall the discussion, most people were on one extreme
> > side of the discussion or the other:
> 
> > a) We should use _DSD for ARM64 servers to maximize code reuse with
> > DT-enabled drivers, work around the slow UEFI standardization process,
> > remain in control of the actual bindings, and avoid the need for
> > endless per-ID platform-data definitions in drivers.
> 
> > b) We should never use _DSD at all, since doing that would have no
> > advantage over using DT directly, and we should force every device
> > manufacturer to specify their bindings in an official ACPI document
> > to prevent random incompatible bindings from being established.
> > Any device that shows up in servers should not need arbitrary detailed
> > properties anyway, as the details are supposed to be hidden in AML.
> 
> > I can understand the reasons for both approaches, and I find it hard
> > to say either one is invalid. However, the worst possible outcome in
> > my opinion would be having to support a mix of the two.
> 
> Right, and the x86 embedded folks are going full steam ahead with _DSD
> regardless so it seems there will be some systems out there using it
> even if they're not ARM servers.

Our intention is specifically not to use "random incompatible bindings"
in that.  We'd rather have a common venue and process for establishing
new bindings for both DT and _DSD in a compatible way.

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
