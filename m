From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: unused exports in acpi
Date: Mon, 1 Nov 2004 14:12:47 +0100
Message-ID: <20041101131247.GA8938@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

There's some acpi exports that seems to be unused, could someone who's
able to read the drivers/acpi/ mess doublecheck the list below?

acpi_acquire_global_lock
acpi_bus_receive_event
acpi_clear_event
acpi_dbg_layer
acpi_dbg_level
acpi_disable_event
acpi_enable_event
acpi_enter_sleep_state
acpi_enter_sleep_state_s4bios
acpi_get_next_object
acpi_get_possible_resources
acpi_get_sleep_type_data
acpi_get_system_info
acpi_get_timer
acpi_get_timer_duration
acpi_get_type
acpi_install_address_space_handler
acpi_install_gpe_block
acpi_os_create_semaphore
acpi_os_delete_semaphore
acpi_os_printf
acpi_os_read_pci_configuration
acpi_os_signal
acpi_os_signal_semaphore
acpi_os_sleep
acpi_os_stall
acpi_os_wait_semaphore
acpi_pci_irq_enable
acpi_release_global_lock
acpi_remove_address_space_handler
acpi_remove_gpe_block
acpi_set_current_resources
acpi_strict
acpi_ut_debug_print_raw


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
