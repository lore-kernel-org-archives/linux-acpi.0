From: Arkadiusz Miskiewicz <arekm-k0Z414SquRyhPH1hqNUYSQ@public.gmane.org>
Subject: Re: ACPI: S3 and PAE do not like each other for now, S3 disabled.
Date: Wed, 18 Aug 2004 16:51:15 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200408181651.15838.arekm@pld-linux.org>
References: <88056F38E9E48644A0F562A38C64FB6002A3AE50@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB6002A3AE50-exJ48ZlmiLpQxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 17 of August 2004 01:43, you wrote:

> >Can you confirm that it works reliably with PAE disabled?
>
> Did you get a chance to check this. Does this system
> suspend-resumes reliably with PAE disabled. And has this hang
> only with PAE enabled.
I've tested 2.6.8.1 kernel with ACPI patch 20040715
=2D with PAE enabled - unfortunately no change. System hangs after resume=20
sometimes in a way I've already described.
=2D without PAE enabled it wasn't much better

first went ok
PM: Preparing system for suspend
orinoco_lock() called with hw_unavailable (dev=3Dddbc0800)
PM: Entering state.
Back to C!
APIC error on CPU0: 00(00)
PM: Finishing up.
ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:11.2[D] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:11.3[D] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 10 (level, low) -> IRQ 10
eth1: New link status: Connected (0001)

second went ok but at third time I got:
PM: Entering state.
Back to C!
double fault, gdt at c030d000 [255 bytes]
double fault, tss at c035e800
eip c0117824, esp d03fffb8
eax 00000068, ebx 7073006e, ecx =3D 0000007b, edx =3D d040006c
esi 00000000, edi =3D c0117810
(rewrote by hand so some typos are possible, system hangt after this that=20
sysrq wasn't even working)

> Thanks,
> Venki

=2D-=20
Arkadiusz Mi=B6kiewicz     CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org, 1024/3DB19BBD, JID: arekm.jabber.org, PLD/Linux


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
