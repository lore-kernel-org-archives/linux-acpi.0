From: Len Brown <lenb@kernel.org>
Subject: Re: battery driver
Date: Fri, 26 Jan 2007 14:43:32 -0500
Message-ID: <200701261443.33139.lenb@kernel.org>
References: <8E389A5F2FEABA4CB1DEC35A25CB39CE7836C0@mssmsx411>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35667 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752133AbXAZTow (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 26 Jan 2007 14:44:52 -0500
In-Reply-To: <8E389A5F2FEABA4CB1DEC35A25CB39CE7836C0@mssmsx411>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lebedev, Vladimir P" <vladimir.p.lebedev@intel.com>
Cc: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy@intel.com>, linux-acpi@vger.kernel.org

On Friday 24 November 2006 12:27, Lebedev, Vladimir P wrote:
> Len,
> 
> Attached patch contains new release of battery driver. The battery
> driver was restructured and it is ready now for future development: for
> example: porting from procfs to sysfs. Patch is based on 2.6.19-rc6-mm1.
> It was tested on few laptops on such functionality as: system
> suspend/resume + removing/inserting and so on. I suggest add patch to mm
> tree.

Same comment as for sbs.

It is not practical to review (and thus apply) this patch --
over 800 lines changed with no check-in comment about
what changed or why, no new comments in the code,
tons of whitespace changes, re-names, and apparently
code moving around inside the file.

This needs to be broken up in to a series of patches --
each making a single logical change.  each change needs
a check-in comment telling the reviewer exactly what to
expect when reading the patch.  cosmetic changes must
never be mixed in the same patch as functional changes --
else it makes the functional change harder to review
and backport.

I'd rather have a series of 80 simple patches of 10 lines
than a single patch of 800 lines.  That makes reviewing
easy, and it makes bisect and  isolation of regressions easy --
and that is what we need to optimize for.

 So download quilt or stgit and learn to use it.

I'm sorry I didn't see this patch when you sent it 8 weeks ago
so I could tell you this right away.  However, the good news
is that battery.c has seen only trivial changes since.

thanks,
-Len
