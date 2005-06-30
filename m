From: DJAX <djax-whniv8GeeGkdnm+yROfE0A@public.gmane.org>
Subject: Re: No fan control on an Acer Aspire 1694WLMi
Date: Thu, 30 Jun 2005 23:33:04 +0200
Message-ID: <42C46510.8050309@altern.org>
References: <42C07327.3000209@altern.org> <20050628202209.GA30464@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050628202209.GA30464-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Pavel Machek a =E9crit :

>Hi!
>
> =20
>
>>At the boot, the fan doesn't start immediately, then it start at fisrt
>>speed. After a moment the fan rotates at full speed, but never goes
>>down, even if the temperature is 44=B0C.
>>
>>The CPU is not at full speed (max:2000MHz):
>>   =20
>>
>
>Probably your fan is controlled by hardware... nothing we can solve.
>								Pavel
> =20
>
Thank you for answering.
I don't know how, but under Windows, the fan turns at low speed or at
high speed. With "cpuburn" active, the fan is at high speed, if I stop
cpuburn, the fan gets back to low speed. I notice with the program "PC
Wizard 2005" that the minimum cpu speed was around 661 MHz ( Under
Linux, the minimum I can get is ~798 MHz):
----------------8<----------------

Processeur : Intel Pentium M 760 @ 661 MHz

---------------->8----------------
The temperature seem to be 52=B0C, but the value doesn't vary.


So the fan souldn't act differently if only hardware based, should it?

Is there a way to speed down the CPU to 661MHz?


Best regards
Didier










-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclic=
k
