From: Michael Frank <mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org>
Subject: ACPI button module - USB interaction during unload
Date: Wed, 14 May 2003 20:22:57 +0800
Sender: linux-usb-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200305142022.57709.mflt1@micrologica.com.hk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: linux-usb-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:linux-usb-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:linux-usb-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org, linux-usb-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Rob Miller <rob-7HoZ3oJp7ZtBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

2.4.21-rc1 + acpi2003 04 24

Problems: Unloading of button modules generates messages below when having usbcore loaded with either usb-ohci or usb-uhci

May 14 16:18:00 mhfl2 kernel: evxfevnt-0318 [23] acpi_disable_event    : Could not disable power_button events
May 14 16:18:00 mhfl2 kernel:  evxface-0172 [22] acpi_remove_fixed_even: Could not write to fixed event enable register.
May 14 16:18:00 mhfl2 kernel: acpi_button-0453 [21] acpi_button_remove    : Error removing notify handler
May 14 16:18:00 mhfl2 kernel: usb.c: USB disconnect on device 00:14.0-0 address 1
May 14 16:18:00 mhfl2 kernel: usb.c: USB bus 1 deregistered
May 14 16:18:00 mhfl2 kernel: usb.c: deregistering driver usbdevfs
May 14 16:18:00 mhfl2 kernel: usb.c: deregistering driver hub

Notes: 
1) This problem does not show in 2.5.69.

2) unloading of button module without USB loaded OK.
  
Any suggestions how this can be fixed?

Regards
Michael


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

_______________________________________________
linux-usb-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
