From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: 2.6.9rc2-mm4 oops
Date: Fri, 1 Oct 2004 09:04:52 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200410010904.52892.bjorn.helgaas@hp.com>
References: <1096571653.11298.163.camel@cmn37.stanford.edu> <200409301704.28573.bjorn.helgaas@hp.com> <1096594616.11297.688.camel@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1096594616.11297.688.camel-+OMRr5b1p0xegcJQxxnBRDe48wsgrGvP@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Fernando Pablo Lopez-Lezcano <nando-l0SEpsmuUtBegcJQxxnBRDe48wsgrGvP@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mingo-X9Un+BFzKDI@public.gmane.org, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Bernhard Rosenkraenzer <bero-9zdaV+82baBg9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thursday 30 September 2004 7:36 pm, Fernando Pablo Lopez-Lezcano wrote:
> On Thu, 2004-09-30 at 16:04, Bjorn Helgaas wrote:
> > Like Pierre, I was able to reproduce this with DEBUG_PAGEALLOC.
> > I found a struct acpi_driver in hpet.c that was erroneously marked
> > __init, and the attached patch fixed the oops for me.  Can you give
> > this a whirl?
> 
> Sorry, I did, and still get the oops. This is it this time (looks the
> same to me):
> 
> inserting floppy driver for 2.6.8.1-1.520.1nov.rhfc2.ccrma
> Unable to handle kernel paging request at virtual address f8881920

Can you post your .config?  If you don't have CONFIG_HPET turned
on, my patch wouldn't help.  Also, can you look up the bad address
(e.g., f8881920) in /proc/kallsyms?  When I reproduced it, the
faulting address was hpet_acpi_driver.  Maybe you've found a
similar bug in a different driver.



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
