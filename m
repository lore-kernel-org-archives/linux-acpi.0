From: Fernando Pablo Lopez-Lezcano <nando-Q5CBQdYaXkCY9Qp+Rujo2eW1CriLhL8O@public.gmane.org>
Subject: Re: 2.6.9rc2-mm4 oops
Date: 07 Oct 2004 14:09:46 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1097183386.3310.261.camel@cmn37.stanford.edu>
References: <1096571653.11298.163.camel@cmn37.stanford.edu>
	 <1096653158.7485.17.camel@cmn37.stanford.edu>
	 <200410011633.10171.bjorn.helgaas@hp.com>
	 <200410071431.20400.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200410071431.20400.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mingo-X9Un+BFzKDI@public.gmane.org, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Bernhard Rosenkraenzer <bero-9zdaV+82baBg9hUCZPvPmw@public.gmane.org>, Fernando Pablo Lopez-Lezcano <nando-Q5CBQdYaXkCY9Qp+Rujo2eW1CriLhL8O@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2004-10-07 at 13:31, Bjorn Helgaas wrote:
> On Friday 01 October 2004 4:33 pm, Bjorn Helgaas wrote:
> > On Friday 01 October 2004 11:52 am, Fernando Pablo Lopez-Lezcano wrote:
> > > On Fri, 2004-10-01 at 08:04, Bjorn Helgaas wrote:
> > > >  Also, can you look up the bad address
> > > > (e.g., f8881920) in /proc/kallsyms? 
> > > 
> > > This is what I find:
> > > f8880f80 ? __mod_vermagic5      [xor]
> > > f8880fcd ? __module_depends     [xor]
> > > f8881000 t acpi_button_init     [button]
> > > f8881000 t init_module  [button]
> > > f8884000 t xor_pII_mmx_2        [xor]
> > > f8884130 t xor_pII_mmx_3        [xor]
> > 
> > You are remembering that /proc/kallsyms isn't sorted, right?
> > 
> > If you still can't match the address to anything interesting,
> > can you see whether it's related to any of the other modules
> > (i.e., see whether it happens even if you don't load any of
> > the other ACPI drivers, or try leaving out any other drivers
> > you can get along without)?  Maybe try loading an ACPI driver
> > other than floppy, at the same point in the module load sequence,
> > to see if the problem is specific to floppy, or if floppy is
> > just an innocent bystander?
> > 
> > I looked at all the callers of acpi_bus_register_driver(), and
> > they all look fine (except the hpet one I found yesterday).  But
> > maybe there's something I missed, or maybe the acpi_bus_drivers
> > list got corrupted somehow.
> > 
> > If you don't load the floppy driver, is the system stable?

Even if I load it (unsuccesfully - there's actually no floppy) the
system _appears_ to be fine. If I remember correctly this happens in the
context of device discovery (kudzu). 

> Any update on all this?  I've tried to reproduce the problem on
> my Athlon box, but so far I've been unsuccessful.

Sorry for the delay, too busy as usual. 

BTW, what I sent was actually sorted. I'll see if I can get more
information later today (I have not forgotten). 

-- Fernando




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
