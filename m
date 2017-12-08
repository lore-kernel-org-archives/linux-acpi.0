From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v3 0/4] x86: make rsdp address accessible via boot params
Date: Fri,  8 Dec 2017 16:11:35 +0100
Message-ID: <20171208151139.30213-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
Cc: boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, corbet@lwn.net, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, Juergen Gross <jgross@suse.com>
List-Id: linux-acpi@vger.kernel.org

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


Juergen Gross (4):
  x86/boot: add acpi rsdp address to setup_header
  x86/acpi: take rsdp address for boot params if available
  x86/xen: fix boot loader version reported for pvh guests
  x86/xen: supply rsdp address in boot params for pvh guests

 Documentation/x86/boot.txt            | 19 +++++++++++++++++++
 arch/x86/boot/header.S                |  6 +++++-
 arch/x86/include/uapi/asm/bootparam.h |  1 +
 arch/x86/kernel/acpi/boot.c           |  7 +++++++
 arch/x86/xen/enlighten_pvh.c          |  5 ++++-
 drivers/acpi/osl.c                    | 10 +++++++++-
 include/linux/acpi.h                  |  2 ++
 7 files changed, 47 insertions(+), 3 deletions(-)

-- 
2.12.3
