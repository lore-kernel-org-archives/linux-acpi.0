From: Stian Jordet <liste-NI9zH3lwcMKHXe+LvDLADg@public.gmane.org>
Subject: RE: smpenum patch updated to 2.6.9-rc2
Date: Tue, 21 Sep 2004 04:01:47 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1095732108.3544.6.camel@localhost.localdomain>
References: <F760B14C9561B941B89469F59BA3A847078E2B48@orsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A847078E2B48-sBd4vmA9Se6krb+BlOpmy7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

man, 20,.09.2004 kl. 11.29 -0700, skrev Grover, Andrew:
> If you'd like to really figure out why this system isn't working via
> MPS, here are some things to try:
> 
> 1) Is it hanging in that function? insert a printk at the very end, to
> see.
> 2) Find the line that says "#define Dprintk (x...)" in
> include/asm-i386/apic.h and change it to "#define Dprintk (x...) printk
> (x...)". That should print out everything that's going on, so we can
> compare the working ACPI case with the non-working MPS case.


First, thank you very much for your answer, you have really helped me a
lot. 

stianj@chevrolet:~$ uname -a
Linux chevrolet 2.6.9-rc2 #38 SMP Tue Sep 21 03:46:40 CEST 2004 i686
GNU/Linux

I have now recompiled my kernel 37 times, and I have rebooted twice that
amount :) Anyway, after testing 1000 things, I have actually found the
reason (I think). In arch/i386/kernel/mpparse.c, in the function
mps_setup_io_apic_irqs, I changed

for (pin = 0; pin < nr_ioapic_registers[apic]; pin++) {

to

for (pin = 3; pin < nr_ioapic_registers[apic]; pin++) {

and now it works. I found out this after using printk's which told me
that it hanged at pin 2. I have no idea why, since all this is just
magic for me, but I hope you can help me understand it.

I'm now running in IO-APIC mode without ACPI for the first time :) USB
don't work, but they never do on VIA boards in IO-APIC mode I'm told, so
that's ok (for now... :)

Bedtime now. The clock is 4 AM :)

Best regards,
Stian



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
