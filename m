From: "Dino Klein" <dinoklein-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: Entering C3 Processor State without a Bus Arbiter
Date: Thu, 15 Jan 2004 17:29:23 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Law11-OE36TK4GXSNMh0000bd93@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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

Hello,

I'm curios as to why the implementation does not enter C3 without the presence of a Bus Arbiter; also, how come a comment in the
source claims that C3/WBINVD is too expensive?

After removing the restrictions in the source files, and adding a WBINVD instruction right before the read from P_LVL3 - the
processor was put in the C3 state. This is on my Via Apollo Pro133A based Abit VP6 board, which does not have a Bus Arbiter.
Just for the record, I did pull out the second CPU, so I can do "safer" experimentation.

Everything seemed to be working fine, the delay was quite noticeable (900 in the FACP) to the point that keystrokes were lost. In
essence, the computer was quite unusable. Nevertheless, in order to see if the system was still stable after the modifications, I
recompiled the kernel with "-j8" and everything worked fine; I even started X without problems.

I've seen a thread talking about how the processor was not put into C3 as often enough, when the USB drivers were loaded - in my
case I would say that it was put too often, this with the UHCI + EHCI + HID drivers loaded, and two mice and one hub attached.

Just thought I'd bring this up.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
