From: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Subject: Re: "irq 11: nobody cared" after S3
Date: Tue, 03 Aug 2004 11:32:18 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <410FB002.5030907@optonline.net>
References: <200408011850.25991.stefandoesinger@gmx.at> <410DC163.1090109@optonline.net> <200408031629.19466.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200408031629.19466.stefandoesinger-RbZlAiThDcE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: stefandoesinger-RbZlAiThDcE@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Stefan Dösinger wrote:
[snip]
>>Does kernel command line "acpi=noirq" help?
> 
> 
> Yes it does. Sorry for not mentioning this. I used pci=noacpi the last few 
> weeks. This makes the wireless card use IRQ 10
> It doesn't work very well thought, the IRQ10 and IRQ5 are unstable and the 
> wireless and the sound block each other(Both IRQ 10), as well as USB and 
> ethernet(IRQ 5). Additionally, DRI is unstable after resume.
> 
> I modified my DSDT to use IRQ 10 for LNKE, and that makes my system work 
> perfectly. Is this a workaround or can I consider this a solution. The 

This is a workaround. The ultimate solution is to have Linux restore the 
IRQ routing upon resume from S3. There is not yet a clear consensus 
about whether this needs to be done through the chipset drivers or the 
ACPI BIOS routines...

IMO, we need to make the ACPI BIOS IRQ routing code compatible with the 
non-ACPI IRQ routing code. This means that either they both should run 
only at boot/resume, or they both should NOT. Right now they are 
inconsistent...

> problem is, that half my hardware uses irq10 while the irqs 4,6,7,11,14 and 
> 15 are unused.
> Shall I upload my modified dsdt? I think so.

the ultimate solution is IRQ restore on resume. Your modified DSDT isn't 
really guaranteed to do the right thing for everyone forever, it just 
hardwires certain interrupts that Linux might want to dynamically assign 
in some circumstances...



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
