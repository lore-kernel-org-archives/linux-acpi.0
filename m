From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: ACPI_STRICT_COMPLIANCE (was RE: RE: ACPI -- Workaround for
	broken DSDT)
Date: 11 Feb 2004 11:37:08 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1076517428.12955.32.camel@dhcppc4>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8AB6@hdsmsx402.hd.intel.com>
	 <1075964148.5017.7.camel@tinny.home.foo>  <20040209122256.K74314@root.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040209122256.K74314-Y6VGUYTwhu0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Cc: "Scott T. Smith" <scott-j3vAvQ9dNB9ByuSxxbvQtw@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2004-02-09 at 15:29, Nate Lawson wrote:

> We're doing something slightly different with ACPI on FreeBSD.  We add
> hacks^Wworkarounds for buggy DSDT whenever possible but they are under a
> kernel option, #ifndef ACPICA_PEDANTIC.  The default is for this option to
> give maximum compatibility with the stock DSDT, at the expense of spec
> correctness.  However, by adding that option and compiling a kernel, OEMs
> could test against ACPI-CA as a reference implementation while ordinary
> users get maximum compatibility.
> 
> I think the ACPI-CA developers should take a similar tact.  Len, who is on
> the Linux side, could suggest distribution maintainers use the option that
> gives maximum Windows compatibility when shipping a distro.  Bob, who is
> on the ACPI-CA side, could encourage OEMs to test with the option
> disabled.  It might even make sense for a Linux distro maintainer to
> partner with ACPI-CA to provide a reference ISO that OEMs could boot that
> had a /sbin/init that tests the various APIs for correctness.  Both Andy
> and I thought this was a good direction to go and perhaps people are
> already making progress in that area.

Nate,
I think you're right, practical compatibility must be the default, and a
single config option should allow an OEM to disable the out-of-spec
warnings and workarounds.

CONFIG_ACPI_STRICT_COMPLIANCE seems to be a good choice for the config
option.  Disabled by default, enabled by OEMs for testing their
platforms.

Right now, CONFIG_ACPI_RELAXED AML would be replaced by this.  This will
fix the issue that RELAXED_AML is not currently enabled by default.

We have some warnings and workarounds that gum-up various dmesg that I
think we can put under this umbrella also.

thanks,
-Len




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
