From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: [PATCHES] add _CST support
Date: 23 Dec 2004 00:02:13 -0500
Message-ID: <1103778133.2567.45.camel@d845pe>
References: <20041127215118.GA30309@dominikbrodowski.de>
	 <1103694244.17325.58.camel@d845pe>
	 <20041223000842.GA8289@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041223000842.GA8289-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2004-12-22 at 19:08, Dominik Brodowski wrote:
> On Wed, Dec 22, 2004 at 12:44:05AM -0500, Len Brown wrote:
> > On Sat, 2004-11-27 at 16:51, Dominik Brodowski wrote:
> >
> > > - make acpi_cstate_limit aware of c-state types instead of
> numbers, as the latter mean (almost) nothing
> >
> > While both C3 and C4 will be of type-C3, I'd like to still be able
> to disable C4 without disabling C3.
> 
> If we can agree not to call it "C3" and "C4", yes... The problem is
> the C-nomination is sort of a _type_ which is overloaded with the
> actual states.

C-states are enumerated C0...Cn
C-state types are enumerated C1, C2, C3.
I don't see any confusion in the name-space duplicates
as long as you know you're talking about C-states or C-state-types.

> I.e. you could have C0 state, C1 state, 2 different C2 states, and 2
> different C3 states. Then you'd have
> 
> number  type    overloaded C-notation
> 
> 0       C0      C0
> 1       C1      C1
> 2       C2      C2
> 3       C2      C3      <--- confusion/breakage
> 4       C3      C4
> 5       C3      C5

while it is probably unlikely for a system to supply
multiple C2-type states, it would be perfectly legal
and should not cause either confusion or breakage.

> Also, drivers like the ipw driver will want to disable all of _type_
> C3 sleep, AFAICS. Therefore, if you want to limit it by number instead
> of type as well, I'd suggest to add another differently named
> parameter.

I'd rather delete the workaround than further complicate it.

The workaround specifies the maximum C-state allowed (max_cstate) -- it
doesn't specify the minimum C-state type dis-allowed.
So when ipw2100 says acpi_set_cstate_limit(2), this will always work.
Yes, you could invent a system like this

type c-state
C1	C1
C3	C2
C3	C3

and that would break.  But by the time somebody invents that
system, the ipw2100 which needs this workaround will not be present.  It
has been replaced by the 2200BG, which has been replaced by the 2915ABG.

-Len




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
