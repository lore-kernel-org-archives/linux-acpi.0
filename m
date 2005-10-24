From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Acer Extensa 3002 WLMi: DSDT fixed but system misses keyboard and mouse events
Date: Mon, 24 Oct 2005 13:40:17 -0700
Message-ID: <971FCB6690CD0E4898387DBF7552B90E032CF08F@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Berthold Cogel <cogel-F8dkAKZEjLURtNtAH2Wc8g@public.gmane.org>, ACPI Development <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

smbus-cm.asl    87:         Method (_SBI, 0, NotSerialized)
Warning  2097 -  Unknown reserved name ^  (_SBI)

smbus-cm.asl   147:         Method (_SBR, 3, NotSerialized)
Warning  2097 -  Unknown reserved name ^  (_SBR)

smbus-cm.asl   237:         Method (_SBW, 5, NotSerialized)
Warning  2097 -  Unknown reserved name ^  (_SBW)

smbus-cm.asl   314:         Method (_SBA, 0, NotSerialized)
Warning  2097 -  Unknown reserved name ^  (_SBA)

These are valid warnings from the compiler. It certainly can't do
anything about BIOS writers that simply refuse to follow the ACPI spec
:-(

Bob


> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Berthold Cogel
> Sent: Monday, October 24, 2005 1:28 PM
> To: ACPI Development
> Subject: [ACPI] Acer Extensa 3002 WLMi: DSDT fixed but system misses
> keyboard and mouse events
>=20
> Hello!
>=20
> I couldn't use the DSDT Olaf Jansen-Olliges send me some weeks ago for
> my Acer because of the different amount of memory, so I tried it
myself
> again.
>=20
> First I fixed the original DSDT and then patched it with
> acer-tm4xxx-sbs-cm.diff from the sbs-linux project. There are still
> warnings from iasl (20050930) for smbus-cm.asl. I've attached the
> source, the resulting DSDT and the output of iasl.
>=20
> I include the DSDT as initrd and boot the kernel with ec_burst=3D1 as
> kernel parameter.
>=20
> Almost everything works as expected except that the system is missing
> keyboard and mouse events when the battery is inserted. This is
nothing
> for fast writers. When I'm working only with ac-adapter, everything is
> ok. The logs don't show any errors.
>=20
>=20
> Kernel:
>=20
> linux-2.6.14-rc3, suspend2, acpi-dsdt-initrd-patch
>=20
>=20
> Hardware:
>=20
> Acer Extensa 3002 WLMi
> Pentium M 725 1,6 GHz, 1GB RAM, 100GB HD
> ATI Mobility Radeon 9700
> Intel 802.11 b/g Wlan
>=20
>=20
> Best regards,
>=20
> Berthold


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
