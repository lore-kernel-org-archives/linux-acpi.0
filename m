From: Hugh Dickins <hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [BK PATCH] acpismp=force fix
Date: Fri, 27 Jun 2003 12:58:17 +0100 (BST)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <Pine.LNX.4.44.0306271221110.1197-100000@localhost.localdomain>
References: <A5974D8E5F98D511BB910002A50A66470B981205@hdsmsx103.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <A5974D8E5F98D511BB910002A50A66470B981205-MgY+aF+eRfZviC08c4yzC1DQ4js95KgL@public.gmane.org>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: 'Arjan van de Ven' <arjanv-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-LL/9OlyS9hIAvxtiuMwx3w@public.gmane.org>, torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 26 Jun 2003, Brown, Len wrote:
> 
> I think there should be a boot-option to use ACPI for boot-time
> configuration tables, but to not load the driver for run-time event
> handling.  This is useful for enabling HT on systems with broken ACPI
> run-time BIOS.

I may be wrong, I think it was Arjan persuaded AndrewG to allow the
acpitable.c code into 2.5 for this case.  At present it's enabled by
config option instead of boot option, in both 2.5 (where the config
option didn't actually work, patch posted for that a couple of days ago)
and in 2.4.22-pre (which thus diverges from 2.4.21).  That surprises me,
but I'd definitely defer to Arjan's preference.

> UnitedLinux uses "acpi=oldboot" for this.  While 'old' will become ambiguous
> when today's "new" becomes tomorrow's "old";-), I do like "acpi={something}"
> rather than complicating matters with non "acpi=" syntax.

I agree with you.

> Re: "acpismp=force"
> I wouldn't miss it.  Sounds unanimous.

It did have some point before, recent changes have rendered it pointless,
and even if those changes get revised, there'll be a better way than the
confusing "acpismp=force".

> Re: "noht"
> To disable HT on a uni-processor, wouldn't it be preferable to simply run
> the UP kernel rather than the SMP kernel with HT disabled?

Yes, though wouldn't BIOS be able to disable it on those too?

> That leaves SMP
> systems, where either the BIOS could disable it (it is a BIOS bug if it
> can't), or as a last resort CONFIG_X86_HT (2.5) could be config'd out of the
> kernel.  I guess I've talked myself into not missing "noht" also.

I fathered "noht", so feel some responsibility for it.  In its present
state it's simply buggered in both 2.5 and 2.4.22-pre, and I'd much rather
kill it off than leave it around in that misery.  If we can always switch
off in BIOS instead, I guess it's redundant and should go.  Arjan remarked
that it's no problem to honor it codewise in 2.4: up to 2.4.21 it was easy,
but now beyond what I can safely mess with - I'm hoping someone (perhaps
beginning with A?) might reprieve it, but if not I'll send patches to
remove it from 2.4 and 2.5 in a few weeks time.

Hugh
