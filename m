From: Jarek Zuk <j.zuk-QYlicCNJNu5TzFIbWlesCw@public.gmane.org>
Subject: ACPI wake up event (alarm)
Date: Thu, 15 Apr 2004 14:48:31 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200404151448.31556.j.zuk@cetelembank.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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


I have a question about ACPI alarm (/proc/acpi/alarm).

I have a cron job  that runs early in the morning, so I need my machine to be up at that time. 
I dont want to have it up all night, so I want to use the alarm feature.

I use kernel 2.4.25 with your corresponding patch. I read everything on acpi page about 
/proc/acpi/sleep and /proc/acpi/alarm .
What I want to do is :
echo 2004-04-15 14:40:00 > /proc/acpi/alarm 
echo 5 > /proc/acpi/sleep 

and get the computer up when the specified time comes.

My problem is that it works  sometimes, well what I noticed is that it works providing that 
before I put the system into sleep mode (5)  I do :
echo 1 > /proc/acpi/sleep 
(the power button starts blinking) 
press the button  ( system is awake ) 

When I  dont do this  "echo 1 > /proc/acpi/sleep" thing , the computer doesn't  turn on 
whet time comes. :(

Looks like putting system into a sleep mode 1 changes something that allows later to 
do proper wakeup.

Does the system have to be in sleep mode to be woken up by alarm event ? or it should work 
also after shutdown ?

I want to have this procedure in a script and presing the power button  is kinda difficult from a 
script. 

Any pointers are welcome.
Jarek Zuk 



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
