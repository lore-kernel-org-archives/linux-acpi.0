From: Ryan Hadley <rhadley-SquOHqY54CWNtvSE1QmJz5qQE7yCjDx5@public.gmane.org>
Subject: ACPI sleep issues on a Lattitude D500 (gentoo-dev-2.6.2)
Date: Thu, 19 Feb 2004 16:42:53 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40352DDD.5050004@interlinknetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

If I stick:

	echo -n "1" > /proc/acpi/sleep

To be called when my lid is closed bad things happen.

It seems to go to sleep just fine, but when I try to bring it out of 
sleep mode (by opening the lid and pressing power) things don't go fine. 
It outputs "Back to C!" followed by some things about the ide stuff 
coming back up and then does nothing. I have to hold the power button 
until it shuts off and then turn it back on to get it to respond again.

Then, when I check my /var/log/acpid.log file, I see this in it 
happening in between the start and stop markings of the lid button 
actions being called:

	/bin/sh: line 30: `start-single-daemon': not a valid identifier

Is that some perl script trying to be ran with /bin/sh as the 
interpreter? Could this be a cause of my hung system on power restore?

If I don't put the machine to sleep when the lid button is closed, just 
do other things like spin down the hard drive (hdparm -y /dev/hda), then 
nothing bad happens and there is no strange /bin/sh error in the acpid 
log file.

Any help would be greatly appreciated... All I found on google was the 
/bin/sh error being caused by a perl script being ran with /bin/sh as 
the interpreter instead of perl... but it was for a completely unrelated 
problem (not even ACPI related).

Thanks-
Ryan


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
