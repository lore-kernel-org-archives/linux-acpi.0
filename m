From: ming-Csh58dz32nSZ9vWoFJJngh2eb7JE58TQ@public.gmane.org
Subject: Asus P4SP-MX can not reboot
Date: Thu, 9 Sep 2004 17:50:19 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040909095019.GA2187@ming.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Dear All,

I have a new machine. Basically linux runs on it does not have problem.
The only one problem is reboot. After "reboot" is issued, everything
seems ok, until the message "Restarting System.". After showing this
message, the system does not reboot. It just stoped. 

I think it may be the problem of ACPI subsystem. This system can not
reboot and poweroff, before update the kernel. After upgraded the kernel
to 2.4.27, this system can be shutdown, but reboot still fail. I am sure
the APM does not in use. The dmesg show me that :

zone(1): 53244 pages.zone(2): 0 pages.
ACPI: RSDP (v000 ASUS                                      ) @0x000f5520
ACPI: RSDT (v001 ASUS   P4SP-MX  0x42302e31 MSFT 0x31313031) @0x0dffc000
ACPI: FADT (v001 ASUS   P4SP-MX  0x42302e31 MSFT 0x31313031) @0x0dffc0c0
ACPI: BOOT (v001 ASUS   P4SP-MX  0x42302e31 MSFT 0x31313031) @0x0dffc030
ACPI: MADT (v001 ASUS   P4SP-MX  0x42302e31 MSFT 0x31313031) @0x0dffc058
ACPI: DSDT (v001   ASUS P4SP-MX  0x00001000 MSFT 0x0100000b) @0x00000000


If this is really ACPI problem, what can I help to solve the
problem (such as what information I have to provide) ?


PS: The motherboard is Asus P4SP-MX. BIOS is updated to the latest
version.

Regards,
Ming


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
