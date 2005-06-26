From: Benedek Frank <linux-mmCHBaZtUya2oZ/6fjIToQ@public.gmane.org>
Subject: Re: Suspend to RAM issus on a Dell 700m
Date: Sun, 26 Jun 2005 21:25:36 +0200
Message-ID: <20050626212536.1345f132.linux@celifornia.com>
References: <BAYC1-PASMTP01AF878251E9C0DF5ECA1BD6EF0@cez.ice>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <BAYC1-PASMTP01AF878251E9C0DF5ECA1BD6EF0-vCQSkuYnZQ8@public.gmane.org>
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

On Sun, 26 Jun 2005 12:36:48 -0400
Petros Kolyvas <pkolyvas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Hi Folks,
> 
> I finally got the "mem" state to function on my laptop (a state which
> I  use extensively in that "other" OS when I'm working.)
> 
> A few issues though... my cpu, upon return, powers up to full-speed 
> making it impossible to truly conserve power, sort of defeating the 
> whole process.
> 
> It seems a rogue process (one which I can't kill)... listed only as
> 'sh  -i" is using ~99% of the available CPU cycles. I have no idea
> where it's  coming from.
> 
> Additionally the system gets less and less responsive with each return
> 
> from the "mem" state. Probably due to many of these rogue processes 
> building up and bogging the system down.
> 
> Below is the script I used, which I found online and modified (very 
> little) as needed. Any insight would be greatly appreciated. Oh, I'm 
> using FC4 w/ 2.6.12 (unpatched.)
> 
> Thanks,
> Pk

Hi

I have mine working perfectly, you may check my site, and compare a few
things.

http://www.celifornia.com/documents/dell700m.html

Hope it helps

Benedek
> 
> ///
> 
> script to drive the system to S3
> # suspend-to-ram
> 
> if [-e /suspending]; then
> 	echo "already in the process of suspending. Please be patient."
> else
> 	/bin/touch /suspending
> 
> 	# Step 1: preparing sleep
> 	/usr/bin/killall -s SIGUSR1 cpuspeed
> 	/usr/bin/chvt 1 # necessary to make DRI work
> 	/sbin/service anacron stop
> 	# USB doesn't suspend without unloading first
> 	/sbin/rmmod ehci_hcd
> 	/sbin/rmmod uhci_hcd
> 	#save the system time
> 	/sbin/hwclock --adjust
> 	#/sbin/rmmod wacom # only necessary of you have wacom stylus
> 	/sbin/rmmod -as
> 	/bin/sync
> 
> 	# Step 2: send sleep command via ACPI
> 	echo mem > /sys/power/state
> 
> 	# Step 3: wake-up and reload
> 	# restart the BIOS code for the video card
> 	/usr/bin/video_post
> 	# restore clock
> 	/sbin/hwclock --hctosys
> 	# reload USB modules
> 	/sbin/modprobe ehci_hcd
> 	/sbin/modprobe uhci_hcd
> 	# initialise X
> 	xinit /bin/false -- :1
> 	/usr/bin/chvt 7
> 	# restore resvices
> 	/sbin/service anacron start
> 	/sbin/service cpuspeed restart
> 
> 	rm /suspending
> fi
> 
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 
> 


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
