From: "Wilkinson, Alex" <alex.wilkinson-7BNmJD1m9TP299njBJCvBrpzq4S04n8Q@public.gmane.org>
Subject: ACPI; S5 state; powerbutton->clean shutdown
Date: Fri, 7 Jan 2005 11:26:52 +1030
Message-ID: <20050107005652.GA17647@squash.dsto.defence.gov.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hi all,

Can some please recommend to me the correct method in Linux to confirm
whether or not pressing the power-button on an ATX box triggers an ACPI
state S5 (for both 2.6 and 2.4 kernels).

In the FreeBSD world I would do something like:

   #sysctl hw.acpi.power_button_state
   hw.acpi.power_button_state: S5
   
   #grep acpi_button /var/run/dmesg.boot
   acpi_button0: <Power Button> on acpi0

Distributions are Redhat 9.0, Fedora Core 3, and SuSE Enterprise 9.2.

Cheers

 -aW


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
