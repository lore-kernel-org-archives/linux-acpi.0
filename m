From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: RefOf() bug?
Date: Tue, 30 Mar 2004 18:53:01 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401CBB7AA@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ville Syrj?l? <syrjala-ORSVBvAovxo@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org wrote:
> My HP OmniBook 6000 has some problems with the battery. The
> first time the
> battery gets detected (it doesn't matter if I boot with battery
> disconnected or connected) things don't work. Then if I
> disconnect and
> reconnect the battery things start to work. But the next
> disconnect/reconnect cycle fails again, the next after that
> succeeds and
> so on.
>=20
> I've traced the problem to usage of RefOf() operator. Here's
> a snippet of
> the DSDT:
>=20
> While (LGreater (Local1, 0x08))
> {
>   If (LNot (And (UBIF, VTOB (Local1))))
>   {
>     GBFE (Local2, Local1, RefOf (Local3))
>     If (Local3)
>     {
>       If (LNot (\_SB.PCI0.ISA0.EC0.SMRD (0x0B, 0x16, Local3,
> RefOf (Local4))))
>=20
>=20
> ^^^^^^^^^^^^^
>       {
>         Store (\_SB.PCI0.ISA0.EC0.BCNT, Local5)
>         Store (Zero, Local3)
>         Store (Zero, ERRC)
>         While (LGreater (Local5, Local3))
>         {
>           GBFE (Local4, Local3, RefOf (Local6))
>=20
> I've highlighted the offending RefOf(). On the first run of the outer
> while loop SMRD() creates a buffer of size 4 and stores it
> into Arg3. For
> some reason that size never changes even though SMRD()
> creates buffers
> with size 5 and 6 on the following runs and when the buffer
> is supposed
> to be size 6 the following GBFE() tries to access beyond the
> size 4 limit
> and I get the error:
> dsopcode-0526 [528] ds_init_buffer_field  : Field [TIDX] size
> 40 exceeds Buffer [NULL] size 32 (
>=20
> The data in the Local4 buffer changes as SMRD copies new
> stuff to the new
> buffer so it looks like the Store() to Arg3 only copies the buffer
> contents up to the original buffer's size.
>=20
> Why the battery works on every second reconnect is because the first
> SMRD() call creates a buffer with size 6 on those occasions.
> I have yet to
> find out why. But that should not matter since it looks like
> RefOf() is to
> blame here.
>=20
> I've only glanced at the ACPI spec so I'm not entirely sure
> my diagnosis
> is correct...

Please check your ACPI version.
--Luming


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
