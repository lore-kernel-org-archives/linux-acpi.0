From: Arndt Schoenewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>
Subject: Re: Changing temperature trip points
Date: Fri, 8 Nov 2002 12:01:17 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021108110117.GB29469@schiggy.intern.quelltext.com>
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

On Fri, Nov 08, 2002 at 08:45:06AM +0100, Maier Gerfried wrote:
> Zitiere Arndt Schoenewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>:
> 
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

Yes, /proc/acpi/fan/... should be present, also in 2.4.x kernels; I had
it all the time since 2.4.18+acpi-20020329 (the first Linux+ACPI kernel
I put on my then brandnew Gericom M6-T laptop). I haven't tried kernel
2.4.20-rc1 yet, though.

Are you using the ACPI patch from http://sf.net/projects/acpi?

Of course the fan can only be controlled through ACPI if there is a fan
and it is listed correctly in the ACPI description tables. This is
typically the case for laptops and notebooks (but not for all of them),
and typically not the case for desktop machines.

Arndt


-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
