From: "Tommy Ch." <tommy-c-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Req: debug dsdt of Toshiba M30
Date: Tue, 01 Mar 2005 13:48:28 +0100
Message-ID: <4224649C.2010604@gmx.net>
References: <4220D0CF.3090705@gmx.net> <20050228182910.GL12182@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050228182910.GL12182-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
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


>>[...] erm, I think it was Bruno Ducrot. 

Bruno Ducrot wrote:
> Well, I don't remember if that's me.
> But I have an acpidmp for a toshiba M30-404.

Could be it was John Belmonte.

> After doing something like this:
> 
> ducrot@neptune:~/acpi_hack/toshiba-M30-404$ ../pmtools/acpidmp/acpixtract SSDT > ssdt < acpidmp
> ducrot@neptune:~/acpi_hack/toshiba-M30-404$ iasl-20041203 -d ssdt
> 
> and the resulting ssdt.dsl will contains the processor object.
> 
> So all you have to do is to add something like that:
> External (\_PR.CPU0)
> onto the dsdt.dsl in order to get rid of those errors.

>  DefinitionBlock ("DSDT.aml", "DSDT", 1, "TOSHIB", "A0007   ", 537069574)
>  {
> +    External (\_PR.CPU0)

OK, thanks. I read something like this somewhere but was really unsure 
where to place the External Definition.
So, is it worth correcting this and loading the new dsdt at boot? Will 
it help?

>>And perhaps: can anybody tell me why it isn't possible to switch CRT or 
>>S-VIDEO on with the toshiba acpi driver? Is it possible to see this from 
>>the disassembly?
> 
> 
> I dont know for the toshiba acpi driver.  But there is for sure support
> for the acpi_video driver in this dsdt.
> 
> It may be fine to test if by chance acpi_video work.

Ok, I wrote you already Bruno. I also posted a new Thread reagarding my 
experience with acpi_video.

-Tommy


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
