From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: 2.4 patch updated
Date: Wed, 21 Aug 2002 14:15:18 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DDC3@orsmsx119.jf.intel.com>
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
To: "'KOCHI, Takayoshi'" <t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: KOCHI, Takayoshi [mailto:t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org] 
> I've found some files degraded(?)
> 
> 		2.5.31-0815	2.4.20-pre4-0821
> ac.c		27		26
> acpi_ksyms.c	16		15
> battery.c	37		36
> acpi_bus.c	80		77
> button.c	30		29
> dbdisasm.c	67		50  <= ***
> fan.c		29		28
> osl.c		83		80
> power.c		39		38
> processor.c	71		69
> system.c	63		57
> thermal.c	41		40
> utils.c		10		8
> 
> most of these changes from 2.4 -> 2.5 are just branching
> so it's okay, but dbdisasm.c seems wrong anyway.

dbdisasm.c is no longer needed, and so should be deleted from both 2.4 and
2.5. The same with driver.c and os.c. Their existence shouldn't hurt
anything so their removal can wait until the next substantive release.

Updates to the interpreter aren't branched, but all the files in
drivers/acpi are completely separate between 2.4 and 2.5. Obviously I'd love
to stop updating both, but that's just not possible yet.

> Per branching 2.4-tree and 2.5-tree, how do you keep track
> of changes common to both tree (not a serious question, I'm just
> curious) ?
> 
> driver.c/os.c are not deleted by the patch.

I apply fixes in both trees. No other way, AFAICS. Using BK makes this
easier, but obviously things slip through, so I really do appreciate you
mentioning things as you find them. Thanks.

(BTW I put your numa patch in 2.5, did you want it in 2.4 as well?)

Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
