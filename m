From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] fix(Fix _STA checking in acpi_bus_add)
Date: Thu, 29 Apr 2004 20:49:02 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040429184902.GC578@poupinou.org>
References: <Pine.LNX.4.58.0404281525160.30907@daphne.frec.bull.fr> <200404280934.26381.bjorn.helgaas@hp.com> <Pine.A41.4.53.0404291005470.37100@isabelle.frec.bull.fr> <200404290846.41647.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200404290846.41647.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: Simon Derr <Simon.Derr-6ktuUTfB/bM@public.gmane.org>, Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Apr 29, 2004 at 08:46:41AM -0600, Bjorn Helgaas wrote:
> On Thursday 29 April 2004 2:18 am, Simon Derr wrote:
> > On Wed, 28 Apr 2004, Bjorn Helgaas wrote:
> > 
> > > Is your box based on Intel chipsets and/or firmware?  You might be
> > Indeed.
> > 
> > > suffering from the problem I described here:
> > >
> > >     https://sourceforge.net/mailarchive/message.php?msg_id=6923358
> > >
> > > Intel firmware seems to describe the PCI root bridge where chipset
> > > configuration space lives with _STA==0x8.  The spec says this means
> > > "functional, but not present".  The current Linux code ignores things
> > > that are "not present".
> > 
> > I tried your patch and it works perfectly. Thank you.
> > This chipset/firmware is probably very common in the ia64 world so I think
> > it might be a good idea to include your patch in the stock Linux kernel.
> 
> Well, the patch is a gross hack for a special case, and I'd be worried
> about it breaking something related to docking or hotplug.  That's why
> I posted it as "RFC" first, in the hope that someone could explain the
> intent behind the Intel firmware.

Note that my previous post is how I interpret the specs.  I can be
completely wrong, and thinks like breaking docking etc. is only based on
my interpretation.

> Given the current ACPI spec, I'd say it's a bug in the Intel firmware,
> and any workaround should be specific to that firmware.  If Intel
> figures out good semantics for what they're trying to do, I think that
> should be reflected in a future spec.

It's up to real ACPI experts, like Bob, to tell actually what means
exactly that funny 0x8 returned from _STA.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
