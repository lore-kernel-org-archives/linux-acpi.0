From: John Knottenbelt <jak97-CezfXpuMXD6Fxr2TtlUqVg@public.gmane.org>
Subject: Does Linux make use of the S3D methods?
Date: Mon, 19 Jan 2004 13:54:36 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200401191354.36354.jak97@doc.ic.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

Hi

I have been inspecting my DSDT and I noticed this:

Scope(\_SB_) {
    Device(PWRB) {
        Name(_HID, 0x0c0cd041)
        Method(_STA) {
            Return(0xb)
        }
    }
    Device(PCI0) {
        Name(_HID, 0x030ad041)
        Name(_ADR, 0x0)
        Name(_BBN, 0x0)
        Method(_S3D) {
            If(OSFL) {
                Return(0x2)
            }
            Else {
                Return(0x3)
            }
        }

The ACPI spec says that the _S3D method returns the highest power saving level 
that the device can be put into. As you can see from the above (and other 
similar S3D methods) the result depends on the OSFL variable, which is 
defined with:

         Method(_INI) {
            \_SB_.PCI0.SBRG.IODT()
            If(MCTH(\_OS_, "Microsoft Windows NT")) {
                Store(0x0, OSFL)
            }
            Else {
                If(MCTH(\_OS_, "Microsoft Windows")) {
                    Store(0x1, OSFL)
                }
                Else {
                    If(MCTH(\_OS_, "Microsoft WindowsME: Millennium Edition"))
                   {
                        Store(0x2, OSFL)
                    }
                    Else {
                        Store(0x3, OSFL)
                    }
                }
            }
        }

So for under Linux, the OSFL will be 3, and _S3D methods will return 2. My 
question is, does the kernel make use of this information at all? Is it worth 
editing the DSDT so that OSFL=0 (i.e. Windows NT) ?

Thanks

John



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
