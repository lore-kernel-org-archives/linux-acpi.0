From: Gregory Gulik <greg-eIr5aKVv5JjYtjvyW6yDsg@public.gmane.org>
Subject: Re: Newbie looking to try latest ACPI support...
Date: Mon, 09 Dec 2002 09:14:39 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3DF4A54F.2030400@gulik.org>
References: <3DF20AB4.3020205@gulik.org> <20021209105144.GB26375@poup.poupinou.org> <3DF4A0F4.6060103@gulik.org> <20021209140714.H20336@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021209140714.H20336-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Of course.
I just ran it again just now for about the tenth time and still no go. 
Here's the relavant part of the output from "make modules_install":

make[1]: Entering directory `/usr/src/linux-2.4.20/drivers'^M
make -C acpi modules_install^M
make[2]: Entering directory `/usr/src/linux-2.4.20/drivers/acpi'^M
make[2]: Nothing to be done for `modules_install'.^M
make[2]: Leaving directory `/usr/src/linux-2.4.20/drivers/acpi'^M
make -C atm modules_install^M

Yet that directory does seem to contain the files:

[root@toshiba1115 linux-2.4.20]# ls drivers/acpi/
Config.in       battery.c    executer   ospm         resources
Makefile        blacklist.c  fan.c      parser       system.c
ac.c            bus.c        hardware   pci_bind.c   tables
acpi.o          button.c     include    pci_irq.c    tables.c
acpi_bus.h      dispatcher   namespace  pci_link.c   thermal.c
acpi_drivers.h  driver.o     numa.c     pci_root.c   toshiba_acpi.c
acpi_ksyms.c    ec.c         os.o       power.c      utilities
acpi_ksyms.o    events       osl.c      processor.c  utils.c
[root@toshiba1115 linux-2.4.20]#


Maybe I'll just wipe out that directory and start all over with a fresh 
copy of the kernel sources and acpi patch...


Matthew Wilcox wrote:
> did you run `make modules_install'?
> 

-- 
Greg Gulik                                 http://www.gulik.org/greg/
greg @ gulik.org                           http://www.drivingevents.com/




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
