From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: ACPI error messages
Date: Wed, 02 Jun 2010 10:13:33 +0800
Message-ID: <1275444813.9119.7310.camel@rzhang1-desktop>
References: <Pine.LNX.4.44L0.1006012126370.32192-300000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:56651 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753803Ab0FBCPT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Jun 2010 22:15:19 -0400
In-Reply-To: <Pine.LNX.4.44L0.1006012126370.32192-300000@netrider.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, 2010-06-02 at 09:32 +0800, Alan Stern wrote:
> On Wed, 2 Jun 2010, Zhang Rui wrote:
> 
> > On Tue, 2010-06-01 at 21:11 +0800, Alan Stern wrote:
> > > My kernel log is full of hundreds of messages like these:
> > >
> > > ACPI Exception: AE_AML_BUFFER_LIMIT, Index (000000046) is beyond end of object (20090903/exoparg2-445)
> > > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.SBRG.EC0_.STBR] (Node f701c918), AE_AML_BUFFER_LIMIT
> > > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.VGA_.LCDD._BCM] (Node f7017b58), AE_AML_BUFFER_LIMIT
> > > ACPI Error: Evaluating _BCM failed (20090903/video-528)
> > >
> > This sounds like a win7 compatibility issue that I've seen before.
> > please try boot option acpi_osi="!Windows 2009" and see if it helps.
> 
> Yes, indeed it does!  It results in a few other differences too; I
> can't tell whether they are good, bad, or neutral.
> 
well, I don't see any other difference except some code execution
ordering issue.

I read the acpidump of this laptop, and it also confirms that this (_BCM
stuff) is the only place that acpi_osi="!Windows 2009" changes.

thanks,
rui

> > BTW, it would be great if you can attach the acpidump of this laptop and
> > the dmesg output after boot.
> 
> Attached (the dmesg log is from a boot without the acpi_osi option).
> Below is a diff between that boot and one with acpi_osi="!Windows
> 2009".  (I believe all those "name_count maxed" lines come from
> mounting an NTFS filesystem; you can ignore them.)
> 
> Alan Stern
> 
> 
> --- dmesg1.txt  2010-06-01 21:23:34.569204151 -0400
> +++ dmesg2.txt  2010-06-01 21:18:21.329732003 -0400



