From: Sander Smeenk <ssmeenk-ntXksADE/7Pk1uMJSBkQmQ@public.gmane.org>
Subject: Re: DSDT Fix, one question ...
Date: Thu, 27 Feb 2003 13:53:18 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030227125318.GI21631@freshdot.net>
References: <20030227104122.GG21631@freshdot.net> <000001c2de5a$55d99160$7c4425db@sayonara>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <000001c2de5a$55d99160$7c4425db-F8JvWDuGsZU@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Adachi, Kenichi" <aileenja-dTzOdQ2U+/YAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Quoting Adachi, Kenichi (aileenja-dTzOdQ2U+/YAvxtiuMwx3w@public.gmane.org):

> I bet this sub-method "STM_" is being called from _STM - standard method
> to set timing mode for IDE - and "TMD0" may stand for "Timing for D0",
> but I'm lipping just a gibberish without whole DSDT and make/chipset
> info. I need'em for better reasoning.

The complete DSDT is now located at:
  http://valor.freshdot.net/~ssmeenk/

There's a lot of info about my hardware inside the DSDT.
This one came from an MSI KT333 Ultra ARU (MS-6580E) mainboard running
the latest, or maybe the second to last BIOS, not sure about that. 
I'm currently running 2.5.53 vanilla, with no special ACPI-patches
applied.

HTH,
Sander.

-- 
| Waarom draagt een kamikazepiloot een helm ? 
| 1024D/08CEC94D - 34B3 3314 B146 E13C 70C8  9BDB D463 7E41 08CE C94D


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
