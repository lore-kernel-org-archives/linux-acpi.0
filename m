From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: patch: acpi-20020821 fix?
Date: Thu, 29 Aug 2002 16:13:51 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020829161351.V28676@parcelfarce.linux.theplanet.co.uk>
References: <15723.8797.507913.189282@marple.lmc.cs.sunysb.edu> <20020829144434.GB246@lilyth.vrlteam>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020829144434.GB246-eODHXEvUBeUUXDL+gvDWyA@public.gmane.org>; from valvoline-FEXhGYRT/JJAfugRpC6u6w@public.gmane.org on Thu, Aug 29, 2002 at 04:44:34PM +0200
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: valvo <valvoline-FEXhGYRT/JJAfugRpC6u6w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Aug 29, 2002 at 04:44:34PM +0200, valvo wrote:
> On Tue, Aug 27, 2002 at 02:55:25AM -0400, Giridhar Pemmasani wrote:
> > -   if (state != ACPI_STATE_S1 || state != ACPI_STATE_S5)
> > +   if (state != ACPI_STATE_S1 && state != ACPI_STATE_S5)

> i don't understand the purpouses of this patch...can you be more explicit, plz ?

think about it... we have:

	if (x != a || z != b)

this is _always_ true.  if x == a then x != b and thus the test always passes
so we return an error.  it's a simple & easy mistake to make.

-- 
Revolutions do not require corporate support.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
