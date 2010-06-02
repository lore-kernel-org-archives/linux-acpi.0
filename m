From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: ACPI error messages
Date: Wed, 2 Jun 2010 11:10:25 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006021105590.1992-100000@iolanthe.rowland.org>
References: <1275444813.9119.7310.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:42638 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932518Ab0FBPK3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2010 11:10:29 -0400
In-Reply-To: <1275444813.9119.7310.camel@rzhang1-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, 2 Jun 2010, Zhang Rui wrote:

> On Wed, 2010-06-02 at 09:32 +0800, Alan Stern wrote:
> > On Wed, 2 Jun 2010, Zhang Rui wrote:
> > 
> > > On Tue, 2010-06-01 at 21:11 +0800, Alan Stern wrote:
> > > > My kernel log is full of hundreds of messages like these:
> > > >
> > > > ACPI Exception: AE_AML_BUFFER_LIMIT, Index (000000046) is beyond end of object (20090903/exoparg2-445)
> > > > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.SBRG.EC0_.STBR] (Node f701c918), AE_AML_BUFFER_LIMIT
> > > > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.VGA_.LCDD._BCM] (Node f7017b58), AE_AML_BUFFER_LIMIT
> > > > ACPI Error: Evaluating _BCM failed (20090903/video-528)
> > > >
> > > This sounds like a win7 compatibility issue that I've seen before.
> > > please try boot option acpi_osi="!Windows 2009" and see if it helps.
> > 
> > Yes, indeed it does!  It results in a few other differences too; I
> > can't tell whether they are good, bad, or neutral.
> > 
> well, I don't see any other difference except some code execution
> ordering issue.

You are right.  Well, there is one difference: the lines about 
"cfg80211: World regulatory domain updated:".  I'm not concerned about 
that.

> I read the acpidump of this laptop, and it also confirms that this (_BCM
> stuff) is the only place that acpi_osi="!Windows 2009" changes.

All right; I'll keep that boot config option.  Is there a plan to fix 
this compatibility issue?

Alan Stern

