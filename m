From: Arndt Schoenewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>
Subject: Re: No events when pressing power button
Date: Thu, 15 Aug 2002 17:12:50 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020815151250.GC21746@schiggy.intern.quelltext.com>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DD85@orsmsx119.jf.intel.com> <20020813210108.GA11105@digda.intern.quelltext.com> <3D5BAFD5.2030500@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3D5BAFD5.2030500-hi6Y0CQ0nG0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: a.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Andy,

great, another ACPI problem/mystery solved! We are making progress!

Now that we found out that calling eisa_set_level_irq(ACPI_IRQ_NUMBER)
does turn on ACPI event reporting for some machines, would you please
include this call into the ACPI patch proper?

I am really looking forward to the current ACPI implementation making
it into the 2.4 kernel baseline!

Thank you very much for your ongoing efforts!

Arndt


Andy Grover wrote some days ago:
> The problem *may* be that the ACPI interrupt is not being set to
> active-low, level-triggered properly (we do this for PCI irqs but not
> our own ;-)
> 
> Is your acpi interrupt shared with any PCI devices? If the above
> hypothesis is true, the answer should be "no".
> 
> I don't know about people's comfort level with the code, but you might try
> adding a call to eisa_set_level_irq(<ACPI irq #>) and seeing if that gets
> interrupts happening properly.

Arndt Schoenewald wrote yesterday:
> I own one of those machines that need eisa_set_level_irq() for some
> builtin devices, and I have never seen any events coming out of
> /var/log/acpid so far. The ACPI interrupt is not shared with anything.
> 
> So I really guess you are right and eisa_set_level_irq(9) might be
> needed to turn ACPI interrupt reporting on. I'll add this call next
> time I build a kernel.
>
> [The machine is a Gericom 1st Supersonic M6-T (FIC A380 OEM).]

Martin Platter wrote today:
> It works on my Gericom M6T. I have added "eisa_set_level_irq(9);" in the 
> pci_irq.c at line 365.
> Now I get events from LID, Powerbutton and I can even use the special 
> function keys to set the backlight :-)
> 
> Martin


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
