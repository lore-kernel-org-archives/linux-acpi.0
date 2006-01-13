From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: soft lockup detected in acpi_processor_idle() -- false
	positive?
Date: Fri, 13 Jan 2006 08:55:24 +0800
Message-ID: <1137113724.5750.113.camel@sli10-desk.sh.intel.com>
References: <20060112184305.GA7068@isilmar.linta.de>
	 <200601122054.14128.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200601122054.14128.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2006-01-12 at 20:54 +0100, Rafael J. Wysocki wrote:
> On Thursday, 12 January 2006 19:43, Dominik Brodowski wrote:
> > Latest git, fresh after resuming from suspend-to-disk (in-kernel variant):
> > 
> > [4294914.586000] Restarting tasks... done
> > [4294922.657000] BUG: soft lockup detected on CPU#0!
> > [4294922.657000] 
> > [4294922.657000] Pid: 0, comm:              swapper
> > [4294922.657000] EIP: 0060:[<f003084c>] CPU: 0
> > [4294922.657000] EIP is at acpi_processor_idle+0x1f3/0x2d5 [processor]
> > [4294922.657000]  EFLAGS: 00000282    Not tainted  (2.6.15)
> > [4294922.657000] EAX: fffff000 EBX: 005543a8 ECX: 00000000 EDX: 00000000
> > [4294922.657000] ESI: edcc3064 EDI: edcc2f60 EBP: c041cfdc DS: 007b ES: 007b
> > [4294922.657000] CR0: 8005003b CR2: 080c3000 CR3: 2d530000 CR4: 000006d0
> > 
> > 
> > As acpi_processor_idle doesn't take any locks AFAIK, it seems to me to be a
> > false positive -- or do I miss something obvious?
> 
> I think it's a false-positive.
> 
> This "soft lockup" message has been appearing for me for quite some time now
> (actually since the softlockup patch made it into -mm ;-)), in a
> non-reproducible manner, but I haven't been able to nail it down.
> 
> Still, I thought it was x86-64-specific, but your machine is an i386,
> so there's more to it, apparently.  Probably there's missing
> touch_softlockup_watchdog() somewhere, or the timer .suspend()/.resume()
> routines need some additional review.
I got some similar reports for S3:
http://bugzilla.kernel.org/show_bug.cgi?id=5825
I guess x86-64 lacks .suspend/.resume for timer. Last time I looked at
such issue in ia32, and I fixed it, but I didn't fix x86-64.

Thanks,
Shaohua

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
