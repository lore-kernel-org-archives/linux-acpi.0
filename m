From: Kevin Fenzi <kevin-acpi-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: Compaq Presario 2800T
Date: Wed, 7 Aug 2002 16:46:43 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020807224648.5744.qmail@scrye.com>
References: <200208010551.BAA23125@biohazard-cafe.mit.edu>
	<20020803220614.21895.qmail@scrye.com>
	<1028528792.7332.14.camel@anodyne.mandal>
	<20020805150428.10039.qmail@scrye.com>
	<1028614416.4553.3.camel@localhost.localdomain>
	<20020806081618.GA7148@dutidad.twi.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020806081618.GA7148-V1rPnKwUOrA59+mn7qD7y50iERQUc4G+@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Charl" == Charl P Botha <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org> writes:

Charl> FWIW, my dim/bright keys (Fn-F6 and Fn-F6) always work and the
Charl> brightness level is even retained across reboots.  The binaries
Charl> on http://cpbotha.net/dri_reinit.html have been updated,
Charl> although I doubt that thet changes have to do with your
Charl> brightness settings.

Well, I finally got around to upgrading to the newest one there (got
some more memory for the laptop and had to reboot anyhow)... 

I also did some debugging... 

The Fn f7 (dim) and Fn-f8 (brighten) and Fn-F4 (monitor) all work fine
when I first boot up. They also work fine if I start X with no DRM. If
I start X with drm, then they stop working and won't work again until
I reboot. 

Any ideas? Could be a XFree86 version problem? 

I am running RedHat limbo with XFree86-4.2.0-56 + your drm_reinit
modules. 

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.6 and Gnu Privacy Guard <http://www.gnupg.org/>

iD8DBQE9UaNX3imCezTjY0ERAonrAJ9Gr62NIEG0iuDZKCUxpJq1EFMQpQCfcdua
hcd+BNZvpMsThcef+qLBs2U=
=/WtP
-----END PGP SIGNATURE-----


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
