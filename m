From: jurriaan <thunder7-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Subject: A8N-SLI Deluxe: poweroff OK with 1006 bios, fails with 1011 and later bioses
Date: Sun, 7 Aug 2005 08:48:02 +0200
Message-ID: <20050807064802.GA4188@amd64.of.nowhere>
Reply-To: Jurriaan <thunder7-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

My Asus A8N-SLI Deluxe motherboard doesn't power off when shutting down
with a bios later than the original 1006.

I would like to use a newer bios, since they support X2 chips, for
example.

I have decompiled the 1006 dsdt and the 1011 dsdt, and somewhere there
must be a difference that causes this.

I've tried to read the acpi specification to find out where I should
start, but I'm not getting it. What parts in the dsdt have to do with
powering off the system? Where do I look?

I'll attach 1006.dsl and the diff.

Thanks,
Jurriaan
-- 
Apple I (c) Copyright 1767, Sir Isaac Newton.
Debian (Unstable) GNU/Linux 2.6.13-rc4-mm1 5505 bogomips load 0.40

--IS0zKkzwUGydFO0o
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="a8nsli_deluxe_1006.dsl.bz2"
Content-Transfer-Encoding: base64

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

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="a8nsli_deluxe_1006_1011.diff"

--- 1006.dsl	2005-08-06 20:45:36.000000000 +0200
+++ 1011.dsl	2005-08-06 20:45:48.000000000 +0200
@@ -2,13 +2,14 @@
  * Intel ACPI Component Architecture
  * AML Disassembler version 20050624
  *
- * Disassembly of dsdt.1006, Sat Aug  6 20:45:36 2005
+ * Disassembly of dsdt.1011, Sat Aug  6 20:45:48 2005
  */
 DefinitionBlock ("DSDT.aml", "DSDT", 1, "NVIDIA", "AWRDACPI", 4096)
 {
     Scope (\_PR)
     {
-        Processor (\_PR.CPU0, 0x00, 0x00004010, 0x06) {}
+        Processor (\_PR.CPU0, 0x00, 0x00000000, 0x00) {}
+        Processor (\_PR.CPU1, 0x01, 0x00000000, 0x00) {}
     }
 
     Name (\_S0, Package (0x04)
@@ -153,7 +154,7 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1, 
         Return (Local3)
     }
 
-    OperationRegion (\GP1, SystemIO, 0x44C0, 0x32)
+    OperationRegion (\GP1, SystemIO, 0x44C0, 0x3D)
     Field (\GP1, ByteAcc, NoLock, Preserve)
     {
         GP00,   8, 
@@ -205,7 +206,18 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1, 
         GP46,   8, 
         GP47,   8, 
         GP48,   8, 
-        GP49,   8
+        GP49,   8, 
+        GP50,   8, 
+        GP51,   8, 
+        GP52,   8, 
+        GP53,   8, 
+        GP54,   8, 
+        GP55,   8, 
+        GP56,   8, 
+        GP57,   8, 
+        GP58,   8, 
+        GP59,   8, 
+        GP60,   8
     }
 
     Name (OSFX, 0x01)
@@ -481,106 +493,8 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1, 
         }
     }
 
-    Scope (\_PR.CPU0)
-    {
-        Name (_PCT, Package (0x02)
-        {
-            ResourceTemplate ()
-            {
-                Register (FFixedHW, 0x00, 0x00, 0x0000000000000000)
-            }, 
-
-            ResourceTemplate ()
-            {
-                Register (FFixedHW, 0x00, 0x00, 0x0000000000000000)
-            }
-        })
-        Method (_PPC, 0, NotSerialized)
-        {
-            Return (0x00)
-        }
-
-        Name (PPSS, Package (0x06)
-        {
-            Package (0x06)
-            {
-                0xFFFF, 
-                0xFFFFFFFF, 
-                0xFF, 
-                0xFF, 
-                0xFFFFFFFF, 
-                0x03FF
-            }, 
-
-            Package (0x06)
-            {
-                0xFFFF, 
-                0xFFFFFFFF, 
-                0xFF, 
-                0xFF, 
-                0xFFFFFFFF, 
-                0x03FF
-            }, 
-
-            Package (0x06)
-            {
-                0xFFFF, 
-                0xFFFFFFFF, 
-                0xFF, 
-                0xFF, 
-                0xFFFFFFFF, 
-                0x03FF
-            }, 
-
-            Package (0x06)
-            {
-                0xFFFF, 
-                0xFFFFFFFF, 
-                0xFF, 
-                0xFF, 
-                0xFFFFFFFF, 
-                0x03FF
-            }, 
-
-            Package (0x06)
-            {
-                0xFFFF, 
-                0xFFFFFFFF, 
-                0xFF, 
-                0xFF, 
-                0xFFFFFFFF, 
-                0x03FF
-            }, 
-
-            Package (0x06)
-            {
-                0xFFFF, 
-                0xFFFFFFFF, 
-                0xFF, 
-                0xFF, 
-                0xFFFFFFFF, 
-                0x03FF
-            }
-        })
-    }
-
     Scope (\_SB)
     {
-        Device (MBIO)
-        {
-            Name (_HID, EisaId ("PNP0C02"))
-            Name (_UID, 0x05)
-            Name (_CRS, ResourceTemplate ()
-            {
-                IO (Decode16, 0x4000, 0x4000, 0x01, 0x80)
-                IO (Decode16, 0x4080, 0x4080, 0x01, 0x80)
-                IO (Decode16, 0x4400, 0x4400, 0x01, 0x80)
-                IO (Decode16, 0x4480, 0x4480, 0x01, 0x80)
-                IO (Decode16, 0x4800, 0x4800, 0x01, 0x80)
-                IO (Decode16, 0x4880, 0x4880, 0x01, 0x80)
-            })
-        }
-
         Device (PWRB)
         {
             Name (_HID, EisaId ("PNP0C0C"))
@@ -606,6 +520,44 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1, 
                 }
             }
 
+            OperationRegion (BRCR, PCI_Config, 0xD0, 0x04)
+            Scope (\)
+            {
+                Field (\_SB.PCI0.BRCR, ByteAcc, NoLock, Preserve)
+                {
+                    GPUB,   32
+                }
+            }
+
+            Device (MBIO)
+            {
+                Name (_HID, EisaId ("PNP0C02"))
+                Name (_UID, 0x05)
+                Method (_CRS, 0, NotSerialized)
+                {
+                    Name (BUF0, ResourceTemplate ()
+                    {
+                        IO (Decode16, 0x4000, 0x4000, 0x01, 0x80)
+                        IO (Decode16, 0x4080, 0x4080, 0x01, 0x80)
+                        IO (Decode16, 0x4400, 0x4400, 0x01, 0x80)
+                        IO (Decode16, 0x4480, 0x4480, 0x01, 0x80)
+                        IO (Decode16, 0x4800, 0x4800, 0x01, 0x80)
+                        IO (Decode16, 0x4880, 0x4880, 0x01, 0x80)
+                        Memory32Fixed (ReadWrite, 0xA0000000, 0x00000000)
+                    })
+                    CreateDWordField (BUF0, 0x34, BRAB)
+                    CreateDWordField (BUF0, 0x38, BRAL)
+                    If (GPUB)
+                    {
+                        ShiftLeft (GPUB, 0x10, Local0)
+                        Store (Local0, BRAB)
+                        Store (0x10000000, BRAL)
+                    }
+
+                    Return (BUF0)
+                }
+            }
+
             Name (NATA, Package (0x01)
             {
                 0x00060000
@@ -3026,6 +2978,18 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1, 
                     If (LEqual (Arg0, Local0))
                     {
                         Store (VCOR, Local0)
+                        Store (0x00, Local1)
+                        While (LEqual (Local0, 0xFF))
+                        {
+                            Store (VCOR, Local0)
+                            If (LEqual (Local1, 0x000186A0))
+                            {
+                                Break
+                            }
+
+                            Add (Local1, 0x01, Local1)
+                        }
+
                         Multiply (Local0, 0x10, Local0)
                         Return (Local0)
                     }
@@ -3034,6 +2998,18 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1, 
                     If (LEqual (Arg0, Local0))
                     {
                         Store (V33V, Local0)
+                        Store (0x00, Local1)
+                        While (LEqual (Local0, 0xFF))
+                        {
+                            Store (V33V, Local0)
+                            If (LEqual (Local1, 0x000186A0))
+                            {
+                                Break
+                            }
+
+                            Add (Local1, 0x01, Local1)
+                        }
+
                         Multiply (Local0, 0x10, Local0)
                         Return (Local0)
                     }
@@ -3042,6 +3018,18 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1, 
                     If (LEqual (Arg0, Local0))
                     {
                         Store (V50V, Local0)
+                        Store (0x00, Local1)
+                        While (LEqual (Local0, 0xFF))
+                        {
+                            Store (V50V, Local0)
+                            If (LEqual (Local1, 0x000186A0))
+                            {
+                                Break
+                            }
+
+                            Add (Local1, 0x01, Local1)
+                        }
+
                         Multiply (Local0, 0x10, Local0)
                         Store (0x22, Local1)
                         Store (0x32, Local2)
@@ -3055,6 +3043,18 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1, 
                     If (LEqual (Arg0, Local0))
                     {
                         Store (V12V, Local0)
+                        Store (0x00, Local1)
+                        While (LEqual (Local0, 0xFF))
+                        {
+                            Store (V12V, Local0)
+                            If (LEqual (Local1, 0x000186A0))
+                            {
+                                Break
+                            }
+
+                            Add (Local1, 0x01, Local1)
+                        }
+
                         Multiply (Local0, 0x10, Local0)
                         Store (0x1E, Local1)
                         Store (0x0A, Local2)
@@ -3098,6 +3098,18 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1, 
                     If (LEqual (Arg0, Local0))
                     {
                         Store (TSR1, Local0)
+                        Store (0x00, Local1)
+                        While (LEqual (Local0, 0x80))
+                        {
+                            Store (TSR1, Local0)
+                            If (LEqual (Local1, 0x000186A0))
+                            {
+                                Break
+                            }
+
+                            Add (Local1, 0x01, Local1)
+                        }
+
                         Multiply (Local0, 0x0A, Local0)
                         Return (Local0)
                     }
@@ -3106,6 +3118,18 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1, 
                     If (LEqual (Arg0, Local0))
                     {
                         Store (MBTE, Local0)
+                        Store (0x00, Local1)
+                        While (LEqual (Local0, 0x80))
+                        {
+                            Store (MBTE, Local0)
+                            If (LEqual (Local1, 0x000186A0))
+                            {
+                                Break
+                            }
+
+                            Add (Local1, 0x01, Local1)
+                        }
+
                         Multiply (Local0, 0x0A, Local0)
                         Return (Local0)
                     }
@@ -3733,6 +3757,124 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1, 
                     MMCM,   8
                 }
 
+                Method (GSLI, 1, NotSerialized)
+                {
+                    If (LEqual (Arg0, 0x03060000))
+                    {
+                        Store (0x00, Local1)
+                        Store (ESLI (), Local0)
+                        If (LEqual (Local0, 0x40))
+                        {
+                            Or (Local1, 0x01, Local1)
+                        }
+
+                        Store (NVSL (), Local2)
+                        If (LEqual (Local2, 0x00))
+                        {
+                            Store (PCBV (), Local3)
+                            If (LEqual (Local3, 0x01))
+                            {
+                                Store (CSLI (), Local0)
+                                If (LEqual (Local0, 0x40))
+                                {
+                                    Or (Local1, 0x02, Local1)
+                                }
+                            }
+                            Else
+                            {
+                                Store (DSLI (), Local0)
+                                If (LEqual (Local0, 0x40))
+                                {
+                                    Or (Local1, 0x02, Local1)
+                                }
+                            }
+                        }
+                        Else
+                        {
+                            Store (DSLI (), Local0)
+                            If (LEqual (Local0, 0x40))
+                            {
+                                Or (Local1, 0x02, Local1)
+                            }
+                        }
+
+                        Store (Local1, Index (VCNT, 0x02))
+                        Return (VCNT)
+                    }
+
+                    If (LEqual (Arg0, 0x03060001))
+                    {
+                        Store (0x00, Local1)
+                        Store (NVSL (), Local0)
+                        If (LEqual (Local0, 0x10))
+                        {
+                            Or (Local1, 0x01, Local1)
+                        }
+
+                        Store (Local1, Index (SLIS, 0x02))
+                        Return (SLIS)
+                    }
+                    Else
+                    {
+                        Return (0x00)
+                    }
+                }
+
+                Name (VCNT, Package (0x04)
+                {
+                    0x03060000, 
+                    0x01, 
+                    0x01, 
+                    0x01
+                })
+                Name (SLIS, Package (0x06)
+                {
+                    0x03060001, 
+                    0x00, 
+                    0x01, 
+                    0x01, 
+                    "Disabled", 
+                    "Enabled"
+                })
+                Method (SSLI, 2, NotSerialized)
+                {
+                    If (LEqual (Arg0, 0x03060001))
+                    {
+                        If (Arg1)
+                        {
+                            Store (SLIC, Local0)
+                            Not (0x60, Local2)
+                            And (Local0, Local2, Local0)
+                            Store (0x00, Local1)
+                            ShiftLeft (Local1, 0x05, Local1)
+                            Or (Local0, Local1, Local0)
+                            Store (Local0, SLIC)
+                            Return (0x03)
+                        }
+                        Else
+                        {
+                            Store (SLIC, Local0)
+                            Not (0x60, Local2)
+                            And (Local0, Local2, Local0)
+                            Store (0x01, Local1)
+                            ShiftLeft (Local1, 0x05, Local1)
+                            Or (Local0, Local1, Local0)
+                            Store (Local0, SLIC)
+                            Return (0x03)
+                        }
+                    }
+                    Else
+                    {
+                        Return (0x01)
+                    }
+                }
+
+                IndexField (CM2I, CM2D, ByteAcc, NoLock, Preserve)
+                {
+                    Offset (0xBD), 
+                    SLIC,   8
+                }
+
                 Name (CQFN, Package (0x06)
                 {
                     0x04060003, 
@@ -4187,6 +4329,31 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1, 
                 Return (Local0)
             }
 
+            Method (CRSB, 1, NotSerialized)
+            {
+                If (LEqual (Arg0, 0x01))
+                {
+                    Return (0x11)
+                }
+
+                If (LEqual (Arg0, 0x02))
+                {
+                    Return (0x12)
+                }
+
+                If (LEqual (Arg0, 0x08))
+                {
+                    Return (0x10)
+                }
+
+                If (LEqual (Arg0, 0x0D))
+                {
+                    Return (0x13)
+                }
+
+                Return (Arg0)
+            }
+
             Method (CRSA, 1, Serialized)
             {
                 Store (0x00, Local0)
@@ -4934,7 +5101,9 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1, 
 
                 Method (_CRS, 0, NotSerialized)
                 {
-                    Return (BUF1)
+                    CreateWordField (IRZ1, 0x05, IRQ1)
+                    Store (CRSB (INTA), IRQ1)
+                    Return (IRZ1)
                 }
 
                 Method (_SRS, 1, NotSerialized)
@@ -4971,7 +5140,9 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1, 
 
                 Method (_CRS, 0, NotSerialized)
                 {
-                    Return (BUF2)
+                    CreateWordField (IRZ1, 0x05, IRQ1)
+                    Store (CRSB (INTB), IRQ1)
+                    Return (IRZ1)
                 }
 
                 Method (_SRS, 1, NotSerialized)
@@ -5008,7 +5179,9 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1, 
 
                 Method (_CRS, 0, NotSerialized)
                 {
-                    Return (BUF3)
+                    CreateWordField (IRZ1, 0x05, IRQ1)
+                    Store (CRSB (INTC), IRQ1)
+                    Return (IRZ1)
                 }
 
                 Method (_SRS, 1, NotSerialized)
@@ -5045,7 +5218,9 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1, 
 
                 Method (_CRS, 0, NotSerialized)
                 {
-                    Return (BUF4)
+                    CreateWordField (IRZ1, 0x05, IRQ1)
+                    Store (CRSB (INTD), IRQ1)
+                    Return (IRZ1)
                 }
 
                 Method (_SRS, 1, NotSerialized)

--IS0zKkzwUGydFO0o--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
