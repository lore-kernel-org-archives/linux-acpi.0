From: "Adachi, Kenichi" <aileenja-dTzOdQ2U+/YAvxtiuMwx3w@public.gmane.org>
Subject: RE: General ACPI/Linux question
Date: Sun, 26 Jan 2003 12:18:52 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000001c2c4e9$aa7bf670$0e4425db@sayonara>
References: <1043546064.14472.9.camel@nefeli>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1043546064.14472.9.camel-coIz1MXBdV0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'Constantinos Antoniou' <costas-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Constantinos,

> My question is: One of the most usual things I see in the 
> various newsgroup posts is that DSDT tables are buggy, and 
> people need to disassemble them, edit them, replace them etc 
> etc. However, windows power management on the same machines 
> works. So what is the situation? 
> 
> The way I (don't) understand it, the ACPI implementation 
> expects some things to be defined correctly in the DSDT 
> table. However, some OSes manage to work with whatever is there.

If your DSDT is totally broken, Windows won't work perfectly either. If
the problem is well known like "PC Vendor X's Model Y" has buggy PCI
Routing Table etc., Windows tries to save the machine by applying hack
logic. See %SystemRoot%\Inf\BiosInfo.inf for more details on this.
However, of course this approach is not ideal, and they(Microsoft) keep
telling BIOS writers to create the flawless BIOS. Only few aspects are
Windows specific, but as a whole they also want to have ACPI BIOS
perfectly honoring ACPI spec.

> And to go one step further, if I change this DSDT thingie, 
> will the ACPI functionality in the other OSes still work? So, 
> would an option be to be more lenient (I understand that 
> there are standards and people should respect them...)

You are not changing the ACPI stuffs stored in ROM, and the other OSes
still honor the ones in ROM (though they could have their own way to
replace ACPI tables, at least they don't understand the way Linux does),
changing DSDT specifically for Linux won't do any harm to other OSes (in
theory).


Thanks,
- Adachi, Kenichi 




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
