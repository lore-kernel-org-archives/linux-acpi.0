From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: Re: Re: [PATCHES] add _CST support
Date: Thu, 23 Dec 2004 01:08:42 +0100
Message-ID: <20041223000842.GA8289@dominikbrodowski.de>
References: <20041127215118.GA30309@dominikbrodowski.de> <1103694244.17325.58.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1103694244.17325.58.camel@d845pe>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Dec 22, 2004 at 12:44:05AM -0500, Len Brown wrote:
> On Sat, 2004-11-27 at 16:51, Dominik Brodowski wrote:
> 
> > - make acpi_cstate_limit aware of c-state types instead of numbers, as the
> > 	latter mean (almost) nothing
> 
> While both C3 and C4 will be of type-C3, I'd like to still be able to
> disable C4 without disabling C3.

If we can agree not to call it "C3" and "C4", yes... The problem is the 
C-nomination is sort of a _type_ which is overloaded with the actual states.
I.e. you could have C0 state, C1 state, 2 different C2 states, and 2
different C3 states. Then you'd have

number	type	overloaded C-notation

0	C0	C0
1	C1	C1
2	C2	C2
3	C2	C3	<--- confusion/breakage
4	C3	C4
5	C3	C5

Also, drivers like the ipw driver will want to disable all of _type_ C3
sleep, AFAICS. Therefore, if you want to limit it by number instead of type
as well, I'd suggest to add another differently named parameter.

	Dominik


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
