From: Eric Valette <eric.valette-GANU6spQydw@public.gmane.org>
Subject: Re: Linux 2.6-pre1 Does not boot on ASUS L3800C: lock up in acpi
 while  "Executing all Devices _STA and_INIT methods"
Date: Sun, 20 Jul 2003 15:18:20 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <3F1A969C.6060606@free.fr>
References: <F760B14C9561B941B89469F59BA3A847E9702C@orsmsx401.jf.intel.com>
Reply-To: eric.valette-GANU6spQydw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E9702C-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Grover, Andrew wrote:
>>From: Eric Valette [mailto:eric.valette-GANU6spQydw@public.gmane.org] 
>>I happily run 2.4.21-pre5 with ACPI enabled and everything works just 
>>fine. I tried today 2.6-pre1 with exactly the same hardware 
>>configuration as the 2.4 one and the laptop does not boot. It hangs 
>>while dispaying : "Executing all Devices _STA and_INIT methods" 
>>allthough it has already printed several '.'
> 
> 
> That's weird. They should have the same version of the ACPI code...


Just to try to help, as suggested by Karol Kasimor, disabling the APIC 
make the code pass this section. The APIC is now really unconditionnaly 
enabled (regardless of BIOS settings) due to this change in 2.5.74...

<http://lists.insecure.org/lists/linux-kernel/2003/Jun/5840.html>

So this is an interaction between APIC and ACPI... I still think it 
should not crash at least...

BTW : I still cannot boot as the radeon framebuffer driver make things 
unreable. I will stcik with 2.4 for a while...

-- eric
