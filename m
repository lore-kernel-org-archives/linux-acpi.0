From: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Problem with ACPI S3 sleep with kernel 2.6.9 on a T41
Date: Fri, 22 Oct 2004 21:07:29 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <pan.2004.10.22.18.07.28.765889@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi All,

With the new kernel 2.6.9 every time I put the computer in ACPI S3 sleep I
get following messages in dmesg. Is this normal ?
I am using S3 for some time on this computer without any other glitches
(except high power usage in S3) and this is the first time I had this
messages on a vanilla kernel.
Otherwise it suspends and resumes fine, but I don't know what this
messages mean.
Any hints ?


Back to C!
Debug: sleeping function called from invalid context at mm/slab.c:2059
in_atomic():0, irqs_disabled():1
 [<c011e898>] __might_sleep+0x98/0xa0
 [<c0151b93>] __kmalloc+0xa3/0xb0
 [<c0208825>] acpi_os_allocate+0xe/0x11
 [<c021cad6>] acpi_ut_allocate+0x38/0x5a
 [<c021ca61>] acpi_ut_initialize_buffer+0x43/0x80
 [<c02197c3>] acpi_rs_create_byte_stream+0x2a/0x47
 [<c021abf4>] acpi_rs_set_srs_method_data+0x1d/0xb1
 [<c0243bfb>] poke_blanked_console+0x7b/0xd0
 [<c0221113>] acpi_pci_link_set+0xe9/0x163
 [<c0221480>] acpi_pci_link_resume+0x1c/0x22
 [<c02214a1>] irqrouter_resume+0x1b/0x30
 [<c0221486>] irqrouter_resume+0x0/0x30
 [<c025bc43>] sysdev_resume+0x103/0x108
 [<c025f825>] device_power_up+0x5/0xa
 [<c0138996>] suspend_enter+0x36/0x50
 [<c0138a41>] enter_state+0x51/0x80
 [<c0138ba0>] state_store+0xa0/0xa8
 [<c019f79a>] subsys_attr_store+0x3a/0x40
 [<c019fa0b>] flush_write_buffer+0x3b/0x50
 [<c019fa80>] sysfs_write_file+0x60/0x70
 [<c01663ad>] vfs_write+0xed/0x160
 [<c01664f1>] sys_write+0x51/0x80
 [<c01070bd>] sysenter_past_esp+0x52/0x71
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 5 (level, low) -> IRQ 5




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
