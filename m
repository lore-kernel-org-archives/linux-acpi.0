From: Michael Hardy <mike-YPUHpfzIkGtIf6P1QZMOBw@public.gmane.org>
Subject: Re: lid switch on dell latitude d800 freezes system
Date: Thu, 15 May 2003 21:26:42 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3EC46882.50102@mikehardy.net>
References: <1053019947.4310.20.camel@localhost.localdomain> <1053049258.4929.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1053049258.4929.4.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Malcolm Caldwell <malcolm.caldwell-HU4z9rI8l8AQrrorzV6ljw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, markus-nyufa/AnP+9Wk0Htik3J/w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Seems to me like there are two separate paths to follow, one of which 
may only
be here because I haven't tested everything correctly -

1) work with nvidia and/or Dell - if loading the nvidia driver causes an 
ACPI
   interaction that locks the machine, it seems that it must be a vendor 
thing.
   I'd go with nvidia first just because they at least *try*, and might know
   something, then maybe followup with Dell

2) work with the open source nv authors to see if they can work out DPMS for
   the D800. This is where I might be ignorant, but I'm under the impression
   screen blanking doesn't work with the nv driver and getting it to 
work would
   get a very effective power-save state on lid close combined with ACPI S1.
   Obviously doesn't get you 3D, but I'd be quite happy if this worked

Mainly, I'm just glad I'm not crazy and someone else sees what I do :-). 
I've
posted this on my D800 site, and I'll be happy to test and chronicle 
anything
anyone finds out.

Thanks for putting in the effort to try and isolate this-
-Mike

Malcolm Caldwell wrote:

>Ok,
>
>I have more or less confirmed that the problem is, as Michael suggested,
>the nvidia driver.  If I never start X the lid button does nothing
>except log stuff into the log file.  With X started once, even if it is
>no longer running running the system freezes.
>
>So - what now?  Report this to nvidia?  Try to work this out in some
>other way?  Any hints where to look?
>
>On Fri, 2003-05-16 at 03:02, Malcolm Caldwell wrote:
>  
>
>>Hello,
>>
>>I am running 2.4.21-rc1 with acpi patches.  I have also patched to run a
>>custom dstc which I got from someone on the net.  (The interface at
>>acpi.sourceforge.net fails to find the dstc that it says are there -
>>however the author's email address is there and he sent it to me
>>directly)
>>
>>The only problem is that the lid switch freezes the machine.  As far as
>>I know the freeze only happens if something is reading from
>>/proc/acpi/events (although I would have to do some more testing to
>>verify this).
>>
>>Can anyone give any hints on how to go about fixing this?
>>
>>
>>
>>-------------------------------------------------------
>>Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
>>The only event dedicated to issues related to Linux enterprise solutions
>>www.enterpriselinuxforum.com
>>
>>_______________________________________________
>>Acpi-devel mailing list
>>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>>
>>    
>>



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
