From: "Andreas Leppert" <wudmx-S0/GAf8tV78@public.gmane.org>
Subject: /proc/acpi/battery/BAT0/state present rate bug with patch
Date: Tue, 14 Sep 2004 14:12:37 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1561098668@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

i don't know if it's a real bug, but i had some trouble with /proc/acpi/battery/BAT0/state. present rate was sometimes ok and sometimes it had the value "unknown". 

i figured out that the patch from acpi.sf.net is the problem: if i build the kernel without this patch installed, everything is okay. but if i patch my kernel (and with the same config-file), present rate is "unknown" after a reboot.

tested on gentoo with development-sources 2.6.9-rc1 (with "latest" patch) and gentoo-dev-sources 2.6.8-r4.

perhaps someone else can reproduce it - or is it just my fault?

HTH
Andreas Leppert
_________________________________________________________
Mit WEB.DE FreePhone? mit hochster Qualitat ab 0 Ct./Min.
weltweit telefonieren! http://freephone.web.de/?mc=021201



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
