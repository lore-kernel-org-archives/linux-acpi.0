From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>
Subject: Re: ACPI Source patches updated (20021022)
Date: Wed, 23 Oct 2002 21:41:59 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021023214159.B21758@sci.fi>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DF63@orsmsx119.jf.intel.com> <20021023183646.GB5091@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021023183646.GB5091-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>; from ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org on Wed, Oct 23, 2002 at 08:36:46PM +0200
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, =?iso-8859-1?Q?S=E9rgio_Monteiro_Basto?= <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


On Wed, Oct 23, 2002 at 08:36:46PM +0200, Ducrot Bruno wrote:
> On Wed, Oct 23, 2002 at 10:11:52AM -0700, Grover, Andrew wrote:
> > I didn't think video needed an IRQ.
> 
> Please look at
> drivers/char/drm/drm_dma.h
> drivers/char/drm/radeon_irq.c
> 
> for examples.

In my case the cause is DirectFB.

-- 
Ville Syrjälä
syrjala-ORSVBvAovxo@public.gmane.org
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
