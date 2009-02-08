From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: state of some x86 acpi patches
Date: Sat, 07 Feb 2009 16:09:00 -0800
Message-ID: <498E229C.5030205@goop.org>
References: <4947FF4C.80706@goop.org> <20081216192534.GB843@elte.hu> <alpine.LFD.2.00.0812311821110.3854@localhost.localdomain> <495C677F.6080707@goop.org> <20090102153957.GA1180@elte.hu> <4980EE0C.4070308@goop.org> <49810211.9030808@kernel.org> <498CF8DA.30004@goop.org> <498CFD95.5070004@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756042AbZBHAJW@vger.kernel.org>
In-Reply-To: <498CFD95.5070004@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Yinghai Lu wrote:
> Ingo is too busy...
> It seems Len already agreed those patches can go through tip.
>   

OK, I have them prepared as a branch off tip/git pullable from:

The following changes since commit 82eda818f26cbef2b0a6bf6580e52645af62e4fd:
  Ingo Molnar (1):
        Merge branch 'core/locking'

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jeremy/xen.git acpi/map

Jeremy Fitzhardinge (3):
      x86: use early_ioremap in __acpi_map_table
      x86: always explicitly map acpi memory
      acpi: remove final __acpi_map_table mapping before setting acpi_gbl_permanent_mmap

Yinghai Lu (2):
      acpi/x86: introduce __apci_map_table, v4
      revert_fix_es7000_compiling

 arch/ia64/kernel/acpi.c          |    4 ++++
 arch/x86/include/asm/acpi.h      |    3 ---
 arch/x86/include/asm/fixmap_32.h |    4 ----
 arch/x86/include/asm/fixmap_64.h |    4 ----
 arch/x86/kernel/acpi/boot.c      |   33 ++++++++-------------------------
 arch/x86/kernel/es7000_32.c      |    9 ++++++++-
 drivers/acpi/acpica/tbxface.c    |   17 ++++++++++++++---
 drivers/acpi/osl.c               |   11 +++++++++--
 drivers/acpi/tables.c            |   20 ++++++++++++++------
 include/acpi/acpiosxf.h          |    1 +
 include/acpi/acpixf.h            |    4 ++++
 include/linux/acpi.h             |    1 +
 12 files changed, 63 insertions(+), 48 deletions(-)

	J
