From: "Francisco Figueiredo Jr." <fxjrlists-/E1597aS9LRfJ/NunPodnw@public.gmane.org>
Subject: Re: [PATCH] hysteresis for active cooling
Date: Sun, 31 Jul 2005 22:59:51 -0300
Message-ID: <42ED8217.5080807@yahoo.com.br>
References: <E1DwtK9-000275-00@skye.ra.phy.cam.ac.uk> <Pine.LNX.4.58.0507250950540.4364@nacho>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0507250950540.4364@nacho>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jamie Lentin <lentinj-aI60gWiEnN8g9ELcbhaJlPXRex20P6io@public.gmane.org>
Cc: Sanjoy Mahajan <sanjoy-Bhlo64W4KxTQzY9nttDBhA@public.gmane.org>, "acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jamie Lentin wrote:
>>I don't know for sure, since I don't understand why your system starts
>>active cooling at 52 C (instead of 50 C) -- maybe there's hysteresis
>>in the hardware?  And why does it have to get way down to 44 C instead
>>of only 50 C before turning off?
> 
> 
> There is probably hysteresis built into the DSDT.  The ACPI Spec
> suggests doing this (don't have a page # handy tho', sorry), it's how
> hysteresis is implemented on my laptop (as well as yours---atlhough the
> hysteresis code is probably broken as it was on mine.  I'm preparing a
> page in the DSDT fixes/rewrites I've done on my laptop, if you're
> interested.  Your 600x DSDT code seems pretty much identical to my 770x
> code).
> 
> Basically, whenever there is a change in fan state, the DSDT can trigger
> the OS to re-read the trip-points from the DSDT, and give lower values.
> Again, once the fan turns off, it can tell the OS to re-read, and give
> higher trip-point values.
> 

Ahhhh, nice catch!

I never watched my trip points when fan was on.

This is what I get:
cat /proc/acpi/thermal_zone/THRM/trip_points
critical (S5):           93 C
passive:                 90 C: tc1=2 tc2=3 tsp=100 devices=0xdf6de240
active[0]:               70 C: devices=0xc147fe00
active[1]:               60 C: devices=0xc147ff20
active[2]:               45 C: devices=0xc147ffe0

Indeed, my active[2] was changed to 45 C. As I get my fan turned off
when it reaches 42, 41C I think it has the hysteresis already in my dsdt
as Jamie said. This would explain why values when fan is on or off
changes sometimes. I mean, sometimes my fan starts with 51C, other times
with 52C. The same happens when turning off.

Thanks guys for this one more information.



- --
Regards,

Francisco Figueiredo Jr.
Npgsql Lead Developer
http://gborg.postgresql.org/project/npgsql
MonoBrasil Project Founder Member
http://monobrasil.softwarelivre.org


- -------------
"Science without religion is lame;
religion without science is blind."

                  ~ Albert Einstein
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQEVAwUBQu2CFv7iFmsNzeXfAQKm9gf/dtcvDM7ijfryGUd9uJr/A5HBA178AQ9J
MLDUzoVZBcF09SHLk4Oa6b0rqmMpfXiQ4n+Smai9zhwpysY66pcR8JFXHDqXow+K
xpEAO91aE34VAYObcBS0WTWZd/5AIBDNzztV26Kaykn/Yp8JR618U94kSjU0k/ot
fMqMKJq8IkvsJINxqst6fbHya/IuPSEg1XR6IwAR1DQML3dmXAWFeJiuYx4hrUDd
yGU0rR+H369KzGU8Fqexo+aWPLw3beKcF15EGpYea9fwNNGqixEjbB19Cs7vr7z2
7UAn4ZTIX/aQn8rbsXrcn30jlbXNHIkk3k9ziLBKE6ve1IQxVreeYA==
=VN0U
-----END PGP SIGNATURE-----

	
	
		
_______________________________________________________ 
Yahoo! Acesso Grátis - Internet rápida e grátis. 
Instale o discador agora! http://br.acesso.yahoo.com/



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
