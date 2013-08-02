From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: i915 backlight
Date: Fri, 02 Aug 2013 16:03 +0200
Message-ID: <1544218.2BR9ul04Pj@vostro.rjw.lan>
References: <20130731162252.GC4724@pd.tnic> <CAPBO7TaPxa_13FBDE5Z=Aoa+ePPfLRH0+oWSQyEmO00xSfGqYg@mail.gmail.com> <CAMP44s1WMMXcGfF6Ta0CFthY3-7tkpqXEPx1iZhVU-XpS6KUWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMP44s1WMMXcGfF6Ta0CFthY3-7tkpqXEPx1iZhVU-XpS6KUWw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Josep Lladonosa <jlladono@gmail.com>, Aaron Lu <aaron.lu@intel.com>, Borislav Petkov <bp@alien8.de>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, lkml <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Friday, August 02, 2013 01:48:37 AM Felipe Contreras wrote:
> On Fri, Aug 2, 2013 at 1:25 AM, Josep Lladonosa <jlladono@gmail.com> wrote:
> > Hello,
> >
> > I am using a Lenovo Edge E530 and, with kernel 3.11.0-rc3, I had to
> > change to this parameter to the kernel boot:
> >
> >
> > GRUB_CMDLINE_LINUX="acpi_osi=\"!Windows 2012\""
> 
> I think it's pretty obvious that for the time being we need to
> blacklist a ton of machines so they boot without this OSI. In fact, in
> might make sense to simply remove the OSI completely for all machines
> (for now).

That would have made sense 6 months ago, but not today.

The reason is that you don't really know what's affected by that and I'm
pretty sure it's not only backlight.

So no, we won't do that.

We *might* blacklist machines that shipped with Windows 7, but whose BIOSes
call the Windows 8 OSI, because there's a good chance they weren't really
tested with Windows 8.

Thanks,
Rafael
