From: Phillip Susi <psusi-3tLf1voIkJTQT0dZR+AlfA@public.gmane.org>
Subject: Re: Asus K8V Delux broken acpi tables?
Date: Mon, 10 Oct 2005 22:36:12 -0400
Message-ID: <434B251C.3090300@cfl.rr.com>
References: <43475CDB.6070204@cfl.rr.com> <4347ED97.1090504@cfl.rr.com> <434A3BB4.1050404@suse.de> <434B171A.3040103@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <434B171A.3040103-3tLf1voIkJTQT0dZR+AlfA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I got iasl -d to disassemble /proc/acpi/dsdt, and your patch cleanly 
applied to that.  When I try to recompile the patched file, I get these 
errors though:

dsdt.dsl    54:             Store (0xAA, DBG8)
Error    1061 -       Object does not exist ^  (DBG8)

dsdt.dsl    58:             Store (0xAC, DBG8)
Error    1061 -       Object does not exist ^  (DBG8)

dsdt.dsl    65:     Method (OSFL, 0, NotSerialized)
Warning  2085 -                ^ Not all control paths return a value (OSFL)

dsdt.dsl    74:             Store (0xAC, DBG8)
Error    1061 -       Object does not exist ^  (DBG8)

dsdt.dsl    78:         If (MCTH (\_OS, "Microsoft Windows NT"))
Error    1094 -                      ^ syntax error, unexpected 
PARSEOP_NAMESEG, expecting ')'

dsdt.dsl    82:         Else
Error    1094 -            ^ syntax error, unexpected PARSEOP_ELSE

dsdt.dsl    84:             If (MCTH (\_OS, "Microsoft WindowsME: 
Millennium Edition"))
Error    1094 -                          ^ syntax error, unexpected 
PARSEOP_NAMESEG, expecting ')'
dsdt.dsl    88:         }
Error    1094 -         ^ syntax error, unexpected '}', expecting $end

Any ideas?


Phillip Susi wrote:

> I think I updated my bios a month or two ago.  I'm not quite sure how 
> to recompile my DSDT.  I thought I needed to use iasl to decompile the 
> existing DSDT from acpidump, then apply your patch, then recompile.  I 
> seem to be missing something though, iasl -d doesn't seem to like my 
> acpidump.log.
> Also getting iasl compiled was kind of a pain, the code is a bit 
> borked.  First I had to add the -l flag to flex so that unput() could 
> be used correctly, then the code was declaring a variable in one place 
> as a char [] and in another as a char *, so I had to fix that to get 
> it to compile.  Even then it had a bunch of warnings because of 
> incorrect casts due to assumptions about being on a 32bit architecture 
> ( I'm running 64 bit ).
>


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
