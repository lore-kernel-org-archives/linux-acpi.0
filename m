From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>
Subject: Re: patch: acpi-20020821 fix?
Date: Thu, 29 Aug 2002 18:20:33 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020829182033.A23001@sci.fi>
References: <15723.8797.507913.189282@marple.lmc.cs.sunysb.edu> <20020829144434.GB246@lilyth.vrlteam>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
> >     /* only support S1 and S5 on kernel 2.4 */
> > -   if (state != ACPI_STATE_S1 || state != ACPI_STATE_S5)
> > +   if (state != ACPI_STATE_S1 && state != ACPI_STATE_S5)
> >         return AE_ERROR;
>
> i don't understand the purpouses of this patch...can you be more explicit, plz ?

Looks clear to me. Without this change the condition is always true.

-- 
Ville Syrjälä
syrjala-ORSVBvAovxo@public.gmane.org
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
