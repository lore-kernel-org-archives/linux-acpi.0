From: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>
Subject: Re: C states on AMD SMP
Date: Sat, 10 Sep 2005 14:47:58 +0200
Message-ID: <4322D5FE.2040308@tzi.de>
References: <1126178956.24699.42.camel@localhost.localdomain>	 <43202621.9080600@tzi.de> <1126182374.4397.8.camel@localhost.localdomain>	 <43215F09.7030909@tzi.de> <1126339733.22979.2.camel@localhost.localdomain>	 <4322A06D.8050804@tzi.de> <1126349362.4766.51.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1126349362.4766.51.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Erik Slagter <erik-KW7PGP3XNp7a5EbDDlwbIw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



Erik Slagter wrote:
> On Sat, 2005-09-10 at 10:59 +0200, Janosch Machowinski wrote:
>=20
>>>Is there a way to patch the FADT or to fool linux-acpi into it does
>>>actually work (to at least be able to test the thing)?
>>
>>Shure, patch the verify functions in processor_idle.c ...
>>But actually I think this is no good idea...
>=20
>=20
> I tested it a few mins ago and there's good news and bad news ;-)
>=20
> The very bad news is that my power meter is in a place I cannot reach a=
t
> the moment;
>=20
> The good news is that CPU0 now has three C3 states and is almost
> constantly running in that state;
>=20
> The bad news is that CPU1 still reports only C1.
That's a bug:
Here a comment from ACPI Spec 3.0 :
Processor power state support is symmetric when presented via the FADT=20
and P_BLK interfaces; OSPM
assumes all processors in a system support the same power states. If=20
processors have non-symmetric power
state support, then the BIOS will choose and use the lowest common power=20
states supported by all the
processors in the system through the FADT table. For example, if the=20
CPU0 processor supports all power
states up to and including the C3 state, but the CPU1 processor only=20
supports the C1 power state, then
OSPM will only place idle processors into the C1 power state (CPU0 will=20
never be put into the C2 or C3
power states). Notice that the C1 power state must be supported. The C2=20
and C3 power states are optional
(see the PROC_C1 flag in the FADT table description in section 5.2.6,=20
=93System Description Table
Header=94).


Feel free to write a patch
>=20
> Could it be that the "restriction" of this chipset is, that the complet=
e
> system (including both cpu's) always must run in the same C-state? That
> would be no real problem for me.
No, every Processor can use the Sleep states independent (with some=20
restrictions, see ACPISpec p. 257).


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
