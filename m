From: Pedro Venda <pjlv-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>
Subject: Re: Centrino speedstep
Date: Fri, 31 Dec 2004 01:25:51 +0000
Message-ID: <41D4AA9F.7080200@mega.ist.utl.pt>
References: <m2zmzyw4e7.fsf@phoenix.squirrel.nl>	<20041228212653.GA8436@dominikbrodowski.de>	<20041229181834.GA19199@poupinou.org>	<41D42E88.5080800@mega.ist.utl.pt>	<m2llbfk931.fsf@phoenix.squirrel.nl>	<41D43A9F.5050507@mega.ist.utl.pt> <16852.15668.315630.700537@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <16852.15668.315630.700537-KjnUIgV0B0bak1Ioo/c9IoRWq/SkRNHw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Johan Vromans wrote:
> [Quoting Pedro Venda, on December 30 2004, 17:27, in "Re: Centrino spee=
dst"]
>=20
>>will dissassemble my dsdt tonight and upload it to somewhere on the
>>internet.
>=20
>=20
> Yes, please.

here it is:
http://arrakis.dhis.org/linux/laptop/dsdt.dsl.gz

my bios version is:

System BIOS Ver: 3A06
VGA BIOS Ver: ATI-M11-008.018M.017.000
KBC Ver: PQ1A28

(may look like copied from your e-mail but wasn't)

the machines look exactly the same. the only difference is that mine work=
s with=20
the speedstep centrino driver and johan's doesn't.

This may be the responsible for mine to work with the speedstep driver:
(from kernel config)

       Default CPUFreq governor (ondemand)  --->
   x x              <M>   'performance' governor
   x x              <M>   'powersave' governor
   x x              <M>   'userspace' governor for userspace frequency sc=
aling
   x x              [ ]     /proc/sys/cpu/ interface (2.4. / OLD)
   x x              ---   'ondemand' cpufreq policy governor
   x x              <*>   CPU frequency table helpers
   x x              ---   CPUFreq processor drivers
   x x              < > ACPI Processor P-States driver
   x x              < > AMD Mobile K6-2/K6-3 PowerNow!
   x x              < > AMD Mobile Athlon/Duron PowerNow!
   x x              < > AMD Opteron/Athlon64 PowerNow!
   x x              < > Cyrix MediaGX/NatSemi Geode Suspend Modulation
   x x              <M> Intel Enhanced SpeedStep
   x x              [*]   Use ACPI tables to decode valid frequency/volta=
ge pairs
   x x              [*]   Built-in tables for Banias CPUs

the two last lines look to me like the tables referred above. am I right?=
 Also,=20
CPU frequency table helpers seems familiar. What are the differences betw=
een=20
both tables really?

also, how exactly can I use ACPI throttling? because with the speestep dr=
iver, I=20
can't go below 600MHz, but 12% of maximum frequency is 180MHz which I can=
 reach=20
using ACPI throttling.

care to comment?

>=20
>>are you completely unable to use speedstep-centrino and/or ondemand
>>speedfreq governor?
>=20
>=20
> Yes. Upon boot, I always get the message:
>=20
>   speedstep-centrino: no table support for CPU model "Intel(R) Pentium(=
R) M processor 1.50GHz":=20
>   speedstep-centrino: try compiling with CONFIG_X86_SPEEDSTEP_CENTRINO_=
ACPI enable

I'm also using stock kernel 2.6.10 with stock acpi code but I have a diff=
erent
message:
speedstep-centrino: invalid ACPI data

But the module seems to work ok. is there an easy way to test it?

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
