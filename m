From: Garry Williams <gtwilliams-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: DSDT Error Object does not exist (PDC0)
Date: Sun, 24 Jul 2005 15:33:52 -0400
Message-ID: <1122233633.3173.66.camel@localhost>
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

On my Sony VGN-FS640/W I have three errors compiling my DSDT
(http://www.zvolve.com/~garry/dsdt.dsl).

dsdt.dsl   506:             If (LEqual (And (PDC0, 0x0A), 0x0A))
Error    1022 -           Object does not exist ^  (PDC0)
dsdt.dsl   511:             If (LEqual (And (PDC1, 0x0A), 0x0A))
Error    1022 -           Object does not exist ^  (PDC1)
dsdt.dsl   553:                         If (LNot (LEqual (And (PDC1, 0x0A), 0x0A)))
Error    1022 -                             Object does not exist ^  (PDC1)

ASL Input:  dsdt.dsl - 4185 lines, 135677 bytes, 1667 keywords
Compilation complete. 3 Errors, 0 Warnings, 0 Remarks, 1 Optimizations

Does anyone know why this is the case and what to do about it?

-- 
Garry Williams -- +1 (678) 656-4579



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
