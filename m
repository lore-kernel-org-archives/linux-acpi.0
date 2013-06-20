From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 07/16] ACPICA: New: Portable acpidump utility (get system ACPI tables)
Date: Thu, 20 Jun 2013 21:42:21 +0200
Message-ID: <1476146.YPydkeoMbM@vostro.rjw.lan>
References: <cover.1369274558.git.lv.zheng@intel.com> <2723103.DgDP1L2HFo@vostro.rjw.lan> <94F2FBAB4432B54E8AACC7DFDE6C92E36FE88D97@ORSMSX103.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:44585 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965491Ab3FTTdA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Jun 2013 15:33:00 -0400
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E36FE88D97@ORSMSX103.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

On Thursday, June 20, 2013 04:57:04 AM Moore, Robert wrote:
> 
> > -----Original Message-----
> > From: Rafael J. Wysocki [mailto:rjw@sisk.pl]
> > Sent: Wednesday, June 19, 2013 4:11 PM
> > To: Moore, Robert
> > Cc: Len Brown; Zheng, Lv; Wysocki, Rafael J; Brown, Len; linux acpi
> > Subject: Re: [PATCH 07/16] ACPICA: New: Portable acpidump utility (get
> > system ACPI tables)
> > 
> > On Wednesday, June 19, 2013 12:48:56 AM Moore, Robert wrote:
> > > Sorry, I don't think the Linux version has been completed in version
> > > 20130517
> > > -- so perhaps you should ignore this patch after all, unless you want
> > > to simply establish the infrastructure for the final Linux version.
> > > The Linux-specific code is completed and will be part of the June
> > release.
> > 
> > Great, I'll take the patch at that time, then.
> > 
> > > However, we can still discuss the future of the changelog, etc. We
> > > seem to have an overall problem where the ACPICA commit log is
> > > "generic", but I'm seeing here a request to make the actual Linux
> > > patches more specific to Linux.
> > >
> > > As far as acpica and acpidump is concerned, I put specific generation
> > > instructions in the reference manual...
> > >
> > > Of course, the details for any individual operating system may be
> > > different (especially file locations), so I have to make the acpica
> > > changelog somewhat generic.
> > >
> > >
> > > Here is the actual acpica changelog text concerning acpidump, for
> > version 20130517:
> > >
> > > 2) iASL Compiler/Disassembler and Tools:
> > >
> > > New utility: Implemented an easily portable version of the acpidump
> > > utility to extract ACPI tables from the system (or a file) in an ASCII
> > > hex dump format. The top-level code implements the various command
> > > line options, file I/O, and table dump routines. To port to a new
> > > host, only three functions need to be implemented to get tables --
> > > since this functionality is OS-dependent. See the
> > > tools/acpidump/apmain.c module and the ACPICA reference for porting
> > instructions. ACPICA BZ 859. Notes:
> > > 1) The Windows version obtains the ACPI tables from the Registry.
> > > 2) The Linux version is under development.
> > > 3) Other hosts - If an OS-dependent module is submitted, it will be
> > > distributed with ACPICA.
> > 
> > Well, this is much better than what Lv sent, actually.
> > 
> > We could use it for Linux too, I think, only without the "Notes" part.
> > 
> > My general opinion is that we can simply use the same changelogs as the
> > ACPICA upstream does, possibly amended with a more detailed explanation of
> > the motivation behind the patch.
> > 
> > In this case, however, the changelog wasn't even similar to the original
> > one.
> > 
> 
> This is the text from the release notes which end up in the "changes.txt" file.

I see.  We don't get that information with the kernel patches, though.

> I usually expand upon the major changes in a format that is longer than the
> actual commit log.

So perhaps Lv (or whoever generates the Linux patches for the given release)
can simply add the information you put into "changes.txt" to the Linux patches
changelogs?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
