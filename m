From: David Sun <sun.david-rLkRBNOhmFMIhP1ydL5T/A@public.gmane.org>
Subject: undefined reference to `acpi_pci_link_exit'
Date: 15 Dec 2004 17:45:30 +0800
Message-ID: <1103103930.2245.235.camel@outfox>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

hi acpi developers

Sorry if this question's already been addressed somewhere else I don't
know.

Several days ago, I could compile 2.4.26 with acpi support and button
support built in; then patched it with ext2 compression patch and some
littile hacks (which I don't think is acpi related, so not listed); then
I'd like to recompile the kernel, but ended with:

drivers/acpi/acpi.o(.text.exit+0x17): In function `acpi_bus_exit':
: undefined reference to `acpi_pci_link_exit'
drivers/acpi/acpi.o(.text.exit+0x1c): In function `acpi_bus_exit':
: undefined reference to `acpi_ec_exit'
make: *** [vmlinux] Error 1

through some search, I found acpi_pci_link_exit is indeed only declared
but not defined in source code, which accounts for the linking error.
But why did it compile several days ago? How do I tackle this problem?
I am sure there is something I missed, just point it out to me please :)

thanks in advance
David




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
