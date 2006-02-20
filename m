From: "Jaya Kumar" <jayakumar.acpi@gmail.com>
Subject: Re: [PATCH 2.6.15.3 1/1] ACPI: Atlas ACPI driver
Date: Mon, 20 Feb 2006 18:49:54 +0800
Message-ID: <756b48450602200249k1b79b108u42bfef68e1e9dba8@mail.gmail.com>
References: <200602200213.k1K2DrDW013988@ns1.clipsalportal.com>
	 <20060220102639.GA4342@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.200]:372 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964872AbWBTKtz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Feb 2006 05:49:55 -0500
Received: by zproxy.gmail.com with SMTP id 12so854431nzp
        for <linux-acpi@vger.kernel.org>; Mon, 20 Feb 2006 02:49:54 -0800 (PST)
In-Reply-To: <20060220102639.GA4342@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 2/20/06, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Mon, Feb 20, 2006 at 10:13:53AM +0800, jayakumar.acpi@gmail.com wrote:
>
> > +     /* setup proc entry to set and get lcd brightness */
> > +     proc = create_proc_read_entry("lcd", S_IFREG | S_IRUGO | S_IWUSR,
> > +                     atlas_proc_dir, atlas_read_proc_lcd, atlas_dev);
>
> For basic sanity, could this please be a standard backlight driver
> rather than sticking yet another backlight control under yet another
> directory in /proc? It makes userspace much, much easier.

I'm not sure how standard that is. For example, I looked at the asus
and toshiba drivers. These ACPI board drivers use
/proc/acpi/somedevice/lcd. For example,

asus_acpi.c
894                 asus_proc_add(PROC_LCD, &proc_write_lcd,
&proc_read_lcd, mode,
895                               device);

toshiba_acpi.c
472         {"lcd", read_lcd, write_lcd},

So, that's why I chose to do the same in my implementation. I'd have
much rather used a generic sysfs entry but that's not what any ACPI
drivers appear to do. Further, I see that Patrick Mochel is rewriting
the whole acpi driver model (and incorporating sysfs) anyway so I
figured I'd go with the flow of existing drivers. Perhaps someone
could clarify what the consensus is. I'd be happy to make any desired
adjustments.

> drivers/video/backlight/corgi_bl.c is an example, but also see my posts
> to acpi-devel with patches that add it to existing acpi drivers.

I'll go take a look at that. I didn't look for an acpi driver outside
of the drivers/acpi directory. But if that's the consensus, shouldn't
someone also mod the toshiba and asus drivers?

>
> > +             return atlas_acpi_button_add(device);
>
> What buttons does the hardware have? Would it make more sense for it to

Standard wallmount stuff. There's 8 buttons on the one I'm using for
testing. Vol up/down. Brightness up/down. Then several buttons for
miscellaneous usage by people who customize the chassis. Most apps for
this type of board are custom written and tend to just select on
/proc/acpi/event.

> be an input driver rather than (or as well as) just dropping stuff in
> acpi/events?

I would have loved to make it an input driver. But looking at the
mailing list archives, that seems to be a bone of contention and hence
I chose to go with the flow. I'll be happy to switch it over to an
input driver if there is consensus around that. Please do let me know.

Thanks,
jayakumar

>
> --
> Matthew Garrett | mjg59@srcf.ucam.org
>
