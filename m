From: chirag <nisha_rajyaguru-xFOqZoH7zVZ4Eiagz67IpQ@public.gmane.org>
Subject: strace acpid shows weired line
Date: Mon, 03 Jan 2005 21:47:36 +0900
Message-ID: <1104756456.4700.3.camel@YahooBB219031151066.bbtec.net>
Reply-To: chirag-9dAiHs7qY9HTsWAM89vZ1+0/RLrZM5er@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
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

Hi!

When I do strace acpid, one of the lines shows as follows.

open("/proc/acpi/event", O_RDONLY)      = -1 EBUSY (Device or resource
busy)
write(2, "acpid: can\'t open /proc/acpi/event"..., 60acpid: can't
open /proc/acpi/event: Device or resource busy) = 60

Does it have anything to do that none of my button events are logged??
  
Could someone help me out why this is happening? I am using mandrake
10.1 with uname -r showing 2.6.8.1-20mdk.





-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
