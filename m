From: James Courtier-Dutton <James-l7zRWeYnyd2TY6FTCsQk+9Bc4/FLrbF6@public.gmane.org>
Subject: Re: Discussion: ACPI selective IRQ blacklist
Date: Thu, 04 Sep 2003 02:47:16 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F5699A4.3090608@superbug.demon.co.uk>
References: <200309032316.11076.adq_dvb@lidskialf.net> <200309040215.23281.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200309040215.23281.adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Andrew de Quincey wrote:
> On Wednesday 03 September 2003 23:16, Andrew de Quincey wrote:
> 
>>So:
>>If a motherboard is dodgy and IS in the bad-routing-blacklist, ACPI will
>>not be used for PCI routing.
>>
>>If a motherboard is dodgy and is NOT in the bad-routing-blacklist, the
>>fallback to picmode code should catch it. If the user then wants APIC with
>>ACPI, they report the issue and the board is added to the
>>bad-routing-blacklist.
> 
> 
> On further thought, I realise this isn't future proof. This relies on the 
> existence of legacy BIOS tables (e.g. MPBIOS). My machine for one does not 
> have such a table; instead it relies on ACPI.
> 
> In the meantime, VIA have kindly sent me the docs I need. It turns out the PCI 
> routing entries for the problem BIOSes are wrong. The south bridge chip in 
> question is the VT8235 (device ID 0x1337), which explains the spread of 
> motherboards I've been seeing.
> 
> I have a solution in mind; should have something in the next few days.
> 
Would it be possible to bypass the BIOS completely, and talk to the 
chips on the motherboard direct ?
It should work, unless the BIOS provides information that the chips on 
the motherboard do not have. At a guess, I would say that the chips on 
the motherboard might not have information like a wiring diagram.

Cheers
James




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
