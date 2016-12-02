From: Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH V1 1/2] PCI: thunder: Enable ACPI PCI controller for
 ThunderX pass2.x silicon version
Date: Fri, 2 Dec 2016 00:50:47 -0500
Message-ID: <e5b1f09c-ca4c-fbf0-e9d7-c943ad0df2ff@redhat.com>
References: <1479201298-25494-1-git-send-email-tn@semihalf.com>
 <1479201298-25494-2-git-send-email-tn@semihalf.com>
 <20161201002812.GB9409@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750900AbcLBFvQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 2 Dec 2016 00:51:16 -0500
In-Reply-To: <20161201002812.GB9409@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>, Tomasz Nowicki <tn@semihalf.com>
Cc: will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org, Lorenzo.Pieralisi@arm.com, arnd@arndb.de, jchandra@broadcom.com, ard.biesheuvel@linaro.org, robert.richter@caviumnetworks.com, mw@semihalf.com, ddaney@caviumnetworks.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org, andrea.gallo@linaro.org, jeremy.linton@arm.com, liudongdong3@huawei.com, gabriele.paoloni@huawei.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, msalter@redhat.com, Christopher Covington <cov@codeaurora.org>

On 11/30/2016 07:28 PM, Bjorn Helgaas wrote:

> I'm hoping to end up with something like this:
> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/ecam&id=51ad4df79a9b7f2a66b346a46b21a785a2937469

The following build warnings happen using your branch on RHELSA7.3:

drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
  THUNDER_PEM_QUIRK(2,  0), /* off-chip devices */
  ^
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ‘mcfg_quirks[44].cfgres.start’) [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ‘mcfg_quirks[44].cfgres.end’) [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ‘mcfg_quirks[45].cfgres.start’) [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ‘mcfg_quirks[45].cfgres.end’) [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ‘mcfg_quirks[46].cfgres.start’) [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ‘mcfg_quirks[46].cfgres.end’) [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ‘mcfg_quirks[47].cfgres.start’) [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ‘mcfg_quirks[47].cfgres.end’) [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ‘mcfg_quirks[48].cfgres.start’) [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ‘mcfg_quirks[48].cfgres.end’) [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ‘mcfg_quirks[49].cfgres.start’) [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ‘mcfg_quirks[49].cfgres.end’) [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
  THUNDER_PEM_QUIRK(2,  1), /* off-chip devices */
  ^
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ‘mcfg_quirks[50].cfgres.start’) [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ‘mcfg_quirks[50].cfgres.end’) [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ‘mcfg_quirks[51].cfgres.start’) [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ‘mcfg_quirks[51].cfgres.end’) [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ‘mcfg_quirks[52].cfgres.start’) [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ‘mcfg_quirks[52].cfgres.end’) [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ‘mcfg_quirks[53].cfgres.start’) [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ‘mcfg_quirks[53].cfgres.end’) [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ‘mcfg_quirks[54].cfgres.start’) [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ‘mcfg_quirks[54].cfgres.end’) [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ‘mcfg_quirks[55].cfgres.start’) [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ‘mcfg_quirks[55].cfgres.end’) [enabled by default]

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop
