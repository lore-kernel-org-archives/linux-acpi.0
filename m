From: Michael Holzt <kju-+hGXy1KyAyQ@public.gmane.org>
Subject: Re: RE: Toshiba ACPI battery status - ACPI errors
Date: Tue, 25 Nov 2003 18:55:33 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031125175533.GA8417@fqdn.org>
References: <7F740D512C7C1046AB53446D37200173618752@scsmsx402.sc.intel.com> <20031124225539.GA22718@fqdn.org> <20031125104748.GB7375@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031125104748.GB7375-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <poup-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> I posted last week at acpi-devel a patch which fake a ECDT.  That should
> at least fix your embedded error you encounter.
[...]
> Looking your DSDT, the parameter you have to pass at boot are:
> ecdt_fake=0x66:0x62:0x10:-1:\\_SB.PCI0.LPCB.EC0

With the additional patch segment you forgot added, i finally got it
compiled, and ...

[...]
Nov 25 18:49:57 omocha kernel: ACPI: Battery Slot [BAT0] (battery present)
Nov 25 18:49:57 omocha kernel: ACPI: Battery Slot [BAT1] (battery absent)
[...]

omocha:/proc/acpi/battery/BAT0# more state
present:                 yes
capacity state:          ok
charging state:          unknown
present rate:            1500 mA
remaining capacity:      6257 mAh
present voltage:         15000 mV


Looks good, many thanks. Now one question: Is this a bug in the kernel acpi
code, or in the dsdt?

Regards
Michael

-- 
Michael Holzt, DL3KJU, kju-+hGXy1KyAyQ@public.gmane.org, kju@debian.org, kju@IRCNet


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
