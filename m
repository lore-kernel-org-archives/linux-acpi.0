From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Re: [PATCHES] add _CST support
Date: Tue, 28 Dec 2004 22:28:08 +0100
Message-ID: <20041228212808.GE2521@elf.ucw.cz>
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
Cc: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

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

Yes.... With right setup we can even do type-checking with sparse.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
