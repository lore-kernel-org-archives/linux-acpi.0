From: Alexander Bruder <anib-IUH8PdohV+QGVwEePk/RpQ@public.gmane.org>
Subject: Re: [2.6.6] Synaptics driver is 'jumpy'
Date: Mon, 17 May 2004 10:45:28 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40A87BA8.8020508@uni-paderborn.de>
References: <200405161222.48581.lkml@kcore.org> <200405170832.32256.lkml@kcore.org> <200405170142.41289.dtor_core@ameritech.net> <200405170904.24471.lkml@kcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200405170904.24471.lkml-gY0FE6dpLprYtjvyW6yDsg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jan De Luyck <lkml-gY0FE6dpLprYtjvyW6yDsg@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> Ok. Passing on to acpi-devel-5NWGOfrQmneRv+LV9MX5uti2KpX7p8Fi@public.gmane.org
> 
> I've looked in the archives, and the problem looks very much like the one in 
> this thread:
> 
> http://sourceforge.net/mailarchive/forum.php?thread_id=4172848&forum_id=6102
> 
> And I've been noticing some keyboard glitches too, but these were to 
> unfrequent, and usually occur only in one application (gaim) so I figured it 
> might be a bug in gaim... guess not...

I can confirm the problem not only in gaim but also on the console and 
other applications with 2.6.6 .

> Unfortunately, the hints in this thread don't help. I've browsed the input 
> system FAQ, but no dice.
> 
> The only thing that gives me a working synaptics touchpad is acpi=off.

Same for me (Acer TravelMate LciB 801).

> It worked fine with 2.6.5.
> 
> Jan
> 

Alexander


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
