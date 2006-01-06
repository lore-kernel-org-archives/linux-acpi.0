From: Alexander Zarochentsev <zam-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Re. 2.6.15-mm1
Date: Fri, 6 Jan 2006 21:29:21 +0300
Message-ID: <200601062129.22733.zam@namesys.com>
References: <200601051801.29007@zodiac.zodiac.dnsalias.org> <20060105144720.25085afa.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20060105144720.25085afa.akpm-3NddpPZAyC0@public.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: reiserfs-dev-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, Alexander Gran <alex-4mRm4CWMOdkHuPwBo6/EyUB+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>, "Vladimir V. Saveliev" <vs-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Friday 06 January 2006 01:47, Andrew Morton wrote:
> Alexander Gran <alex-4mRm4CWMOdkHuPwBo6/EyUB+6BGkLq7r@public.gmane.org> wrote:
> > Hi,
> >
> > just tried 2.6.15-mm1 on my thinkpad. Various aspects that didn't work /
> > look good:
>
> Thanks.  A few people have some work to do before they are ready to merge
> to 2.6.16.
>
> > Jan  5 16:22:38 t40 kernel: pnp: PnP ACPI init
> > Jan  5 16:22:38 t40 kernel: pnp: PnPACPI: unknown resource type 7
> > Jan  5 16:22:38 t40 kernel: pnp: PnPACPI: unknown resource type 7
> > Jan  5 16:22:39 t40 last message repeated 10 times
> > Jan  5 16:22:39 t40 kernel: pnp: PnP ACPI: found 0 devices
>
> pnpacpi is unhappy.
>
> > All over the place logs like this:
> > Jan  5 16:22:43 t40 kernel: **** SET: Misaligned resource pointer:
> > f7db5502 Type 07 Len 0
> > Unknown to me so far..
>
> acpi is unhappy.
>
> > When X startet, the laptops crashed:
> > Jan  5 16:22:43 t40 kernel: <4>reiser4[syslogd(2729)]:
> > disable_write_barrier (fs/reiser4/wander.c:233)[zam-1055]:
> > Jan  5 16:22:43 t40 kernel: WARNING: disabling write barrier

It means submit_bio(WRITE_BARRIER, bio) fails and reiser4 falls back to 
synchronous write in the transaction commit code.  

Ext3, reiserfs do similar checks in their code and all issue warnings if those 
checks fail.  But only ext3, it seems, has write barrier support disabled by 
default.

> Vladimir, is that expected?
>
> > Jan  5 16:22:43 t40 kernel:
> > Jan  5 16:22:47 t40 kernel: mtrr: 0xe0000000,0x8000000 overlaps existing
> > 0xe0000000,0x4000000
> > Jan  5 16:22:48 t40 last message repeated 2 times
>
> Is that new?
>
> > Jan  5 16:22:48 t40 kernel: agpgart: Found an AGP 2.0 compliant device at
> > 0000:00:00.0.
> > Jan  5 16:22:48 t40 kernel: c028b7cf
> > Jan  5 16:22:48 t40 kernel: Modules linked in: irtty_sir sir_dev
> > cfq_iosched ehci_hcd uhci_hcd
> > Jan  5 16:22:48 t40 kernel: EIP:    0060:[<c028b7cf>]    Not tainted VLI
> > Jan  5 16:22:48 t40 kernel: EFLAGS: 00013202   (2.6.15-mm1)
> > Jan  5 16:22:48 t40 kernel:        <0>c028b9e9 f762ff08 00000002 00000000
> > c19720ec 00000000 1f000217 c1a79400
> > Jan  5 16:22:48 t40 kernel:        <0>00000032 00000001 c028bfb5 c0297262
> > c1a79400 c02972af 1f000207 c029727f
>
> hm, it's not clear what oopsed.   Can you get a cleaner copy of this?
>
> > Jan  5 16:22:48 t40 kernel:  <3>[drm:drm_release] *ERROR* Device busy: 1
> > 0
>
> drm is unhappy

-- 
Alex.
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
