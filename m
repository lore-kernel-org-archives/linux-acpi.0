From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>
Subject: RefOf() bug?
Date: Tue, 30 Mar 2004 13:49:33 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040330104933.GA9234@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

My HP OmniBook 6000 has some problems with the battery. The first time th=
e=20
battery gets detected (it doesn't matter if I boot with battery=20
disconnected or connected) things don't work. Then if I disconnect and=20
reconnect the battery things start to work. But the next=20
disconnect/reconnect cycle fails again, the next after that succeeds and=20
so on.

I've traced the problem to usage of RefOf() operator. Here's a snippet of=
=20
the DSDT:

While (LGreater (Local1, 0x08))
{
  If (LNot (And (UBIF, VTOB (Local1))))
  {
    GBFE (Local2, Local1, RefOf (Local3))
    If (Local3)
    {
      If (LNot (\_SB.PCI0.ISA0.EC0.SMRD (0x0B, 0x16, Local3, RefOf (Local=
4))))

                                                             ^^^^^^^^^^^^=
^
      {
        Store (\_SB.PCI0.ISA0.EC0.BCNT, Local5)
        Store (Zero, Local3)
        Store (Zero, ERRC)
        While (LGreater (Local5, Local3))
        {
          GBFE (Local4, Local3, RefOf (Local6))

I've highlighted the offending RefOf(). On the first run of the outer=20
while loop SMRD() creates a buffer of size 4 and stores it into Arg3. For=
=20
some reason that size never changes even though SMRD() creates buffers=20
with size 5 and 6 on the following runs and when the buffer is supposed=20
to be size 6 the following GBFE() tries to access beyond the size 4 limit=
=20
and I get the error:
dsopcode-0526 [528] ds_init_buffer_field  : Field [TIDX] size 40 exceeds =
Buffer [NULL] size 32 (

The data in the Local4 buffer changes as SMRD copies new stuff to the new=
=20
buffer so it looks like the Store() to Arg3 only copies the buffer=20
contents up to the original buffer's size.

Why the battery works on every second reconnect is because the first=20
SMRD() call creates a buffer with size 6 on those occasions. I have yet t=
o=20
find out why. But that should not matter since it looks like RefOf() is t=
o=20
blame here.

I've only glanced at the ACPI spec so I'm not entirely sure my diagnosis=20
is correct...

--=20
Ville Syrj=E4l=E4
syrjala-ORSVBvAovxo@public.gmane.org
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
