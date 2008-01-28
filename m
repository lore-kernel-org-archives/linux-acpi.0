From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: New: After Hibernation the battery charging information is not working any more.
Date: Mon, 28 Jan 2008 16:16:51 +0100
Message-ID: <200801281616.51861.rjw@sisk.pl>
References: <bug-9835-10286@http.bugzilla.kernel.org/> <20080128045053.a07f6539.akpm@linux-foundation.org> <20080128125755.GB8471@vzsze.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:35300 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761681AbYA1PTM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Jan 2008 10:19:12 -0500
In-Reply-To: <20080128125755.GB8471@vzsze.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rolf Kutz <rk@vzsze.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, bugme-daemon@bugzilla.kernel.org

On Monday, 28 of January 2008, Rolf Kutz wrote:
> On 28/01/08 04:50 -0800, Andrew Morton wrote:
> >On Mon, 28 Jan 2008 04:43:49 -0800 (PST) bugme-daemon@bugzilla.kernel.org wrote:
>
> >This regression apparently occurred very late in 2.6.24 development.  It
> >should be easy to pinpoint?
> 
> I noticed that ACPI_SYSFS_POWER was added in -rc8.
> But neither enabling it nor disabling it resolves
> the bug.
> 
> I will provide additional information if needed.

One of the following commits might be responsible:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=c04209a7948b95e8c52084e8595e74e9428653d3
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=9f9adecd2d0e4f88fa0e8cb06c6ec207748df70a
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=d1ec7298fcefd7e4d1ca612da402ce9e5d5e2c13
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=96c2a8766bf4fe91abac863749c11637fabcc64f

Can you please check if reverting any of them helps?
