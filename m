From: Fred Labrosse <ffl-4CLdheC3Iye1Qrn1Bg8BZw@public.gmane.org>
Subject: Laptop does not halt or reboot anymore
Date: Mon, 1 Nov 2004 16:12:38 +0000
Message-ID: <16774.24694.899426.241786@aber.ac.uk>
References: <16768.61140.778090.570927@aber.ac.uk>
	<16769.64564.408964.717856@aber.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <16769.64564.408964.717856-4CLdheC3Iye1Qrn1Bg8BZw@public.gmane.org>
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

Fred Labrosse writes:
 > Fred Labrosse writes:
 >  > All,
 >  > 
 >  > My laptop does not halt (reboots straight away) or reboot (just hangs at
 >  > the last stage of the shutdown process) since 2.6.7 (see my other message
 >  > on battery status).
 >  > 
 >  > I have seen another post on a similar issue, but without any reply.
 >  > 
 >  > My machine is an ACER TM636.
 >  > 
 > 
 > Some more info on that following some more tests I made.  I also have
 > problems with battery and temperature status (see my posts on "Battery
 > status wrong from 2.6.7").  The problem seems to happen when I run on
 > batteries only and does not happen when I run on AC.
 > 
 > When I run on AC, /sbin/halt does halt the computer, but it restarts right
 > after that.  After a short while of running on battery, /sbin/halt finishes
 > with "Power down" printed on the console but the computer does not power
 > down, as when I had "Enhanced Real time counter" enabled, which I haven't
 > now.
 > 
 > So it seems that the whole ACPI part of the kernel dies when I run on
 > batteries.
 > 

Sorry, doing more tests reveal that this only happens in 2.6.9.  I just
tried in 2.6.8.1 and it worked. (The thing happening from 2.6.7 and above
is the battery and temperature status.)

The laptop rebooting as soon as halted is also reported in bug 3669.

Hope this helps.

Fred



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
