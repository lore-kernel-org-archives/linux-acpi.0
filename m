From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: ACPI error messages
Date: Thu, 03 Jun 2010 09:10:06 +0800
Message-ID: <1275527406.9119.8724.camel@rzhang1-desktop>
References: <Pine.LNX.4.44L0.1006021105590.1992-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:25159 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757873Ab0FCBJi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 2 Jun 2010 21:09:38 -0400
In-Reply-To: <Pine.LNX.4.44L0.1006021105590.1992-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, 2010-06-02 at 23:10 +0800, Alan Stern wrote:
> On Wed, 2 Jun 2010, Zhang Rui wrote:
> 
> > On Wed, 2010-06-02 at 09:32 +0800, Alan Stern wrote:
> > > On Wed, 2 Jun 2010, Zhang Rui wrote:
> > > 
> > > > On Tue, 2010-06-01 at 21:11 +0800, Alan Stern wrote:
> > > > > My kernel log is full of hundreds of messages like these:
> > > > >
> > > > > ACPI Exception: AE_AML_BUFFER_LIMIT, Index (000000046) is beyond end of object (20090903/exoparg2-445)
> > > > > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.SBRG.EC0_.STBR] (Node f701c918), AE_AML_BUFFER_LIMIT
> > > > > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.VGA_.LCDD._BCM] (Node f7017b58), AE_AML_BUFFER_LIMIT
> > > > > ACPI Error: Evaluating _BCM failed (20090903/video-528)
> > > > >
> > > > This sounds like a win7 compatibility issue that I've seen before.
> > > > please try boot option acpi_osi="!Windows 2009" and see if it helps.
> > > 
> > > Yes, indeed it does!  It results in a few other differences too; I
> > > can't tell whether they are good, bad, or neutral.
> > > 
> > well, I don't see any other difference except some code execution
> > ordering issue.
> 
> You are right.  Well, there is one difference: the lines about 
> "cfg80211: World regulatory domain updated:".  I'm not concerned about 
> that.
> 
> > I read the acpidump of this laptop, and it also confirms that this (_BCM
> > stuff) is the only place that acpi_osi="!Windows 2009" changes.
> 
> All right; I'll keep that boot config option.  Is there a plan to fix 
> this compatibility issue?
> 
This is a BIOS bug to me. The code runs in this way:

if (not Win7)
  good BIOS code
else
  buggy BIOS code

This is a regression because ACPI declares it's win7 compatible in
2.6.31. I'm afraid we can do nothing in Linux kernel to fix/workaround
it. IMO, we should ping Asus to fix it in their new BIOS release.

thanks,
rui






 We can not fix it in kernel.

> Alan Stern
> 


