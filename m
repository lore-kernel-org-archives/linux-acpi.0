From: Pierre Chifflier <chifflier-Rhs21ED664o@public.gmane.org>
Subject: Acpi on compaq N620C
Date: Mon, 27 Oct 2003 11:28:34 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031027102834.GA22841@image4.cpe.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

I'm trying to get ACPI working on a Compaq Evo N620C.

Whatever version of the kernel i try (2.4.22, 2.6.0-test[89]) i'm
getting these messages at boot:

ACPI: Subsystem revision 20031002
ACPI: IRQ 9 was Edge Triggered, setting to Level Triggerd
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
    ACPI-1120: *** Error: Method execution failed [\_SB_.C046.C052] (Node cffbdc40), AE_AML_BUFFER_LIMIT
    ACPI-1120: *** Error: Method execution failed [\_SB_.C046.C056] (Node cffbdc20), AE_AML_BUFFER_LIMIT
    ACPI-1120: *** Error: Method execution failed [\_SB_.C046._CRS] (Node cffbdc00), AE_AML_BUFFER_LIMIT
    ACPI-0098: *** Error: Method execution failed [\_SB_.C046._CRS] (Node cffbdc00), AE_AML_BUFFER_LIMIT
ACPI: PCI Root Bridge [C046] (00:00)

Despite this message, ACPI *seems* to work

I can load modules processor, thermal, ac, fan & button without errors

'modprobe battery' gives:
    ACPI-1120: *** Error: Method execution failed [\_SB_.C046.C059.C0E4.C153] (Node c12c2940), AE_AML_UNINITIALIZED_LOCAL
    ACPI-1120: *** Error: Method execution failed [\_SB_.C046.C059.C0E4.C162] (Node c12c2840), AE_AML_UNINITIALIZED_LOCAL
    ACPI-1120: *** Error: Method execution failed [\_SB_.C1B1._BTP] (Node c12c0c40), AE_AML_UNINITIALIZED_LOCAL
ACPI: Battery Slot [C1B1] (battery present)
ACPI: Battery Slot [C1B2] (battery absent)


Now, it gets worse:

I often have two progs reading battery level: gkrellm and wmbattery. I can't
tell when this happends exactly (mainly if I switch from console to X) but
these processes frequently get stuck in "D" state.

If I try acpi sleep functions the screen goes black and nothing will get it
back (I need to force hard reboot 2 times)

I do not know well ACPI, but i'd like to help if it is possible ... just tell
me how.
I have dumped all infos (using acpidmp, dmidecode, iasl etc.) but as it
is quite big i've not attached it to this mail.


Thank you for your help,

/P
-- 
chifflier-Rhs21ED664o@public.gmane.org
BOFH excuse #348:

We're on Token Ring, and it looks like the token got loose.


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
