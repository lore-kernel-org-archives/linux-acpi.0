From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI_STRICT_COMPLIANCE (was RE: RE: ACPI -- Workaround forbroken DSDT)
Date: Fri, 13 Feb 2004 01:50:43 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040213005043.GE13262@poupinou.org>
References: <C50AB9511EE59B49B2A503CB7AE1ABD106611260@cceexc19.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <C50AB9511EE59B49B2A503CB7AE1ABD106611260-Iar2LzuD2f6P0FQRY6S+e9kSKC0Mw0DFJ8am2ALHCgk@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Cc: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>, "Scott T. Smith" <scott-j3vAvQ9dNB9ByuSxxbvQtw@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Feb 12, 2004 at 06:08:41PM -0600, Cagle, John (ISS-Houston) wrote:
> From: Bruno Ducrot
> > On Wed, Feb 11, 2004 at 11:33:16PM -0600, Cagle, John 
> > (ISS-Houston) wrote:
> > > From: Yu, Luming [mailto:luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org] 
> > > > 
> > > > > that would be a kernel command line option to do the same thing.
> > > > > ACPI_STRICT=ON?
> > > > 
> > > > It is unfeasible.
> > > 
> > > Care to elaborate?
> > > 
> > 
> > How you will handle the toshiba return bug?
> 
> I'm not familiar with that specific bug, and I want to make it clear I
> was not suggesting that we remove any existing workarounds.

Sorry, I should explain more, then.

> 
> I was suggesting that having a kernel command line option (to control
> the strict-ness of the ACPI implementation) will make it a lot easier
> for OEM's to test their AML under Linux.  Assuming, of course, that the
> default behavior of the ACPI driver is "relaxed", which it is not
> currently.
> 

The 'toshiba return bug' is something like that:

Method(FOO) {
	return (0)
}

Method(BAR) {
	FOO()
}

If ACPI is pedantic, BAR return nothing.

On some implementation of the AML interpreter found on no-named OS, BAR
will return 0.  Also, if now you have

Method(BAZ) {
	DoSomething
	FOO()
	DoSomethingElse
	Return(1)
}

Then if ACPI is pedantic, the DoSomethingElse will be executed, and 1
will be returned, whereas on some no-named AML interpreter the DoSomethingElse
path will not be executed, and 0 will be returned.  Also, it's hard to
know what is exactly the intention of the BIOS writer on such ASL
statements.

It can be possible that the no-named AML interpreter fixed that
issue (I believe this is the case), whereas it do not fix others.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
