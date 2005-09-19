From: Nik Trevallyn-Jones <nik-DjZbVUabzA+jF4gvJNWmbtHuzzzSOjJt@public.gmane.org>
Subject: Ceased working on Dell D600 after update to 2.6.12
Date: Mon, 19 Sep 2005 16:19:00 +1000
Message-ID: <432E5854.4060902@babel.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi All,

This is not a complaint - I'm just looking for information. Suspend no 
longer works, and I really miss it!

Suspend was working fine on my Dell Latitude D600 running Fedora Core 3 
with the 2.6.11-1.27_FC3 kernel. I had to unplug the USB mouse before 
suspending, otherwise the mouse wouldn't come back up after resume, but 
that was a minor inconvenience.

I have just updated to kernel 2.6.12-1.1376_FC3, and cannot get ACPI 
configured or working. If I run klaptop_acpi_helper --suspend, 
absolutely nothing happens - not even an error message. I have tried 
configuring ACPI with the Klaptop applet, but it just told me that the 
helper application has the wrong permissions, regardless of how often I 
set the permissions. Now, some reboots later, the klaptop applet fails 
to start up (I don't even get a menu when I click on the applet icon).

/proc/acpi is populated with files and directories, and they seem to 
reflect the values that I configured with klaptop before it stopped working.

/proc/acpi/info says "version: 20050729"

acpid appears to be running, and is reporting no errors that I can see 
in the logs:

Sep 18 17:30:25 xxx acpid: acpid shutdown succeeded
Sep 18 21:03:13 xxx acpid: acpid startup succeeded
Sep 18 21:03:24 xxx kernel: ibm_acpi: Using generic hotkey driver
Sep 18 21:03:24 xxx kernel: toshiba_acpi: Using generic hotkey driver
Sep 18 23:45:49 xxx acpid: acpid shutdown succeeded
Sep 18 23:59:48 xxx acpid: acpid startup succeeded
Sep 18 23:59:58 xxx kernel: ibm_acpi: Using generic hotkey driver
Sep 18 23:59:58 xxx kernel: toshiba_acpi: Using generic hotkey driver
Sep 19 01:32:49 xxx acpid: acpid shutdown succeeded
Sep 19 09:49:52 xxx acpid: acpid startup succeeded
Sep 19 09:50:02 xxx kernel: ibm_acpi: Using generic hotkey driver
Sep 19 09:50:02 xxx kernel: toshiba_acpi: Using generic hotkey driver

I would really appreciate it if someone could please point me to 
information that might help me get it working again. Specifically:

Q1: Does anyone else with a D600 on 2.6.12 on FC3 have suspend or 
hibernate working?

Q2: Are there known things I should do, or known issues I need to avoid 
with this configuration?

Q3: I used YUM to update the kernel - would that have caused my working 
ACPI config to be overwritten?

Q4: Are there any HOWTOs or trouble-shooting guides to get me started?

Thanks in advance for any and all suggestions.


Cheers!
Nik.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
