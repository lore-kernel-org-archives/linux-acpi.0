From: Luis Miguel Pires Neves <lneves-3+EeCmRbAIo+BYJ/izffpQ@public.gmane.org>
Subject: Re: ACPI button module - USB interaction during unload (Michael Frank)
Date: Thu, 15 May 2003 18:35:02 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200305151831.56182.lneves@estg.iplei.pt>
References: <E19Fvzb-0005LP-00@sc8-sf-list2.sourceforge.net>
Reply-To: lneves-3+EeCmRbAIo+BYJ/izffpQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <E19Fvzb-0005LP-00-ek0oC1U1TqqnvZpeIfgr/KQD96bmaF075NbjCUgZEJk@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: swsusp-LcL5texQODR2DW0IdvIQ2g@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This interaction is perhaps also the cause of the failure to unload usbcore=
=20
when using acpid to=20
trigger suspension (swsusp) and one presses the power button, in kernel=20
2.4.20 + acpi20021212 + swsusp beta19-16 and older versions.

Best regards,

Lu=EDs Neves
>
>Content-Type=3Dmessage/rfc822
>Content-Description=3Dembedded message
From: Michael Frank <mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org>
>To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org, linux-usb-devel@lists.sourceforge.net
>Date: Wed, 14 May 2003 20:22:57 +0800
>Cc: Rob Miller <rob-7HoZ3oJp7ZtBDgjK7y7TUQ@public.gmane.org>
>Subject: [ACPI] ACPI button module - USB interaction during unload

>2.4.21-rc1 + acpi2003 04 24

>Problems: Unloading of button modules generates messages below when having=
=20
>usbcore loaded with either usb-ohci or usb-uhci

>May 14 16:18:00 mhfl2 kernel: evxfevnt-0318 [23] acpi_disable_event    :=20
Could >not disable power_button events
>May 14 16:18:00 mhfl2 kernel:  evxface-0172 [22] acpi_remove_fixed_even:=20
Could >not write to fixed event enable register.
>May 14 16:18:00 mhfl2 kernel: acpi_button-0453 [21] acpi_button_remove    =
:=20
>Error removing notify handler
>May 14 16:18:00 mhfl2 kernel: usb.c: USB disconnect on device 00:14.0-0=20
>address 1
>May 14 16:18:00 mhfl2 kernel: usb.c: USB bus 1 deregistered
>May 14 16:18:00 mhfl2 kernel: usb.c: deregistering driver usbdevfs
>May 14 16:18:00 mhfl2 kernel: usb.c: deregistering driver hub

>Notes:=20
>1) This problem does not show in 2.5.69.

>2) unloading of button module without USB loaded OK.
 =20
>Any suggestions how this can be fixed?

>Regards
>Michael




-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
