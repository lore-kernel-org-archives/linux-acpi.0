From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: 2.6.30-rc6: Reported regressions from 2.6.29
Date: Tue, 26 May 2009 01:02:28 +0200
Message-ID: <200905260102.29455.rjw@sisk.pl>
References: <_AjETDMbIoL.A.DcH.RYzDKB@chimera> <200905252224.37012.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200905252224.37012.elendil-EIBgga6/0yRmR6Xm/wNWPw@public.gmane.org>
Content-Disposition: inline
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frans Pop <elendil-EIBgga6/0yRmR6Xm/wNWPw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Monday 25 May 2009, Frans Pop wrote:
> Rafael J. Wysocki wrote:
> > If you know of any other unresolved regressions from 2.6.29, please let
> > me know either and I'll add them to the list.
> 
> It may be worth tracking a possible regression introduced with -rc6 as a 
> result of http://bugzilla.kernel.org/show_bug.cgi?id=13259.
> 
> A new warning that was added in drivers/acpi/processor_throttling.c 
> (commit 4973b22a: 'ACPI processor: reset the throttling state once it's 
> invalid') may be triggering in cases where it shouldn't. It seems to 
> trigger during boot and on 'cat /proc/acpi/processor/*/throttling'.
> Otherwise it's probably relatively harmless.
> 
> See the comments starting at #23 for details.

Hmm.  It's really better if you file a separate bug for that with a reference
to the previous discussion.

Thanks,
Rafael
