From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH v6 02/12] Driver core: Unified device properties interface for platform firmware
Date: Tue, 04 Nov 2014 22:29:08 +0100
Message-ID: <3275773.HN9MNfIOOq@vostro.rjw.lan>
References: <13750506.S2yVlRRDa2@vostro.rjw.lan> <3645687.BsyGDrJDrU@vostro.rjw.lan> <CACxGe6uv0TmoZivL3ESw+oRW-OjqakLP4KBnDrwJXzQ2ku8ZLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACxGe6uv0TmoZivL3ESw+oRW-OjqakLP4KBnDrwJXzQ2ku8ZLA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Darren Hart <darren.hart-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday, November 04, 2014 05:01:04 PM Grant Likely wrote:
> On Mon, Nov 3, 2014 at 10:04 PM, Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org> wrote:
> >> I also found that this parser code doesn't correctly handle malformed
> >> (unterminated) string properties. It will overflow. The existing
> >> functions have the same problem, so it isn't something that you've
> >> added. I've got a fix, and as a side effect the fix creates the _array
> >> version basically for free as part of reworking
> >> of_property_count_strings() and of_property_read_string_index()
> >
> > OK
> >
> > So can you please point me to a git branch containing the fix?  I'll rebase the
> > patch on top of that then and everything should merge just fine.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/glikely/linux.git devicetree/merge
> 
> I'm going to let the patch sit in there for a few days to get
> linux-next exposure before I ask Linus to pull. The pull req will go
> out before the end of the week.

OK, thanks!

Pulled, rebased my device-properties branch, merged into linux-pm.git/linux-next
and pushed back.

Rafael

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
