From: Sergio Monteiro Basto <sergio-qOf5bGQp09kptuEoxK/DLR2eb7JE58TQ@public.gmane.org>
Subject: Re: [ACPI-bugzilla] Boot hang in ACPI mode with and w/o "nolapic"
 - compaq 2156EA
Date: Sat, 29 Jan 2005 15:22:30 +0000
Message-ID: <1107012150.1672.12.camel@bastov>
References: <1106178197.4354.8.camel@localhost>
Reply-To: sergio-qOf5bGQp09kptuEoxK/DLR2eb7JE58TQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1106178197.4354.8.camel@localhost>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Daniele Bertin <daniele.bertin-IWqWACnzNjyonA0d6jMUrA@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Yap, after many work, we suspect that the problem is that we have one
local apic on this computers but is not used (even on Windows) because
we don't need it, and in very low level isn't programed either.
So if BIOS reports that local apic is disable, we don't try enabled it
anymore, this feature has enter in kernel 2.6.9.

Conclusion if you use a kernel >=3D 2.6.9 , the local apic will not be
enabled and computer won't hang anymore.

BTW: the Mailing List for us to write is acpi-devel.=20

thanks,

On Thu, 2005-01-20 at 00:43 +0100, Daniele Bertin wrote:
> At boot  with noapic, ACPI=3Don my Compaq Presario 2156EA hang safter t=
he
> syslog messages (seen from failsafe boot on the screen):
> ...
> spurious 8259A interupt: IRQ7
> ACPI: IRQ9 SCI: Level Trigger=20
>=20
> If I use nolapic the PC hangs even before during the message
> "Calibrating delay loop..."
>=20
> It works with ACPI=3Dht but in this case I have no ACPI in my laptop(!)=
.
>=20
> After searches and trials it seems that the problem is related to the
> use of nolapic with ACPI, see bug 1269 at
> http://bugme.osdl.org/show_bug.cgi?id=3D1269
>=20
> So what. What to do to put in practice the solution? I have not seen
> that bug included in the last ACPI versions. I'm a goodwill person and
> even if found of linux I'm only a user for writing, internet and music
> and never patched or compiled a kernel, so a simple explaination will b=
e
> appreciated.
>=20
> Distribution: Mandrake Linux 10.1. Kernel 2.6.8.1-12mdk. BIOS KAM 1.42.
> ACPI 20040326
>=20
> Thanks for any help
>=20
> Daniele
>=20
> A summary of what I have tried (only the part significant to the presen=
t
> debugging):
>=20
> 1) Use of APIC. PC hangs. After that always noapic in kernel parameter
> in lilo.conf
> 2) Use of nolapic: hang at "Calibrating "  as said above. After that us=
e
> of nolapic is avoided
> 3) Use of combination of parameters in append of lilo: pci=3Dnoacpi,
> acpi=3Dnoirq
> 4) Use of a corrected DSDT table. dump of my PC table with pmtools,
> decompile and compile with  iasl compiler after fixing an error related
> to *SYN0105 symbol which was not alphanmeric. The table is found in the
> initrd but the behaviour is the same as with the original DSDT table.
>=20
>=20
--=20
S=E9rgio M.B.



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
