From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: first shoot for smartbattery (was Re: Re: i2c-acpi-ec.c)
Date: Fri, 31 Dec 2004 20:09:07 +0100
Message-ID: <20041231190907.GM19199@poupinou.org>
References: <20041231092156.GA612@phys.ethz.ch> <41D56002.5060008@mega.ist.utl.pt> <20041231150724.GK19199@poupinou.org> <20041231181628.GL19199@poupinou.org> <41D59F15.2030504@tiscali.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <41D59F15.2030504-IWqWACnzNjyZIoH1IeqzKA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?iso-8859-1?Q?Fran=E7ois?= Valenduc <fvalenduc-IWqWACnzNjyZIoH1IeqzKA@public.gmane.org>
Cc: Pedro Venda <pjlv-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>, Mathias Weyland <mweyland-vpGm2Noi6jeZvKxeG3EEhw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Dec 31, 2004 at 07:48:53PM +0100, Fran=E7ois Valenduc wrote:
> Hello,
>=20
> Since I own a ACER Travelmate 4001 which has a smartbattery, I tried=20
> this driver. Everythings works well until I try to compile=20
> smartbattery.c. If I launch the gcc command like explained in the READM=
E=20
> file, here is what I get:
>=20
> gcc -W -Wall -O2 -o smartbattery smartbattery.c
> smartbattery.c: Dans la fonction =AB main =BB:
> smartbattery.c:274: attention : implicit declaration of function `ioctl=
'
> smartbattery.c:274: error: `I2C_FUNCS' undeclared (first use in this=20
> function)
> smartbattery.c:274: error: (Each undeclared identifier is reported only=
 once
> smartbattery.c:274: error: for each function it appears in.)
> smartbattery.c:280: error: `I2C_FUNC_SMBUS_READ_WORD_DATA' undeclared=20
> (first use in this function)
> smartbattery.c:290: error: `I2C_SLAVE_FORCE' undeclared (first use in=20
> this function)

I missed up some include in /usr/local/include/linux installing latest
lm-sensors I guess...  Sorry.  I don't have time to fix this properly.

Please refetch (will contain now the include I'm using) and do a
$ gcc -W -Wall -I./include -O2 -o smartbattery smartbattery.c

You need only this latest step.

Cheers,

--=20
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
