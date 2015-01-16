From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Linaro-acpi] [PATCH v7 00/17] Introduce ACPI for ARM64 based on ACPI 5.1
Date: Fri, 16 Jan 2015 16:53:33 +0100
Message-ID: <1887263.kzglbjcc0t@wuerfel>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org> <1809831.d9GPSfLUEN@wuerfel> <20150116154913.GW7091@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:52922 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbbAPPyu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jan 2015 10:54:50 -0500
In-Reply-To: <20150116154913.GW7091@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linaro-acpi@lists.linaro.org
Cc: Will Deacon <will.deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Yijing Wang <wangyijing@huawei.com>, Rob Herring <robh@kernel.org>, Timur Tabi <timur@codeaurora.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Olof Johansson <olof@lixom.net>

On Friday 16 January 2015 15:49:13 Will Deacon wrote:
> 
> The on-board ethernet on Seattle requires the driver to program its AXI
> attributes, so configuring it to be a coherent master actually means
> "program the same cacheable AXI settings as you have on the CPU". That
> sounds like Linux should be doing it to me, but even if the firmware takes
> a guess at "normal cacheable WBRWA", it's not clear to me whether that
> register persists across things like adapter reset.
> 
> Tom?
> 
> There's also the situation where the firmware hasn't initialised the
> register and Linux realises this during probe. What should it do then?

In case of a 10gbit ethernet adapter, there really should be no question
regarding whether to set it coherent or not. Can't Linux just always
set this AXI attribute in the driver?

	Arnd
