From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Call for help: list of machines with working S3
Date: Tue, 15 Feb 2005 19:57:14 +0100
Message-ID: <4212460A.4000100@gmx.net>
References: <20050214211105.GA12808@elf.ucw.cz> <20050215125555.GD16394@gamma.logic.tuwien.ac.at> <42121EC5.8000004@gmx.net> <20050215170837.GA6336@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050215170837.GA6336-DqSSrKF0TaySnEC3TeqHn5dqbFPxfnh/@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Norbert Preining <preining-DX+603jRYB8@public.gmane.org>
Cc: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, seife-l3A5Bk7waGM@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Norbert Preining schrieb:
> On Die, 15 Feb 2005, Carl-Daniel Hailfinger wrote:
> 
>>To suspend and resume properly, call the following script as root:
> 
> 
> Success. 

Great!


> After deactivating DRI in the X config file and saving the states with
> your script (thanks) and turning off various stuff I get X running
> again.
> 
> Questions:
> - DRI must be disabled I guess?! Even with newer X server (x.org)?

I never disabled it.

> - I dont have to restore the font, it is back without any problem
>   (I have vga console)

Good. I guess that's highly chipset-specific.

> - Sometimes I have to make a Sysrq-s (sync) to get some stuff running
>   (eg logging in from the console hangs after input of passwd, calling
>   sysrq-s makes it continue). I had a similar effect when logging in
>   AFTER resuming (for the resume I had only gdm running but wasn't
>   logged in) the GNOME starting screen stayed there indefinitely, no
>   change. Even after restarting the X server and retrying.
>   Logging in with twm session DID work without any problem.
>   Do you have any idea what this could be?

Pavel?

> - My script is a bit more complicated: stopping: hotplug, mysql,
>   ifplugd, waproamd, cpufreqd, acpid, ifdown eth0, eth1, rmmod acerhk
>   echo "performance" onto governor, then going to sleepand doing
>   more or less the reverse stuff after waking up.
>   DO you have any experience with hotplug network etc stuff, working
>   even without stopping?

I used to unload modules, shutdown network interfaces etc. until I
tried without all that stuff and it still worked. So I concluded
that stopping things before suspend was a thing only needed with
older kernels. Granted, mounted volumes on USB or IEEE1394 still
have problems because the kernel doesn't expect them to disappear
for a few moments, but that's nothing a module unload would fix.
Simply umount all external drives and use my script. Drivers which
still need to be unloaded and reloaded are buggy and have to be
fixed.

I'll prepare a web page with detailed S3/S4 suspend/resume
information for ATI graphics card owners including step-by-step
howtos for smooth suspend/resume cycles.

Kendall Bennett is working with me to get suspend/resume working
even with framebuffers. Once we have results, I'll post them here.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
