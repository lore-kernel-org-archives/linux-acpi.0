From: Bernhard Kaindl <bernhard.kaindl-Mmb7MZpHnFY@public.gmane.org>
Subject: Relaxed AML parsing
Date: Fri, 28 Feb 2003 02:24:04 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.53.0302280059170.1511@hase.a11.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Rick Richardson <rickr-EySxSuIQeMUAvxtiuMwx3w@public.gmane.org>, Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
   As far as I see the Linux ACPI code has problems with many
systems which seem to be caused by the ASL compiler tolerating
field access within the region size, rounded up to a multiple
of the access byte width.

In such cases, the current ACPI code fails with an AE_AML_REGION_LIMIT
error because it does not tolerate the errors the compiler allows.

I've found Rick Richardsons great relaxed AML parsing patch which
makes the parser compatible to the compiler, as far as I understood:

http://home.mn.rr.com/richardsons/toshiba-1115-s103/relaxed-aml.patch

I think it's only nuts and bolts if the Linux AML parser tolerates
the same errors which the ASL compiler tolerates.

I'm new to ACPI, so I would like to ask you if you agree with the above
and if you think that the relaxed AML parsing should be be included and
enabled in the acpi patches.

Thanks for your help!
Bernd

PS: I agree that better DSDT would be good, but I think as the relaxed
region checking just works, I see no reason to cause trouble to users
because of this(also as it works with non-Linux and it's not an error
for the compiler). Of course strict checks are better from a development
standpoint but as the tools which allow these errors are released and
the systems are in the field, the real fix has to wait for the next
ACPI version.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
