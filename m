From: "Francisco Figueiredo Jr." <fxjrlists-/E1597aS9LRfJ/NunPodnw@public.gmane.org>
Subject: Turn fan off as soon as turning computer on.
Date: Thu, 11 Nov 2004 22:54:53 -0200
Message-ID: <419409DD.3080507@yahoo.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi all,

I'd like to know how I could turn my laptop fan off when I turn my
computer on.

The fan control of my laptop is almost fully working. The only missing
part is that when I turn my computer on, if the temperature of the
thermal zone is 35 C for example, the fan isn't turned off.

Just when my thermal zone reaches 48 , 50C and goes down to 42, 43 is
that my fan is turned off. Being turned on again when temp gets 48, 50C.

The problem is that as soon as I turn my computer, the thermal is not so
hot and the fan keeps on. Another problem is about the energy saving and
noise. As now with 2.6.9 kernel I could get speedstep to work in my
laptop :) the temp doesn't get high very fast and the cooler will take
too much time to be in the state above when it will be turned off.

Do you know some way I could do to make my fan keeps quiet when I turn
my computer?

I didn't want to say that when I had the other OS installed, it turned
the fan off as soon as the login screen appeared.

Thanks in advance.

Regards,

Francisco Figueiredo Jr.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQEVAwUBQZQJ3f7iFmsNzeXfAQLhwwf/b1IX0C60hExNt/75N8evA6H49EXAX36M
ZPKIIinalSEuMh9Tonu1R/pYEN/Ee3LeyW8WWCKHurYMONmfCCm7QFQB2Cq5Vmne
fSJNLnDHbXWLeLB7qtK3G7KnP3byNhxq2DOpX3m33waYTKfzSn2C64yOSLMh+0p5
IDCKbXLTJYQpCnbGwKkNc7qZmMGIE0wrwLxMRZEwLQh4Mfd3AMB8Y894JTrgZN8T
H0IQUGVbzR6FgCfIqdodIDHtoQCZISlzd42INme1PV703qftUiorGiO2n61G8FQP
UHJEt0Zaq86fzWOoYcW92A6wcmevagVV7aDtAZ6L5j4KxwPGZlYTAg==
=n5lt
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
