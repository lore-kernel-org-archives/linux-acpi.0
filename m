From: mmadore <mmadore-LGgQ8o1HsRFeoWH0uzbU5w@public.gmane.org>
Subject: Supermicro P8SC8 won't power off
Date: Tue, 28 Dec 2004 10:11:45 -0800
Message-ID: <5d1f89c06e91128def06736b4b788017@www.blargmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
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

Hi,

I have a Supermicro P8SC8 motherboard that won't poweroff with ACPI using the 2.4 kernel series.  I have testing it with 2.4.25, 2.4.27, 2.4.28 and 2.4.29-pre2.  In all cases, the system enters acpi_enter_sleep_state after which, the keyboard leds flash once and the screen goes blank.  The system remains in this state with the power still on.  If I try to reboot the system via the reset switch, the machine never POSTS.  I have to remove and re-insert the power cord to boot the system again.

With 2.6.9, the machine powers off as expected.  Can anyone offer any advice on how to debug this problem?

Thanks

Mike




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
