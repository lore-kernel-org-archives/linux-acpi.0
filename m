From: Paulo da Silva <pvmagacho78-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: AE_BAD_HEX_CONSTANT
Date: Tue, 9 Nov 2004 11:33:31 -0800 (PST)
Message-ID: <20041109193331.930.qmail@web41101.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1544154936-1100028811=:99561"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

--0-1544154936-1100028811=:99561
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Hello,

 I am having a few problems with the battery
information with my Acer Aspire 1613Lmi.
 I get the following error :
kernel:  psparse-1133: *** Error: Method execution
failed [\_SB_.PCI0.LPC0.EC__.GBIF] (Node dfe6e480),
AE_BAD_HEX_CONSTANT
kernel:  psparse-1133: *** Error: Method execution
failed [\_SB_.PCI0.LPC0.EC__.BAT0._BIF] (Node
dfe6de00), AE_BAD_HEX_CONSTANT

I tracked down to the lines in the ASL code. I've
attached part of the DSDT containing this lines. The
part that gives the problem is pointed out. 

The whole DSDT can be seen at :
http://cern.ch/paulo/dsdt.dsl.orig

Thanks in advance for any help.

Regards,
Paulo


		
__________________________________ 
Do you Yahoo!? 
Check out the new Yahoo! Front Page. 
www.yahoo.com 
 

--0-1544154936-1100028811=:99561
Content-Type: text/x-dsl; name="battery.dsl"
Content-Description: battery.dsl
Content-Disposition: inline; filename="battery.dsl"

                    Mutex (BATM, 0x07)
                    Method (GBIF, 2, NotSerialized)
                    {
                        Acquire (BATM, 0xFFFF)
/* Problems start here - If commented out the error goes away, but I can't get no information from the battery*/
                        Store (0x0FA0, Index (Arg1, 0x01))
                        Store (0x0FA0, Index (Arg1, 0x02))
                        Store (0x39D0, Index (Arg1, 0x04))
                        Store (0x0190, Index (Arg1, 0x05))
                        Store (0x78, Index (Arg1, 0x06))
                        Store (0x0118, Index (Arg1, 0x07))
                        Store (0x0E10, Index (Arg1, 0x08))
                        Store ("Bat 8Cell", Index (Arg1, 0x09))
                        Store ("236", Index (Arg1, 0x0A))
                        Store ("Lion", Index (Arg1, 0x0B))
                        Store ("Acer", Index (Arg1, 0x0C))
/* Problems ends here */
                        Release (BATM)
                        Return (Arg1)
                    }

                    Method (GBST, 4, NotSerialized)
                    {
                        Acquire (BATM, 0xFFFF)
                        If (Arg1)
                        {
                            Store (GBPI (Arg0, 0x01), Local0)
                        }

                        If (\_SB.PCI0.LPC0.EC.AC.ACST)
                        {
                            If (Arg1)
                            {
                                If (And (Local0, 0x20))
                                {
                                    Store (0x00, Index (Arg2, 0x00))
                                }
                                Else
                                {
                                    If (CLED)
                                    {
                                        Store (0x00, Index (Arg2, 0x00))
                                    }
                                    Else
                                    {
                                        Store (0x02, Index (Arg2, 0x00))
                                    }
                                }
                            }
                            Else
                            {
                                Store (0x00, Index (Arg2, 0x00))
                                Store (0xFFFFFFFF, Index (Arg2, 0x01))
                                Store (0xFFFFFFFF, Index (Arg2, 0x02))
                                Store (0xFFFFFFFF, Index (Arg2, 0x03))
                                Return (Arg2)
                            }
                        }
                        Else
                        {
                            Store (0x01, Local5)
                            If (LEqual (And (\RBEC (0x43), 0x20), 0x00))
                            {
                                Or (Local5, 0x04, Local5)
                            }

                            Store (Local5, Index (Arg2, 0x00))
                        }

                        If (Arg1)
                        {
                            Store (GBPI (Arg0, 0x04), Local3)
                        }

                        If (BLLW)
                        {
                            Store (0x00, BLLW)
                            Store (0x06, Local4)
                        }
                        Else
                        {
                            If (LEqual (Local3, 0x64))
                            {
                                Store (Arg3, Local4)
                            }
                            Else
                            {
                                If (LLess (Local3, 0x03))
                                {
                                    Store (0x00, Local4)
                                }
                                Else
                                {
                                    Multiply (Arg3, Local3, Local5)
                                    Divide (Local5, 0x64, Local6, Local4)
                                    If (Local6)
                                    {
                                        Increment (Local4)
                                    }
                                }
                            }
                        }

                        Store (Local4, Index (Arg2, 0x02))
                        Store (0xFFFFFFFF, Local5)
                        Store (Local5, Index (Arg2, 0x01))
                        If (Arg0)
                        {
                            Store (0x2EE0, Index (Arg2, 0x03))
                        }
                        Else
                        {
                            Store (0x3E80, Index (Arg2, 0x03))
                        }

                        Release (BATM)
                        Return (Arg2)
                    }

                    Device (BAT0)
                    {
                        Name (_HID, EisaId ("PNP0C0A"))
                        Name (_PCL, Package (0x01)
                        {
                            \_SB
                        })
                        Name (B0ST, 0x00)
                        Method (_STA, 0, NotSerialized)
                        {
                            If (\_SB.PCI0.AGP.EVGA.SWIH)
                            {
                                If (And (\RBEC (0x78), 0x04))
                                {
                                    Store (0x00, B0ST)
                                }
                                Else
                                {
                                    Store (0x01, B0ST)
                                }
                            }
                            Else
                            {
                                Store (0x01, B0ST)
                            }

                            If (B0ST)
                            {
                                Return (0x1F)
                            }
                            Else
                            {
                                Return (0x0F)
                            }
                        }

                        Name (BT0I, Package (0x0D)
                        {
                            0x01, 
                            0x19C8, 
                            0x19C8, 
                            0x01, 
                            0x39D0, 
                            0x014A, 
                            0xDC, 
                            0x012C, 
                            0x0294, 
                            "ANA", 
                            "110", 
                            "Lion", 
                            0x00
                        })
                        Method (_BIF, 0, NotSerialized)
                        {
                            If (And (\RBEC (0x78), 0x04))
                            {
                                Store (0xFFFFFFFF, Index (BT0I, 0x01))
                                Store (0xFFFFFFFF, Index (BT0I, 0x02))
                                Store (0xFFFFFFFF, Index (BT0I, 0x04))
                                Store ("Bad", Index (BT0I, 0x09))
                                Store ("Bad", Index (BT0I, 0x0A))
                                Store ("Bad", Index (BT0I, 0x0B))
                                Store ("Bad", Index (BT0I, 0x0C))
                                Return (BT0I)
                            }
                            Else
                            {
                                Return (GBIF (0x00, BT0I))
                            }
                        }

                        Name (BT0P, Package (0x04)
                        {
                            0x00, 
                            0xFFFFFFFF, 
                            0x0BB8, 
                            0xFFFFFFFF
                        })
                        Method (_BST, 0, NotSerialized)
                        {
                            Store (DerefOf (Index (BT0I, 0x02)), Local0)
                            Return (GBST (0x00, B0ST, BT0P, Local0))
                        }
                    }
--0-1544154936-1100028811=:99561--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
