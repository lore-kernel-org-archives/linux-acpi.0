From: Fedor Karpelevitch <fedor.karpelevitch-X80Pqrzrk4F8zQARNC3f2A@public.gmane.org>
Subject: RE: [LinuxPresario900] Re: DSDT fixes for Presario 900
Date: Tue, 23 Sep 2003 09:17:59 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <AA1E1F7FC9E1124F999E37BFA1DD344766DC35@iris.win.barra.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C381EE.413AD4C0"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "'linuxpresario900-+vy+FFr6rAI3CPJRO4ggG/Z8FUJU4vz8@public.gmane.org'" <linuxpresario900-+vy+FFr6rAI3CPJRO4ggG/Z8FUJU4vz8@public.gmane.org>, Fedor Karpelevitch <fedor-ugkMPi23kyXAHCkTjeiZhQ@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C381EE.413AD4C0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: S=E9rgio Monteiro Basto [mailto:sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org]
> Sent: Monday, September 22, 2003 10:20 PM
> To: Fedor Karpelevitch
> Cc: LinuxPresario900-+vy+FFr6rAI3CPJRO4ggG/Z8FUJU4vz8@public.gmane.org; acpi-devel
> Subject: [LinuxPresario900] Re: [ACPI] DSDT fixes for Presario 900
>=20
>=20
> Hi!
> I can you give a diff of your orig dsl and your corrected dsl?
>=20
> BTW: http://developer.intel.com/technology/iapc/acpi/downloads.htm as
> been updated in September 19, 2003 and have some things new=20
> for presario
> for example mine 706EA , now compiles without any error or warning !.
>=20
> thanks

see attachment. most of the differences are just additional debugging
output.


> =20
>=20
> On Fri, 2003-09-19 at 22:39, Fedor Karpelevitch wrote:
> > Hi, people!
> >=20
> > I finally got around to fixing some of the annoying acpi problems I =

> > was experiencing:
> >=20
> > 1) lid state reported incorrectly ("open" when closed and "closed"=20
> > when open)
> >=20
> > 2) lack of AC plug/unplug events
> >=20
> > one remaining annoying problem is double powerbutton events=20
> (i get two=20
> > events when I press button once). For what I understand it=20
> cannot be=20
> > fixed by DSDT since it is handled as fixed-feature.
> >=20
> > Attached are: source and compiled DSDT and a patch to=20
> vanilla 2.4.22=20
> > (maybe it will apply to 2.6 kernels too) to have this fixed DSDT=20
> > override the one from ROM...
> >=20
> > I would be interested to hear
> >=20
> > 1) do other people experience same issues on presario 900=20
> (and maybe=20
> > Evos) in all it's permutations
> > 2) if yes, does this patch remedy these problems?
> >=20
> > I would appreciate you sending me your DSDTs (cat=20
> /proc/acpi/dsdt to a=20
> > file) to see if they all have it identical or not...
> >=20
> > Thanks.
> >=20
> > Fedor.
> > ----
>=20
> --=20
> S=E9rgioMB
> email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org
>=20
> Who gives me one shell, give me everything.
>=20
> _______________________________________________
> LinuxPresario900 mailing list
> LinuxPresario900-+vy+FFr6rAI3CPJRO4ggG/Z8FUJU4vz8@public.gmane.org
> http://videl.ics.hawaii.edu/mailman/listinfo/linuxpresario900
>=20


------_=_NextPart_000_01C381EE.413AD4C0
Content-Type: application/octet-stream;
	name="dsdt.dsl.diff"
Content-Disposition: attachment;
	filename="dsdt.dsl.diff"

--- my/dsdt.dsl	2003-09-19 00:05:14.000000000 -0700
+++ A09/dsdt.dsl	2003-09-16 16:27:51.000000000 -0700
@@ -88,7 +88,6 @@
         }
 
         Store (0x00, \_GPE.GPEF)
-	Return (0x00000000)
     }
 
     Scope (_SI)
@@ -149,24 +148,19 @@
             })
             Method (_LID, 0, NotSerialized)
             {
-                Store ("in _LID", Debug)
                 If (\_SB.PCI0.ISA.EC.ECOK)
                 {
-                    Store (" ECOK is true ", Debug)
                     If (\_SB.PCI0.ISA.EC.LIDS)
                     {
-		    	Store ("LIDS is true", Debug)
-                        Return (0x01)
+                        Return (0x00)
                     }
                     Else
                     {
-		    	Store ("LIDS is false", Debug)
-                        Return (0x00)
+                        Return (0x01)
                     }
                 }
                 Else
                 {
-                    Store (" ECOK is false ", Debug)
                     Return (0x00)
                 }
             }
@@ -176,7 +170,6 @@
         {
             Method (_L01, 0, NotSerialized)
             {
-                Store (" in _L01 ", Debug)
                 Store (0x01, GPEF)
                 If (Not (\_SB.PCI0.ISA.EC.Z000))
                 {
@@ -191,7 +184,6 @@
 
             Method (_L09, 0, NotSerialized)
             {
-                Store (" in _L09 ", Debug)
                 Store (0x01, GPEF)
                 Notify (\_SB.PCI0, 0x02)
             }
@@ -911,7 +903,7 @@
 
                 Device (MSE0)
                 {
-                    Name (_HID, "SYN0100")
+                    Name (_HID, "*SYN0100")
                     Name (_CID, Package (0x02)
                     {
                         0x02002E4F, 
@@ -1657,7 +1649,7 @@
                         CMD3,   8
                     }
 
-                    Field (ERAM, ByteAcc, NoLock, Preserve)
+                    Field (ERAM, AnyAcc, NoLock, Preserve)
                     {
                         Offset (0x80), 
                         NMSG,   8, 
@@ -1720,7 +1712,6 @@
                     Mutex (MTX1, 0x00)
                     Method (_Q0B, 0, NotSerialized)
                     {
-                        Store ("Sleep btn runtime event", Debug)
                         Notify (\_SB.SLPB, 0x80)
                     }
 
@@ -1742,7 +1733,6 @@
                             Store (0x89, \_SB.PCI0.ISA.BCMD)
                             Store (Zero, \_SB.PCI0.ISA.SMIC)
                         }
-			Notify (\_SB.AC, 0x80)
                     }
 
                     Method (_Q08, 0, NotSerialized)
@@ -1915,7 +1905,6 @@
                             {
                                 Store (0x8E, \_SB.PCI0.ISA.BCMD)
                                 Store (Zero, \_SB.PCI0.ISA.SMIC)
-                        	Store ("notify AGP.VGA", Debug)
                                 Notify (\_SB.PCI0.AGP.VGA, 0x80)
                             }
                         }
@@ -2777,7 +2766,7 @@
                     }
                 }
 
-                OperationRegion (CCRD, PCI_Config, 0x00, 0xA9)
+                OperationRegion (CCRD, PCI_Config, 0x00, 0xA7)
                 Field (CCRD, DWordAcc, Lock, Preserve)
                 {
                     Offset (0x04), 

------_=_NextPart_000_01C381EE.413AD4C0--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
