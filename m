From: "Antonio G. - Geotronix" <antonio-OL5acaPONM41GQ1Ptb7lUw@public.gmane.org>
Subject: Is it possibile that ACPi messes my battery ...
Date: Tue, 1 Oct 2002 02:16:56 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021001001656.GC9965@geolandia.home>
Reply-To: antonio-OL5acaPONM41GQ1Ptb7lUw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline; filename="msg.pgp"
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

I don't know if something like this is possible however I don't think so
but yet I will ask the same. I have noticed that in a few month, without
any heavy duty, my Li-ion battery for my Preassrio 710EA has declined in
full capacity. While the cat of /proc/acpi/battery/BAT0/state has always
told me that "design capacity: 53280 mWh" the "last full capcity:" has
declined from "43200 mWh" to the now "26669 mWh".

As a matter of fact even though 2-3 months ago ACPI was loseing
interupts and was heating lot more than now (now there aren't lost
interupt any more and the fan is almost always off) the battery would
last some 1h 10min but now I only get 1h durability while I should
almost be getting 2 hours as I've measured some 6000mWh drop every
15min. (on low use, C2 proc state and T0) (7x6000=42000 for 1h45min
durability). I seem to be getting the same durabilty and charge
capacity also under winXP so I think the problem is OS independent. I
presume the life span of my battery has dropped in so short time (3
months max):

a) because the battery is faulted (most presumable)
b) bad ACPI (old pathes, the june-july patches) messed the battery?????

Thanks

BTW. I bought the laptop only 6 months ago so if I have to claim
garantee on the battery I have to be sure on what I'm saying.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Per informazioni si veda http://www.gnupg.org

iD8DBQE9mOl4IRaQQEznKxURAp04AJ4+EEN1Ef88tpPlTLLsYgy+0HguBgCeP5XR
dtUzDfZwuxugYar3XApdcT4=
=j65i
-----END PGP SIGNATURE-----


-------------------------------------------------------
This sf.net email is sponsored by: DEDICATED SERVERS only $89!
Linux or FreeBSD, FREE setup, FAST network. Get your own server 
today at http://www.ServePath.com/indexfm.htm
