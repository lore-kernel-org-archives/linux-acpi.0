From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH] fix(Fix _STA checking in acpi_bus_add)
Date: Wed, 12 May 2004 15:54:28 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200405121554.28902.bjorn.helgaas@hp.com>
References: <Pine.LNX.4.58.0404281525160.30907@daphne.frec.bull.fr> <1084336805.12353.143.camel@dhcppc4> <1084398577.12352.186.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1084398577.12352.186.camel-D2Zvc0uNKG8@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Simon Derr <Simon.Derr-6ktuUTfB/bM@public.gmane.org>, Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday 12 May 2004 3:49 pm, Len Brown wrote:
> The ACPI spec gurus say that as of 2.0c,
> _STA.functional is meaningless unless _STA.present.
> 
> However, they also say that the (_STA.functional && !_STA.present)
> implementation was intentional -- apparently to trick some OSPM into
> using a resource for initialization only, but to not load
> a driver.

Yup, I think somebody said Windows did something special with
this combination.  Figures.

> I'm advocating that the spec be clarified to explicitly
> allow or disallow this idiom.
> 
> In the mean-time, Bjorn's patch is now present in the acpi-test tree.

Sounds good to me.  Thanks for chasing it down!

Bjorn


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
