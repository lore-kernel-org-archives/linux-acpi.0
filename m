From: Benedek Frank <linux-mmCHBaZtUya2oZ/6fjIToQ@public.gmane.org>
Subject: LID button Event ACPI malfunction
Date: Tue, 21 Dec 2004 16:26:16 -0800
Message-ID: <200412211626.17033.linux@celifornia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hi

When I shut down, my machine (Dell 700m) goes into suspend to ram twice. I 
have to wake it 
up, and it goes further, sleeps again, wake it up, and finally shuts down. I 
just had ACPI worked out (kernel 2.6.9), and since just recently I can go to 
suspend to RAM 
and DISK as well. Now, why a shut down triggers a suspend-to-ram?

When I look at the LID button under ACPI

/proc/acpi/button/lid/LID0/state

it says 

state: closed

It is clearly not closed, as I am looking at the screen. :)

I have an ACPI event that gets triggered when I REALLY close the lid, and that 
works.

Here is the event

/etc/acpi/event/lidbtn

event=button/lid
action=/etc/acpi/lidbtn.sh

And here is the script

/etc/acpi/lidbtn.sh

#!/bin/sh
/sbin/sleep

And finally here is /sbin/sleep, that was written by me for the machine's 
special needs (like module unloading, video_post etc.)

rmmod b44
echo "mem" > /sys/power/state
#echo 3 > /proc/acpi/sleep
modprobe i830
/root/emu/video_post
modprobe b44
/etc/init.d/networking restart

Thanks for any help

Ben


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
