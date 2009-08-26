From: Frans Pop <elendil-EIBgga6/0yRmR6Xm/wNWPw@public.gmane.org>
Subject: Re: 2.6.31-rc7-git2: Reported regressions 2.6.29 -> 2.6.30
Date: Wed, 26 Aug 2009 18:33:34 +0200
Message-ID: <200908261833.37310.elendil@planet.nl>
References: <JuOd1ZASH0B.A.YGB.0zGlKB@chimera> <b170af450908260147o60427997ne6b9872198893c41@mail.gmail.com> <b170af450908260147o60427997ne6b9872198893c41@mail.gmail.com> <20090826075337.4230d82c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-To: <20090826075337.4230d82c.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Content-Disposition: inline
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, protasnb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

(Dropped unrelated CCs.)

Andrew Morton wrote:
> I'm not seeing any linux-acpi emails from Len since August 14.
> 
> So I merged this patch and shall send it along with
> 
> thermal_sys-check-get_temp-return-value.patch
> acpi-dont-call-acpi_processor_init-if-acpi-is-disabled.patch

Thanks for that Andrew. Could you please do the same for my patches in
http://bugzilla.kernel.org/show_bug.cgi?id=13389 (or
http://lkml.org/lkml/2009/8/17/169)?

That BR is on the regression list for 2.6.30. The patches apply cleanly to 
current mainline.

Thanks,
FJP
