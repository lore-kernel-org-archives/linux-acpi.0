From: Marco Walther <Marco.Walther-xsfywfwIY+M@public.gmane.org>
Subject: Where does Dell i8200 hide it's fans?
Date: Fri, 24 Jan 2003 12:43:50 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <15921.42374.651850.622121@jena.eng.sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I've a Dell Inspiron 8200 and I know it has two fans. The Dell-laptop
driver is able to switch them but I don't see anything in the acpi
DSDT:-( 

The whole ThermalZone is really small:

    Scope (\_TZ)
    {
        ThermalZone (THM)
        {
            Method (_CRT, 0, NotSerialized)
            {
                Store (0x5E, Local0)
                Multiply (Local0, 0x0A, Local0)
                Add (Local0, 0x0AAC, Local0)
                Return (Local0)   /* 94 C */
            }

            Method (_TMP, 0, NotSerialized)
            {
                Store (GINF (0x04), Local0)
                Return (Local0)
            }

            Method (GINF, 1, NotSerialized)
           {
                SX10 ()
                SX30 (Arg0)
                SX11 ()
                Store (SX41 (), Local0)
                SX12 ()
                If (LLess (Local0, 0x0BA6))
                {
                    Store (0x0BA6, Local0)   /* 25 C, that's what I
					      * see in the /proc/acpi */
                }

                Return (Local0)
            }
        }
    }

There should be more but where would I find it?

Another question: The Dell DSDT has some parts which work differently
for different Windows OS's. Since this laptop is only supported with
WinXP, whould it make sense to to fake that even under Linux?

Thanks,
-- Marco

-- 


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
