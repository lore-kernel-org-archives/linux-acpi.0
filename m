From: Eric Valette <eric.valette-GANU6spQydw@public.gmane.org>
Subject: Re: Re: Linux 2.6-pre1 Does not boot on ASUS L3800C: lock
 up in acpi while  "Executing all Devices _STA and_INIT methods"
Date: Wed, 16 Jul 2003 11:09:06 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F151632.9090303@free.fr>
References: <F760B14C9561B941B89469F59BA3A847E9702C@orsmsx401.jf.intel.com>	 <3F146770.8020603@free.fr>  <20030715212054.GA10046@hell.org.pl> <1058345036.8960.82.camel@idoru.kc.de>
Reply-To: eric.valette-GANU6spQydw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1058345036.8960.82.camel-65LrUGLyukAb1SvskN2V4Q@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nils Faerber <nils-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Cc: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Nils Faerber wrote:
> Am Die, 2003-07-15 um 23.20 schrieb Karol Kozimor:
> 
>>Thus wrote Eric Valette:
>>
>>>>That's weird. They should have the same version of the ACPI code...
>>>
>>>Thanks for responding. Note I have never seen such messages on 2.4 so...
>>>FYI : I tested today with the latest version 0714 and it doesn't change 
>>> anything... 2.4.22-pre6 + the patch works fine... Someone suggested 
>>>problem with the APIC but its enabled in 2.4...
>>
>>That's how it works for me on the same machine: if APIC and IO-APIC is
>>compiled in, the kernel hangs at the place you mentioned. noapic doesn't
>>help, acpi=off does, as well as not compiling APIC in at all.
>>
>>According to my experience, APIC should not work under 2.4.x and 2.5.x 
>>where x < 74, since it is magically disabled by BIOS and the kernel doesn't
>>know anything about it. Do you have any evidence that APIC works at all 
>>on these kernels?
> 
> 
> Even worse, APIC does not work at all on those machines.
> I tried by bashing the kernel, re-enabling it etc.
> Afterwards you'll get a system that boots sometimes (!) with APIC,
> sometime does not boot at all. You will get the APIC but not IO-APIC
> which is what I was looking for to get more IRQs than 16 (silly me :)
> 
> So not compiling APIC support on those machines is no loss.

So OK, I will back out I/OAPIC but frankly the fact that the kernel lock
is a real problem. Think a minute to all people converting their 2.4 
config like I did...


-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette-GANU6spQydw@public.gmane.org



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
