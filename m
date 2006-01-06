From: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Re. 2.6.15-mm1
Date: Thu, 5 Jan 2006 19:38:10 -0500
Message-ID: <20060106003810.GA22051@redhat.com>
References: <200601051801.29007@zodiac.zodiac.dnsalias.org> <20060105144720.25085afa.akpm@osdl.org> <200601060033.34276@zodiac.zodiac.dnsalias.org> <20060105162151.6fc1716f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20060105162151.6fc1716f.akpm-3NddpPZAyC0@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: Alexander Gran <alex-4mRm4CWMOdkHuPwBo6/EyUB+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org, reiserfs-dev-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, vs-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org, "Seth, Rohit" <rohit.seth-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jan 05, 2006 at 04:21:51PM -0800, Andrew Morton wrote:

 > > Am Donnerstag, 5. Januar 2006 23:47 schrieb Andrew Morton:
 > > > > Jan  5 16:22:47 t40 kernel: mtrr: 0xe0000000,0x8000000 overlaps existing
 > > > > 0xe0000000,0x4000000
 > > > > Jan  5 16:22:48 t40 last message repeated 2 times
 > > >
 > > > Is that new?
 > > 
 > > Umm, no. I just thought it could be related to the X oops.
 > 
 > OK.  I don't know how common this is, nor whether it'll cause problems. 
 > David(s), do you know?

at worse, a video performance hit.

 > > EIP is at agp_collect_device_status+0x14/0xd4
 > OK.  I've been assuming that this is a DRM bug but I note that the AGP tree
 > has been dinking with agp_collect_device_status(), so perhaps I had the wrong
 > David.

I'm a moron. I'll fix it up.
I only tested the 'have no agp' case which this changed, and didn't test
the commoncase 'have agp'.  Doh.

		Dave

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
