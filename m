From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: ThinkPad A30 vs. 2.6.3rc2 - ACPI errors on boot
Date: Tue, 17 Feb 2004 10:24:13 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040217102318.L30108@root.org>
References: <20040217154218.GH1696@perlsupport.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040217154218.GH1696-R2BnnNewRl46W4JZGn+SJw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Chip Salzenberg <chip-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 17 Feb 2004, Chip Salzenberg wrote:
> (I don't know if SourceForge is broken temporarily or permanently, but
> I was unable to find list archives.  So I can't see whether anyonee
> else has reported these issues, or read any answers unless I'm copied.)
>
> Booting with ACPI in kernel 2.6.3rc2 on a ThinkPad A30 (2652-36U)
> produces these errors.  Most things seem OK at runtime, except of
> course that there's no working suspend, which is a killer.  :-(
>
> =====================================================================================
> ACPI: RSDP (v002 IBM                                       ) @ 0x000f7440
> ACPI: XSDT (v001 IBM    TP-1E    0x00001152  LTP 0x00000000) @ 0x27f6f070
> ACPI: FADT (v001 IBM    TP-1E    0x00001152 IBM  0x00000001) @ 0x27f6f0b4
> ACPI: SSDT (v001 IBM    TP-1E    0x00001152 MSFT 0x0100000d) @ 0x27f6f168
> ACPI: ECDT (v001 IBM    TP-1E    0x00001152 IBM  0x00000001) @ 0x27f79f87
> ACPI: BOOT (v001 IBM    TP-1E    0x00001152  LTP 0x00000001) @ 0x27f79fd8
> ACPI: DSDT (v001 IBM    TP-1E    0x00001152 MSFT 0x0100000d) @ 0x00000000
> ACPI: Subsystem revision 20040116
> ACPI: IRQ9 SCI: Level Trigger.
> ACPI: Found ECDT
> ACPI: Could not use ECDT

You need to figure out why the ECDT can't be used.  That is what is
generating these errors as accesses to EC space fail.

-Nate


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
