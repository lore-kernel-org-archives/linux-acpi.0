From: Pedro Venda <pjlv-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>
Subject: Re: i2c-acpi-ec.c
Date: Fri, 31 Dec 2004 14:19:46 +0000
Message-ID: <41D56002.5060008@mega.ist.utl.pt>
References: <20041231092156.GA612@phys.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041231092156.GA612-vpGm2Noi6jeZvKxeG3EEhw@public.gmane.org>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Mathias Weyland wrote:
> Hi

hello,

> My girlfriend bought a new notebook and asked me to install linux on it
> (she's fearing viruses ect.). It's an acer tm 2303lc and I installed a
> recent kernel on it. I was quite astonished when I got an empty
> /proc/acpi/battery, so I checked the dsdt but couldn't find any errors.

yes, from what I've found, smartbatteries are much more efficient than st=
andard=20
ones, so that's probably a good thing. I like to think so, since I have o=
ne.

> After some time of googling, I read something about smartbatteries. I
> checked my asl code, and yes, I do have one of those smartbattery-thing=
s in
> front of me. That's quite a problem since my girlfriend will probably k=
ill
> me when I tell her that battery monitoring is not working.

be prepared :-)

> I've read in the acpi4linux list that you took Bruno's old code and tha=
t you
> are working on a driver. So I wanted to ask whether you need any help (=
don't=20
> expect too much, I'm writing simulations for computional science and
> I do only have some minor knowledge of kernel programming (with a 2.0
> codebase) and how far you got now.

I started to learn about kernel programming and i2c, smb, acpi etc, but I=
'm=20
constantly interrupted because of academic work. So I've no time to effic=
iently=20
develop such beast. Beast because of my no-experience in kernel programmi=
ng and=20
related subsystems.

About bruno's driver, I really don't remember well what I've done. I reme=
mber=20
correctly addressing the smartbattery and getting some very basic informa=
tion.=20
nothing useful. I was happy for actually finding and talking to a smart b=
attery=20
though :-)

My standpoint right now is about the same as you. I'm offering help but w=
on't=20
author a driver because I'm unable to find enough free time.

regards,
pedro venda.

p.s.: I CC'd this reply to the acpi-devel mailing list. It's the place wh=
ere you=20
want to offer help. there are a couple of people that already have offere=
d=20
themselves to help.
--=20

Pedro Jo=E3o Lopes Venda
email: pjlv-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org
http://arrakis.dhis.org


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
