From: Pedro Venda <pjlv-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>
Subject: Re: Centrino speedstep
Date: Thu, 30 Dec 2004 16:36:24 +0000
Message-ID: <41D42E88.5080800@mega.ist.utl.pt>
References: <m2zmzyw4e7.fsf@phoenix.squirrel.nl> <20041228212653.GA8436@dominikbrodowski.de> <20041229181834.GA19199@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041229181834.GA19199-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Bruno Ducrot wrote:
> On Tue, Dec 28, 2004 at 10:26:53PM +0100, Dominik Brodowski wrote:
>=20
>>On Tue, Dec 28, 2004 at 09:32:00PM +0100, Johan Vromans wrote:
>>
>>>Hi,
>>>
>>>On my Acer Travelmate 4000WLMi, with various 2.6.9 and 2.6.10 kernels
>>>and patch sets, I keep getting the following message:
>>>
>>>  speedstep-centrino: invalid ACPI data
>>>  speedstep-centrino: no table support for CPU model "Intel(R) Pentium=
(R) M processor 1.50GHz":=20
>>>
>>>(Some kernels report "Invalid control/status registers" instead of
>>>"invalid ACPI data").
>>>
>>>My latest attempt was the stock 2.6.10 kernel, with ACPI patch set
>>>acpi-20041210-2.6.10-rc3.diff, and a fixed DSDT. Still no success.
>>>
>>>Any help is appreciated.
>>
>>It looks like your notebook's BIOS does not report sufficient data to t=
he
>>speedstep-centrino cpufreq driver. Does the acpi-cpufreq driver work
>>instead?
>>
>=20
>=20
> After looking the DSDT, this laptop do not support the _PDC switch, so
> the cpufreq-centrino driver will not work.  But it should work with the
> acpi io driver though.
>=20
 > This also mean there is no way to get the ondemand governor (or any DV=
S
 > requiring low latency driver) to work with this one (unless hardcoding
 > a table in the cpufreq-centrino).
 >
 > There is no _CST also, this means there is no C4 support :(
 >

sorry for interrupting thread flow, but I didn't understand this one...

I'm running on a tmate 4001 WLMi with speedstep-centrino driver and ondem=
and=20
governor.

I don't see any problems... the clock scales correctly and fast... Is it=20
possible to have a different DSDT from dominik's?

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
