From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Fw: 2.6.12 hangs on boot
Date: Thu, 23 Jun 2005 01:14:23 -0700
Message-ID: <20050623011423.0f72187f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: "Alexander Y. Fomichev" <gluk-IEI71MnrQTM@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org



Begin forwarded message:

Date: Wed, 22 Jun 2005 18:13:49 +0400
From: "Alexander Y. Fomichev" <gluk-IEI71MnrQTM@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: admin-QYz/2UuD9VIox3rIn2DAYQ@public.gmane.org
Subject: 2.6.12 hangs on boot


G' day

I've been trying to switch from 2.6.12-rc3 to 2.6.12 on Dual EM64T 2.8 GHz
[ MoBo: Intel E7520, intel 82801 ]
but kernel hangs on boot right after records:

Booting processor 2/1 rip 6000 rsp ffff8100023dbf58
Initializing CPU#2

( below is a link to full boot trace, actually -git3 but no differences)
http://sysadminday.org.ru/2.6.12-hang-on-boot/2.6.12-git3-hang

An attempt to enable debug:
+CONFIG_ACPI_DEBUG=y
+CONFIG_DEBUG_SLAB=y
+CONFIG_DEBUG_PREEMPT=y
+CONFIG_DEBUG_SPINLOCK=y
+CONFIG_DEBUG_SPINLOCK_SLEEP=y
+CONFIG_DEBUG_KOBJECT=y
+CONFIG_DEBUG_INFO=y
+CONFIG_INIT_DEBUG=y
gives rather strange result, kernel boots successfully ( with a lot of
debuging messages of course but i couldn't find something suspicious )
http://sysadminday.org.ru/2.6.12-hang-on-boot/2.6.12-git3-debug

config for 2.6.12 have been taken from previous one, only
'make oldconfig' has been made.
http://sysadminday.org.ru/2.6.12-hang-on-boot/2.6.12-git3.config

Hang 100% reproducible on at least two of my EM64T hosts.
( actualy the same configuration as of MoBo/CPU )

-- 
Best regards.
        Alexander Y. Fomichev <gluk-IEI71MnrQTM@public.gmane.org>
        Public PGP key: http://sysadminday.org.ru/gluk.asc
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
