From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] fix(Fix _STA checking in acpi_bus_add)
Date: Thu, 29 Apr 2004 10:44:36 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040429084436.GA578@poupinou.org>
References: <Pine.LNX.4.58.0404281525160.30907@daphne.frec.bull.fr> <20040428142557.GB22558@parcelfarce.linux.theplanet.co.uk> <Pine.A41.4.53.0404281637220.37100@isabelle.frec.bull.fr> <200404280934.26381.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200404280934.26381.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
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

On Wed, Apr 28, 2004 at 09:34:26AM -0600, Bjorn Helgaas wrote:
> On Wednesday 28 April 2004 8:53 am, Simon Derr wrote:
> > On Wed, 28 Apr 2004, Matthew Wilcox wrote:
> > 
> > > Sounds like you have a bug.  Why does your firmware not report that the
> > > device is present?
> > >
> > Yes there is very probably some firmware bug involved, and as a matter of
> > fact we happen to have a 16-way system where the 0xff bus is visible even
> > with recent kernels.
> 
> Is your box based on Intel chipsets and/or firmware?  You might be
> suffering from the problem I described here:
> 
>     https://sourceforge.net/mailarchive/message.php?msg_id=6923358
> 
> Intel firmware seems to describe the PCI root bridge where chipset
> configuration space lives with _STA==0x8.  The spec says this means
> "functional, but not present".  The current Linux code ignores things
> that are "not present".
> 
> Nobody cared enough to do anything about this issue at the time, so
> it is still broken.  I did raise the issue with our ACPI representative,
> but I don't know what happened.  I'd like to see some clarification in
> the spec.
> 

This is only my interpretation of the specs but I think that if bit3 is
set, then that mean the device have been checked at POST time.
But if bit0 is cleared also, that mean that the device is not present,
so far it may be indication of an event like unplugging a laptop from a
station (for example), or a pci card removed in a hotplug system, etc.

Note that even if there is somehow a way to say, hey, that device is
present (via for example a RELAX rule), there is still the problem of
bit1 (device decode ressources, which could be cleared if for example
the device is set to a low power mode).

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
