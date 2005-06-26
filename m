From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Suspend to RAM issus on a Dell 700m
Date: Sun, 26 Jun 2005 23:11:07 +0200
Message-ID: <20050626211107.GA1315@elf.ucw.cz>
References: <42BED9A0.9050803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <42BED9A0.9050803-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Petros Kolyvas <pkolyvas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> I finally got the "mem" state to function on my laptop (a state which I 
> use extensively in that "other" OS when I'm working.)
> 
> A few issues though... my cpu, upon return, powers up to full-speed 
> making it impossible to truly conserve power, sort of defeating the 
> whole process.
> 
> It seems a rogue process (one which I can't kill)... listed only as 'sh 
> -i" is using ~99% of the available CPU cycles. I have no idea where it's 
> coming from.
> 
> Additionally the system gets less and less responsive with each return 
> from the "mem" state. Probably due to many of these rogue processes 
> building up and bogging the system down.
> 
> Below is the script I used, which I found online and modified (very 
> little) as needed. Any insight would be greatly appreciated. Oh, I'm 
> using FC4 w/ 2.6.12 (unpatched.)

Are you using preempt by chance? See wchan where the sh -i is
running... then debug it :-).
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
