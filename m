From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [git pull request] ACPI patches for 2.6.34-rc6
Date: Sat, 8 May 2010 01:17:23 +0200
Message-ID: <201005080117.23760.rjw@sisk.pl>
References: <alpine.LFD.2.00.1005062216430.10792@localhost.localdomain> <201005080039.45533.rjw@sisk.pl> <alpine.LFD.2.00.1005071600030.901@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57217 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754396Ab0EGXQ0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 May 2010 19:16:26 -0400
In-Reply-To: <alpine.LFD.2.00.1005071600030.901@i5.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Saturday 08 May 2010, Linus Torvalds wrote:
> 
> On Sat, 8 May 2010, Rafael J. Wysocki wrote:
> 
> > On Friday 07 May 2010, Linus Torvalds wrote:
> > > 
> > > Btw, why don't we just force the SCI_EN by hand?
> > 
> > Because there are boxes that are broken right away by this.
> > 
> > I have one on my desk in front of me. :-)
> 
> Also if we check whether it was already set before?

Yes.

> The thing is, if that bit is clear (_after_ we've done the regular ACPI 
> setup), the box can't work correctly as far as I know.

That's correct.  But on that particular box acpi_enable() is necessary to
make things work.  Setting SCI_EN by hand makes it hang solid.

Rafael
