From: Gregory Gulik <greg-eIr5aKVv5JjYtjvyW6yDsg@public.gmane.org>
Subject: Re: Newbie looking to try latest ACPI support...
Date: Mon, 09 Dec 2002 10:12:54 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3DF4B2F6.6070400@gulik.org>
References: <3DF20AB4.3020205@gulik.org> <20021209105144.GB26375@poup.poupinou.org> <3DF4A0F4.6060103@gulik.org> <20021209140714.H20336@parcelfarce.linux.theplanet.co.uk> <3DF4A54F.2030400@gulik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3DF4A54F.2030400-eIr5aKVv5JjYtjvyW6yDsg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


I did that my starting with a clean 2.4.20 kernel, applied the 
acpi-20021205-2.4.20.diff patches, reconfigured my kernel, did the 
correct kernel build procedure.  Everything worked without apparent 
error and I do have files in the acpi driver directory:

[root@toshiba1115 pcmcia-cs-3.2.3]# ls 
/lib/modules/2.4.20/kernel/drivers/acpi/
ac.o  battery.o  button.o  fan.o  processor.o  thermal.o  toshiba_acpi.o


While updating my PCMCIA driver I saw the following errors:

make[2]: Leaving directory `/usr/src/pcmcia-cs-3.2.3/etc/cis'
-> Updating client scripts in /etc/pcmcia
-> Running depmod...
depmod: *** Unresolved symbols in 
/lib/modules/2.4.20/kernel/drivers/acpi/ac.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.20/kernel/drivers/acpi/battery.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.20/kernel/drivers/acpi/button.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.20/kernel/drivers/acpi/fan.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.20/kernel/drivers/acpi/processor.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.20/kernel/drivers/acpi/thermal.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.20/kernel/drivers/acpi/toshiba_acpi.o
make[1]: Leaving directory `/usr/src/pcmcia-cs-3.2.3/etc'
[root@toshiba1115 pcmcia-cs-3.2.3]#

Is this anything to worry about??

Gregory Gulik wrote:
> Maybe I'll just wipe out that directory and start all over with a fresh 
> copy of the kernel sources and acpi patch...

-- 
Greg Gulik                                 http://www.gulik.org/greg/
greg @ gulik.org                           http://www.drivingevents.com/




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
