From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>
Subject: Re: ACPI Source patches updated (20021022)
Date: Wed, 23 Oct 2002 18:15:24 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021023181524.A13838@sci.fi>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DF60@orsmsx119.jf.intel.com> <20021023110222.A14630@sci.fi> <1035384462.3db6b68e3ca67@webmail.sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1035384462.3db6b68e3ca67-2RFepEojUI03ju2hA3itMQ@public.gmane.org>; from sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org on Wed, Oct 23, 2002 at 03:47:42PM +0100
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?iso-8859-1?Q?S=E9rgio_Monteiro_Basto?= <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 23, 2002 at 03:47:42PM +0100, Sérgio Monteiro Basto wrote:
> Citando Ville Syrjälä <syrjala-ORSVBvAovxo@public.gmane.org>:
> 
> } You didn't pick up my IRQ derive fix. Is it incorrect
> } or did you just
> } miss it?
> 
> In this list it is normal.
> You have to justify what this fix do.

Simply put it fixes the AGP slot's IRQ routing on my Abit KT7 :)

> I try it in my laptop and the IRQ derive warning disappears, 
> but doesn't warranty  that code is correct, so can you explain,
> what is the difference of this code?

The AGP slot doesn't have an entry in the PRT but the AGP bridge does.
Without this change the code gets the devfn field from the bridge which
causes it to think it wants INTB instead of INTA even though the card
wants INTA. The effect of which is one IRQ completely unused and AGP card
sharing it's IRQ with two other PCI cards.

As I said I'm not sure it's correct but I'm pretty confident since the
IO-APIC code uses dev->devfn instead of bridge->devfn.

-- 
Ville Syrjälä
syrjala-ORSVBvAovxo@public.gmane.org
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
