From: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Subject: Re: new DRI resume binary snapshots and patches available
Date: 04 Dec 2002 15:11:10 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1039011070.4773.36.camel@dutidad>
References: <20021203232507.GA1723@dutidad.twi.tudelft.nl>
	<1039010406.31730.53.camel@debian.Debian-beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1039010406.31730.53.camel-XpXrOaFReG1A+pMbq6XI4y5m1MAxIYdN@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 2002-12-04 at 15:00, Pere Casta=F1er Sard=E0 wrote:
> One question: I have installed xserver-Xfree86-dri-trunk-2002.11.06-2,
> kernel 2.4.20 with latest drm tree (1.7.0) and the dri patch of
> 20021203. Your new resume patch will work with debian trunk packages?

There should be no problem... it's exactly the same as the dri.sf.net
binaries, except that it has my patch integrated and installs its own
copy of the XFree86, libxaa.a and libpcidata.a binaries as well.  These
have all been built from a 20021203 checkout of the DRI tree.

> PD:Hardware is Radeon M7 LW...with a clevo 5600.

Good laptop... ;)

Good luck,
Charl

ps. You know about the SSE problems in current DRI?  If some of your
applications quit with a FPE, start them with env var MESA_NO_SSE=3D1 ...
this bug manifested after the latest Mesa merge.

--=20
charl p. botha http://cpbotha.net/ http://visualisation.tudelft.nl/


-------------------------------------------------------
This SF.net email is sponsored by: Microsoft Visual Studio.NET 
comprehensive development tool, built to increase your 
productivity. Try a free online hosted session at:
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr0003en
