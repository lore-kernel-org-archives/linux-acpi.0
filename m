From: "Francisco Figueiredo Jr." <fxjrlists-/E1597aS9LRfJ/NunPodnw@public.gmane.org>
Subject: Re: How to control Thermal zone
Date: Mon, 13 Dec 2004 13:01:09 -0200
Message-ID: <41BDAEB5.3040308@yahoo.com.br>
References: <41B8FC12.5090602@yahoo.com.br> <20041210142425.GB3654@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041210142425.GB3654-u08AdweFZfgxtPtxi4kahqVXKuFTiq87@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Pavel Machek wrote:
| Hi!
|
|
|>sorry if this has been already asked,
|>
|>but I'd like to know if is it possible to control thermal zone in
|>order
|>to turn off my laptop fan when I get my login screen.
|>
|>I mean, The fan is being correctly turned on and off but only after
|>getting some threshold. When the laptop is turned on and my thermal
|>zone
|>temp is 35C fan is kept on when it could be turned off.
|>
|>Any tips?
|
|
| You can just echo 1:2:3 > trip_points...
| 				Pavel



What do this do?
I don't know trip_points and what their parameters mean. Could you
explain it, please?

Thanks in advance.

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

iQEVAwUBQb2utf7iFmsNzeXfAQLGRAgAhHklWoS9jkGyjlPghkxTJ15hP7zBaKsK
AleFZH4LYRFVShmi2JPboDZccmvpBuN7hHx8HITzoa4WlIM9U17aG+XMV6es+Dwt
GObb4913EffOvQXSJz/LhMYJhT3hOwiTl3Nv2OwOjStTYiUd6AOI10CAMRg+/2xR
dmKtOIj8QNsCgZB3H8793sUv/osUhvkO+Q95s8ZGmM2qCY16POtHm19OWZluddzj
Q2LNeDz7kQHxRgQr+nMqNsH4JU+WUwihPtTPGBoopXcCwoA+j9gGRS/ccEC7EeqY
jSnTK0JZhqZHLOn2pOusOqKylEFS98UAPibfapRAOR3ws7nlKkpg6Q==
=pdFg
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
