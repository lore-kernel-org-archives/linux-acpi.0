From: Pedro Venda <pjlv-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>
Subject: Re: first shoot for smartbattery (was Re: Re: i2c-acpi-ec.c)
Date: Sat, 01 Jan 2005 17:05:23 +0000
Message-ID: <41D6D853.30209@mega.ist.utl.pt>
References: <20041231092156.GA612@phys.ethz.ch> <41D56002.5060008@mega.ist.utl.pt> <20041231150724.GK19199@poupinou.org> <20041231181628.GL19199@poupinou.org> <20050101082605.GA24896@phys.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050101082605.GA24896-vpGm2Noi6jeZvKxeG3EEhw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Mathias Weyland <mweyland-vpGm2Noi6jeZvKxeG3EEhw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Mathias Weyland wrote:

>>You can find this at http://www.poupinou.org/acpi/smartbatt/
>>Take one of the smartbatt.tar.{gz,bz2} and follow the README after
>>unpacking it, and hopefully a ./smartbatt will give you correct battery
>>informations (who knows).
>=20
>=20
> Ok, here's what's happening:
>=20
> corcovado:/usr/src/smartbatt# ./smartbattery
> Error: No i2c-bus specified!
> Syntax: smartbatt I2CBUS
>   Installed I2C busses:
>     i2c-1       unknown         ACPI EC SMBus adapter at 0018
> Algorithm unavailable
>     i2c-0       unknown         SMBus I801 adapter at 1880
> Algorithm unavailable
> corcovado:/usr/src/smartbatt# ./smartbattery  1
> current:       65535 mA
> remain:        65535 mA or mWh
> time to empty: 65535 minutes
> time to full:  65535 minutes
> temperature:   6280.5 C
> voltage:       65535 mV

same here.

>=20
> The values are wrong, but I guess you helped me a lot. I'll dive into t=
he
> code this afternoon and I'll try to nail down the problem. As for now, =
what
> I can tell you is that the base address has been detected correctly. Fr=
om my
> dsdt.asl:
>=20
>                     Device (SMBC)
>                     {
>                         Name (_HID, "ACPI0001")
>                         Name (_EC, 0x1820)
>                         Device (SBS0)
>                         {
>                             Name (_HID, "ACPI0002")
>                             Name (_SBS, 0x01)
>                         }
>                     }
>=20
>=20
> Loading the module shows:
>=20
> i2c_acpi_ec: disagrees about version of symbol struct_module
> base: 0x18    alert: 0x20
> i2c-acpi-ec.c: ACPI EC SMBus adapter at 0x18

same here.

>=20
> So at least that is working.
>=20
> But something puzzeled me a bit:
>=20
> corcovado:/home/lea# i2cdetect 1
> WARNING! This program can confuse your I2C bus, cause data loss and wor=
se!
> I will probe file /dev/i2c-1.
> I will probe address range 0x03-0x77.
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 70: XX XX XX XX XX XX XX XX
>=20
> At least the output differs from what Pedro (IIRC) got in October.

same here. now I get the same as you.

>=20
> Regards & thank you very much for the effort!

indeed! thanks for the very helpful work with the driver.


regards,
pedro venda.
--=20

Pedro Jo=E3o Lopes Venda
email: pjlv-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org
http://arrakis.dhis.org


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
