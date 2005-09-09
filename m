From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] [2.6.13-mm2] set IBM ThinkPad extras to default n in Kconfig
Date: Fri, 9 Sep 2005 12:06:34 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30048FA292@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, akpm-3NddpPZAyC0@public.gmane.org, Borislav Petkov <petkov-xhPu7QH+N+StU9/U+hoEgQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


>Hi Andrew,
>
>   I think the following isn't on purpose but the IBM Thinkpad acpi
>   extras default to y in Kconfig. The patch below fixes it:
>
>   Signed-off-by: <petkov-xhPu7QH+N+StU9/U+hoEgQ@public.gmane.org>
>
>
>--- drivers/acpi/Kconfig.orig	2005-09-09 09:46:26.000000000 +0200
>+++ drivers/acpi/Kconfig	2005-09-09 09:46:46.000000000 +0200
>@@ -197,7 +197,7 @@ config ACPI_ASUS
> config ACPI_IBM
> 	tristate "IBM ThinkPad Laptop Extras"
> 	depends on X86
>-	default y
>+	default n
> 	---help---
> 	  This is a Linux ACPI driver for the IBM ThinkPad=20

Before we had "default m", since that is how a distro
is expected to compile this, and other, "ACPI drivers".

But we got complaits that _nothing_ should be "default m",
so I changed it to "default y".  Maybe that was simplistic --
button should be "default y", but the platform drivers should
all be "default n"?

I'm not sure what to do here -- what use-model
should we tune default Kconfig for?

thanks,
-Len


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
