From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [Discontig-devel] RE: Cleanup of NUMA support in ACPI
Date: Mon, 19 Aug 2002 10:33:46 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DDAE@orsmsx119.jf.intel.com>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "'KOCHI, Takayoshi'" <t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org, "'martin.bligh=r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org'" <martin.bligh-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> From: KOCHI, Takayoshi [mailto:t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org] 
> Here's the patch.
> This is generated against 2.5.30 kernel's driver.
> For 2.4.18 + 20020725, I saw faiures against Config.in and Makefile...
> perhaps it's easy to merge.
> 
> 
> For discontig/numa developers:
> 
> If this is applied, both i386 and ia64 have to provide their own
> functions in architecture-dependent numa support (only when 
> CONFIG_NUMA and
> CONFIG_ACPI_NUMA are both Y):

The strange thing is that ia32 doesn't have CONFIG_NUMA, it has
CONFIG_MULTIQUAD. Are these equivalent, or more importantly, do they imply
the use of SLIT and SRAT?

For now I'll just apply this, and we can sort out the details later. :)

Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
