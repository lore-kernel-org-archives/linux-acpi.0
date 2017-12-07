From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v2 0/3] x86: make rsdp address accessible via boot params
Date: Thu,  7 Dec 2017 13:28:18 +0100
Message-ID: <20171207122821.30158-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58138 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752875AbdLGM22 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 Dec 2017 07:28:28 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
Cc: boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, corbet@lwn.net, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, Juergen Gross <jgross@suse.com>

In the non-EFI boot path the ACPI RSDP table is currently found via
either EBDA or by searching through low memory for the RSDP magic.
This requires the RSDP to be located in the first 1MB of physical
memory. Xen PVH guests, however, get the RSDP address via the start of
day information block.

In order to support an arbitrary RSDP address this patch series adds
the physical address of the RSDP to the boot params structure filled
by the boot loader. A kernel booted directly in PVH mode can save the
RSDP address in the boot params, while a kernel booted in PVH mode via
grub can rely on the RSDP address being specified by grub2 (which in
turn got the address via the start of day information block from Xen).

Juergen Gross (3):
  x86/boot: add acpi rsdp address to setup_header
  x86/acpi: take rsdp address for boot params if available
  x86/xen: supply rsdp address in boot params for pvh guests

 Documentation/x86/boot.txt            | 19 +++++++++++++++++++
 arch/x86/boot/header.S                |  6 +++++-
 arch/x86/include/uapi/asm/bootparam.h |  1 +
 arch/x86/xen/enlighten_pvh.c          |  5 ++++-
 drivers/acpi/osl.c                    |  8 ++++++++
 5 files changed, 37 insertions(+), 2 deletions(-)

-- 
2.12.3

