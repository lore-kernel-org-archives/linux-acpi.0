From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: Re: Re: [PATCHES] add _CST support
Date: Tue, 28 Dec 2004 18:50:58 +0100
Message-ID: <20041228175058.GA8112@dominikbrodowski.de>
References: <20041127215118.GA30309@dominikbrodowski.de> <1103694244.17325.58.camel@d845pe> <20041223000842.GA8289@dominikbrodowski.de> <1103778133.2567.45.camel@d845pe> <20041223130723.GE731@openzaurus.ucw.cz> <1104204434.18166.50.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1104204434.18166.50.camel@d845pe>
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
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Dec 27, 2004 at 10:27:15PM -0500, Len Brown wrote:
> On Thu, 2004-12-23 at 08:07, Pavel Machek wrote:
> 
> > > C-states are enumerated C0...Cn
> > > C-state types are enumerated C1, C2, C3.
> > > I don't see any confusion in the name-space duplicates
> > > as long as you know you're talking about C-states or C-state-types.
> > >
> > 
> > Unfortunately, people often don't know what they are talking about.
> > Having two things called C2 is definitely going to confuse just
> > about everyone but you...
> 
> Probably we should not mess with the "well known" (hah;-) name space for
> C-states themselves (C0...Cn).
> 
> Types, on the other hand, would probably be well addressed with a enum
> whose vales are 1,2,3 so if we chose to print them out they'd simply be
> a %d -- using C%d only for actual C-states themselves.
> 
> would that be better?

I _still_ favour using C0 to C3 for the types, as the meaning of this is
probably better known [e.g. the implications of C3 to bus mastering], and
invent something new (like I0 to In for idle states?) and hope the ACPI
specification group will like this naming and "clarify" it in ACPI 2./3.x

However, I guess we do have to live with a broken ACPI specification in this
regard... But it is an imperfect world, after all :-)

	Dominik


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
