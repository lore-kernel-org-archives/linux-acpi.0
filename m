From: Frans Pop <elendil-EIBgga6/0yRmR6Xm/wNWPw@public.gmane.org>
Subject: Re: 2.6.30-rc6: Reported regressions from 2.6.29
Date: Mon, 25 May 2009 22:24:35 +0200
Message-ID: <200905252224.37012.elendil@planet.nl>
References: <_AjETDMbIoL.A.DcH.RYzDKB@chimera>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-To: <_AjETDMbIoL.A.DcH.RYzDKB@chimera>
Content-Disposition: inline
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Rafael J. Wysocki wrote:
> If you know of any other unresolved regressions from 2.6.29, please let
> me know either and I'll add them to the list.

It may be worth tracking a possible regression introduced with -rc6 as a 
result of http://bugzilla.kernel.org/show_bug.cgi?id=13259.

A new warning that was added in drivers/acpi/processor_throttling.c 
(commit 4973b22a: 'ACPI processor: reset the throttling state once it's 
invalid') may be triggering in cases where it shouldn't. It seems to 
trigger during boot and on 'cat /proc/acpi/processor/*/throttling'.
Otherwise it's probably relatively harmless.

See the comments starting at #23 for details.

Cheers,
FJP
