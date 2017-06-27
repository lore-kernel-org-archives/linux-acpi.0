From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 1/7] platform/x86: fujitsu-laptop: do not use kfifo for
 storing hotkey scancodes
Date: Mon, 26 Jun 2017 17:07:18 -0700
Message-ID: <20170627000718.GA11146@localhost.localdomain>
References: <20170616044058.30443-1-kernel@kempniu.pl>
 <20170616044058.30443-2-kernel@kempniu.pl>
 <20170621181543.GB25900@fury>
 <40512901.HXkrFCdsVg@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <40512901.HXkrFCdsVg@aspire.rjw.lan>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Jonathan Woithe <jwoithe@just42.net>, Andy Shevchenko <andy@infradead.org>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Jun 24, 2017 at 02:25:46AM +0200, Rafael Wysocki wrote:
> On Wednesday, June 21, 2017 11:15:43 AM Darren Hart wrote:
> > On Fri, Jun 16, 2017 at 06:40:52AM +0200, Michał Kępień wrote:
> > > All ACPI device notify callbacks are invoked using acpi_os_execute(),
> > > which causes the supplied callback to be queued to a static workqueue
> > > which always executes on CPU 0.  This means that there is no possibility
> > > for any ACPI device notify callback to be concurrently executed on
> > > multiple CPUs, which in the case of fujitsu-laptop means that using a
> > > locked kfifo for handling hotkeys is redundant: as hotkey scancodes are
> > > only pushed and popped from within acpi_fujitsu_laptop_notify(), no risk
> > > of concurrent pushing and popping exists.
> > 
> > Was the kfifo causing a problem currently or for the migration to separate
> > modules? Is this purely a simplification?
> > 
> > Rafael, the above rationale appears sound to me. Do you have any concerns?
> 
> I actually do.
> 
> While this is the case today, making the driver code depend on it in a hard way
> sort of makes it difficult to change in the future if need be.

OK, if we aren't guaranteed for this to run on CPU 0 in the future, and this
will be annoying to debug if it does changes, let's skip the kfifo change.

I have removed this patch, and fixed up the merge conflicts of the remaining 6
patches here:

http://git.infradead.org/linux-platform-drivers-x86.git/shortlog/refs/heads/fujitsu

Michal / Jonathan, would you please review and let me know if this is what you
would have done / approve the rebase?

Thanks,

-- 
Darren Hart
VMware Open Source Technology Center
