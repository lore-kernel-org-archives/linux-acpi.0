From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Toshiba Satellite 1905S303 DSDT table
Date: Wed, 5 Nov 2003 13:12:34 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031105121234.GV21970@poupinou.org>
References: <3FA58FE8.4000409@techisa.srv.br> <20031104103943.GJ21970@poupinou.org> <3FA7A224.1080907@techisa.srv.br> <20031104150926.GO21970@poupinou.org> <1067994460.6048.23.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1067994460.6048.23.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Erico M Mendonca <erico-cz9lu//xMc+vYRxJAoKWRg@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 04, 2003 at 08:07:41PM -0500, Len Brown wrote:
> On Tue, 2003-11-04 at 10:09, Ducrot Bruno wrote:
> > On Tue, Nov 04, 2003 at 10:57:08AM -0200, Erico M Mendonca wrote:
> > > Ducrot Bruno wrote:
> 
> > As I already tryed to say, unless you are on a BSD system,
> > or unless someone port the FreeBSD acpidump, do not use acpidump.
> > Or else, you are missing informations for debugging irq for example.
> 
> huh?
> Are you referring to acpidmp from Intel's pmtools package?
> What exactly is it missing?

acpidump, with a 'u'.  It has nothing to do with pmtools.

It was the only free, decent AML decompiler available, before iasl
implemented the '-d' option, and is part of FreeBSD system.

A backport for other OS, like linux, were made, but is
less complete than the FreeBSD version.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
