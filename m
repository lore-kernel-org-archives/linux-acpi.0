From: <graik-S0/GAf8tV78@public.gmane.org>
Subject: problems with patch acpi-20020725 and Suse kernel
Date: Sun, 4 Aug 2002 23:47:17 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200208042147.g74LlHX22652@mailgate5.cinetic.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
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

Hi,

I just applied patch acpi-20020725 to my standard Suse 2.14.18-4GB kernel. The patching fails in several files:

First: 
linux-24/arch/i386/kernel/acpitable.c
Reversed (or previously applied) patch detected!

then there are failed patches reported for:
mpparse.c
mm/init.c
acpi_ksyms.c

Compilation of the kernel stopped in acpi_ksyms.c. I could "fix" this by commenting out  lines 31, 97, 98:
   #ifdef CONFIG_ACPI_INTERPRETER
   acpi_hw_register_bit_access
   acpi_hw_obtain_sleep_type_register_data
Actually I haven't got a clue what I am doing there but it sort of worked..

Unfortunately, on my Evo N160 the new kernel stopped booting after reporting some IRQ's. But this seems to be already a different topic as it has been reported before for this notebook...

Is there a Suse-specific patch available, or should I revert to the standard kernel (which one)? 
Has anyone managed to get ACPI functionality on the Evo N160?

Best regards
Raik

______________________________________________________________________________
ich.bin-WUNohcmBtvU@public.gmane.org - nur eine der witzigsten E-Mail-Adressen der Welt! 
Interesse? Klicken! http://digitaledienste.web.de/MyAdress/?mc=021104



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
