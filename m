From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] watchdog: wdat_wdt: Ping the watchdog on resume
Date: Thu, 20 Oct 2016 18:17:38 +0300
Message-ID: <20161020151738.GP24289@lahna.fi.intel.com>
References: <20161020150336.97791-1-mika.westerberg@linux.intel.com>
 <CAJZ5v0ipdO2psmdesoQuw_5uuOSqDh22DK04bEJTi1pW0fL53g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ipdO2psmdesoQuw_5uuOSqDh22DK04bEJTi1pW0fL53g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Oct 20, 2016 at 05:05:22PM +0200, Rafael J. Wysocki wrote:
> On Thu, Oct 20, 2016 at 5:03 PM, Mika Westerberg
> <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> > It turns out we need to ping the watchdog hardware on resume when we
> > re-program it. Otherwise this results inadvertent reset to trigger right
> > after the resume is completed.
> >
> > Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> 
> Is there a Fixes: tag missing here?

Oops, right. Sorry about that.

It should be:

Fixes: 058dfc767008 ("ACPI / watchdog: Add support for WDAT hardware watchdog")

(I can resend the patch as well, if needed with the Fixes tag).

> > ---
> >  drivers/watchdog/wdat_wdt.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
> > index e473e3b23720..6d1fbda0f461 100644
> > --- a/drivers/watchdog/wdat_wdt.c
> > +++ b/drivers/watchdog/wdat_wdt.c
> > @@ -499,6 +499,10 @@ static int wdat_wdt_resume_noirq(struct device *dev)
> >                 ret = wdat_wdt_enable_reboot(wdat);
> >                 if (ret)
> >                         return ret;
> > +
> > +               ret = wdat_wdt_ping(&wdat->wdd);
> > +               if (ret)
> > +                       return ret;
> >         }
> >
> >         return wdat_wdt_start(&wdat->wdd);
> > --
> 
> Thanks,
> Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
