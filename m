From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI Source patches updated (20021022)
Date: Thu, 24 Oct 2002 20:07:39 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021024180739.GB8003@poup.poupinou.org>
References: <72B3FD82E303D611BD0100508BB29735046DFF44@orsmsx102.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <72B3FD82E303D611BD0100508BB29735046DFF44-LkGsggTGxVkSgA9wuWY2vVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Lee, Jung-Ik" <jung-ik.lee-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: 'Ducrot Bruno' <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, =?iso-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Oct 24, 2002 at 10:04:29AM -0700, Lee, Jung-Ik wrote:
> 
> > > > >
> > > > > So I think this is an AML issue.  Your AGP device is actually a
> > > > > bridge and ACPI spec require a _PRT entry for each bridge.
> > > > 
> > 
> > I should read a little bit more specs.  A _PRT entry is required
> > only for root bridges.
> > 
> _PRT could be in non root bridges.

Of course.  'required' is the keyword, here.

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0003en
