From: "KOCHI, Takayoshi" <t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>
Subject: Re: RE: ACPI interrupts..
Date: Thu, 26 Sep 2002 09:44:47 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020927014414.BAUMC0A82650.6C9EC293@mvf.biglobe.ne.jp>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DEC3@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DEC3-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
Cc: torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Andy,

=46rom the definition of SCI in the spec:
|A system interrupt used by hardware to notify the OS of ACPI events.
|The SCI is an active, low, shareable, level interrupt.

Although the spec states that the SCI is an active-low & level
interrupt, there are some ia64 platforms that break this rule
(such as BigSur, NEC AzusA).  But they describe the SCI's polarity
and trigger in MADT's interrupt source override record.

I have little idea about ia32 platforms but they should be same as ia64.
So the current code that forces the SCI to be active-low & level
seems wrong for me.  If an interrupt source override record for SCI
exists in MADT, we should obey what the record says.

I don't know whether Linus's machine has the record, but I have
ever seen the same phenomenon when wrong polarity is specified
for an interrupt...

Hope this helps.

On Wed, 25 Sep 2002 14:20:17 -0700
"Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> > That also implies that it's not a completely spurious=20
> > interrupt: if it was
> > spurious, the interrupt handler wouldn't know what to do with=20
> > it, and it=20
> > would scream constantly and the machine would make no=20
> > progress. Obviously=20
> > that isn't the case, since the machine works fine.
>=20
> A properly functioning ACPI system should not generate 72000 interrupts p=
er
> second, needless to say. It may not be a lockup but it's still bad.
>=20
> From your trace, it sure looks like the software doesn't think it has any
> fixed or general-purpose events outstanding, (like you say, enable and
> status bits appear to be mutually exclusive) so it returns, assuming the
> interrupt must be for someone else - but ACPI is the only one on irq 9
> right?
>=20
> I will whip up a patch to 1) disable all GPE enable bits and 2) clear all
> GPE status bits and see if the problem goes away.
>=20
> This kind of problem is pretty hard for me to fix without an actual insta=
nce
> of the system to play with...sigh
>=20
> Regards -- Andy

Thanks,
--=20
KOCHI, Takayoshi <t-kouchi-f7IHDacdhdx8UrSeD/g0lQ@public.gmane.org/t-kouchi>



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
