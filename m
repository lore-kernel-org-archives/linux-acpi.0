From: Dave Hansen <haveblue-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: RE: [Lhms-devel] [PATCH] ACPI based Memory Hotplug
	DriverPatch
Date: Thu, 09 Sep 2004 11:33:20 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1094754799.29990.94.camel@nighthawk>
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB007A6C485@fmsmsx406.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <D36CE1FCEFD3524B81CA12C6FE5BCAB007A6C485-oCDej+MBycNZtRGVdHMbwrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew E Tolentino <matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "S, Naveen B" <naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, keith <kmannth-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lhms <lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2004-09-09 at 11:28, Tolentino, Matthew E wrote:
> >What does this end up naming the module?  If it ends up being memory.o,
> >you might want to think about making it something a bit more
> >descriptive.  Does it even need to be allowed to be a module, 
> >or is that
> >standard ACPI practice?
> 
> Currently, it names it memory.ko.  Len has also suggested that it be
> something more like memory_hotplug.ko or memory_hp.ko or something
> like that, because the ACPI spec does include verbage about the
> system memory map...  As this driver does handle "memory"
> devices, it kinda makes sense, but we're not wed to any particular 
> name...  ;-)  

How about including acpi in the name?  acpi_memory.o? 
acpi_memhotplug.o?

> >Other than the add/remove_memory() calls does this have any real
> >interaction with any non-ACPI code that I overlooked?
> 
> Nope, the only real interaction with the VM is isolated to those 
> calls.  This driver is really only for handling the interaction 
> with real hardware via ACPI, so it shouldn't need to muck around 
> with other code...  

Cool.  Looks pretty good.

-- Dave



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
