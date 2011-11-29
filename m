From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [BUG] ACPI resource validation not working [Was: Re: ITE 8728F]
Date: Tue, 29 Nov 2011 21:44:08 +0800
Message-ID: <CAF1ivSZyvzOY9DGWEgSwrcbyPQ9ftOGbO9VAwcDk-V4=Utxk0g@mail.gmail.com>
References: <CAKPcRGofYw_DcVL1QDorSp8Gr1ZL6-ur=oZnDs0w_e91ZuwKbQ@mail.gmail.com>
	<94F2FBAB4432B54E8AACC7DFDE6C92E316EE2575@ORSMSX101.amr.corp.intel.com>
	<1322531323.1467.10.camel@minggr>
	<CAKPcRGpXP=A-WHVLyvf_ZazY8br5d4-CxrDpnCbpJbcsnMVpiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:52743 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755270Ab1K2NoJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Nov 2011 08:44:09 -0500
Received: by vcbfk14 with SMTP id fk14so4596026vcb.19
        for <linux-acpi@vger.kernel.org>; Tue, 29 Nov 2011 05:44:08 -0800 (PST)
In-Reply-To: <CAKPcRGpXP=A-WHVLyvf_ZazY8br5d4-CxrDpnCbpJbcsnMVpiQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, Jean Delvare <khali@linux-fr.org>, Nikolay Mikov <nik.mikov@gmail.com>, Thomas <trenn@suse.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, Nov 29, 2011 at 9:18 PM, Luca Tettamanti <kronos.it@gmail.com> wrote:
> On Tue, Nov 29, 2011 at 2:48 AM, Lin Ming <ming.m.lin@intel.com> wrote:
>> On Tue, 2011-11-29 at 06:56 +0800, Moore, Robert wrote:
>>> I'm going to let Lin Ming respond to this, since the functions in question appear to be Linux extensions to ACPICA.
> [...]
>> Yes, we should put the call back.
>
> Great, are you going to push this patch yourself?

Yes. I'll send it to Len.
