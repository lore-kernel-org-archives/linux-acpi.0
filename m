From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Changing temperature trip points
Date: Fri, 8 Nov 2002 10:25:04 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021108092504.GB29848@atrey.karlin.mff.cuni.cz>
References: <E187ipj-0001ss-00@usw-sf-list2.sourceforge.net> <000001c28231$b7cae110$c200a8c0@pikachu> <20021105164048.GF18318@schiggy.intern.quelltext.com> <1036741506.3dcb6b824e289@sbox.tugraz.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1036741506.3dcb6b824e289-ArvQUR6U0fYD0fefG/KofA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Maier Gerfried <moali-ArvQUR6U0fYD0fefG/KofA@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> [...]
> > Just FYI, "on" and "off" are not the right keywords here:
> > 
> >     echo >/proc/acpi/fan/FAN0/state 0		turns the fan on
> >     echo >/proc/acpi/fan/FAN0/state 3		turns the fan off
> > 
> > (On my machine, though, 3 doesn't turn the fan off, but makes it run
> > slower and thus more quiet.)
> 
> Does this mean, that there shold be /proc/acpi/fan/... present in the latest 
> acpi (kernel 2.4.20-rc1)?
> 
> Well, unfortunately I do not have it :-(
> (fan-module seems to be loaded without any problems - meaning: error messages; 
> acpi-debug enabled)

We are talking 2.5.X here.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.


-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
