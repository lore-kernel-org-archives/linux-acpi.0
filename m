From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: ACPI_STRICT_COMPLIANCE (was RE: RE: ACPI -- Workaround
 for broken DSDT)
Date: Wed, 11 Feb 2004 09:51:07 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040211095009.R91991@root.org>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8AB6@hdsmsx402.hd.intel.com>
  <1075964148.5017.7.camel@tinny.home.foo>  <20040209122256.K74314@root.org>
 <1076517428.12955.32.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1076517428.12955.32.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 11 Feb 2004, Len Brown wrote:
> Nate,
> I think you're right, practical compatibility must be the default, and a
> single config option should allow an OEM to disable the out-of-spec
> warnings and workarounds.
>
> CONFIG_ACPI_STRICT_COMPLIANCE seems to be a good choice for the config
> option.  Disabled by default, enabled by OEMs for testing their
> platforms.
>
> Right now, CONFIG_ACPI_RELAXED AML would be replaced by this.  This will
> fix the issue that RELAXED_AML is not currently enabled by default.
>
> We have some warnings and workarounds that gum-up various dmesg that I
> think we can put under this umbrella also.

Sounds good to me.  Just watch out for hacks that cause valid platforms to
misbehave.  Those should be kept under an off-by-default option.

-Nate


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
