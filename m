From: Vishal Verma <vermavee-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: listening for GPEs
Date: 21 Aug 2003 14:04:42 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1061499882.2454.10.camel@dhcp-2-135.bivio.net>
Reply-To: vermavee-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I have a problem related to the propagation of GPEs. In my module, I'm
installing my own GPE handler using acpi_install_gpe_handler() as

acpi_install_gpe_handler(NULL, 8, ACPI_EVENT_EDGE_TRIGGERED, my_handler,
NULL);

my_handler() gets called on arrival of events and it queues a task as:

acpi_disable_gpe(NULL, 8, ACPI_ISR);
acpi_os_queue_for_execution(OSD_PRIORITY_GPE, my_doit_handler, data);

and then my_doit_handler() performs the following tasks:

/* some processing */
acpi_clear_gpe(NULL, 8, ACPI_NOT_ISR);
acpi_enable_gpe(NULL, 8, ACPI_NOT_ISR);


The problem is that the acpi subsystem keeps calling my_handler()
infinitely. The only reason, I think that can happen is that I'm not
able to remove the event from the ACPI event queue. I was thinking
acpi_clear_gpe() would remove it, but it doesn't seem to be doing that.

Can anybody help me here? Any ideas?

thanks
-vish

PS: Please cc me as I'm not a subscriber.





-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
