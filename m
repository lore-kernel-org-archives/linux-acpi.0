From: Anil Mamede <amak-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>
Subject: ACPI Problems
Date: Tue, 05 Oct 2004 11:31:53 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <41627819.6070104@mega.ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi. My computer is:
- Athlon Barton 2600+
- Asus NFORCE2 chipset
- 512 Mb
- Kernel 2.4.27

Im trying to have ACPI. First i compiled battery, thermal, processor, 
etc.. in modules but when i do modprobe processor for example it show this:


/lib/modules/2.4.27/kernel/drivers/acpi/processor.o: 
/lib/modules/2.4.27/kernel/drivers/acpi/processor.o: unresolved symbol 
acpi_bus_generate_event
/lib/modules/2.4.27/kernel/drivers/acpi/processor.o: 
/lib/modules/2.4.27/kernel/drivers/acpi/processor.o: unresolved symbol 
acpi_os_free
/lib/modules/2.4.27/kernel/drivers/acpi/processor.o: 
/lib/modules/2.4.27/kernel/drivers/acpi/processor.o: unresolved symbol 
acpi_bus_get_device
/lib/modules/2.4.27/kernel/drivers/acpi/processor.o: 
/lib/modules/2.4.27/kernel/drivers/acpi/processor.o: unresolved symbol 
acpi_set_register
/lib/modules/2.4.27/kernel/drivers/acpi/processor.o: 
/lib/modules/2.4.27/kernel/drivers/acpi/processor.o: unresolved symbol 
acpi_root_dir
/lib/modules/2.4.27/kernel/drivers/acpi/processor.o: 
/lib/modules/2.4.27/kernel/drivers/acpi/processor.o: unresolved symbol 
acpi_install_notify_handler
/lib/modules/2.4.27/kernel/drivers/acpi/processor.o: 
/lib/modules/2.4.27/kernel/drivers/acpi/processor.o: unresolved symbol 
acpi_extract_package
/lib/modules/2.4.27/kernel/drivers/acpi/processor.o: 
/lib/modules/2.4.27/kernel/drivers/acpi/processor.o: unresolved symbol 
acpi_evaluate_object
/lib/modules/2.4.27/kernel/drivers/acpi/processor.o: 
/lib/modules/2.4.27/kernel/drivers/acpi/processor.o: unresolved symbol 
acpi_bus_register_driver
/lib/modules/2.4.27/kernel/drivers/acpi/processor.o: 
/lib/modules/2.4.27/kernel/drivers/acpi/processor.o: unresolved symbol 
acpi_fadt
/lib/modules/2.4.27/kernel/drivers/acpi/processor.o: 
/lib/modules/2.4.27/kernel/drivers/acpi/processor.o: unresolved symbol 
acpi_get_register
/lib/modules/2.4.27/kernel/drivers/acpi/processor.o: 
/lib/modules/2.4.27/kernel/drivers/acpi/processor.o: unresolved symbol 
acpi_evaluate_integer
/lib/modules/2.4.27/kernel/drivers/acpi/processor.o: 
/lib/modules/2.4.27/kernel/drivers/acpi/processor.o: unresolved symbol 
acpi_bus_unregister_driver
/lib/modules/2.4.27/kernel/drivers/acpi/processor.o: 
/lib/modules/2.4.27/kernel/drivers/acpi/processor.o: unresolved symbol 
acpi_get_handle
/lib/modules/2.4.27/kernel/drivers/acpi/processor.o: 
/lib/modules/2.4.27/kernel/drivers/acpi/processor.o: unresolved symbol 
acpi_remove_notify_handler
modprobe: insmod /lib/modules/2.4.27/kernel/drivers/acpi/processor.o failed
modprobe: insmod processor failed


If i compile the modules inside the kernel if i do cat 
/proc/acpi/processor/limit for example i have:

not supported

What is wrong?

More Info:

$ cat /proc/acpi/info
version:                 20040326
states:                  S0 S1 S4 S4Bios S5


$ cat /proc/acpi/sleep
S0 S1 S4 S4Bios S5

Anil Mamede


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
