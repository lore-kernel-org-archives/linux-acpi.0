From: keith <kmannth-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: RE: Re: [Lhms-devel] [PATCH 1/1]  patch to
	fixacpi_memhotplug.c
Date: Fri, 18 Nov 2005 12:01:40 -0800
Message-ID: <1132344100.3798.151.camel@knk>
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB00BA21FE8@fmsmsx406.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <D36CE1FCEFD3524B81CA12C6FE5BCAB00BA21FE8-oCDej+MBycNZtRGVdHMbwrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Tolentino, Matthew E" <matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu-+CUm20s59erQFUHtdCDX3A@public.gmane.org>, Yasunori Goto <y-goto-+CUm20s59erQFUHtdCDX3A@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "S, Naveen B" <naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, external hotplug mem list <lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2005-11-18 at 06:29 -0800, Tolentino, Matthew E wrote:
> keith <mailto:kmannth-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org> wrote:
> > Well I can tell you I never see the
> > 
> > printk(KERN_INFO "%s \n", acpi_device_name(device));
> > 
> > from acpi_memory_device_add when I call acpi_bus_add.  I am really
> > trying not to dig around in the acpi generic code.....  I might have
> > time to have a look at the generic acpi code tomorrow....
> > 
> > Is this driver know to work on any hardware?
> > 
> Hi Keith:
> 
> Yes, it works on Intel's E8500 chipset based platforms that support
> hot-add/remove.  I've been wrapped in some other things lately,
> but I'll take a closer look at this shortly... 


It appears my SSDT is triggering on the string Windows 2001 for my _STA
method to return correctly. sigh.... I will get that fixed and report
back. 

thanks, 
keith <kmannth-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
