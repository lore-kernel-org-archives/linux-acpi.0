From: Sourav K Mandal <smandal-DPNOqEs/LNQ@public.gmane.org>
Subject: Re: Re: Compaq Presario 2800T
Date: Wed, 07 Aug 2002 18:57:25 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200208072257.SAA04328@magic-pi-ball.mit.edu>
References: <20020807224648.5744.qmail@scrye.com>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: Your message of "Wed, 07 Aug 2002 16:46:43 MDT."
             <20020807224648.5744.qmail-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Kevin Fenzi <kevin-acpi-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> The Fn f7 (dim) and Fn-f8 (brighten) and Fn-F4 (monitor) all work fine
> when I first boot up. They also work fine if I start X with no DRM. If
> I start X with drm, then they stop working and won't work again until
> I reboot. 

Exactly what I'm getting, but with stock DRI modules.

> Any ideas? Could be a XFree86 version problem? 

Unforunately, not really.  :-(

My (layman's) guess is that it has something to do with the GPU's
power state.  The BIOS won't shut down the LCD until it's
satisfied with the Radeon's power state; once DRM is used
 the Radeon cannot enter an acceptable power state.

This is the inverse of the DRI-on-resume problem, that once
the Radeon is shutdown w/o reset, the DRM "parts" don't 
wake up properoly.


Sourav


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
