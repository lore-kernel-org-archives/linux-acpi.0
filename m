From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: System hang when trying to enter sleep/standby state
Date: Wed, 12 Feb 2003 21:36:37 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030212203637.GA32274@hell.org.pl>
References: <1044987042.1149.4.camel@localhost.localdomain> <Pine.LNX.4.33.0302121042480.1479-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0302121042480.1479-100000-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Cc: Erik van Pienbroek <admin-0LxUhLuGNoZIf6P1QZMOBw@public.gmane.org>, ACPI Mailinglist <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Patrick Mochel:
> ACPI should not allow a user to write '5' to that file. It used to be that 
> way, but someone clever decided that that interface should support _all_ 
> sleep states. (It might have been me, in one of my finer moments). 

May I ask: why? Is it really dangerous to leave it like it is now? Does it
break anything? I actually used it a couple of times, not bothering to hold
my poweroff button for the time needed to poweroff the machine completely.
As for potential dangers, I see many other ways of using the /proc 
interface that can be really *much* more harmful to the system, yet they
don't cease to exist. However confusing it might be now, it is fully
functional, at least. I can't really see any reason for crippling that
functionality. Please, do leave it the way it is.

Gosh, where's my manners... I hereby say hello to everyone. Hope you don't
take the above too personal or whatever, I'm a newbie to ACPI and I might
as well miss the whole point there.
Regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
