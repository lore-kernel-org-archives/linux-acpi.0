From: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: [PATCH] /sys/firmware/acpi/memory/ for showing info of ACPI
 memory object
Date: Fri, 17 Sep 2004 01:00:54 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040917010054.0000603a.tokunaga.keiich@jp.fujitsu.com>
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB007B6FA60@fmsmsx406.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <D36CE1FCEFD3524B81CA12C6FE5BCAB007B6FA60-oCDej+MBycNZtRGVdHMbwrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Tolentino, Matthew E" <matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, haveblue-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 16 Sep 2004 07:07:07 -0700, Tolentino, Matthew E wrote:
> >I have changed the patch to create directories and files in
> >/sys/firmware/acpi/memory/ from Dave's comments.  The files are
> >to export the following stuffs of each ACPI memory object for the
> >first version.
> 
> Hmm.  I thought Dave's suggestion was to create an arch-agnostic
> viewpoint of physical memory and dump it into 
> /sys/devices/system/memory in order to gain consistency between
> arches...  

Yes, that is also his suggestion.  I understand that we have agreedthere are
arch-specific and agnostic 
Actually, the patch is to create
just arch-specific directory, since he has agreed with it.

> ># ls /sys/firmware/acpi/memory/MEM1/
> >address_length
> >address_translation_offset
> >granularity
> >max_address_fixed
> >max_address_range
> >min_address_fixed
> >min_address_range
> >producer_consumer
> >resource_type
> 
> For my understanding, what exactly are all of these attributes for?
> 
> matt


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
