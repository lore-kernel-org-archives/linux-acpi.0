From: Pedro Venda <pjlv-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>
Subject: Re: can't read battery, dsdt bugged?
Date: Tue, 23 Nov 2004 16:52:30 +0000
Message-ID: <41A36ACE.9030602@mega.ist.utl.pt>
References: <41A35CE6.90803@paranoici.org> <41A35FFD.9050701@mega.ist.utl.pt> <41A36560.90701@paranoici.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41A36560.90701-XtQPfPCVGG7srOwW+9ziJQ@public.gmane.org>
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
>> ultrakorne wrote:
>>
>>> Hi, i have a acer laptop (travelmate 4501LCi) and i have installed=20
>>> ubuntu warty 4.10 (kernel 2.6.8.1)
>>> the battery applet didnt works... this because /proc/acpi/battery/ is=
=20
>>> empty!
>>
>>
>>
>> you probably have a smart battery. I have an acer travelmate 4001wlmi=20
>> which has one. There are no smart battery drivers that work in linux.
>>
>> regards,
>> pedro venda.
>>
> on the user guide it says the battery is Lithium Ion...
> but if it is a smart battery... i cant use linux?? i need to read the=20
> charge..
> how i can see if it is a lion or smart...

it can be a lithium ion AND a smart battery. those are two different conc=
epts:
- Lithium Ion refers to the chemical technology used by the battery.
- the smart battery refers to the way computers interact with the battery=
. I think there are two types: smart batteries and some other type which =
name I can't remember (maybe someone could help me here)

it probably is a smart battery, and yes, it's not at all desirable to not=
 be able to read the charge and AC status, but one can live with it... i =
do.

to see if it's a smart battery or not, i think you must dissassemble your=
 DSDT and look for something like "Name(_HID. EISAID("PNP0C090"))" or "Na=
me(_HID,"ACPI0001")" or "Name(_HID,"ACPI0002")" [some=20
more help here would be appreciated: what is the single line in the dsdt =
that can tell if one has a smart battery?]. if you find any of those in y=
our dissassembled DSDT, most certainly you have a=20
smart battery.

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
