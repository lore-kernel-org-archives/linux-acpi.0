From: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: debug message received when resume form S3 on an IBM T41 / 2.6.9-rc4
Date: Sat, 16 Oct 2004 14:33:15 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <pan.2004.10.16.11.33.10.145766@yahoo.com>
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

Hi,

I have compiled a 2.6.9-rc4 kernel with PM debug in it, and now I receive
the output bellow every time I suspend to ram (s3).
It is a T41 IBM Thinkpad, and other than this message, it suspends and
resumes ok from S3. Maybe it helps someone.

PM: Preparing system for suspend
Stopping tasks: ==========================================================================================|
PM: Entering state.
Back to C!
Warning: CPU frequency is 1700000, cpufreq assumed 600000 kHz.
Debug: sleeping function called from invalid context at mm/slab.c:2052
in_atomic():0, irqs_disabled():1
 [<c011d7ef>] __might_sleep+0x9f/0xb0
 [<c014144a>] __kmalloc+0x8a/0xa0
 [<c01e8afd>] acpi_os_allocate+0xa/0xb
 [<c020bf9e>] acpi_ut_allocate+0x68/0xb3
 [<c020c0e1>] acpi_ut_allocate_and_track+0x16/0x56
 [<c020befb>] acpi_ut_initialize_buffer+0x43/0x7e
 [<c02063a5>] acpi_rs_create_byte_stream+0x93/0xfe
 [<c0208fd8>] acpi_rs_set_srs_method_data+0x47/0xfb
 [<c011cae0>] default_wake_function+0x0/0x10
 [<c020c80f>] acpi_ut_trace+0x28/0x2e
 [<c0207358>] acpi_set_current_resources+0x62/0x7b
 [<c02136cf>] acpi_pci_link_set+0x159/0x28b
 [<c0213cc8>] acpi_pci_link_resume+0x45/0x79
 [<c0213d3f>] irqrouter_resume+0x43/0x6a
 [<c024c047>] sysdev_resume+0xf7/0xfc
 [<c024f475>] device_power_up+0x5/0xa
 [<c0135740>] suspend_enter+0x30/0x50
 [<c01357f5>] enter_state+0x65/0xa0
 [<c0135953>] state_store+0xa3/0xab
 [<c01358b0>] state_store+0x0/0xab
 [<c0188a46>] subsys_attr_store+0x36/0x40
 [<c0188c8b>] flush_write_buffer+0x2b/0x40
 [<c0188cde>] sysfs_write_file+0x3e/0x50
 [<c01542f1>] vfs_write+0xd1/0x120
 [<c0154407>] sys_write+0x47/0x80
 [<c0105f0d>] sysenter_past_esp+0x52/0x71
PM: Finishing up.
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 4 (level, low) -> IRQ 4
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 3 (level, low) -> IRQ 3
PCI: Setting latency timer of device 0000:00:1f.5 to 64
PCI: Enabling device 0000:02:01.0 (0000 -> 0003)
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 10 (level, low) -> IRQ 10
Restarting tasks... done
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
