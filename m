From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>
Subject: Re: ACPI Source patches updated (20021022)
Date: Wed, 23 Oct 2002 20:54:41 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021023205441.A17325@sci.fi>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DF64@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DF64-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>; from andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org on Wed, Oct 23, 2002 at 10:17:57AM -0700
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: =?iso-8859-1?Q?S=E9rgio_Monteiro_Basto?= <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 23, 2002 at 10:17:57AM -0700, Grover, Andrew wrote:
> > > From: Ville Syrjälä [mailto:syrjala-ORSVBvAovxo@public.gmane.org] 
> > That said, I'll put this in the next release and we can see 
> > what happens. If
> > people want to try this in the meantime, that would be great, too.
> 
> Wait a second. Looking at the calling code (acpi_pci_irq_enable) we check
> the device itself for PRT entries there, so we shouldn't have to also do
> this in pci_irq_derive, which only gets called if there aren't any found for
> the device.

I'm not sure what you're saying. There isn't an entry in the PRT for the
AGP device so the derive code will look at the bridge's entry. But the
code gets the pin number wrong. It should be looking at A while
it's looking at B. But still the driver code doesn't care what the ACPI
code things so eventually INTA of the card will be assigned to the IRQ
found. Now if I were to attach a card to PCI1 things might become weird.
The AGP card would get one IRQ and the PCI card other even though both
share the INTA line. I'm no expert but I'm pretty sure that would cause
problems.

-- 
Ville Syrjälä
syrjala-ORSVBvAovxo@public.gmane.org
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
