From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: System hang when trying to enter sleep/standby state
Date: Wed, 12 Feb 2003 10:47:59 -0600 (CST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33.0302121042480.1479-100000@localhost.localdomain>
References: <1044987042.1149.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1044987042.1149.4.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Erik van Pienbroek <admin-0LxUhLuGNoZIf6P1QZMOBw@public.gmane.org>
Cc: ACPI Mailinglist <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


On 11 Feb 2003, Erik van Pienbroek wrote:

> Hi,
> 
> I've experimented a little bit more with ACPI and found out the
> following things :
> With kernel 2.4.21-pre4 when I tried to echo "5" to /proc/acpi/sleep
> the console would be killed an the following Oops appeared in the logs :

I would recommend never, ever doing 'echo 5 > /proc/acpi/sleep', 
especially if you're trying to suspend the system. 

S5 (the state the system enters when you do that) is defined as 'Soft 
Off'. It is equivalent to what ACPI does when you shut down the system and 
it automatically powers it off for you. You cannot resume from it; you 
must restart the machine. 

The reason it's defined by the spec is to a) allow software to power down 
the system, and b) allow some events to trigger a power on by the firmware 
(like wake-on-lan). 

ACPI should not allow a user to write '5' to that file. It used to be that 
way, but someone clever decided that that interface should support _all_ 
sleep states. (It might have been me, in one of my finer moments). 


Andy, I recommend removing that from 2.4, and I'll send you a patch for 
2.5..

	-pat



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
