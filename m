From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [BUG] ACPI resource validation not working [Was: Re: ITE 8728F]
Date: Tue, 13 Dec 2011 10:01:22 +0800
Message-ID: <1323741682.17515.20.camel@minggr>
References: <CAKPcRGofYw_DcVL1QDorSp8Gr1ZL6-ur=oZnDs0w_e91ZuwKbQ@mail.gmail.com>
	 <94F2FBAB4432B54E8AACC7DFDE6C92E316EE2575@ORSMSX101.amr.corp.intel.com>
	 <1322531323.1467.10.camel@minggr>
	 <CAKPcRGpXP=A-WHVLyvf_ZazY8br5d4-CxrDpnCbpJbcsnMVpiQ@mail.gmail.com>
	 <1323396109.27764.44.camel@minggr>
	 <CAKPcRGokqQ=jRXkhFdXM7zSGowJ5oWjY7fv+mbz4QtscOX3Ukw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:48069 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753904Ab1LMCBp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Dec 2011 21:01:45 -0500
In-Reply-To: <CAKPcRGokqQ=jRXkhFdXM7zSGowJ5oWjY7fv+mbz4QtscOX3Ukw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, Jean Delvare <khali@linux-fr.org>, Nikolay Mikov <nik.mikov@gmail.com>, Thomas <trenn@suse.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, lenb <lenb@kernel.org>

On Mon, 2011-12-12 at 20:52 +0800, Luca Tettamanti wrote:
> On Fri, Dec 9, 2011 at 3:01 AM, Lin Ming <ming.m.lin@intel.com> wrote:
> > Hi Luca,
> >
> > We have investigated this issue more and think that it's better to move
> > the resource validation code into ACPICA core.
> >
> > Here is the new patch.
> >
> > The major changes include:
> > - Remove acpi_os_validate_address/acpi_os_invalidate_address from osl.c.
> >  They are reimplemented in ACPICA core:
> >  acpi_ut_add_address_range/acpi_ut_remove_address_range.
> >
> > - Add new interface for drivers to check resource conflict:
> >  acpi_check_address_range
> >
> > Could you help to test it?
> 
> Sure, works fine:
> Tested-by: Luca Tettamanti <kronos.it@gmail.com>

Thanks.

