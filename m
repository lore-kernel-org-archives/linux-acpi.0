From: ole.rohne-vJEk5272eHo@public.gmane.org
Subject: Re: Suspend-to-RAM on Sony Vaios
Date: Mon, 01 Nov 2004 16:17:56 +0100
Message-ID: <yzo3bztwqcb.fsf@cern.ch>
References: <20041018020816.48673359@localhost.localdomain>
	<20041018112632.GB4400@openzaurus.ucw.cz>
	<20041021001331.69c6c965@localhost.localdomain>
	<20041020225334.GC29863@elf.ucw.cz>
	<20041101145410.GB12006@tate.loria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041101145410.GB12006-xkTd+U360DcAs8EywTwl9A@public.gmane.org> (Emmanuel
 =?iso-8859-1?q?Thom=E9's?= message of "Mon, 1 Nov 2004 15:54:10 +0100")
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?iso-8859-1?q?Emmanuel_Thom=E9?= <Emmanuel.Thome-MZpvjPyXg2s@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Jon Valvatne <jon-hc6/xhmWZxdWk0Htik3J/w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Emmanuel> Ole, do you mind having your code wrapped up this way ?

Not the least! Thank you very much for picking it up! - it has become
clear that I wouldn't ever have the capacity of bringing it beyond the
"works for me" stage:-)

Emmanuel> I'd be curious to know whether other machines than my Dell
Emmanuel> D600 (with a radeon 9000) and Ole's Fujitsu P2120 (with a
Emmanuel> radeon 7000) work with this hack.

And I'm even more curious about why it doesn't work on some machines...

Emmanuel> A few annoying bits, still:

Emmanuel> When the machine resumes (using s3_late_bios), hitting a key
Emmanuel> seems to be necessary to finish the wakeup. Weird.

On the P2120, this rarely happens, and I think only if the machine was
under heavy load when suspended. I'm guessing it is a missing
interrupt. Linux reenables interrupts early, and some of the drivers'
resume code could depend on getting at least one event to complete.

Emmanuel> At present, I can resume with video=radeonfb:off
Emmanuel> acpi_sleep=s3_late_bios , but not from a VESA mode:

On the P2120, resuming from the hires framebuffer console works, I
haven't even tested the 80x25:-)

Ole




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
