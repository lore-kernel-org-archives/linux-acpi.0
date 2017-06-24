From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/7] platform/x86: fujitsu-laptop: do not use kfifo for storing hotkey scancodes
Date: Sat, 24 Jun 2017 02:25:46 +0200
Message-ID: <40512901.HXkrFCdsVg@aspire.rjw.lan>
References: <20170616044058.30443-1-kernel@kempniu.pl> <20170616044058.30443-2-kernel@kempniu.pl> <20170621181543.GB25900@fury>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170621181543.GB25900@fury>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Jonathan Woithe <jwoithe@just42.net>, Andy Shevchenko <andy@infradead.org>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday, June 21, 2017 11:15:43 AM Darren Hart wrote:
> On Fri, Jun 16, 2017 at 06:40:52AM +0200, Michał Kępień wrote:
> > All ACPI device notify callbacks are invoked using acpi_os_execute(),
> > which causes the supplied callback to be queued to a static workqueue
> > which always executes on CPU 0.  This means that there is no possibility
> > for any ACPI device notify callback to be concurrently executed on
> > multiple CPUs, which in the case of fujitsu-laptop means that using a
> > locked kfifo for handling hotkeys is redundant: as hotkey scancodes are
> > only pushed and popped from within acpi_fujitsu_laptop_notify(), no risk
> > of concurrent pushing and popping exists.
> 
> Was the kfifo causing a problem currently or for the migration to separate
> modules? Is this purely a simplification?
> 
> Rafael, the above rationale appears sound to me. Do you have any concerns?

I actually do.

While this is the case today, making the driver code depend on it in a hard way
sort of makes it difficult to change in the future if need be.

Thanks,
Rafael
