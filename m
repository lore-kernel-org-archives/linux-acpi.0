From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] ACPICA: Restore error table definitions to reduce source
 code differences between Linux and ACPICA upstream.
Date: Thu, 12 Jun 2014 08:23:30 +0200
Message-ID: <20140612062329.GA4857@pd.tnic>
References: <1401784373-8599-1-git-send-email-lv.zheng@intel.com>
 <2787139.OIeHFv9Bzc@vostro.rjw.lan>
 <1AE640813FDE7649BE1B193DEA596E880262CC89@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:44142 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751325AbaFLG0w (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Jun 2014 02:26:52 -0400
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E880262CC89@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "Chen, Gong" <gong.chen@linux.intel.com>, "Luck, Tony" <tony.luck@intel.com>

On Thu, Jun 12, 2014 at 02:33:13AM +0000, Zheng, Lv wrote:
> Hi, Ping Rafael and Boris
> 
> Could this patch be accepted?
> It's easier than asking all OSPMs to do changes in their drivers.
> 
> Thanks and best regards
> -Lv
> 
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Rafael J. Wysocki
> > Sent: Tuesday, June 03, 2014 9:31 PM
> > 
> > CC: Boris.
> > 
> > On Tuesday, June 03, 2014 04:32:53 PM Lv Zheng wrote:
> > > The following commit has changed ACPICA table header definitions:
> > >  Commit: 88f074f4871a8c212b212b725e4dcdcdb09613c1
> > >  Subject: ACPI, CPER: Update cper info
> > > While such definitions are currently maintained in ACPICA. As the
> > > modifications applying to the table definitions affect other OSPMs'
> > > drivers, it is very difficult for ACPICA to initiate a process to complete
> > > the merge. Thus this commit finally only leaves us divergences.
> > >
> > > This patch reverts such naming modifications to reduce the source code
> > > differecnes between Linux and ACPICA upstream. No functional changes.

Well, it sounds to me like we don't have a choice, do we? In that case,
I'm fine with it.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
