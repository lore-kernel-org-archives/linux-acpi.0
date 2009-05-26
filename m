From: Frans Pop <elendil@planet.nl>
Subject: Re: 2.6.30-rc6: Reported regressions from 2.6.29
Date: Tue, 26 May 2009 17:30:51 +0200
Message-ID: <200905261730.53041.elendil@planet.nl>
References: <_AjETDMbIoL.A.DcH.RYzDKB@chimera> <200905252224.37012.elendil@planet.nl> <200905260102.29455.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cpsmtpm-eml104.kpnxchange.com ([195.121.3.8]:61938 "EHLO
	CPSMTPM-EML104.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750883AbZEZPck (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 May 2009 11:32:40 -0400
In-Reply-To: <200905260102.29455.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, kernel-testers@vger.kernel.org, linux-acpi@vger.kernel.org

On Tuesday 26 May 2009, Rafael J. Wysocki wrote:
> On Monday 25 May 2009, Frans Pop wrote:
> > Rafael J. Wysocki wrote:
> > > If you know of any other unresolved regressions from 2.6.29, please
> > > let me know either and I'll add them to the list.
> >
> > It may be worth tracking a possible regression introduced with -rc6
> > as a result of http://bugzilla.kernel.org/show_bug.cgi?id=13259.
> >
> > A new warning that was added in drivers/acpi/processor_throttling.c
> > (commit 4973b22a: 'ACPI processor: reset the throttling state once
> > it's invalid') may be triggering in cases where it shouldn't. It
> > seems to trigger during boot and on 'cat
> > /proc/acpi/processor/*/throttling'. Otherwise it's probably
> > relatively harmless.
> >
> > See the comments starting at #23 for details.
>
> Hmm.  It's really better if you file a separate bug for that with a
> reference to the previous discussion.

Done (after doing additional debugging):
http://bugzilla.kernel.org/show_bug.cgi?id=13389

Marked as regression and set as blocking for #13070.

Cheers,
FJP
