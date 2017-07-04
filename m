From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v2] platform/x86: wmi-bmof: New driver to expose embedded
 Binary WMI MOF metadata
Date: Tue, 4 Jul 2017 15:28:19 +0200
Message-ID: <20170704132819.GE2102@pali>
References: <cd020900567e5c26af29e0735a3945a855d26a30.1496718529.git.dvhart@infradead.org>
 <20170606100440.GA4690@pali>
 <20170606170201.GC32509@fury>
 <201706062250.52564@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34921 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750891AbdGDN2W (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Jul 2017 09:28:22 -0400
Content-Disposition: inline
In-Reply-To: <201706062250.52564@pali>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>, platform-driver-x86@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, Mario Limonciello <mario_limonciello@dell.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tuesday 06 June 2017 22:50:52 Pali Rohár wrote:
> On Tuesday 06 June 2017 19:02:01 Darren Hart wrote:
> > On Tue, Jun 06, 2017 at 12:04:40PM +0200, Pali Rohár wrote:
> > > On Monday 05 June 2017 20:16:44 Andy Lutomirski wrote:
> > > > +#define WMI_BMOF_GUID "05901221-D566-11D1-B2F0-00A0C9062910"
> > > > +MODULE_ALIAS("wmi:" WMI_BMOF_GUID);
> > > 
> > > Cannot we generate MODULE_ALIAS from module_wmi_driver()? IIRC it
> > > is working for i2c drivers.
> > 
> > I could see this being automated since we always use wmi:GUID, but it
> > isn't currently. Happy to consider it as a follow on.
> > 
> > Do you have a specific i2c example you think we should consider
> > following?
> 
> For i2c you can specify in driver code:
> 
> MODULE_DEVICE_TABLE(i2c, id_table);
> 
> And it automatically provides (via file.mod.c) all needed MODULE_ALIAS.
> 
> So when we have wmi_bmof_id_table in driver, cannot we use this?
> 
> MODULE_DEVICE_TABLE(wmi, wmi_bmof_id_table);

Just reminder for above idea ↑↑↑

-- 
Pali Rohár
pali.rohar@gmail.com
