From: Thomas Sjolshagen <Thomas.Sjolshagen-VXdhtT5mjnY@public.gmane.org>
Subject: Compaq EVO n1000c: Missing battery status
Date: Thu, 12 Feb 2004 17:03:31 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1076623411.6714.32.camel@zk3thomas05.sjolshagen.net>
Reply-To: Thomas.Sjolshagen-VXdhtT5mjnY@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi,

When booting the 2.6.2 kernel (no bk or acpi patches) and regardless of
whether I'm using a DSDT that compiles w/iasl (using the initrd patch)
or not, I get the following errors. It's been this way since one of the
2.6.0-rc releases.

This is the portions of the systems dmesg output where I see any sort of
error message. The whole dmesg output (with debug output enabled) is
available upon request.
 
ACPI: Subsystem revision 20040116
ACPI: IRQ9 SCI: Edge set to Level Trigger.
    ACPI-1120: *** Error: Method execution failed
[\_SB_.C03B.C04E.C0CF.C0D3] (Node c157dcc0), AE_NOT_EXIST
    ACPI-1120: *** Error: Method execution failed
[\_SB_.C03B.C04E.C0CF._INI] (Node c157b4c0), AE_NOT_EXIST
ACPI: Interpreter enabled

It seems to me that the problem may be the inclusion of the trailing
underscore for "_SB"? (as seen in the dmesg output)? I've been unable to
locate a "_SB_" string anywhere in my disassembled .dsl file.   

I've also included portions of the .dsl that I think may be relevant
(let me know if you need more, or the whole .dsl file itself).

       Method (C0D3, 0, Serialized)
       {
             C0D4 (0x07, 0xFF)
             Store (C0D5 (), Local0)
             C0D6 (Local0, 0x81)
             And (C0D1, 0x01, C0D7)
             And (ShiftRight (C0D1, 0x01), 0x01, C0D8)
       }

       Method (_REG, 2, NotSerialized)
       {
             If (LEqual (Arg0, 0x03))
             {
                    Store (Arg1, C0D2)
                    If (LAnd (Arg1, LNot (LLess (\C009 (), 0x03))))
                    {
                          C0D3 ()
                    }
             }
       }

       OperationRegion (C0D9, EmbeddedControl, 0x00, 0xFF)
       Field (C0D9, ByteAcc, NoLock, Preserve)
       {
             Offset (0x80),
             Offset (0x81),
                     ,   4,
                 C0DA,   4,
                     ,   1,
                 C0D7,   1,
                 C0DB,   1,
                     ,   1,
                 C0D8,   1,
                     ,   1,
                     ,   1,
                 C0DC,   1,
                 C0DD,   1,
                     ,   1,
                     ,   1,
                     ,   1,
                     ,   1,
                 C0DE,   1,
                 C0DF,   1,
                 C0E0,   1,
                 C0E1,   1,
                     ,   1,
                     ,   1,
                 C0E2,   1,
                 C0E3,   4,
                 C0E4,   1,
             Offset (0x86),
                 C0E5,   4,
             Offset (0x89),
                C0E6,   16,
             Offset (0x8D),
                C0E7,   16,
             Offset (0x91),
                 C0E8,   1,
             Offset (0x95),
                C0E9,   16,
             Offset (0x99),
                 C0EA,   4,
             Offset (0x9D),
                C0EB,   16,
             Offset (0xA1),
                C0EC,   16,
             Offset (0xA5),
                C0ED,   16,
             Offset (0xA9),
                C0EE,   16,
             Offset (0xAD),
                C0EF,   16,
             Offset (0xB1),
                C0F0,   16,
             Offset (0xB5),
                 C0F1,   8,
             Offset (0xB9),
                 C0F2,   8,
             Offset (0xBD),
                 C0F3,   8,
             Offset (0xC1),
                C0F4,   64,
                C0F5,   64,
                C0F6,   32,
                 C0F7,   8,
                 C0F8,   8,
                 C0F9,   8,
                 C0FA,   8,
                 C0FB,   8,
                 C0FC,   8,
                 C0FD,   8,
                 C0FE,   8,
                 C0FF,   4,
                 C100,   4,
                C101,   16,
                C102,   16,
             Offset (0xE3),
                C103,   4
       }

       Method (_INI, 0, NotSerialized)
       {
              If (LLess (\C009 (), 0x03))
              {
                     C0D3 ()
              }
       }
   
-- 
                                Thomas.Sjolshagen-VXdhtT5mjnY@public.gmane.org
Something funny should appear   110 Spit Brook Rd
in this space any day now...    Nashua, NH 03045
                                Phone: +1 (603)785-9780




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
