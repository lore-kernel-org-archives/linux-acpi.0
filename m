From: Michael Stucki <mundaun-OI3hZJvNYWs@public.gmane.org>
Subject: Strange error message: Could not allocate new owner_id
Date: Sun, 17 Jul 2005 16:21:43 +0200
Message-ID: <o46qq2-k8a.ln1@nb02.mstucki.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
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

Hello,

yesterday I've upgrade my laptop from 2.6.11 to 2.6.12. Applied Bootsplash,
SwSusp and the ACPI patches.

All went trough and my laptop is up again.

However, I notice a lot of error messages in the syslog file:

--- cut ---
kernel:     ACPI-0509: *** Error: Method execution failed [\_SB_.BAT1.UPBI] (Node c1434ee0), AE_OWNER_ID_LIMIT
kernel:     ACPI-0509: *** Error: Method execution failed [\_SB_.BAT1._BIF] (Node c1434f20), AE_OWNER_ID_LIMIT
kernel:     ACPI-0098: *** Error: Could not allocate new owner_id (32 max), AE_OWNER_ID_LIMIT
kernel:     ACPI-0509: *** Error: Method execution failed [\_SB_.BAT1.UPBI] (Node c1434ee0), AE_OWNER_ID_LIMIT
kernel:     ACPI-0509: *** Error: Method execution failed [\_SB_.BAT1._BIF] (Node c1434f20), AE_OWNER_ID_LIMIT
kernel:     ACPI-0098: *** Error: Could not allocate new owner_id (32 max), AE_OWNER_ID_LIMIT
kernel:     ACPI-0509: *** Error: Method execution failed [\_SB_.BAT1._BIF] (Node c1434f20), AE_OWNER_ID_LIMIT
kernel:     ACPI-0098: *** Error: Could not allocate new owner_id (32 max), AE_OWNER_ID_LIMIT
kernel:     ACPI-0509: *** Error: Method execution failed [\_SB_.BAT1._BIF] (Node c1434f20), AE_OWNER_ID_LIMIT
kernel:     ACPI-0098: *** Error: Could not allocate new owner_id (32 max), AE_OWNER_ID_LIMIT
last message repeated 36 times
last message repeated 66 times
last message repeated 66 times
last message repeated 37 times
kernel: codec_semaphore: semaphore is not ready [0x1][0x701300]
kernel: codec_read 0: semaphore is not ready for register 0x2c
kernel:     ACPI-0098: *** Error: Could not allocate new owner_id (32 max), AE_OWNER_ID_LIMIT
last message repeated 33 times
--- cut ---

It doesn't seem to hurt much, but as a bad side-effect of this, I am not
able to watch the battery status anymore.

Thanks for any help!
- michael



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
