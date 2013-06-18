From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 07/16] ACPICA: New: Portable acpidump utility (get system ACPI tables)
Date: Tue, 18 Jun 2013 23:40:47 +0200
Message-ID: <3314941.aQrPpJxYFk@vostro.rjw.lan>
References: <cover.1369274558.git.lv.zheng@intel.com> <2334553.HBLCIvOtSu@vostro.rjw.lan> <94F2FBAB4432B54E8AACC7DFDE6C92E36FE886D5@ORSMSX103.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:41848 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756330Ab3FRVb2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Jun 2013 17:31:28 -0400
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E36FE886D5@ORSMSX103.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

On Tuesday, June 18, 2013 09:21:22 PM Moore, Robert wrote:
> It would be a similar generation to the iASL compiler or the acpixtract utility.

Well, so why don't we write in the changelog: "This change allows the user to
build the portable acpidump utility by executing the following command: ..."
and so on?

Rafael


> > -----Original Message-----
> > From: Rafael J. Wysocki [mailto:rjw@sisk.pl]
> > Sent: Tuesday, June 18, 2013 2:06 PM
> > To: Moore, Robert
> > Cc: Len Brown; Zheng, Lv; Wysocki, Rafael J; Brown, Len; linux acpi
> > Subject: Re: [PATCH 07/16] ACPICA: New: Portable acpidump utility (get
> > system ACPI tables)
> > 
> > On Tuesday, June 18, 2013 06:53:42 PM Moore, Robert wrote:
> > > Please don't drop this if it is indeed the acpidump utility.
> > 
> > Well, that's unclear to me to be honest. :-)
> > 
> > > This utility is now a part of ACPICA and should replace the existing
> > utility.
> > 
> > OK, but we need to tell the users how to build it.
> > 
> > Thanks,
> > Rafael
> > 
> > 
> > > > -----Original Message-----
> > > > From: Rafael J. Wysocki [mailto:rjw@sisk.pl]
> > > > Sent: Saturday, June 15, 2013 4:10 PM
> > > > To: Len Brown
> > > > Cc: Zheng, Lv; Wysocki, Rafael J; Moore, Robert; Brown, Len; linux
> > > > acpi
> > > > Subject: Re: [PATCH 07/16] ACPICA: New: Portable acpidump utility
> > > > (get system ACPI tables)
> > > >
> > > > On Wednesday, June 12, 2013 01:07:50 PM Len Brown wrote:
> > > > > > This utility dumps the system ACPI tables in an ascii format
> > > > > > suitable for extraction via the acpixtract utility.
> > > > >
> > > > > This commit message does not match the contents of the patch, or
> > > > > explain how this patch is related (or not) to the acpidump utility
> > > > > already in the kernel tree under tools/power/acpi/acpidump/
> > > > >
> > > > > Naked-by: Len Brown <len.brown@intel.com>
> > > >
> > > > Well, I was on the verge of dropping this one before, so dropped now.
> > > >
> > > > Thanks,
> > > > Rafael
> > > >
> > > >
> > > > --
> > > > I speak only for myself.
> > > > Rafael J. Wysocki, Intel Open Source Technology Center.
> > >
> > --
> > I speak only for myself.
> > Rafael J. Wysocki, Intel Open Source Technology Center.
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
