From: Peter Clifton <pcjc2@cam.ac.uk>
Subject: Re: HP Compaq nc6320 Suspend / Resume (changes in behaviour)
Date: Tue, 22 May 2007 21:57:27 +0100
Message-ID: <1179867447.15226.1.camel@localhost>
References: <1179859741.27532.8.camel@localhost>
	 <200705222127.32713.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-4rdaMqiP7Cxfo17SqFSI"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:38049 "EHLO
	ppsw-7.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757354AbXEVT52 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 May 2007 15:57:28 -0400
Received: from epec1135.eng.cam.ac.uk ([129.169.173.33]:46432)
	by ppsw-7.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:465)
	with esmtpsa (LOGIN:pcjc2) (SSLv3:RC4-MD5:128)
	id 1HqaU1-0003u7-OB (Exim 4.63) for linux-acpi@vger.kernel.org
	(return-path <pcjc2@cam.ac.uk>); Tue, 22 May 2007 20:57:25 +0100
In-Reply-To: <200705222127.32713.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--=-4rdaMqiP7Cxfo17SqFSI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-05-22 at 21:27 +0200, Rafael J. Wysocki wrote:
> Hi,
>=20
> On Tuesday, 22 May 2007 20:49, Peter Clifton wrote:
> > Hi,
> >=20
> > I just updated my bios to HP's latest, and have recently been
upgraded
> > to Ubuntu Gutsy kernel version:
> >=20
> > Linux version 2.6.22-1-generic (buildd@palmer) (gcc version 4.1.3
> > 20070423 (prerelease) (Ubuntu 4.1.2-3ubuntu3)) #1 SMP Mon Apr 30
> > 10:49:22 GMT 2007

[snip]

> Well, threre's a couple of such things.  You may try the kernel.org
kernel
> 2.6.22-rc2 with the hibernation and suspend patchset available from
> http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.22-rc2/patches .

I wonder if those are included in Ubuntu's kernel (I'm being dumb today,
but I couldn't work out if the debian build was adding patches or not,
nor which exact version they started from.

(The source filename is linux-source-2.6.22_2.6.22-5.11.tar.gz)

Just FYI, the link you posted has a file with funny permissions on it:

http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.22-rc2/patches/16-usb=
-use-freezable-workqueue.patch

Gives me a 403 error.


> > After resume from suspend, I see:
> >=20
> > dmesg  | grep ACPI | grep Error
> > [ 4763.428000] ACPI Error (psparse-0537): Method parse/execution
failed [\_SB_.C241] (Node df94c9dc), AE_AML_PACKAGE_LIMIT
> > [ 4763.428000] ACPI Error (psparse-0537): Method parse/execution
failed [\_SB_.C002.C0DC.C349._STM] (Node df94fba8), AE_AML_PACKAGE_LIMIT
> > [ 6417.528000] ACPI Error (psparse-0537): Method parse/execution
failed [\_SB_.C241] (Node df94c9dc), AE_AML_PACKAGE_LIMIT
> > [ 6417.528000] ACPI Error (psparse-0537): Method parse/execution
failed [\_SB_.C002.C0DC.C349._STM] (Node df94fba8), AE_AML_PACKAGE_LIMIT
> >=20
> > Is this anything to worry about - should I post a dsdt for the new
bios?

Looking at the ACPI 3.0 spec:

_STM Optional control method that sets the IDE controller=E2=80=99s transfe=
r
timing sttings. IDE-only

(IE. shouldn't be called for an SATA drive). That may mean its for my CD
writer (which shows up as hda). This is in the first SSDT, "HPQSAT"
which I've attached the dissasembly of.

> This means we are unable to set the IDE controller transfer timings
after the
> resume.  I don't know how serious this is in practice, though.

iasl decompiles and recompiles the dsdt and all ssdt ok (after minor
tweaking due to decompile discrepancies).

The remaining warnings only relate to _BCQ (A Microsoft induced typo for
_BQC?)


And, unreachable code in the _STA method of the "ACEL" device. (They
have blanked that function off with a Return (0x00). Thats a shame - if
it means what I think (that the acceleration sensor doesn't work).

Many places in the ACEL device code check If (_STA ()) around big blocks
of code, so presumably the AML code for it is not doing a great deal. (I
wounder how Windows uses it - a custom driver perhaps?)

Thanks for the great work on suspend / resume (and of course ACPI
support in general) everyone!

Peter

--=-4rdaMqiP7Cxfo17SqFSI
Content-Disposition: attachment; filename=ssdt1.dsl
Content-Type: text/x-csrc; name=ssdt1.dsl; charset=UTF-8
Content-Transfer-Encoding: 7bit

/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20061109
 *
 * Disassembly of ssdt1.aml, Tue May 22 20:59:05 2007
 *
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00000326 (806)
 *     Revision         0x01
 *     OEM ID           "HP    "
 *     OEM Table ID     "HPQSAT"
 *     OEM Revision     0x00000001 (1)
 *     Creator ID       "MSFT"
 *     Creator Revision 0x0100000E (16777230)
 */
DefinitionBlock ("ssdt1.aml", "SSDT", 1, "HP    ", "HPQSAT", 0x00000001)
{
    External (C0EC, MethodObj)    // 6 Arguments
    External (C0E8, MethodObj)    // 5 Arguments
    External (C0E6, MethodObj)    // 2 Arguments
    External (C0E7, MethodObj)    // 1 Argument?
    External (C0E4, MethodObj)    // 2 Arguments
    External (C240)
    External (\_SB_.C14A)
    External (\_SB_.C248, MethodObj)
    External (\_SB_.C241, MethodObj)    // 4 Arguments
    External (\_SB_.C002, DeviceObj)
    External (\_SB_.C002.C0DC, DeviceObj)

    Scope (\_SB.C002)
    {
        Device (C351)
        {
            Name (_ADR, 0x001F0002)
            Device (C0F6)
            {
                Name (_ADR, 0xFFFF)
                Name (C352, Package (0x06)
                {
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00
                })
                Method (_SDD, 1, Serialized)
                {
                    If (LEqual (SizeOf (Arg0), 0x0200))
                    {
                        Store (0x00, Local0)
                        Store (Buffer (Multiply (SizeOf (C240), 0x02)) {}, Local1)
                        While (LLess (Local0, SizeOf (C240)))
                        {
                            Store (DerefOf (Index (C240, Local0)), Local2)
                            Multiply (Local2, 0x02, Local2)
                            Multiply (Local0, 0x02, Local3)
                            Store (DerefOf (Index (Arg0, Local2)), Index (Local1, Local3))
                            Store (DerefOf (Index (Arg0, Add (Local2, 0x01))), Index (
                                Local1, Add (Local3, 0x01)))
                            Increment (Local0)
                        }

                        \_SB.C241 (0x00010000, 0x00, Local1, C352)
                    }
                }

                Method (_GTF, 0, NotSerialized)
                {
                    Return (\_SB.C248(C352, 0x00))
                }
            }
        }
    }

    Scope (\_SB.C002.C0DC)
    {
        Name (_ADR, 0x001F0001)
        Name (C353, 0x01)
        Device (C349)
        {
            Name (_ADR, 0x00)
            Name (C34A, Package (0x05)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            })
            Method (_GTM, 0, NotSerialized)
            {
                Store (Buffer (0x14)
                    {
                        /* 0000 */    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
                        /* 0008 */    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
                        /* 0010 */    0xFF, 0xFF, 0xFF, 0xFF
                    }, Local0)
                CreateDWordField (Local0, 0x00, C34B)
                CreateDWordField (Local0, 0x04, C34C)
                CreateDWordField (Local0, 0x08, C354)
                CreateDWordField (Local0, 0x0C, C355)
                CreateDWordField (Local0, 0x10, C34D)
                Store (C0E4 (0x00, 0x00), C34B)
                Store (C0E7 (0x00), C34D)
                If (And (C34D, 0x01))
                {
                    Store (C0E6 (0x00, 0x00), C34C)
                }
                Else
                {
                    Store (C34B, C34C)
                }

                If (LOr (LEqual (And (\_SB.C14A, 0x0F), 0x07), LEqual (And (
                    C353, 0x01), 0x00)))
                {
                    Store (0x78, C354)
                    Store (0x11, C355)
                    Or (C34D, 0x0C, C34D)
                }
                Else
                {
                    Store (C0E4 (0x00, 0x01), C354)
                    If (And (C34D, 0x04))
                    {
                        Store (C0E6 (0x00, 0x01), C355)
                    }
                    Else
                    {
                        Store (C354, C355)
                    }
                }

                Return (Local0)
            }

            Method (_STM, 3, NotSerialized)
            {
                CreateDWordField (Arg0, 0x00, C34B)
                CreateDWordField (Arg0, 0x04, C34C)
                CreateDWordField (Arg0, 0x08, C354)
                CreateDWordField (Arg0, 0x0C, C355)
                CreateDWordField (Arg0, 0x10, C34D)
                If (LEqual (And (\_SB.C14A, 0x0F), 0x01))
                {
                    Or (C353, 0x01, C353)
                    If (LEqual (SizeOf (Arg1), 0x0200))
                    {
                        Store (0x00, Local0)
                        Store (Buffer (Multiply (SizeOf (C240), 0x02)) {}, Local1)
                        While (LLess (Local0, SizeOf (C240)))
                        {
                            Store (DerefOf (Index (C240, Local0)), Local2)
                            Multiply (Local2, 0x02, Local2)
                            Multiply (Local0, 0x02, Local3)
                            Store (DerefOf (Index (Arg1, Local2)), Index (Local1, Local3))
                            Store (DerefOf (Index (Arg1, Add (Local2, 0x01))), Index (
                                Local1, Add (Local3, 0x01)))
                            Increment (Local0)
                        }

                        Store (C0E8 (0x00, 0x00, C34B, C34D, Local1), Local2)
                        Store (C0EC (0x00, 0x00, C34C, C34D, Local1, Local3), \_SB.C241 (Local2, Local3, Local1, C34A))
                    }
                }
            }

            Device (C34E)
            {
                Name (_ADR, 0x00)
                Method (_GTF, 0, NotSerialized)
                {
                    Return (\_SB.C248 (C34A, 0x00))
                }
            }
        }
    }
}


--=-4rdaMqiP7Cxfo17SqFSI--

