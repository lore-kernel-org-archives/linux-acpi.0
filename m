From: Zwane Mwaikambo <zwane-T6AQWPvKiI1fDP7aoN8Z5Q@public.gmane.org>
Subject: Re: [RFC] ACPI power-off on P4 HT
Date: Wed, 25 Feb 2004 11:13:17 -0500 (EST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.58.0402251110250.30536@montezuma.fsmlabs.com>
References: <1076145024.8687.32.camel@dhcppc4>  <20040208082059.GD29363@alpha.home.local>
  <20040208090854.GE29363@alpha.home.local>  <20040214081726.GH29363@alpha.home.local>
  <1076824106.25344.78.camel@dhcppc4>  <20040225070019.GA30971@alpha.home.local>
 <1077695701.5911.130.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1077695701.5911.130.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Willy Tarreau <willy-tRhHnHjXm5DYtjvyW6yDsg@public.gmane.org>, Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZQ39yzSjRtAkw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 25 Feb 2004, Len Brown wrote:

> Willy,
> I do think we need a generic way to be sure that certain routines are
> run only on cpu0.

set_cpus_allowed?

> I don't see it in the ACPI spec, but it seems that on some platforms,
> some register accesses (such as writing to the sleep control reg) are
> reliable only when accessed from cpu0.
>
> This issue has been with us for some time:
> http://bugzilla.kernel.org/show_bug.cgi?id=1141
>
> I am hopeful that the prepare-shutdown sequence you suggest below will
> not be necessary.


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
