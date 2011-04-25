From: Len Brown <lenb@kernel.org>
Subject: Re: ACPICA release 20110413 linuxized patches
Date: Mon, 25 Apr 2011 16:50:52 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1104251648590.26994@x980>
References: <1302829803.28930.12.camel@minggr.sh.intel.com>
 <BANLkTik4NAmL+tJaecQ4pdmrpPZG8fw=Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:46465 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932367Ab1DYUvN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Apr 2011 16:51:13 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LK800DDV78WOSI2@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Apr 2011 15:51:02 -0500 (CDT)
In-reply-to: <BANLkTik4NAmL+tJaecQ4pdmrpPZG8fw=Lw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <minggr@gmail.com>
Cc: Lin Ming <ming.m.lin@intel.com>, "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Mon, 25 Apr 2011, Lin Ming wrote:

> On Fri, Apr 15, 2011 at 9:10 AM, Lin Ming <ming.m.lin@intel.com> wrote:
> > Hi, Len
> >
> > ACPICA release 20110413 linuxized patches attached.
> > Build and tested on my notebook without problem.
> >
> > [PATCH 1/6] ACPICA: Split all internal Global Lock functions to new file - evglock
> > [PATCH 2/6] ACPICA: Add more methods eligible for NULL package element removal
> > [PATCH 3/6] ACPICA: Update internal address SpaceID for DataTable regions
> > [PATCH 4/6] ACPICA: Move ACPI_NUM_PREDEFINED_REGIONS to a more appropriate place
> > [PATCH 5/6] ACPICA: Execute an orphan _REG method under the EC device
> > [PATCH 6/6] ACPICA: Update to version 20110413
> 
> Hi, Len
> 
> Have you applied this?

No, I've been out of town since the 15th when you sent it (I'm back now).

The acpica branch currently has this:

Lin Ming (3):
      ACPI: osl, add acpi_os_create_lock interface
      ACPICA: Use acpi_os_create_lock interface
      ACPICA: Fix code divergence of global lock handling

cheers,
-Len

