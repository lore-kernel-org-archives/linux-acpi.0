From: Bernhard Rosenkraenzer <bero-9zdaV+82baBg9hUCZPvPmw@public.gmane.org>
Subject: Re: 2.6.9rc2-mm4 oops
Date: Sun, 17 Oct 2004 18:14:59 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200410171815.00274.bero@arklinux.org>
References: <1096571653.11298.163.camel@cmn37.stanford.edu> <200410011633.10171.bjorn.helgaas@hp.com> <200410071431.20400.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200410071431.20400.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: Fernando Pablo Lopez-Lezcano <nando-l0SEpsmuUtBegcJQxxnBRDe48wsgrGvP@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mingo-X9Un+BFzKDI@public.gmane.org, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thursday 07 October 2004 22:31, Bjorn Helgaas wrote:

> > I looked at all the callers of acpi_bus_register_driver(), and
> > they all look fine (except the hpet one I found yesterday).  But
> > maybe there's something I missed, or maybe the acpi_bus_drivers
> > list got corrupted somehow.
> >
> > If you don't load the floppy driver, is the system stable?
>
> Any update on all this?  I've tried to reproduce the problem on
> my Athlon box, but so far I've been unsuccessful.

Tried a couple of boxes (with versions up to 2.6.9-rc4-mm1), it appears to be 
100% reproducable on boxes that don't have a floppy drive while it works ok 
on boxes that do have a floppy drive.

The system still works reliably after the oops btw.

LLaP
bero


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
