From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] Don't disable interrupts during EC access
Date: Tue, 16 Nov 2004 16:37:10 +0100
Message-ID: <20041116153709.GA2392@wotan.suse.de>
References: <3ACA40606221794F80A5670F0AF15F84041AC082@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041AC082@pdsmsx403>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Fu, Michael" <michael.fu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 16, 2004 at 11:21:03PM +0800, Yu, Luming wrote:
> It is just due to odd hardware behavior.  :-)
> For example, if you want to read data from EC.  The first step
> is writing 0x80 (read command) to ec command register.
> Then, if EC (hardware) write data into the output buffer, the
> output buffer flag (OBF) in the status register is set.
> (I assume it is within 1ms). According to ACPI spec,
> now, EC interrupt will get triggered. And this is
> firmware generated edge interrupt. It will hold until OBF get reset.
> When the host processor reads this data from the output buffer, 
> the OBF can be reset.
> 
> So, if you remove the spin_lock_irqsave, when OBF is set
> you could get interrupt storm.  


> 
> For detail, please refer to ACPI spec :
> 12   ACPI Embedded Controller Interface Specification.

Ok. But the problem is not the actual write, but the waiting 
for the event which takes extremly long on these machines
(it's not a single broken machine, but has been observed
on several VIA based laptops). Would it work to only disable
interrupts during the register write/read, but not during the
polling delay? 

Another possible way would be to only disable the ACPI interrupt
in the local APIC and keep the others alive  (but what to do in PIC mode?) 
> 
> >
> >And the event polling can take several ms, there is just no way 
> >to do this during runtime with interrupts off. Especially since
> >thermal will do this every few seconds. With my patch at least 
> >only kacpid is blocked for that long, not the whole system.
> >
> >-Andi
> >
> 
> As for thermal event, AFAIK,  not all laptops use EC to generate thermal
> event. And I'm thinking of a algorithm.

A better algorithm to do this would be fine, but even if you do
the EC access only very infrequent it's imho still not really 
appropiate to lose timer interrupts and create long scheduling bubbles
durign this. So some solution for the broken EC reads needs to be found even
independent from the thermal algorithm. 


-Andi


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
