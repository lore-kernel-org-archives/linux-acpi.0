From: Ulrich Dobramysl <uli-do-RbZlAiThDcE@public.gmane.org>
Subject: Re: Gericom Supersonic ACPI hang (smi_cmd)
Date: Sat, 12 Oct 2002 13:47:45 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3DA80BE1.5040609@gmx.at>
References: <3DA6F3C7.3040108@gmx.at> <000b01c27163$927d6e70$6600a8c0@rolilaptop>
Reply-To: Ulrich Dobramysl <uli-do-RbZlAiThDcE@public.gmane.org>
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
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Success!
Thanks a lot! Now it works.
I had to tweak some things in the source file arch/i386/kernel/mpparse.c 
because FIX_APIC_BASE, Dprintk, and apic_read aren't defined when APIC 
is disabled, but needed by ACPI? I got a lot of compiler errors when 
trying to build the kernel. I just commented some things out, and made 
some real bad hacks, but it compiles and works now. I don't think that 
this is the normal way of doing this? ;-)

S1 just works fine, MUCH better than with APM.
Now I have problems putting the laptop in S4 (swsusp) state. It seems 
like swsusp goes into an endless loop, with many warnings that he is 
scheduling in atomic state or something.

Sometimes, when trying to read some state files in /proc/acpi (the 
battery state and some other things too), the reading process (cat in my 
case) hangs and I have to kill it with STRG-C.

The Lid fires no event when closed or opened.

I'm using kernel 2.5.40 and acpi patch 20021002, sorry I forgot to write 
that in my last mail.

Ulrich Dobramysl

Roland Moser wrote:
> hi
> 
> Try deactivating APIC (yes APIC not ACPI!). There are 2 or 3 options with
> APIC.
> Select everywhere no. Then it should boot (at least it does for me).
> 
> hope that helps
> 
> Roland Moser
> 
> PS:
> APIC is the Advanced Programmable Interrupt Controller AFAIK
> Don't know why you have to deactivate it.
> 
> 
>>Hello there again!
>>
>>I posted some days ago, that I have problems getting ACPI up and running
>>  on my Gericom Laptop. The Kernel just hangs without any error message.
>>Arndt Schoenewald suggested some Kernel Configurations to me (thanks
>>again!) , but none of them did work. It seems like I have a very rare
>>Version of this laptop model, with a (very) broken BIOS.
>>So I tried to debug that myself. I'm not a very good C Programmer and
>>have no clue about the ACPI specifications, so I cannot solve this
>>problem myself.
>>I was able to trace down the hang where acpi_enable gets called and
>>itself calls acpi_hw_set_mode. This goes into the function
>>acpi_os_write_port(acpi_gbl_FADT->smi_cmd, (acpi_integer)
>>acpi_gbl_FADT->acpi_enable, 8), where outb gets called with port
>>acpi_gbl_FADT->smi_cmd and value acpi_gbl_FADT->acpi_enable.
>>I think there is something wrong with the address smi_cmd. I could not
>>find the part in the code where it gets set.
>>Tell me if I can provide more information about this problem or something.
>>
>>Ulrich Dobramysl
>>
>>
>>
>>-------------------------------------------------------
>>This sf.net email is sponsored by:ThinkGeek
>>Welcome to geek heaven.
>>http://thinkgeek.com/sf
>>_______________________________________________
>>Acpi-devel mailing list
>>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>>
> 
> 
> 




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
