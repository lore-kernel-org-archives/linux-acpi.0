From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: toshiba tecra 8100 problems with ACPI
Date: Thu, 3 Mar 2005 18:23:00 +0100
Message-ID: <20050303172300.GA31985@poupinou.org>
References: <200503031648.29509.bruno.biagini-anva@poste.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503031648.29509.bruno.biagini-anva-Syd3ARw+vPY@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: bruno <bruno.biagini-anva-Syd3ARw+vPY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Mar 03, 2005 at 04:48:29PM +0100, bruno wrote:
> Dear all
> I'm posting after having read different messages in such mailing list.
> I know that I should try to read more but ... I promise you I'll continue to 
> read.
> While I continue in reading I would like to ask you for very quick answers 
> (yes or no, wrong or right) to my question in order to understand if I'm 
> going in the right directions to find a solution to my problem.
> 
> The problem is the following:
> 
> This are the messages I got from DMESG (regarding ACPI only):
> BIOS-provided physical RAM map:
>  ..........
>  BIOS-e820: 00000000000e8640 - 00000000000e8840 (ACPI NVS)
>  .........
>  BIOS-e820: 0000000013fe0000 - 0000000013ff0000 (ACPI data)
> .........
> 
> ACPI: RSDP (v000 TOSHIB                                    ) @ 0x000f4fd0
> ACPI: RSDT (v001 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x13fe0000
> ACPI: FADT (v001 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x13fe0054
> ACPI: DSDT (v001 TOSHIB 8100     0x20000614 MSFT 0x0100000a) @ 0x00000000
> Kernel command line: BOOT_IMAGE=Linux ro root=304
> ..........
> ACPI: Subsystem revision 20040326
                           ^^^^^^^^
			This is the problem.
		   Please upgrade your kernel.
...

> ">> dsdt.asl 134: Method(_WAK, 1) {
>  >> Warning 2026 - ^ Reserved method must return a value (_WAK)
>  
>  You should probably add a "Return(Package(0x02){0x00, 0x00})" on a new 
>  line just before the closing curly brace like so:
>  
>  Method(_WAK, 1) {
>  ... ... ...
>  Return(Package(0x02){0x00, 0x00})
>  }"
> 
> I used such workaround for all my warnings (adding such line) then I 
> recompiled the new dsdt.dsl and I got 0 errors, 0 warnings, 0 remarks but .
> 

No.  This work only for _WAK.

> This is the story:
> My question are:
> Am I right with ACPI IRQ handler (it doesn't work because my DSDT is broken)?
> the use of the workaround described for CRS, PRS, STA, PSC is correct or do I 
> have to find a different solution studying the ACPI spec document?
> 
> please pardon me for the book I wrote but I was wondering if it would be 
> possible to receive back a reply (also very short, it would be really 
> appreciated :-) )


Most recent versions of ACPI-CA do have already a quirk in order to
fix those troubles for (older) Toshiba.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
