From: "Paulo Vitor Magacho da Silva" <pvmagacho78-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: Suspend button works only once
Date: Fri, 08 Apr 2005 13:44:11 -0300
Message-ID: <BAY1-F3952C92A967725B708690BA83F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

Hello,

  I am using the kernel 2.6.11.5, with an ACER Aspire 1613Lmi. I fixed my 
DSDT to get it working correctly. But, the suspend button only work once. I 
click on it, then the acpid daemon executes the action. I resume the 
computer and everything is working. But if click at the suspend button again 
nothing happens.
  I stopped the acpid daemon and did a cat /proc/acpi/event, and clicked at 
the suspend button again. Nothing showed up. Normally it should show 
"button/sleep SLPB 00000080 00000001". Also the acpi interrupts are not 
changing when I am clicking the suspend button after the resume. The other 
buttons that are handled by ACPI also don't work. However, the power button 
still works.
   I have the following in my syslog:

kernel: Stopping tasks: 
======================================================================|
kernel:  hwsleep-0306 [35] acpi_enter_sleep_state: Entering sleep state [S3]
kernel: Debug: sleeping function called from invalid context at 
mm/slab.c:2082
kernel: in_atomic():0, irqs_disabled():1
kernel:  [<c01145cc>] __might_sleep+0xac/0xc0
kernel:  [<c01f5c6b>] acpi_ut_trace+0x28/0x2e
kernel:  [<c013aa8b>] kmem_cache_alloc+0x5b/0x60
kernel:  [<c01fd397>] acpi_pci_link_set+0x81/0x263
kernel:  [<c01fda3d>] acpi_pci_link_resume+0x45/0x79
kernel:  [<c01fdab4>] irqrouter_resume+0x43/0x6a
kernel:  [<c023a6b7>] sysdev_resume+0xf7/0xfc
kernel:  [<c023e775>] device_power_up+0x5/0xa
kernel:  [<c012d165>] suspend_enter+0x35/0x50
kernel:  [<c012d205>] enter_state+0x55/0x90
kernel:  [<c012d373>] state_store+0xa3/0xab
kernel:  [<c012d2d0>] state_store+0x0/0xab
kernel:  [<c0184cb6>] subsys_attr_store+0x36/0x40
kernel:  [<c0184f2e>] flush_write_buffer+0x2e/0x40
kernel:  [<c0184f8e>] sysfs_write_file+0x4e/0x80
kernel:  [<c014ee83>] vfs_write+0xc3/0x130
kernel:  [<c014efb7>] sys_write+0x47/0x80
kernel:  [<c0102ddd>] sysenter_past_esp+0x52/0x75
kernel: ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
kernel: ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 10 (level, low) -> IRQ 10
kernel: ACPI: PCI interrupt 0000:03:04.2[C] -> GSI 10 (level, low) -> IRQ 10
kernel: Restarting tasks... done


Thanks,
Paulo

_________________________________________________________________
Chegou o que faltava: MSN Acesso Grátis. Instale Já! 
http://www.msn.com.br/discador



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
