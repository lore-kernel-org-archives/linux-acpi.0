From: margitsw-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org (Margit Schubert-While)
Subject: Intel ACPI
Date: Tue, 04 Feb 2003 00:14:13 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4.3.2.7.2.20030204000748.00b62270@mail.dns-host.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
	So, What do you think about this (D845):

Method (OSFL, 0, NotSerialized)
     {
         Store (0x00, Local0)
         If (MCTH (\_OS, "Microsoft Windows"))
         {
             Store (0x01, Local0)
         }

         If (MCTH (\_OS, "Microsoft WindowsME: Millennium Edition"))
         {
             Store (0x01, Local0)
         }

         Return (Local0)
     }

Method (_PS3, 0, NotSerialized)
                     {
                         If (MCTH (\_OS, "Microsoft Windows"))
                         {
                             Store (_GTM (), TIM1)
                         }
                     }

Method (_PS0, 0, NotSerialized)
                     {
                         If (MCTH (\_OS, "Microsoft Windows"))
                         {
                             If (BOOT)
                             {
                                 If (And (DRVI, 0x20))
                                 {
                                     PRGT (MPIO, MDMA, FLGS, 0xA0)
                                 }

                                 If (And (DRVI, 0x80))
                                 {
                                     PRGT (SPIO, SDMA, FLGS, 0xB0)
                                 }
                             }

                             Store (0x01, BOOT)
                         }
                     }


Method (_PS3, 0, NotSerialized)
                     {
                         If (MCTH (\_OS, "Microsoft Windows"))
                         {
                             Store (_GTM (), TIM1)
                         }
                     }


                    Method (_PS0, 0, NotSerialized)
                     {
                         If (MCTH (\_OS, "Microsoft Windows"))
                         {
                             If (BOOT)
                             {
                                 If (And (DRVI, 0x20))
                                 {
                                     PRGT (MPIO, MDMA, FLGS, 0xA0)
                                 }

                                 If (And (DRVI, 0x80))
                                 {
                                     PRGT (SPIO, SDMA, FLGS, 0xB0)
                                 }
                             }

                             Store (0x01, BOOT)
                         }
                     }



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
