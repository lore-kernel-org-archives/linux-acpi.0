From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Linaro-acpi] [PATCH 2/6] x86, acpi, pci: Move arch-agnostic MMCFG code out of arch/x86/ directory
Date: Fri, 12 Dec 2014 15:55:23 +0100
Message-ID: <67564550.9h6b3Ng1Fi@wuerfel>
References: <1416413091-13452-1-git-send-email-tomasz.nowicki@linaro.org> <1416413091-13452-3-git-send-email-tomasz.nowicki@linaro.org> <20141210235500.GA22886@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:50135 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757044AbaLLOzn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Dec 2014 09:55:43 -0500
In-Reply-To: <20141210235500.GA22886@google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linaro-acpi@lists.linaro.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, rjw@rjwysocki.net, linux-pci@vger.kernel.org, catalin.marinas@arm.com, x86@kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, wangyijing@huawei.com, Liviu.Dudau@arm.com, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org

On Wednesday 10 December 2014 16:55:00 Bjorn Helgaas wrote:
> On Wed, Nov 19, 2014 at 05:04:47PM +0100, Tomasz Nowicki wrote:
> > MMCFG table seems to be architecture independent and it makes sense
> > to share common code across all architectures. The ones that may need
> > architectural specific actions have default prototype (__weak).
> > 
> > Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> > Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> > ---
> >  arch/x86/include/asm/pci_x86.h |  29 -----
> >  arch/x86/pci/acpi.c            |   1 +
> >  arch/x86/pci/init.c            |   1 +
> >  arch/x86/pci/mmconfig-shared.c | 200 +---------------------------------
> >  arch/x86/pci/mmconfig_32.c     |   1 +
> >  arch/x86/pci/mmconfig_64.c     |   1 +
> >  drivers/acpi/Makefile          |   1 +
> >  drivers/acpi/bus.c             |   1 +
> >  drivers/acpi/mmconfig.c        | 242 +++++++++++++++++++++++++++++++++++++++++
> >  include/linux/mmconfig.h       |  58 ++++++++++
> >  include/linux/pci.h            |   8 --
> >  11 files changed, 308 insertions(+), 235 deletions(-)
> >  create mode 100644 drivers/acpi/mmconfig.c
> >  create mode 100644 include/linux/mmconfig.h
> > ... 
> 
> Much of the code you're moving to drivers/acpi/mmconfig.c is not actually
> ACPI-specific and would have to be duplicated for a non-ACPI architecture
> that supports ECAM.  Could that code be moved somewhere like
> drivers/pci/ecam.c, where it could be shared?

We have an implementation of ECAM in drivers/pci/host/pci-host-generic.c,
which today is ARM32 specific but should be migrated to the new generic
infrastructure we are adding for ARM64, after which that driver becomes
very simple.

I suppose we could either make it use drivers/pci/ecam.c then, or have
the config space code from pci-host-generic be shared between ACPI and
DT based platforms. The former approach is probably nicer in the long
run, and it allows sharing with other drivers that use ECAM but are not
completely generic otherwise.

	Arnd
