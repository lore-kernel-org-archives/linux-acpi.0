From: boltmelots <boltmelots-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: ERROR - Could not suspend device 0000:00:1d.7: error -5
Date: Sun, 6 Mar 2005 23:20:29 +1100
Message-ID: <9ed79ee0050306042055f815bb@mail.gmail.com>
Reply-To: boltmelots <boltmelots-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

Hi all: 
I have recently installed FC3 on my inspiron 500m.  when I try 'echo
standby > /sys/power/state', I am not able to go into standby.  When I
run dmesg this is the output it produces.  I have no idea what it
means, can someone point me in the right direction please? thank you
very much.
--
Setu.

::::::DMESG OUTPUT:::::
Stopping tasks:
==================================================================================|
Badness in hcd_unlink_urb at drivers/usb/core/hcd.c:1243
 [<02280052>] hcd_unlink_urb+0x18a/0x3ca
 [<02280dd7>] usb_kill_urb+0x11d/0x26a
 [<02209409>] acpi_ut_update_ref_count+0x36/0x45
 [<0220960c>] acpi_ut_update_object_reference+0x1f4/0x22d
 [<02200be4>] acpi_evaluate_object+0x194/0x1a0
 [<0227bef8>] hub_quiesce+0x12/0x49
 [<0227d3fe>] hub_suspend+0x1d/0x79
 [<0227b158>] usb_generic_suspend+0x38/0x3a
 [<02245488>] suspend_device+0x28/0x2f
 [<022454e3>] device_suspend+0x54/0xd8
 [<0213d706>] suspend_prepare+0x48/0x6f
 [<0213d7b3>] enter_state+0x32/0x5e
 [<0213d8bf>] state_store+0x83/0x91
 [<0213d83c>] state_store+0x0/0x91
 [<021aad7b>] subsys_attr_store+0x19/0x21
 [<021aaeee>] flush_write_buffer+0x1d/0x22
 [<021aaf15>] sysfs_write_file+0x22/0x35
 [<021656fa>] vfs_write+0xb6/0xe2
 [<021657c4>] sys_write+0x3c/0x62
PCI: Setting latency timer of device 0000:00:1d.7 to 64
hub 1-0:1.0: hub_port_status failed (err = -19)
hub 1-0:1.0: hub_port_status failed (err = -19)
hub 1-0:1.0: hub_port_status failed (err = -19)
hub 1-0:1.0: hub_port_status failed (err = -19)
hub 1-0:1.0: hub_port_status failed (err = -19)
hub 1-0:1.0: hub_port_status failed (err = -19)
hub 1-0:1.0: reactivate --> -19
ehci_hcd 0000:00:1d.7: HC died; cleaning up
Could not suspend device 0000:00:1d.7: error -5
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:00:1f.5 to 64
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:00:1f.6 to 64
ACPI: PCI interrupt 0000:01:03.0[A] -> GSI 7 (level, low) -> IRQ 7
hub 1-0:1.0: hub_port_status failed (err = -19)
hub 1-0:1.0: hub_port_status failed (err = -19)
hub 1-0:1.0: hub_port_status failed (err = -19)
hub 1-0:1.0: hub_port_status failed (err = -19)
hub 1-0:1.0: hub_port_status failed (err = -19)
hub 1-0:1.0: hub_port_status failed (err = -19)
hub 1-0:1.0: reactivate --> -19
hub 1-0:1.0: hub_port_status failed (err = -19)
hub 1-0:1.0: hub_port_status failed (err = -19)
hub 1-0:1.0: hub_port_status failed (err = -19)
hub 1-0:1.0: hub_port_status failed (err = -19)
hub 1-0:1.0: hub_port_status failed (err = -19)
hub 1-0:1.0: hub_port_status failed (err = -19)
hub 1-0:1.0: reactivate --> -19
hub 2-0:1.0: reactivate --> -22
hub 3-0:1.0: reactivate --> -22
hub 4-0:1.0: reactivate --> -22
Restarting tasks... done


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
