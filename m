From: "Prakash K. Cheemplavam" <PrakashKC-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: acpi problem with nforce motherboards and ethernet
Date: Fri, 06 Feb 2004 01:08:14 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4022DAEE.2030109@gmx.de>
References: <402298C7.5050405@wanadoo.es>	<40229D2C.20701@blue-labs.org>	<4022B55B.1090309@wanadoo.es> <20040205154059.6649dd74.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040205154059.6649dd74.akpm-3NddpPZAyC0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: =?ISO-8859-1?Q?Luis_Miguel_Garc=EDa?= <ktech-39ZsbGIQGT7e5aOfsHch1g@public.gmane.org>, david+challenge-response-qokYbnrgTHEgsBAKwltoeQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, a.verweij-oe7qfRrRQfeEZXFvZSAUrfP6llvjuJOh@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>>>What patches are you using?
>>
>>
>>I'm using nforce2-apic.patch and nforce2-disconnect-quirk.patch that 
>>Andrew Morton have sent to me. I think they have been included in 
>>previous mm kernels but now are droped because they caused some 
>>temperature problems for some people with no nforce motherboards.
> 
> 
> Yes, the patch which disables "Halt Disconnect and Stop Grant Disconnect"
> apparently causes the CPU to run hot.

Well, my temp is about 6-9°C hotter in idle mode, but with current 
kernels APIC (and no CPU diconnect) seems to be more stable than PIC and 
CPU Disconnect with my nforce. I at least don't have problems with 
forcedeth driver and current acpi.

>>By the way, is anyone involved in solving the IO-APIC thing in nforce 
>>motherboards? Anyone trying a different approach? Anyone contacting 
>>nvidia about this problem?
> 
> 
> As far as I know, we're dead in the water on these problems.

I remember Jesse Allan sending some lspci outputs to Bart to investigate 
the BIOS fix. I wonder what has happened to it. I tried to do a 
comparison with my values, but due to lack of some smart tools to show 
what is common and what is not (diff is not very suitable) it is very 
hard, esp if you have no knowledge about the actual meanings of those 
parameters.

Prakash



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
