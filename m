From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI Source patches updated (20021022)
Date: Wed, 23 Oct 2002 21:47:51 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021023194751.GD5091@poup.poupinou.org>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DF64@orsmsx119.jf.intel.com> <20021023205441.A17325@sci.fi> <20021023182527.GA5091@poup.poupinou.org> <20021023214046.A21758@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021023214046.A21758-ORSVBvAovxo@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, =?iso-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 23, 2002 at 09:40:46PM +0300, Ville Syrjälä wrote:
> On Wed, Oct 23, 2002 at 08:25:27PM +0200, Ducrot Bruno wrote:
> >
> > So I think this is an AML issue.  Your AGP device is actually a
> > bridge and ACPI spec require a _PRT entry for each bridge.
> 
> The DSDT has PCI0._PRT in which 00:01.0 (the AGP bridge) is listed. Are
> you saying that there should also be PCI1._PRT with just one entry for
> 01:00.0? If that were the case there wouldn't be any need to derive the
> IRQ would there?
> 

You should have something like this:

Device(PCI0) {
	Name(..)
	Name (_ADR, 0x00)
	...
	Name (_PRT, Package(...) ) {
		...
	}
	...
	Device (AGP) {
		Name (_ADR, 0x00010000)
		Name (_PRT, Package(1) {
			Package(4) {
				...,
				0x00,
				PATH.TO.LNKA,
				...
			}
		})
		Device (VGA) {
			...
		}
	}
	...

}

If you have Name(_ADR, 0x00010000) for your Device (AGP), it
should ok to add the _PRT entry.  This is also a requirement, but
only for 2.0 specs.

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
