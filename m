From: Michael Holzt <kju-+hGXy1KyAyQ@public.gmane.org>
Subject: Re: RE: Toshiba ACPI battery status - ACPI errors
Date: Wed, 26 Nov 2003 01:25:17 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031126002517.GB16101@fqdn.org>
References: <F760B14C9561B941B89469F59BA3A8470255EF9E@orsmsx401.jf.intel.com> <20031126002309.GA16101@fqdn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031126002309.GA16101-+hGXy1KyAyQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> Whoohoo! I was curious and tried thix fix instead of the ecdt fake, and...
> ...it works. So it seems that i was a bug in the DSDT and i won't neet the
> ecdt fake.

Hmm, said that a little bit too early. The DSDT-Fix removes the loading
error, but many values are not set correctly, for example:

omocha:/proc/acpi/battery/BAT0# more state
present:                 yes
capacity state:          ok
charging state:          unknown
present rate:            unknown
remaining capacity:      unknown
present voltage:         11100 mV

The unknown-values were known when using the ecdt fake.


Regards
Michael

-- 
Michael Holzt, DL3KJU, kju-+hGXy1KyAyQ@public.gmane.org, kju@debian.org, kju@IRCNet


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
