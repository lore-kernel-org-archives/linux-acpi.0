From: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Subject: Re: ACPI on the Compaq Presario 2800T
Date: Sat, 27 Jul 2002 12:21:05 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020727102105.GA15370@dutidad.twi.tudelft.nl>
References: <200207260632.g6Q6WsH14921@ikffws2.ikff.uni-stuttgart.de> <200207270043.UAA17797@cathedral-seven.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200207270043.UAA17797-YqEmrenMroz22lVXsKccr97O1rVE3XUg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Sourav K Mandal <smandal-DPNOqEs/LNQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jul 26, 2002 at 08:43:37PM -0400, Sourav K Mandal wrote:
> > I did that, did make mrproper; make dep; make bzImage (kept my
> > modules as they were), now have a file /proc/acpi/sleep, but
> > nothing happens when I echo 1 into this file.
> 
> Same with me.  However, the swsusp patch works now!  And, it's
> much faster than with Windows.
> 
> X is being a little flaky,  but that problem likely has a different
> cause since I also updated my Radeon DRI stuff.  I'll investigate 
> more ...

You can physically NOT suspend from a DRI using X because there is no
functionality at the moment that will re-initialise the Radeon after a
resume.  At the moment, your choices are:
1. run X without DRI (i.e. NO hardware accelerated 3D) and be able to use 
   software suspend.
2. run X with DRI (i.e. with hardware accelerated 3D) but remember not to
   suspend.

The switching to a VT trick does not help with 2.  We are working on a patch
that releases all DRI resources during a VT switch so that it is possible to
suspend from X if no 3D apps are running at that moment.  This means that
one will be able to suspend from DRI X if you stop all 3D apps first.

-- 
charl p. botha http://cpbotha.net/ http://visualisation.tudelft.nl/


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
