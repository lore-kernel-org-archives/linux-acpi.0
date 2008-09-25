From: Frans Pop <elendil@planet.nl>
Subject: Syntax errors in SSDT1 table of HP 2510p laptop
Date: Thu, 25 Sep 2008 11:19:47 +0200
Message-ID: <200809251119.48907.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0e12IO84jj2Lyyw"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hpsmtp-eml11.kpnxchange.com ([213.75.38.111]:30167 "EHLO
	hpsmtp-eml11.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752099AbYIYJTw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Sep 2008 05:19:52 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--Boundary-00=_0e12IO84jj2Lyyw
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I'm having problems with resume from suspend with this laptop. A lot of
the time it resumes perfectly, but sometimes it fails early.

During good resumes I see the following in my log:
ACPI Exception (exoparg2-0444): AE_AML_PACKAGE_LIMIT,
   Index (000000005) is beyond end of object [20080609]
ACPI Error (psparse-0530): Method parse/execution failed [\_SB_.C2C3]
   (Node ffff88007e335e80), AE_AML_PACKAGE_LIMIT
ACPI Error (psparse-0530): Method parse/execution failed [\_SB_.C003.C0F6.C3F3._STM]
   (Node ffff88007e33bdc0), AE_AML_PACKAGE_LIMIT
ata1: ACPI set timing mode failed (status=0x300d)

I have disassembled the ACPI tables using 'iasl' and found five obvious
syntax errors in the SSDT1 table (dump attached), of which one is in the
_GTM and two are in the _STM method. So that looks like an obvious cause.
I'm wondering if this could explain the resume problems.

If you cannot help me I'd appreciate some suggestions where to take this.


The first error looks like it may be a fairly simple fix:
@@ -64,8 +64,7 @@
                 CreateDWordField (Local0, 0x0C, C3F9)
                 CreateDWordField (Local0, 0x10, C3FA)
                 Store (C0FE (0x00, 0x00), C3F6)
-                Store (C101, 0x00)
-                C3FA
+                Store (C101 (0x00), C3FA)
                 If (And (C3FA, 0x01))
                 {
                     Store (C100 (0x00, 0x00), C3F7)

Or should that instead be
+                Store (C101 (0x00, 0x00), C3FA)
?


The next two I can't make anything of. They are very similar.
In the disassembly the first looks like:
<snip>
                If (LEqual (SizeOf (Arg1), 0x0200))
                {
                    Store (0x00, Local0)
                    Store (Buffer (Multiply (SizeOf (C2C2), 0x02)) {}, Local1)
                    While (LLess (Local0, SizeOf (C2C2)))
                    {
                        Store (DerefOf (Index (C2C2, Local0)), Local2)
                        Multiply (Local2, 0x02, Local2)
                        Multiply (Local0, 0x02, Local3)
                        Store (DerefOf (Index (Arg1, Local2)), Index (Local1, Local3))
                        Store (DerefOf (Index (Arg1, Add (Local2, 0x01))), Index (
                            Local1, Add (Local3, 0x01)))
                        Increment (Local0)
                    }

                    Store (C102 (0x00, 0x00, C3F6, C3FA, Local1), Local2)
                    Store (C106 (0x00, 0x00, C3F7, C3FA, Local1, Local3), \_SB.C2C3)
                    Local2
                    Local3
                    Local1
                    C3F4
                }
</snip>

The last 4 lines are obviously bogus. Does anyone here have a clue what
could be intended here?


The last two errors are in the _GTF method for two devices, again similar.
The first of those looks as follows:
<snip>
            Device (C3FB)
            {
                Name (_ADR, 0x00)
                Method (_GTF, 0, NotSerialized)
                {
                    Return (\_SB.C2CA)
                    C3F4
                    0x00
                }
            }
</snip>


Cheers and TIA,
FJP

P.S. There's also a warning from the DSDT table, but that looks relatively
harmless:
dsdt.dsl  9155:                         Wait (\_SB.C1AD, 0x10)
Warning  1103 -        Possible operator timeout is ignored ^

Can that be ignored or should I follow up on that too?

--Boundary-00=_0e12IO84jj2Lyyw
Content-Type: application/octet-stream;
  name="ssdt1.dat"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="ssdt1.dat"

U1NEVL4CAAABxkhQICAgIEhQUVBBVAAAAQAAAE1TRlQBAAADEEkpXC8DX1NCX0MwMDNDMEY2CF9B
RFIMAQAfAFuCTCdDM0YzCF9BRFIKAAhDM0Y0Eg4GCgAKAAoACgAKAAoACEMzRjUSDAUKAAoACgAK
AAoAFE4JX0dUTQBwERcKFP//////////////////////////YIpgCgBDM0Y2imAKBEMzRjeKYAoI
QzNGOIpgCgxDM0Y5imAKEEMzRkFwQzBGRQoACgBDM0Y2cEMxMDEKAEMzRkGgFntDM0ZBCgEAcEMx
MDAKAAoAQzNGN6EKcEMzRjZDM0Y3cAp4QzNGOHAKEUMzRjl9QzNGQQoMQzNGQaRgFEcUX1NUTQOK
aAoAQzNGNopoCgRDM0Y3imgKCEMzRjiKaAoMQzNGOYpoChBDM0ZBoEsIk4dpCwACcAoAYHARCneH
QzJDMgoCAGGiOpVgh0MyQzJwg4hDMkMyYABid2IKAmJ3YAoCY3CDiGliAIhhYwBwg4hpcmIKAQAA
iGFyYwoBAAB1YHBDMTAyCgAKAEMzRjZDM0ZBYWJwQzEwNgoACgBDM0Y3QzNGQWFjXC5fU0JfQzJD
M2JjYUMzRjSgSwiTh2oLAAJwCgBgcBEKd4dDMkMyCgIAYaI6lWCHQzJDMnCDiEMyQzJgAGJ3YgoC
YndgCgJjcIOIamIAiGFjAHCDiGpyYgoBAACIYXJjCgEAAHVgcEMxMDIKAAoBQzNGOEMzRkFhYnBD
MTA2CgAKAUMzRjlDM0ZBYWNcLl9TQl9DMkMzYmNhQzNGNVuCJEMzRkIIX0FEUgoAFBdfR1RGAKRc
Ll9TQl9DMkNBQzNGNAoAW4I6QzNGQwhfQURSCgEUCl9QUzAAcAoAYBQKX1BTMwBwCgBgFBdfR1RG
AKRcLl9TQl9DMkNBQzNGNQoB

--Boundary-00=_0e12IO84jj2Lyyw--
