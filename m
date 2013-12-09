From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Linaro-acpi] [RFC part1 PATCH 1/7] ACPI: Make ACPI core running without PCI on ARM64
Date: Mon, 9 Dec 2013 18:20:22 +0100
Message-ID: <201312091820.23006.arnd@arndb.de>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org> <201312091735.05014.arnd@arndb.de> <20131209165548.GE19163@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:61424 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229Ab3LIRUd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Dec 2013 12:20:33 -0500
In-Reply-To: <20131209165548.GE19163@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Mark Rutland <Mark.Rutland@arm.com>, Matthew Garrett <mjg59@srcf.ucam.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "patches@linaro.org" <patches@linaro.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Monday 09 December 2013, Catalin Marinas wrote:
> CONFIG_PCI does not exist on arm64 yet (we have some internal patches
> but may not be ready to be posted before the holidays; they try to share
> code with other archs, so more discussions before merging). We could add
> CONFIG_PCI and some dummy functions on arm64 for development (not to be
> upstreamed) or Hanjun could continue to use the current patch before we
> get PCI working. In the order of priorities, we'll have to merge PCI
> before ACPI anyway.

Well, lack of PCI support on ARM64 is a much better reason for accepting
the patch than potential use on non-server platforms of course.

What is the status of the PCI work though? I suspect it won't be all
that hard to add minimal PCI support for a simple mmconfig plus
fixed I/O space based host of the kind that qemu can easily provide.

The hard part that we want to share code with other architectures is
supporting pluggable host controllers, and I think we can defer that
a bit.

	Arnd
