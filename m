From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v18 00/15] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
Date: Mon, 16 Jan 2017 11:59:40 +0000
Message-ID: <20170116115940.GC5908@leverpostej>
References: <20161208173319.6618-1-fu.wei@linaro.org>
 <20170113192920.GF2472@leverpostej>
 <CADyBb7vF0v2DwXA8fNUOTQcqriJK1Hp57_G8DKi0WO9FnvrB5w@mail.gmail.com>
 <CADyBb7ugz_YpxKQUsJbF1vdjm_Nzyh2mH8TZMPqj1cSHGSPCFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CADyBb7ugz_YpxKQUsJbF1vdjm_Nzyh2mH8TZMPqj1cSHGSPCFw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linaro ACPI Mailman List <linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, "Abdulhamid, Harb" <harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Christopher Covington <cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Timur Tabi <timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, G Gregory <graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Al Stone <al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 16, 2017 at 08:54:46AM +0800, Fu Wei wrote:
> On 14 January 2017 at 19:34, Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> > On 14 January 2017 at 03:29, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:

> >> Once v4.10-rc4 comes out this weekend, could you please rebase and
> >> repost this?
> >
> > Yes, of course.
> >
> > I have rebased v19 to the latest v4.10-rc3-e96f8f1, it dosen't need
> > any modification.
> > I will rebase it every day, and will repost it if it need any  modification.
> >
> > But for now, V19 works well with the master branch of upstream kernel.
> > Do I need to re-post it even if it doesn't need any improvement or
> > modification? :-)
> 
> I just fetched the latest mainline kernel, and rebase v19 on the top
> of 4.10-rc4.
> I have double checked it, V19 works well with  4.10-rc4.
> For rebasing,  it doesn't need any modification.

Ok. Assuming that the patches apply cleanly atop of v4.10-rc4, I will
look over this shortly.

Thanks for checking that!

Mark.
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
