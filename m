From: Paul Menage <menage-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: ACPI global lock macros
Date: Tue, 09 Dec 2003 01:50:16 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FD59AD8.1060507@google.com>
References: <3FD59441.2000202@google.com> <1070962573.5223.2.camel@laptop.fenrus.com> <3FD5990A.9020908@google.com> <20031209094356.GA19702@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031209094356.GA19702-s/M1imWmeEoQw3kMeb7FcACJwEvxM/w9@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Arjan van de Ven <arjanv-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Arjan van de Ven wrote:
>>>maybe the odd thing is that it exists at all?
>>>(eg why does ACPI need to have it's own locking primitives...)
>>
>>Because the ACPI spec defines its own locking protocol for 
>>synchronization between the OS and the BIOS.
> 
> 
> ... which can't be written based on linux locks ?

I assume (hope!) there's already a higher-level linux lock serializing 
access to acpi_acquire_global_lock() although I've not delved deeply 
into the code. This is the lock described on p112 of 
http://www.acpi.info/DOWNLOADS/ACPIspec-2-0c.pdf, which has the 
semantics that if the OS wants to take the lock while the BIOS holds it, 
it sets a bit and waits for an interrupt from the BIOS. I don't see that 
it could be naturally implemented using a linux lock.

Paul



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
