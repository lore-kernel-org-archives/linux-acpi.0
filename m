From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [bug] endless loop in arch/i386/kernel/mpparse.c
Date: Mon, 30 Sep 2002 10:59:43 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DEDD@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "'Bjoern A. Zeeb'" <bzeeb-lists-mt/InyFV0sMN6vK3N8ee0qxOck334EZe@public.gmane.org>, Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: Linus Torvalds <torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Bjoern A. Zeeb [mailto:bzeeb-lists-mt/InyFV0sMN6vK3N8ee0qxOck334EZe@public.gmane.org] 
> > buggy MADT, but let's not _crash_ when the vendor provides 
> a shit BIOS.
> 
> the other thing that I was thinking of is: entry is icremented by 8
> but to reach madt_end we need to do another 494 increments. As I am
> not really in that code I ask myself what is in that struct. If I
> remember correctly 309 objects, ... were found; far not that much ...
> (assumtion that we walk through them).
> This, with the entry->header.length being zero I think (repeating
> myself) madt_end may be wrong ?

I cribbed this code from table.c acpi_table_parse_madt_family, which works
fine.

Some change must have screwed something up for this to be hanging...

Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
