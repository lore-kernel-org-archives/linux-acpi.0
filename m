From: Dominik Brodowski <devel-JhLEnvuH02M@public.gmane.org>
Subject: Re: IRQ problem with LNKG
Date: Mon, 16 Sep 2002 23:09:43 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020916230943.C2247@brodo.de>
References: <8FD16F6B8AC4B6499BE151D339AEEFD60534FF@vie-dc1.vienna.ucpag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8FD16F6B8AC4B6499BE151D339AEEFD60534FF-6kLr0Tm+v0hgSZZmzADRUiFVQ3g8EIah@public.gmane.org>; from max.demmelbauer-z3Qmyc3n39kAvxtiuMwx3w@public.gmane.org on Fri, Sep 13, 2002 at 12:07:50PM +0200
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Max Demmelbauer <max.demmelbauer-z3Qmyc3n39kAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Max,

It seems like the IRQ 9 specified in the DSDT (or selected among several
possible ones) for LNKG isn't really "allowed" for that USB device -- 
causing it to break either when setting it, or when trying to access it.

What is the /proc/interrupts for a non-ACPI (or otherwise "working" kernel)?
Specifically, what IRQ is assigned to your second USB controller? [Looks
like it is IRQ 10] You might want to override the acpi_pci_link_set call 
to set LNKG to this (working) IRQ (10?) instead of IRQ 9 (as it seems you're 
more familiar with kernel hacking than DSDT hacking). Alternatively, you can 
adjust the _PRS (possible resource settings) for the LNKG device in the DSDT. 

> is there a way to set a specific interrupt in the dsdt.asl for
> LNKG(which??)
best thing would be to just state one possible IRQ (the one found in the
non-ACPI kernel for the 2nd USB device) in the _PRS for LNKG.

>, or should i hack the kernel???
> and what is LNKG used for???
That depends on your system. You can check the _PRT (pci routing table) for
this.

>    do i need this part, what is \_OSI ?? find nothing in ACPI
> documentation
unfortunately, I don't know whether you need this part; but _OSI seems to be
a method which looks up what Operating System is running. And certain
features might be disabled if you use the "wrong" OS... [at least that seems
to be the case in the DSDT on my notebook].

	Dominik


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
