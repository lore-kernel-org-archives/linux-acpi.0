From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: acpi on toshiba satellite 1625CDT
Date: Fri, 28 Mar 2003 19:59:47 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030328185947.GE5147@zaurus.ucw.cz>
References: <200303251447.12168.mark@ale8.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200303251447.12168.mark-pX1FbxK42pU@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Mark Stocker <mark-pX1FbxK42pU@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> state of the lid and power button, thermal zone seems to work, sleep doesnt 
> seem to work as it should but this doesnt bother me.  Battery info appears 
> incorrect as it will show a battery even when the battery is removed.  Ac 
> power is correctly read.
> I would greatly appreciate any help!!  Compiling acpi without fan support 
> doesnt help, the fan still gets stuck on.  Is there anyway around this other 
> than disabling acpi completly causing the lid switch problem?
> 

Look at thermal zone info, try echo 3
> /proc/acpi/fan/PFAN/state (IIRC).
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
