From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Re: [patch 1/1] thinkpad fn+fx key driver
Date: Tue, 28 Sep 2004 10:55:35 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040928085535.GB18819@elf.ucw.cz>
References: <F7DC2337C7631D4386A2DF6E8FB22B300179B935@hdsmsx401.amr.corp.intel.com> <20040923112457.GB1083@ucw.cz> <20040924134118.GA467@openzaurus.ucw.cz> <1096112154.10736.10.camel@localhost.localdomain> <20040925175618.GB1798@ucw.cz> <20040926185454.GA7960@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040926185454.GA7960-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>, Erik Rigtorp <erik-aH8aFkyL5XJBDgjK7y7TUQ@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > Yes, the question was whether it's a good idea to make them generate
> > regular key events like the normal keys on keyboard do, and I believe
> > the answer is yes.
> 
> Well, there's certainly _some_ reasoning behind the laptop keys generating
> ACPI events and not key events on some notebooks? Not that I'm aware of
> any, unfortunately...

Probably "we want these extra keys and we do not want to touch windows
keyboard handling" :-).
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
