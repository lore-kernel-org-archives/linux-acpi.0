From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V2 22/23] pci, acpi: Match PCI config space accessors against platfrom specific quirks.
Date: Mon, 21 Dec 2015 23:42:18 +0100
Message-ID: <201512212342.18960.arnd@arndb.de>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com> <201512211510.32029.arnd@arndb.de> <5678370B.1030102@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:57287 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbbLUWno (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Dec 2015 17:43:44 -0500
In-Reply-To: <5678370B.1030102@caviumnetworks.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: David Daney <ddaney@caviumnetworks.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "will.deacon@arm.com" <will.deacon@arm.com>, "okaya@codeaurora.org" <okaya@codeaurora.org>, Wangyijing <wangyijing@huawei.com>, "Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>, Tomasz Nowicki <tn@semihalf.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "robert.richter@caviumnetworks.com" <robert.richter@caviumnetworks.com>, "msalter@redhat.com" <msalter@redhat.com>, "jcm@redhat.com" <jcm@redhat.com>, "Stefano.Stabellini@eu.citrix.com" <Stefano.Stabellini@eu.citrix.com>, "Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "tglx@linutronix.de" <tgl>

On Monday 21 December 2015, David Daney wrote:
> On 12/21/2015 06:10 AM, Arnd Bergmann wrote:
> > On Monday 21 December 2015, Gabriele Paoloni wrote:
> 
> > or require the BIOS to work around the hardware
> > quirks differently (e.g. by trapping config space access through secure
> > firmware, or going through an AML method to be defined).
> 
> Some systems don't seem to have this capability.  For example, in ARMv8 
> (A.K.A. arm64), I haven't been able to figure out how to trap these 
> accesses to EL3 for emulation.  The specification is 5700 pages long 
> though, so perhaps I missed that bit.

How about using AML then? This would be similar to what CHRP used with
RTAS calls to do PCI config space access.

	Arnd
