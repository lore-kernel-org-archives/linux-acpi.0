From: Nicolas Bessert <Nicolas.Bessert-rrVOh9T094gb1SvskN2V4Q@public.gmane.org>
Subject: Sleep on an ASUS M2400
Date: Thu, 01 Aug 2002 21:27:49 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3D498BB5.6070902@lanscape.de>
Reply-To: Nicolas.Bessert-rrVOh9T094gb1SvskN2V4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,
I have an ASUS M2400 with an AWARD Bios but
"echo -n 1> /proc/acpi/sleep"
did not have any effect.
I use a 2.4.18 Kernel with
acpi-20020709-2.4.18.diff.gz
nocorruption.2.acpi.diff
CONFIG_ACPI_SLEEP.patch
Is this the current development status for the sleep mode,or is there
something missing in my patches or knowlage.

Thanks a lot

Nicolas

-- 
*********************************************************************
* Nicolas Bessert            email: Nicolas.Bessert-rrVOh9T094gb1SvskN2V4Q@public.gmane.org     *
* Berlin, Germany                                                   *
*             Make each program do one thing well.                  *
*********************************************************************



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
