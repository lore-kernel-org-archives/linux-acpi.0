From: Pedro Venda <pjlv-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>
Subject: Re: can't read battery, dsdt bugged?
Date: Tue, 23 Nov 2004 18:11:14 +0000
Message-ID: <41A37D42.9040204@mega.ist.utl.pt>
References: <41A35CE6.90803@paranoici.org> <41A35FFD.9050701@mega.ist.utl.pt> <41A36560.90701@paranoici.org> <41A36ACE.9030602@mega.ist.utl.pt> <41A3709F.7020404@paranoici.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41A3709F.7020404-XtQPfPCVGG7srOwW+9ziJQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ultrakorne <ultrakorne-XtQPfPCVGG7srOwW+9ziJQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

ultrakorne wrote:
> Pedro Venda wrote:
>=20
>> Pedro Venda wrote:
>> you probably have a smart battery. I have an acer travelmate 4001wlmi=20
>> which has one. There are no smart battery drivers that work in linux.
>=20
>=20
> 0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBM (ICH4) SMBus Controller (re=
v=20
> 03)

SMBus (system management bus) is a physical communication bus which lives=
 in your computer, whether you have a smart battery or not.

to dissassemble your DSDT dmesg or lspci are useless. you need to cat /pr=
oc/acpi/dsdt and use iasl to dissassemble the output file. look in the ge=
ntoo forum, there is a very good tutorial there.

> ... i cant belive i cant get this working... but how u can avoid loosin=
g=20
>  power when u are working, if u cant see battery left?

Usually, I plug it into AC power. if that's impossible, 2 things can happ=
en:
if I have an idea of how long the battery has left... i use it for 3/4 of=
 my estimated time, just to be safe.
if I have no idea of how much power the battery has left, I won't use it.

it's not that you can't get it working... it's just that nobody else has =
written a driver yet. probably smart batteries are not the most widely us=
ed batteries...
I am learning and gathering information to start coding, but I don't have=
 enough time to do so in the next few months. also some other people on t=
his list are doing the same. lmsensors people have=20
some 2.4 work... but not enough to make it useful.

regards,
pedro venda.
--=20

Pedro Jo=E3o Lopes Venda
email: pjlv-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org
http://arrakis.dhis.org


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
