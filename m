From: "Francisco Figueiredo Jr." <fxjrlists-/E1597aS9LRfJ/NunPodnw@public.gmane.org>
Subject: Re: How to control Thermal zone [SOLVED]
Date: Sun, 12 Dec 2004 00:46:39 -0200
Message-ID: <41BBB10F.1060808@yahoo.com.br>
References: <41B8FC12.5090602@yahoo.com.br> <20041210011029.GA28676@zhen-devel.sh.intel.com> <41BB86FA.7040802@yahoo.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41BB86FA.7040802-/E1597aS9LRfJ/NunPodnw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI devel list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: "Wang, Zhenyu" <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Francisco Figueiredo Jr. wrote:
| Wang, Zhenyu wrote:
| |>Hi guys,
| |>
| |>sorry if this has been already asked,
| |>
| |>but I'd like to know if is it possible to control thermal zone in order
| |>to turn off my laptop fan when I get my login screen.
| |>
| |>I mean, The fan is being correctly turned on and off but only after
| |>getting some threshold. When the laptop is turned on and my thermal zone
| |>temp is 35C fan is kept on when it could be turned off.
| |>
| |>Any tips?
| |>
| |
| |
| | Have you loaded acpi fan module? Have you got any device under
| /proc/acpi/fan?
| | Try to trigger on/off to that device.
| |
|
| Hi Wang,
|
| Yes, I get the following under /proc/acpi/fan:
|
| FAN1, FAN2, FAN3.
|
| I played triggering on off on fan.
|
| In fact, I could turn them on! :) I even could check that FAN2 and 3 are
| fan velocities as when I turned them on they did a much higher noise :)
|
| But unfortunately I couldn't turn them off :(
|
| I tried both echo off > /proc/acpi/fan/FAN1 and echo -n 0 >
| /proc/acpi/fan/FAN1, but they only turned it on. I mean, when I do echo
| off, it turns on. So I think that whatever I put is turning them on.
|
| What should I echo to turn them off?
|

After some google, I finally found:

http://www.novell.com/documentation/suse91/suselinux-adminguide/html/ch09s03.html

"Shows if the fan is currently active. The fan can be activated and
deactivated manually by writing 0 (on) or 3 (off) into this file.
However, both the ACPI code in the kernel and the hardware (or the BIOS)
overwrite this setting when it gets too warm."


I thought something like that could be found in acpi.sf.net. What about it?


At least now I can control my cpu fans!! :D

with a single echo -n 3 in the state and it turns off!! Perfect!

Is this the right value? I mean, it worked, but I could be writing some
bogus value. I could confirm that automatic on/off by acpi/bios is
working as usual even when I manually turn it on/off.

Again, tanks Wang, for feedback and tip. ;)


Now, I think I have almost everything from my laptop.

The only missing thing is S4! :)

I'm waiting for 2.6.10 patch of software suspend to come up!
I'm using 2.6.10rc1.


Good work acpi people!

Thank you very much!



- --
Regards,

Francisco Figueiredo Jr.
Membro Fundador do Projeto MonoBrasil - MonoBrasil Project Founder Member
http://monobrasil.softwarelivre.org



- -------------
"Science without religion is lame;
religion without science is blind."

~                  ~ Albert Einstein
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQEVAwUBQbuxD/7iFmsNzeXfAQLk1Af/WYWPrjJOVFIwdQaD5cKwWNgDR801/Cki
QLQvmx0tv6xZUNZ6uZFTPdkqH7l6bVc6fgq6WirXodNogucRzfxsH8ebcoGZj0Yr
sWz9/SOGB02PMIQd6t2Xn9pwBY9UQkFR/z0KNIBmynhsO7gcU4Ec3y/9O+I+QGXD
zEi0hhAVSHdvVJJ1GJVZFIkihNEnuIEsBRpTqXxq01Uh5/JAD92KGVuUfD+2yCa/
5E8SorMZr93MbG+YKG/bqHNYTwiEPLnQ4vaDyhCneDw215H9Ld1EwRFrbyY2P1dS
R2qQ5sM9bw1pk5b9LCsFNF3VX5Yro//fTSd6MjpR2hF+wTQob9xftw==
=9Hfv
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
