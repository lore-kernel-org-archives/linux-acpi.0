From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: performance problems?
Date: Tue, 19 Nov 2002 11:22:20 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A520@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'Nils Faerber' <nils-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>, Thomas List <Thomas.List-vA1bhqPz9FBZXbeN9DUtxg@public.gmane.org>
Cc: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Nils Faerber [mailto:nils-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org] 
> > Now could this be a problem with the acpi implementation or is this
> > the result of a wrong usage of acpi?
> 
> I think this is a problem with ACPI...

Yep.

Clearly we are doing something wrong. But, we're not sure what. It only
happens on some systems, so we're kinda in "change something, did that fix
it? no? try this." mode.

We changed mutex handling in the release yesterday - there's a *slight*
chance that was the needed fix. Can you try that patch?

Other than that, maybe the best way is to call
acpi_set_debug(ACPI_DEBUG_HIGH) in the battery driver right before we
evaluate _BIF, and see where it's spending all its time.

Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
