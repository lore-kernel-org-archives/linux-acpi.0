From: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Subject: Re: ACPI Compaq Presario
Date: Mon, 29 Jul 2002 23:54:58 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020729215458.GA2312@dutidad.twi.tudelft.nl>
References: <000001c23742$9e9ec650$9865fea9@AMAINSLT> <200207292121.RAA17223@cathedral-seven.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200207292121.RAA17223-YqEmrenMroz22lVXsKccr97O1rVE3XUg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jul 29, 2002 at 05:21:46PM -0400, Sourav K Mandal wrote:
> * Suspend to disk and sleep on lid-closing works, 
> provided X has only run w/o DRI since the last 
> power up; once you fire up X w/ DRI enabled, neither
> will work unless you reboot.

Sorry for plugging this, but I need victims^H^H^H^H^H^H^Htesters for my
kludge.  Maybe one day it'll become a feature.  Your 2800 has a Radeon,
which is good, and probably an intel 845 chipset, which is even better.

http://cpbotha.net/dri_reinit_kludge.html has patches (and binaries) so that
the Radeon DRI drivers release DRM/AGP resources across VT switches if no 3D
apps are running at that moment.  This means if you have a chvt before
suspend, resuming will work.

These patches also include (just like DRI CVS) our fixes for the Radeon DRI
VT (console) switch bug.

Regards,
Charl

-- 
charl p. botha http://cpbotha.net/ http://visualisation.tudelft.nl/


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
