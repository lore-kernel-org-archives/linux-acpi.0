From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Aspire 1511LMI - Aspire 1513LMI DSDT
Date: Mon, 22 Nov 2004 15:15:49 +0100
Message-ID: <20041122141549.GI31422@poupinou.org>
References: <419E5183.6030405@aliceposta.it> <20041119200129.GG31422@poupinou.org> <41A1F973.7060700@aliceposta.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <41A1F973.7060700-nznwD2ikctv02BlrwmTdfg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: giupil <giupil-nznwD2ikctv02BlrwmTdfg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 22, 2004 at 02:36:35PM +0000, giupil wrote:
> Hi Bruno,
> 
> I'm sorry for my ignorance, I'm not a expert. I'm very gratefull for 
> your notes.
> The only problem that still remains in my mind is:
> 
>   In
>  
>   http://acpi.sourceforge.net/dsdt/tables/ACER/Aspire_1513LMi/-
>   ACER-Aspire_1513LMi-unknown_bios-custom.asl.gz
>  
>   at the line 3893 of the ACER-Aspire_1513LMi-unknown_bios-custom.dsl 
> decompiled file, I
>   find:
> 
>                    Return (Package (0x02)
>                    {
>                            Zero,
>                            Zero
>                     })
> 
>    but at the 
> http://casteyde.christian.free.fr/laptop/LinuxOnAspire1511LMi.html in the
>    dsdt_asp1511.asl at the line 3895, I find:
> 
> 
>                    Return (0x00)
> 
>    These corrections are about the warnig:
> 
>    mydsdt_orig.dsl  3865:                     Method (DRUL, 1, 
> NotSerialized)
>    Warning  2019 -                              ^ Not all control paths 
> return a value (DRUL)

The other paths return an integer, and this is not a reserved method.
So return an integer ;)

I would buy for 'Return (0)', but anyway I will not care for this at
all, since it's called only in order to query a VGA change via probably
a hotkey at first read (via a _Q?? method), and there is
nothing to verify the return values anyway in the AML.


-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
