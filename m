From: James Joseph <jannix97-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI hangs X-Windows with nForce chipset
Date: Sat, 4 Jan 2003 00:38:55 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030104083855.58289.qmail@web13405.mail.yahoo.com>
References: <20030103162335.GB26301@schiggy.intern.quelltext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030103162335.GB26301-dzH3swnhYuu5cqaZGqYS/O8dC6aEkcuFVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Arndt Schoenewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Arndt,
First of all, thanx for such a prompt reply.  With
2.4.20 and acpi-20021212 patch, the system works with
APIC disabled from BIOS!  X-Windows and KDE is stable.
 My system was already stable in text-mode (run level
3).The errors which i obtained before are still
there:-

pci_bind-0191 [05] acpi_pci_bind         : Device
00:00:04.00 not present in PCI namespace
(Anyone know what the above means?!)

and a series of AE_AML_BUFFER_LIMIT conditions.
(Is there anyway to increase the 8 * (HOST BUFFER
size) from 48 to 56?, and will that solve the
problem?)

It seems that the problem is when IO-APIC is used for
IRQ routing.  I greped /usr/src/linux*/drivers/acpi
for AE_AML_BUFFER_LIMIT, and  it seems (from
dispatcher/dsopcode.c, line 496, in function
Acpi_ds_init_buffer_field(...):-

The Host buffer length, buffer_desc->buffer.length =
6, and if it was 7, it should work.(in my case)
Is it possible to increase that buffer, something
tells me it isn't as simple as :-

buffer_desc->buffer.length = 7;         :)

Please understand that i know nothing about what i am
talking about here, so anyone reading this should have
a high stupidity tolerance! Please help if there is an

easy fix to the above.

James Joseph


--- Arndt Schoenewald
<abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org> wrote:
> Hi James,
> 
> does your system work without APIC and IO-APIC
> support enabled in the
> kernel, or with APIC support being turned off in the
> BIOS?
> 
> (I have a SiS650 based machine with a MS-6335E
> mainboard which will
> only boot with either one of the above workarounds.
> It seems that the
> support for APICs and/or IO-APICs is still not 100%
> bugfree.)
> 
> The "Spurious 8259A interrupt : IRQ7" messages
> appear on many machines,
> but seem to be harmless. I don't know what causes
> them.
> 
> Good luck,
> Arndt

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
