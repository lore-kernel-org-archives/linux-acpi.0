From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: 2.5.69 - S3
Date: Mon, 19 May 2003 10:07:46 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030519080746.GA30651@hell.org.pl>
References: <200305140140.02188.mflt1@micrologica.com.hk> <200305182005.30192.mflt1@micrologica.com.hk> <20030518211245.GA452@elf.ucw.cz> <200305191153.51196.mflt1@micrologica.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200305191153.51196.mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Michael Frank <mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Michael Frank:
> Cute, Your velo S3 OK (before it died) ? - Do you know of any machines that really work with S3?

I've actually succeeded in getting my Asus L3800C into and out of S3,
though not without some hassle:
1) turning off DMA -- it seemed to work with DMA and a particular kernel
   version, but I may be wrong,
2) appending acpi_sleep=s3_mode to get my display reinitialized,
3) compiling keybdev and related as modules, logging on remotely after
   resume and reloading these turns the keyboard back on.

I didn't test much, as I was (and still am) plagued by a serious filesystem 
problem under 2.5.x, but AFAIK, though the S3 worked OK with the somehow
older kernels (2.5.61, possibly up to 63 or 65), the disk would always hang
with the newer ones (2.5.67, 69), regardless of the DMA setting.

Somehow, if I recall correctly, I was even able to do S3 with usb-uhci
loaded, which is strange because its presence always hangs my machine when 
leaving S1.

If you need any more info, I can do some further testing.

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
