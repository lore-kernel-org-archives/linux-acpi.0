From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Help with the DSDT for an Acer Ferrari 3400 laptop
Date: Tue, 28 Dec 2004 11:56:11 +0100
Message-ID: <20041228105611.GF9606@poupinou.org>
References: <41D0F15D.8000201@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <41D0F15D.8000201-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Pedro I. Sanchez" <pedro.sanchez-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 28, 2004 at 12:38:37AM -0500, Pedro I. Sanchez wrote:
> Hello,
> 
> I'm new to this ACPI world and I'd like your help to fix the dsdt.dsl 
> file that I got with this laptop. I followed the steps in the ACPI FAQ 
> to disassemble the bin file and ended up with a source file that 
> compiles with 8 errors and 1 warning using the Intel ASL compiler.
> 
> For your reference the problem I want to fix is that I have no control 
> over the fan which is always on, quite annoying. Even though my Linux 
> kernel has compiled ACPI fan support the directory /proc/acpi/fan is 
> empty. I'm running vanilla kernel 2.6.10 with Debian-AMD64.
> 
> The good news is that the 8 errors are actually the same one spread all 
> over the source file. So fixing it once will fix the whole file. The bad 
> news is that I don't know how to fix it :|
> 
> The Error
> ---------
> dsdt.dsl  4480:           If (LLess (\_PR.CPU0._PPC, Local1))
> Error    1022 -             Object does not exist ^  (\_PR.CPU0._PPC)
> 
> The error is repeated every time the object \_PR.CPU0._PPC appears in 
> the code. I read in the FAQ that one possible solution is to use the 
> statement
> 
> 	External(\_PR.CPU0._PPC)
> 
> to tell the compiler that this is an external object. However I don't 
> understand where this External statement should go. I've tried putting 
> it at the beginning of the file and inside the Scope(\_PR) section which 
> simply reads
> 
> 	Scope (\_PR)
> 	{
> 	   Processor (CPU0, 0x00, 0x00004010, 0x06) {}
> 	}
> 
> In both cases the compiler complains. So, where shall this External 
> statement go?

They go to a SSDT table likely.  If you do something like:
sudo ./acpidmp SSDT > ssdt
and
iasl -d ssdt
you should get those external statements.

> The Warning
> -----------
> dsdt.dsl  4287: Method (SMSL, 0, NotSerialized)
> Warning  2019 -            ^ Not all control paths return a value (SMSL)
> 
> I added a Return (0x00) statement at the very end of the method and the 
> warning disappeared. But, is this right? Following my signature you will 
> find the code of the offending method including my extra line.

Could you send me the original DSDT please (or better the full acpidmp)
or even better provide a link?

I don't think it's very problematic, but I need to look a little bit
further to be sure.  This method is "internal" and is called by other
methods, so need to check what those methods do with the return value.

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
