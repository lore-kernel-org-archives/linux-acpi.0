From: Jean-Michel POURE <jm.poure-3sKltW3hOZpWj0EZb7rXcA@public.gmane.org>
Subject: power-off problem : ASUS K7 + ASUS L3800 + Kernel 2.6-pre9
Date: Tue, 16 Dec 2003 12:04:14 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200312161204.14477.jm.poure@freesurf.fr>
Reply-To: jm.poure-3sKltW3hOZpWj0EZb7rXcA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
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

Dear friends,

I recently installed Debian 2.6-pre9 kernel on two ASUS computers: a K7 
terminator and a L3800 laptop. Previously, I was using apm under kernel 2.4.

Under the nex kernel, ACPI seems to work fine as I can monitor various 
information. The problem is that both computers do not power-off.

When pressing the button, /etc/acpi/powerbtn.sh is executed and init 0 is 
trigerred.

if ps -Af | grep -q '[k]desktop' && test -f /usr/bin/dcop
then
    dcop --all-users ksmserver ksmserver logout 0 2 0 && exit 0
fi

/sbin/init 0

But the computers do not shut-down cleanly (no power-off). I checked their 
BIOS and in both cases, the latest versions are installed. /var/log/acpid 
shows normal information:

[Mon Dec 15 16:45:43 2003] received event "button/power PWRF 00000080 
00000001"
[Mon Dec 15 16:45:43 2003] executing action "/etc/acpi/powerbtn.sh"
[Mon Dec 15 16:45:43 2003] BEGIN HANDLER MESSAGES
[Mon Dec 15 16:45:44 2003] END HANDLER MESSAGES
[Mon Dec 15 16:45:44 2003] action exited with status 0
[Mon Dec 15 16:45:44 2003] completed event "button/power PWRF 00000080 
00000001"
[Mon Dec 15 16:45:46 2003] exiting

Do I miss something? This power-off question is quite a problem for me as 
everytime I start the computers, ext3 recovers files. Can anyone help me?

Best regards,
Jean-Michel



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
