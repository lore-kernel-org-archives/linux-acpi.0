From: Mikael Pettersson <mikpe-gJWeRRR3xd2zQB+pC5nmwQ@public.gmane.org>
Subject: Re: IO-APIC on MS-6163 (2.4.23). ACPI?
Date: Wed, 10 Dec 2003 14:40:25 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <16343.8777.389445.2007@alkaid.it.uu.se>
References: <3ACA40606221794F80A5670F0AF15F8401720C15@PDSMSX403.ccr.corp.intel.com>
	<20031210125543.GA1444@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031210125543.GA1444-eRi7t0xs5gloIlNlpBNreQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ryan Underwood <nemesis-lists-RBwgCYbvQ+vk1uMJSBkQmQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Ryan Underwood writes:
 > 
 > Attached dmesg and interrupts with acpi=off.  Also attached kernel
 > config.
 > 
 > As you see, it acknowledges a local APIC but mentions nothing about
 > IO-APIC.  So I guess this isn't ACPI issue after all.  But, I wonder why
 > the IO-APIC isn't being used on this board anymore.  There was a
 > blacklist entry for it, but it was removed after it was discovered to be
 > in error.

Your dmesg log doesn't mention any MP-table. With neither ACPI MADT
nor an MP-table the kernel has no way of knowing about any I/O-APIC.

You do have UP_IOAPIC enabled, so the kernel should look for it.
Please check your BIOS settings, and try with no ACPI at all in the kernel
(just to verify that acpi=off doesn't prevent MP-table parsing).

/Mikael


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
