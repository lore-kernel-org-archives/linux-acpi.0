From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [ACPI] Re: [2.6.0-test5-mm1] Suspend to RAM problems
Date: Sat, 13 Sep 2003 17:56:26 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030913155626.GB527@elf.ucw.cz>
References: <20030910154551.GA1507@rootdir.de> <Pine.LNX.4.44.0309101806480.2528-100000@pau.intranet.ct>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309101806480.2528-100000-hpaKMlRJ+hxRbP4gfI7f2Q@public.gmane.org>
To: Pau Aliagas <linuxnow-MYlnYO1lEJtAfugRpC6u6w@public.gmane.org>
Cc: Claas Langbehn <claas-YJlxJerscEeELgA04lAiVw@public.gmane.org>, Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew de Quincey <adq-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > > 2) ACPI
> > > > Thanks to Andrew de Quincey I can boot with ACPI without
> > > > problems and I can read out my temp and so on, but when I do
> > > >    echo -n "mem" >/sys/power/state 
> > > > the machine goes into sleep (STR) but crashes after waking up again.
> > > 
> > > What exactly does it do on wakeup? 
> 
> Mine crashes before suspending. It says something like:
> Stoppings tasks
> ===========================================================
> critical region / count pages [XXXXXXXXXXXX]

This looks like swsusp, not S3.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
