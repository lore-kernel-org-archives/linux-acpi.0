From: Heiko Ettelbrueck <hbruckynews-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Kernel with acpi hangs on compaq presario 1700
Date: Sat, 14 Dec 2002 21:46:00 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3DFB9888.2050803@gmx.net>
References: <200212142221.15212.hogenberg11@zonnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200212142221.15212.hogenberg11-RSh1/+X/PmFmR6Xm/wNWPw@public.gmane.org>
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

Hi Jaap,

if you don't want to use ACPI because of its IRQ routing, you could 
simply try adding "pci=noacpi" at the boot prompt (or into lilo.conf / 
grub's menu.lst) for your acpi kernel and try once again. I have a 
Compaq Evo N160 and had the same problem (hang during boot) before I 
tried the above kernel option.

I also got the advice to disable "Local APIC" and "SMP Support" in the 
kernel configuration, but this didn't help in my case. Perhaps it will 
in your one?

Regards,
Heiko

Jaap Hogenberg wrote:
> Hi,
> 
> I'm new to this list so forgive me if this is a FAQ:
> 
> I'm tried kernel 2.4.20 with the acpi patches of 12052002 and 12122002
> as well as a 2.5.51 with and without patch (12132002) and when I include
> acpi support , the kernel will hang when probing the PCI bus.
> 
> I have seen references about acpi on compaq laptops indicating that it needed
> some tweaking (dumping acpi tables to a file) but as these were 
> very old postings to linux-kernel mailing list , and the answers there
> were quite inconclusive I thought I'd ask here.
> 
> Is there some (recent :-) ) documentation on getting acpi working
> on this laptop ? 
> Or is there anything else I should try in my kernel config ?
> 
> Regards,
> 
> Jaap 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:
> With Great Power, Comes Great Responsibility 
> Learn to use your power at OSDN's High Performance Computing Channel
> http://hpc.devchannel.org/
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
