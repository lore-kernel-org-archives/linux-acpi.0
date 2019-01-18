From: Kairui Song <kasong@redhat.com>
Subject: [PATCH v3 0/3] make kexec work with efi=noruntime or efi=old_map
Date: Fri, 18 Jan 2019 19:13:07 +0800
Message-ID: <20190118111310.29589-1-kasong@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org, dyoung@redhat.com, bhe@redhat.com, kexec@lists.infradead.org, akpm@linux-foundation.org, robert.moore@intel.com, erik.schmauss@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, fanc.fnst@cn.fujitsu.com, linux-acpi@vger.kernel.org, Kairui Song <kasong@redhat.com>
List-Id: linux-acpi@vger.kernel.org

This patch series fix the kexec panic on efi=noruntime or efi=old_map
pass acpi_rsdp_addr to the second kernel and make it boot up properly.

Update from V2:
 - Store acpi rsdp value, and add an acpi_os_get_root_pointer_late as
   a helper, leveraging existing codes so we don't need to reparse RSDP.

Update from V1:
 - Add a cover letter and fix some type in commit message
 - Previous patches are not sent in a single thread

Kairui Song (3):
  x86, kexec_file_load: Don't setup EFI info if EFI runtime is not
    enabled
  acpi: store acpi_rsdp address for later kexec usage
  x86, kexec_file_load: make it work with efi=noruntime or efi=old_map

 arch/x86/kernel/kexec-bzimage64.c | 13 +++++++++++++
 drivers/acpi/osl.c                | 10 ++++++++++
 include/linux/acpi.h              |  3 +++
 3 files changed, 26 insertions(+)

-- 
2.20.1
