From: "Francisco Figueiredo Jr." <fxjrlists-/E1597aS9LRfJ/NunPodnw@public.gmane.org>
Subject: Re: [PATCH] hysteresis for active cooling
Date: Sun, 24 Jul 2005 01:21:37 -0300
Message-ID: <42E31751.4080802@yahoo.com.br>
References: <E1DwPAQ-0006Oa-FA@approximate.corpus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <E1DwPAQ-0006Oa-FA-BgpFEFc6EmUvjq1vVebcCXE/jYh+Q74khca9k7ZVKlY@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Sanjoy Mahajan <sanjoy-Bhlo64W4KxTQzY9nttDBhA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Sanjoy Mahajan wrote:
> My laptop's fan was turning on and off as the temperature crossed the
> active trip point.  The patch below adds hysteresis: It turns off active
> cooling only when the temperature falls, say, 2 C below the trip point.
> Maybe the magic difference should be 5 degrees; I'd be curious what
> setting suits people best.
> 


Hi Sanjoy.

How do I know what temperature active cooling will be turned off?

Currently as I type that, my system starts active cooling when it
reaches 52 C and turns off when it reaches 44.


I have the following as my trip_points:

cat /proc/acpi/thermal_zone/THRM/trip_points
critical (S5):           93 C
passive:                 90 C: tc1=2 tc2=3 tsp=100 devices=0xdf6de280
active[0]:               70 C: devices=0xc147de20
active[1]:               60 C: devices=0xc147df40
active[2]:               50 C: devices=0xc147d120

In my system, what your patch would do? Will it turn off fan when it
reach 42, instead of actual 44?

Thanks in advance. And sorry for boring you with these questions. I'm
very interested in fan management in my laptop, since I had a challenge
of knowing how to turn it on and off manually :)



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

iQEVAwUBQuMXUf7iFmsNzeXfAQKEMAf+OEVWUHpkgczonoRTn3KX7IOXv3lDjdVz
25DsFSR7lcMQ6t+6AzX1x1eN8IPtd8jPo2n0uE8Q66t/TNY/7ERtqxpqnDiGLPYr
p7rXR+BfG3in/ZGdqKOclnfDhEVQLy8LLuyARRwVAlVdbnPeOjLRNkUZ2ElQNKW8
C/IUU7MzkrmtYutfQZRrwOS/rWA+o2GmnNtGQFTgNDhIM4H3ZnT6Kwt74Ramfsd2
mXJM9iq7AlBZxwQUBp3nSwVVYUfUX7NX/lPaOIdi7Fx2F3cYCEa+4ww9kUuW2uhs
9RF29dJf9vAflfrtKzWODU/aAukYTCawqkPxMOcLusodEFPS4k5lbg==
=ulkU
-----END PGP SIGNATURE-----

	
	
		
_______________________________________________________ 
Yahoo! Acesso Grátis - Internet rápida e grátis. 
Instale o discador agora! http://br.acesso.yahoo.com/



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
