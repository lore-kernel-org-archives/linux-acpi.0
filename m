From: Michael Madore <mmadore-JChM1cqIHx8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Reboot on shutdown with USB 2.0
Date: Fri, 28 Mar 2003 15:41:08 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E84DD94.4080508@aslab.com>
References: <F760B14C9561B941B89469F59BA3A84725A23B@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Grover, Andrew wrote:

>>From: Michael Madore [mailto:mmadore-JChM1cqIHx8AvxtiuMwx3w@public.gmane.org] 
>>    
>>
>
>  
>
>>I'm having a strange problem regarding ACPI and USB 2.0 devices 
>>(External CD-Rom, Jaz drive, etc).  Using 2.4.21-pre5 with the latest 
>>patch if I issue:
>>
>>shutdown -h now
>>
>>The machine shuts off, but half a second later the power 
>>comes back on. 
>> If I unload the echi driver module, the machine shuts off normally.
>>
>>Any thoughts on what would cause that kind of behavior?
>>    
>>
>
>Is this an SMP system? Just curious.
>  
>
Yes, this particular system is SMP.  I'll have to try it with a UP 
kernel just to see if the problem persists.

>What we should be doing (but aren't) is telling each device's driver on
>the system to deactivate its device before we turn off the system power.
>This gives the driver the chance to disable that device's interrupt
>generation. We haven't gotten that far in the driver model work, so what
>we are doing is disabling interrupts and then powering down. This mostly
>works, but isn't really how we want things to work, and is pretty much
>doomed to fail on SMP systems.
>
>I don't know why the ehci device would specifically be the one to cause
>problems...
>  
>
That makes sense, thanks for the explaination.  As a workaround, perhaps 
we can modify the init scripts to unload the ehci driver during shutdown.

Mike Madore



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
