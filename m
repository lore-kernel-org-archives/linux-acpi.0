From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>
Subject: Re: ACPI Source patches updated (20021022)
Date: Thu, 24 Oct 2002 20:15:18 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021024201518.A2708@sci.fi>
References: <20021023110222.A14630@sci.fi> <Pine.LNX.4.44.0210241017560.6574-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44.0210241017560.6574-100000-+ltLZMaECS1Ps8vDFOCQiqGgjKF21WCF@public.gmane.org>; from kai-germaschewski-Q3dYeWy5uxSHXe+LvDLADg@public.gmane.org on Thu, Oct 24, 2002 at 10:29:04AM -0500
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Kai Germaschewski <kai-germaschewski-Q3dYeWy5uxSHXe+LvDLADg@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Oct 24, 2002 at 10:29:04AM -0500, Kai Germaschewski wrote:
> Well, this patch is obviously not correct, consider the case where the 
> loop is executed more than once.
> 
> I think it should be
> 
> 	while (!irq && bridge->bus->self) {
> 		pin = (pin + PCI_SLOT(bridge->devfn)) % 4;
> 		bridge = bridge->bus->self;
> 		irq = acpi_pci_irq_lookup(0, bridge->bus->number, PCI_SLOT(bridge->devfn), pin);
> 	}

Yes I see the logic in that. But I don't know enough about PCI to relly
understand how things work. Over one iteration this does exactly what my
patch did and that's what I care about :) Is it even realistic to expect
that multiple bridges are lined up so that the loop would get executed
more than once?

-- 
Ville Syrjälä
syrjala-ORSVBvAovxo@public.gmane.org
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0003en
