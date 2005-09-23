From: Berthold Cogel <cogel-F8dkAKZEjLURtNtAH2Wc8g@public.gmane.org>
Subject: acpi-20050902-2.6.13.diff: Problems to patch the kernel
Date: Fri, 23 Sep 2005 22:51:58 +0200
Message-ID: <43346AEE.7070103@rrz.uni-koeln.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Development <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hello!

I'm trying to patch the kernel 2.6.13 with the latest patch
(acpi-20050902-2.6.13.diff). I get rejects for linux-2.6.13,
linux-2.6.13.1 and linux-2.6.13.2:

Hunk #3 FAILED at 353.
1 out of 3 hunks FAILED -- saving rejects to file arch/ia64/Kconfig.rej

Hunk #4 FAILED at 2062.
1 out of 4 hunks FAILED -- saving rejects to file
drivers/char/ipmi/ipmi_si_intf.c.rej

Regards,

Berthold


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
