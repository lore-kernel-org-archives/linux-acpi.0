From: Stian Jordet <liste-NI9zH3lwcMKHXe+LvDLADg@public.gmane.org>
Subject: ACPI in kernel 2.5.68 works better (for me) than 2.5.69
Date: 06 May 2003 02:29:46 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1052180986.1005.3.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

Since kernel 2.5.69, usb no longer work with acpi on my computer. With
2.5.68 it did. Do you know what changes you have done might cause this?

I get this error, but this one is with both .68 and .69.

ACPI-0109: *** Error: No object was returned from
[\_SB_.PCI0.PX40.IRDA._STA] (Node dff5cc80), AE_NOT_EXIST

This is a Asus CUV266-DLS smp motherboard, and thus I need acpi to power
it off, and it would have been very, very much apprpeciated if this
somehow could be fixed before 2.6, atleast. I don't want to be running
2.5.68 for ever :)

Best regards,
Stian



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
