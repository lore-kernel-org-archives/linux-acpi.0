From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI_STRICT_COMPLIANCE (was RE: RE: ACPI -- Workaround
	forbroken DSDT)
Date: 11 Feb 2004 14:35:24 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1076528124.12964.293.camel@dhcppc4>
References: <C50AB9511EE59B49B2A503CB7AE1ABD10661123D@cceexc19.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <C50AB9511EE59B49B2A503CB7AE1ABD10661123D-Iar2LzuD2f6P0FQRY6S+e9kSKC0Mw0DFJ8am2ALHCgk@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Cagle, John   (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Cc: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>, "Scott T. Smith" <scott-j3vAvQ9dNB9ByuSxxbvQtw@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2004-02-11 at 13:04, Cagle, John (ISS-Houston) wrote:

> I agree.  This should make a lot of users happy, since the distro's will
> work out-of-the-box without modification (at least on those machines
> with known workarounds implemented in the ACPI driver), yet the OEMs can
> still test for strict compliance by recompiling the kernel.  Better than
> that would be a kernel command line option to do the same thing.
> ACPI_STRICT=ON?

I think you're right.  If STRICT added code, then a re-build would be
appropriate, b/c the default kernel shouldn't be burdened with extra
code for validation or compliance testing.  However, STRICT would
generally disable code -- so we might as well make it accessible by
using a boot option instead of a build option.  Say...

acpi=strict
  Disable workarounds in Linux for platforms that are not
  strictly ACPI compliant.  This may cause additional warnings
  or cause your system not to boot.


if (acpi_strict)
	a compliance check or warning that is known to fail
	on some systems.

if (!acpi_strict)
	a workaround that is known to be necessary
	on some non-compliant systems, eg. RELAXED_AML

-Len




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
