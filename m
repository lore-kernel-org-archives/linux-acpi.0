From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Possible trouble when you upgrade your ram, and override DSDT (was: System_memory error)
Date: Thu, 12 Sep 2002 13:23:04 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020912112304.GA5608@poup.poupinou.org>
References: <20020911165540.GB581@poup.poupinou.org> <20020911180621.43478.qmail@web14503.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020911180621.43478.qmail-ugbtuMWqwv6A/QwVtaZbd3CJp6faPEW9@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Kent Hunt <kenthunt-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

I CC to the acpi-devel ML, since it can be interresting:
If you upgrade the amount of your RAM, or get an ASL from
others that didn't have the same amount of RAM, you can have
some trouble.


On Wed, Sep 11, 2002 at 11:06:21AM -0700, Kent Hunt wrote:
> Interesting, calling acpidump , which reads /dev/mem,
> I got:
> 
> Scope(_SB_) {
>     OperationRegion(SMI1, SystemIO, 0x0000fe00, 0x2)
>     Field(SMI1, AnyAcc, NoLock, Preserve) {
>         SMIC,   8
>     }
>     OperationRegion(SMI0, SystemMemory, 0x1fffff2c,
> 0x90)
>     Field(SMI0, AnyAcc, NoLock, Preserve) {
>  
> I'm not sure if I should do iasl -d dsdt as you
> described since the above already gave me the
> disasembled output. 

Well, I meant 'acpidmp' from pmtools, not acpidump :)
But acpidump is just fine, of course.

> 
> I think this already gave me the hint. I should then
> modify my DSDT override to reflect this new address. 
> However, if I go back to 256M then I'll have problems
> again. Is this good assumption?

Yes, certainly.  Reading your dmesg I really have no
doubt no more about that.

> 
> My dmesg shows:
> 
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009f800
> (usable)
>  BIOS-e820: 000000000009f800 - 00000000000a0000
> (reserved)
>  BIOS-e820: 00000000000eac00 - 0000000000100000
> (reserved)
>  BIOS-e820: 0000000000100000 - 000000001fff0000
> (usable)
>  BIOS-e820: 000000001fff0000 - 000000001ffffc00 (ACPI
> data)
>  BIOS-e820: 000000001ffffc00 - 0000000020000000 (ACPI
> NVS)
>  BIOS-e820: 00000000fff80000 - 0000000100000000
> (reserved)
> 511MB LOWMEM available.
> 
> If I go back to 256M (just the diff)
> 
> BIOS-e820: 0000000000100000 - 000000000fff0000
> (usable)
>  BIOS-e820: 000000000fff0000 - 000000000ffffc00 (ACPI
> data)
>  BIOS-e820: 000000000ffffc00 - 0000000010000000 (ACPI
> NVS)
> 255MB LOWMEM available.
> 
>   BIOS-e820: 000000000fff0000 - 000000000ffffc00 (ACPI
> data)
>  BIOS-e820: 000000000ffffc00 - 0000000010000000 (ACPI
> NVS)
>  BIOS-e820: 00000000fff80000 - 0000000100000000
> (reserved)
> 255MB LOWMEM available.
> 

That what I supposed, then.

Did you use a phoenix bios?  I think that this bios actually
create the DSDT table right after the POST BIOS...

Cheers,

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
