From: Pedro Venda <pjlv-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>
Subject: Re: Re: No battery information on a ACER Travelmate 4001LMi
Date: Mon, 08 Nov 2004 15:30:01 +0000
Message-ID: <418F90F9.40602@mega.ist.utl.pt>
References: <418A81FC.9030001@tiscali.be> <418A8315.50208@tiscali.be> <47e0449d04110705534dd09447@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <47e0449d04110705534dd09447-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: Johannes Kuhlmann <jkuhlmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Johannes Kuhlmann wrote:
| Hi,
|
| I have the same problem with an Acer Travelmate 4001LCi. What I have
| been able to find out so far is, that these laptops feature a 'smart
| battery'. For these battery there is currently no driver, but Shaohua
| Li from this list considers writing one. I would be very grateful, if
| you really do this :).
| I tried the driver from ftp://ftp.poupinou.org/acpi/i2c-acpi-ec.c. It
| correctly detects the battery, but tells me that there is no module
| 'smartbatt'. I guess this is the intended behaviour.
| If there is something I can do in order to get a driver for my smart
| battery (provide information, test drivers, ...), just tell me.

I have a travelmate 4001WLMi. I didn't see Shaohua Li offering to do
such drivers, but he sure gave me some useful tips. I will be trying
also when there is some spare time. So far i read some ACPI
specification and practised some very simple kernel modules while
reading Robert Love's book about kernel development.

the driver you pointed was written by bruno ducrot and he abandoned it
because:
"1- I haven't real use for it (I searched actually something else,
~   related to the LCD backlight at that time),
2- it's very slow compared to a well wrotten EC firmware which will
~   cache the information needed for batteries and expose them in the EC
~   register space, so I thought no bios developper would use this at
least for modern laptops."

I don't think the driver can actually talk to the battery however I was
able to detect it on the smbus.

the lmsensors team have some support for smart batteries. I don't know
if it has a bright future (as ducrot's driver), but it's a start. I'll
be checking it out too, but I would prefer to develop a kernel driver
according to Li's tips.

regards,
pedro venda.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBj5D5eRy7HWZxjWERAnWGAKCqh5oprCHkKED+7ZRH+0vXhPxofgCdHeUg
5V65FKmVUxW6IbsIoTTkjU0=
=ru5L
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
