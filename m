From: Rob North <tzwvgwv2001-O/bDAPVd7B0N+BqQ9rBEUg@public.gmane.org>
Subject: Re: [PATCH] IRQ params patch#4
Date: Sat, 19 Jul 2003 11:49:04 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <bfb7kv$oas$1@main.gmane.org>
References: <200307151142.12738.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200307151142.12738.adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Andrew de Quincey wrote:
> OK, patch#3 is way too strict... thought a bit more about it, and I suppose 
> the BIOS not allocating some devices an IRQ is actually OK....
> 
> Anyway, patch#4 now just warns the user if an attempt to set an IRQ results in 
> a different IRQ than expected, and attempts to abort ACPI irq routing. 
> Unfortunately, it isn't able to undo the changes it has made to the routing 
> as it would have to call the _SRS method to do it... and its just found out 
> that that is buggy. So at the moment it probably won't be able to 
> automatically "fix" devices already programmed when dropping back to a 
> different method (it can't on my board). Sigh.
> 
> Anyway, the warning should at least help find which boards have bad ACPI IRQ 
> routing.
> 

I've applied this patch to 2.4.22-pre3-ac1. (Needed to patch some of it 
by hand)
It seems to work for my Asus A7N8X Deluxe. I've only checked that all 
drivers succesfully connect to devices. I have not checked wether all 
the devices work yet.

Many thanks
	-Rob.




-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
