From: Pedro Venda <pjlv-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>
Subject: Re: what is the worst laptop atm?
Date: Tue, 28 Dec 2004 10:35:30 +0000
Message-ID: <41D136F2.6080009@mega.ist.utl.pt>
References: <20041227165207.GB9606@poupinou.org> <200412271800.31064.wijnhout@science.uva.nl> <20041227171202.GC9606@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041227171202.GC9606-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
Cc: Jeroen Wijnhout <wijnhout-FT9nftu9LUxX9el/+yt6TA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Bruno Ducrot wrote:
> On Mon, Dec 27, 2004 at 06:00:30PM +0100, Jeroen Wijnhout wrote:
>=20
>>On Monday 27 December 2004 17:52, Bruno Ducrot wrote:
>>
>>>Hi,
>>>
>>>Due to hw failure, I'm thinking buying a new laptop.  I would like
>>>to know what is the worst laptop with ACPI atm?
>>
>>Well, that is certainly an interesting thought! Usually people want to =
have a=20
>>good working laptop ;-)
>=20
>=20
> It's not interresting if all work as expected ;)
>=20
>=20
>>I'm using a Acer 4001WLmi (supposedly with a smart-battery). I would be=
 so=20
>>delighted if I could finally see my battery status. Besides, it is a go=
od buy=20
>>(after all you do want to have a working computer, right?).
>=20
>=20
> Does that one fail S3 btw?

I've tried echo "3" /proc/acpi/sleep and it didn't hang... it also=20
didn't sleep though...

It just wakes up immediatelly after suspending. I suspect the radeonfb=20
had something to do with it. Later I'll send some dmesg for analysis.

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
