From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: Re: fan control based on temp
Date: Mon, 14 Jun 2004 10:01:37 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40CD5B61.301@pca.it>
References: <1087114303.21682.2.camel@nazgul.overridex.net> <20040613151023.GA27597@hell.org.pl> <1087164672.3696.1.camel@nazgul.overridex.net> <20040614070038.GA18816@message-id.gmane0305.slipkontur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040614070038.GA18816-l0tNAEGuAhhzZ8+rp42Dbp9+tswZ0GTaehPwdyo5hKaELgA04lAiVw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 06/14/04 09:00, Stefan Seyfried wrote:
> On Sun, Jun 13, 2004 at 06:11:12PM -0400, Dan wrote:
>> Ok, maybe that didn't fix it - or at least I've run into another
>> problem.  Sometimes it's saying that the fan's on:
>> Thermal 1: active[0], 59.0 degrees C
> Where du you get this info from? /proc/acpi/thermal_zone/*/trip_points?
I think it's from 'acpi' [1]:
=====
luca-HSB4nKSusd8@public.gmane.org:~$ acpi -V
     Thermal 1: ok, 52.0 degrees C
  AC Adapter 1: on-line

luca-HSB4nKSusd8@public.gmane.org:~$ acpi -v
acpi 0.07

Copyright (C) 2001 Grahame Bowland.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
====

Thx, bye,
Gismo / Luca

[1] http://grahame.angrygoats.net/acpi.shtml
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAzVtgVAp7Xm10JmkRAnpRAJ0acc+H2JuiW841X491+gAdOJg2ywCfYlWx
XENvsE3FiCVjVLbWp1uPkPA=
=1Fb5
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
