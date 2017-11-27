From: Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: 2f47e7e19f ("x86/mm/kaiser: Use PCID feature to make user and
 .."): WARNING: CPU: 0 PID: 1 at mm/early_ioremap.c:114 __early_ioremap
Date: Mon, 27 Nov 2017 08:14:35 -0800
Message-ID: <bdfdf131-ca57-68c3-3a6c-039cd21c3bb5@linux.intel.com>
References: <5a1aaa36.CWNgvwmmRFzeAlPc%fengguang.wu@intel.com>
 <20171127101814.jsglrh7typy3pxxp@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------EB8315A49B7F033CD039AA1A"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171127101814.jsglrh7typy3pxxp@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, kernel test robot <fengguang.wu@intel.com>
Cc: LKP <lkp@01.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, wfg@linux.intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------EB8315A49B7F033CD039AA1A
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 11/27/2017 02:18 AM, Ingo Molnar wrote:
> [    0.031000] Call Trace:
> [    0.031000]  ? kernfs_add_one+0x1d9/0x1f0
> [    0.031000]  early_memremap+0x33/0x3d
> [    0.031000]  ? cnb20le_res+0x2f2/0x2f2
> [    0.031000]  __acpi_map_table+0x1d/0x28
> [    0.031000]  acpi_os_map_iomem+0x1cf/0x2a0
> [    0.031000]  ? cnb20le_res+0x2f2/0x2f2
> [    0.031000]  acpi_os_map_memory+0xd/0x20
> [    0.031000]  acpi_find_root_pointer+0x1f/0x1ec
> [    0.031000]  ? cnb20le_res+0x2f2/0x2f2
> [    0.031000]  acpi_os_get_root_pointer+0x18/0x25
> [    0.031000]  broadcom_postcore_init+0xc/0x6c
> [    0.031000]  do_one_initcall+0xc4/0x1f7
> [    0.031000]  kernel_init_freeable+0x1c2/0x2b2
> [    0.031000]  ? rest_init+0x1a0/0x1a0
> [    0.031000]  kernel_init+0xd/0x1bc
> [    0.031000]  ret_from_fork+0x1f/0x30

I've been able to reproduce this.  The bug here (at least on my system)
is that we're calling into the ACPI code while 'acpi_disabled=1'.  The
ACPI code then notices that it hasn't been initialized (because it
should be off) and calls into the early_ioremap() code thinking that
it's in early boot.

I don't know why the bisect pinned this on the kaiser patches, or why
it's only showing up now.  It's possible that some botched TLB flush
_caused_ ACPI to get disabled at a weird time which then caused this
warning.

There are some recent changes around broadcom_postcore_init().

ACPI folks, any suggestions on what to do here?  Should we be bailing
out of acpi_os_get_root_pointer() like the attached patch?

It might also be worth an audit of all of the 'acpi_permanent_mmap'
call-sites to make sure they check acpi_disabled first.

--------------EB8315A49B7F033CD039AA1A
Content-Type: text/x-patch;
 name="acpi-off-but-still-called.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="acpi-off-but-still-called.patch"



---

 b/drivers/acpi/osl.c |    4 ++++
 1 file changed, 4 insertions(+)

diff -puN drivers/acpi/osl.c~acpi-off-but-still-called drivers/acpi/osl.c
--- a/drivers/acpi/osl.c~acpi-off-but-still-called	2017-11-27 08:05:53.161611164 -0800
+++ b/drivers/acpi/osl.c	2017-11-27 08:06:55.288611009 -0800
@@ -191,6 +191,8 @@ acpi_physical_address __init acpi_os_get
 {
 	acpi_physical_address pa = 0;
 
+	if (acpi_disabled)
+		return pa;
 #ifdef CONFIG_KEXEC
 	if (acpi_rsdp)
 		return acpi_rsdp;
@@ -318,6 +320,8 @@ acpi_os_map_iomem(acpi_physical_address
 	acpi_physical_address pg_off;
 	acpi_size pg_sz;
 
+	WARN_ON(acpi_disabled);
+
 	if (phys > ULONG_MAX) {
 		printk(KERN_ERR PREFIX "Cannot map memory that high\n");
 		return NULL;
_

--------------EB8315A49B7F033CD039AA1A--
