From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: ACPI patch status (2.6)
Date: Mon, 29 Sep 2003 23:53:07 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030929235203.O79536@root.org>
References: <1064902694.2535.159.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1064902694.2535.159.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thanks.  I don't see the patch I submitted (buffer overflow in resource
lists) below.  Is there a good facility where you track patches that I
should submit them instead?

-Nate

On Mon, 30 Sep 2003, Len Brown wrote:
> FYI,
> The following changes are currently in the ACPI test tree
> http://linux-acpi.bkbits.net/linux-acpi-test-2.6.0
> available for testing before push to 2.6.0
>
> The associated plain patches are also available here:
> ftp.kernel.org:/pub/linux/kernel/people/lenb/acpi/patches/test/
>
> Yes, it has been too long since the last push into 2.6.
> The good news is that we'll have finally got 2.6 back in sync with 2.4.
>
> If you seen any regressions, please let me know.
>
> thanks,
> -Len
>
> http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/README.ACPI
>
> ------
>
> ChangeSet-NapXrNxjHSzEb4TTkPOJTA@public.gmane.org, 2003-09-30 01:09:21-04:00, len.brown@intel.com
>   [ACPI] GV3 IO port is 16-bits (Venkatesh Pallipadi)
>
> ChangeSet-NapXrNxjHSzoSwJSnaUrKw@public.gmane.org, 2003-09-30 00:53:46-04:00, len.brown@intel.com
>   [ACPI] acpi_pci_link_allocate() should stick with irq.active if set.
> (Andrew de Quincey)
>   Fixes OSDL #1186 "broken USB" and others
>
> ChangeSet-NapXrNxjHSyhc2M4uTCxZA@public.gmane.org, 2003-09-30 00:15:16-04:00, len.brown@intel.com
>   [ACPI] add CONFIG_ACPI_RELAXED_AML to config menu
>
> ChangeSet-NapXrNxjHSwp2p4RgGY0lw@public.gmane.org, 2003-09-30 00:06:29-04:00, len.brown@intel.com
>   [ACPI] CONFIG_ACPI is no longer necessary to enable HT (from 2.4.23)
>   if (CONFIG_ACPI || CONFIG_SMP) CONFIG_ACPI_BOOT=y
>
> ChangeSet-NapXrNxjHSwCFy6MiDM1gQ@public.gmane.org, 2003-09-29 23:13:34-04:00, len.brown@intel.com
>   [ACPI] ACPI Component Architecture 20030918 (Bob Moore)
>
>   Found and fixed a longstanding problem with the late execution of
>   the various deferred AML opcodes (such as Operation Regions,
>   Buffer Fields, Buffers, and Packages)...
>   This fixes the "region size computed incorrectly" problem.
>
>   Fixed several 64-bit issues with prototypes, casting and data types.
>
>   Removed duplicate prototype from acdisasm.h
>
> ChangeSet-NapXrNxjHSyNbVT0sNCpDA@public.gmane.org, 2003-09-29 12:32:13-04:00, len.brown@intel.com
>   [ACPI] CONFIG_ACPI_RELAXED_AML from 2.4
>   http://bugzilla.kernel.org/show_bug.cgi?id=1248
>
> ChangeSet-NapXrNxjHSyWvgyCK5BHAA@public.gmane.org, 2003-09-25 16:17:01-04:00, len.brown@intel.com
>   [ACPI] For ThinkPad -- carry on in face of ECDT probe failure (Andi
> Kleen)
>
> ChangeSet-NapXrNxjHSz7J4fLV6oaFA@public.gmane.org, 2003-09-23 17:38:00-04:00, len.brown@intel.com
>   [ACPI] remove __initdata from acpi_disabled for module use (Andi
> Kleen)
>
> ChangeSet-NapXrNxjHSxer9vXpyaIOA@public.gmane.org, 2003-09-19 10:22:14-07:00, len.brown@intel.com
>   [ACPI] fix IO-APIC mode SCI storm due to sharing with PCI device
> (David Shaohua Li)
>   http://bugzilla.kernel.org/show_bug.cgi?id=1165
>
> ChangeSet-NapXrNxjHSzBWNZp46sVrw@public.gmane.org, 2003-09-18 20:14:20-07:00, len.brown@intel.com
>   [ACPI] acpi_disabled is used after __initdata is freed.
>   fixes random battery module loading problem -- SuSE bug #30477 (Andi
> Kleen)
>
> ChangeSet-NapXrNxjHSyRBaQiXl/DHw@public.gmane.org, 2003-09-18 16:40:04-07:00, len.brown@intel.com
>   [ACPI] Fix IO-APIC mode SCI interrupt storm on Tyan
>   http://bugzilla.kernel.org/show_bug.cgi?id=774
>
> ChangeSet-NapXrNxjHSwkZRhte9MuKA@public.gmane.org, 2003-09-18 16:22:16-07:00, len.brown@intel.com
>   [ACPI] avoid alloc_bootmem() for accessing ACPI tables
>   some platforms use ACPI tables to find memory (Jesse Barnes)
>
> ChangeSet-NapXrNxjHSx1qXLPWCKRTw@public.gmane.org, 2003-09-18 12:01:37-07:00, len.brown@intel.com
>   ACPI_CA_VERSION                 0x20030916
>
> ChangeSet-NapXrNxjHSyamEhOJLDLTw@public.gmane.org, 2003-09-18 11:59:12-07:00, len.brown@intel.com
>   remove ASUS A7V BIOS version 1011 from blacklist (Eric Valette)
>
> ChangeSet-NapXrNxjHSyxd20e5Us4rQ@public.gmane.org, 2003-09-18 11:41:51-07:00, len.brown@intel.com
>   IBM ThinkPAD T30/T40 oops (David Shaohua Li)
>   https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=98849
>
> ChangeSet-NapXrNxjHSzIn+4bvDfk6g@public.gmane.org, 2003-09-18 11:29:42-07:00, len.brown@intel.com
>   Extended IRQ resource type for nForce (Andrew de Quincey)
>
> ChangeSet-NapXrNxjHSwbpGf+3Q3hGA@public.gmane.org, 2003-09-18 10:58:41-07:00, len.brown@intel.com
>   [ACPI] Handle systems that specify non-ACPI-compliant SCI over-rides
> (Jun Nakajima)
>
> ChangeSet-NapXrNxjHSzxhsza/HYD6Q@public.gmane.org, 2003-09-18 10:54:11-07:00, len.brown@intel.com
>   Handle BIOS with _CRS that fails (Jun Nakajima)
>
> ChangeSet-NapXrNxjHSxtCJruIQNo1w@public.gmane.org, 2003-09-18 00:52:06-04:00, len.brown@intel.com
>   [ACPI] merge 2.4.22 cleanup into 2.6
>   Restores CONFIG_ACPI_HT_ONLY as an alternative to CONFIG_ACPI
>   rather than a prerequisite
>
> ChangeSet-1Cvhk1ijdKctxE93JcnU2Q@public.gmane.org, 2003-09-15 00:34:00-04:00, len.brown@intel.com
>   sync 2.4.22 changes into 2.6
>   Note that this restores CONFIG_ACPI_HT_ONLY as a sub-set of
> CONFIG_ACPI rather than a dependency.
>
>
>
>
>
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
