From: "KOCHI, Takayoshi" <t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>
Subject: Re: 2.4 patch updated
Date: Wed, 21 Aug 2002 13:46:02 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020822054600.FAFUC0A82650.6C9EC293@mvf.biglobe.ne.jp>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DDBD@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DDBD-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


On Wed, 21 Aug 2002 11:05:24 -0700
"Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> Third time's the charm, right?
> 
> I just uploaded the revised 2.4.20-pre4 patch to sf.net, the one that
> actually includes the 20020815 core.
> 
> ;-)

I've found some files degraded(?)

		2.5.31-0815	2.4.20-pre4-0821
ac.c		27		26
acpi_ksyms.c	16		15
battery.c	37		36
acpi_bus.c	80		77
button.c	30		29
dbdisasm.c	67		50  <= ***
fan.c		29		28
osl.c		83		80
power.c		39		38
processor.c	71		69
system.c	63		57
thermal.c	41		40
utils.c		10		8

most of these changes from 2.4 -> 2.5 are just branching
so it's okay, but dbdisasm.c seems wrong anyway.
Per branching 2.4-tree and 2.5-tree, how do you keep track
of changes common to both tree (not a serious question, I'm just
curious) ?

driver.c/os.c are not deleted by the patch.

Thanks,
-- 
KOCHI, Takayoshi <t-kouchi-f7IHDacdhdx8UrSeD/g0lQ@public.gmane.org/t-kouchi>



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
