From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bug #14379] ACPI Warning for _SB_.BAT0._BIF: Converted Buffer to expected String
Date: Mon, 26 Oct 2009 20:30:55 +0100
Message-ID: <200910262030.55564.rjw@sisk.pl>
References: <Sj-rRjx6TwF.A.djE.vqe5KB@chimera> <6dRYo8ss7vL.A.Z4G.kre5KB@chimera> <4AE5F563.5020803@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:59701 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753793AbZJZT3U (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Oct 2009 15:29:20 -0400
In-Reply-To: <4AE5F563.5020803@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>, Lin Ming <ming.m.lin@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Monday 26 October 2009, Justin P. Mattock wrote:
> Rafael J. Wysocki wrote:
> > This message has been generated automatically as a part of a report
> > of recent regressions.
> >
> > The following bug entry is on the current list of known regressions
> > from 2.6.31.  Please verify if it still should be listed and let me know
> > (either way).
> >
> >
> > Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=14379
> > Subject		: ACPI Warning for _SB_.BAT0._BIF: Converted Buffer to expected String
> > Submitter	: Justin Mattock<justinmattock@gmail.com>
> > Date		: 2009-10-08 21:46 (19 days old)
> > First-Bad-Commit: http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=d9adc2e031bd22d5d9607a53a8d3b30e0b675f39
> > References	: http://marc.info/?l=linux-kernel&m=125504031328941&w=4
> > Handled-By	: Alexey Starikovskiy<astarikovskiy@suse.de>
> > Patch		: http://bugzilla.kernel.org/attachment.cgi?id=23347
> >
> >
> >
> >    
> The patch submitted gets rid of the warning
> for people crying wolf!! but probably would not close
> the bugreport until the patch makes it into the main
> kernel.

Yup.

Thanks,
Rafael
