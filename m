From: Marco Correia <mvc-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: a few questions about acpi
Date: Tue, 27 Jan 2004 13:12:11 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200401271312.11810.mvc@netcabo.pt>
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

hi,

I've been having some problems with acpi in my laptop (toshiba satellite pro 
4340). Also I have a few questions about ACPI in general:
(I'm using kernel 2.6.2-rc1)

1: I don't have a /proc/acpi/toshiba, even when I set CONFIG_ACPI_TOSHIBA in 
the kernel config. Why?

2: doing "cat /proc/acpi/sleep" shows
S0 S1 S3 S4 S4bios S5

but "echo 4|4b|5 > /proc/acpi/sleep" doesn't make anything. I looked in 
/var/log/ but I get no messages from acpi at all (even when setting 
CONFIG_ACPI_DEBUG in the kernel). What's wrong?

thanks
Marco
ps: Please email me directly since I'm not subscribed. thanks.

-- 
Marco Correia <mvc-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
