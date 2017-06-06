From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 16/16] platform/x86: dell-wmi: Convert to the WMI bus
 infrastructure
Date: Mon, 5 Jun 2017 20:04:19 -0700
Message-ID: <20170606030419.GD27270@fury>
References: <cover.1495862272.git.dvhart@infradead.org>
 <4a4da770c8d0af7e3f31e79261b43573d70a6ea6.1495862272.git.dvhart@infradead.org>
 <201705271250.20338@pali>
 <CALCETrWic6ZWrjdmXTRX92U058B1SZ+xMd+5TBW+YL51ZrgeCA@mail.gmail.com>
 <3669DF37-7D17-40AD-852A-F8EDBE15A785@gmail.com>
 <CALCETrWtkEazuMMrFZp4oybwjNO-8r6GNF2BLA39fJqfH8Crtw@mail.gmail.com>
 <20170530024505.GC32841@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:37783 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbdFFDEV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jun 2017 23:04:21 -0400
Content-Disposition: inline
In-Reply-To: <20170530024505.GC32841@dtor-ws>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Jiri Kosina <jikos@kernel.org>, platform-driver-x86@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mario Limonciello <mario_limonciello@dell.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Mon, May 29, 2017 at 07:45:05PM -0700, Dmitry Torokhov wrote:
> On Sat, May 27, 2017 at 11:40:52AM -0700, Andy Lutomirski wrote:
> > On Sat, May 27, 2017 at 9:17 AM, Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > > On May 27, 2017 9:04:38 AM PDT, Andy Lutomirski <luto@kernel.org> wrote:
> > >>On Sat, May 27, 2017 at 3:50 AM, Pali Rohár <pali.rohar@gmail.com>
> > >>wrote:
> > >>> On Saturday 27 May 2017 07:31:30 Darren Hart wrote:
> > >>>> -     dell_wmi_input_dev->name = "Dell WMI hotkeys";
> > >>>> -     dell_wmi_input_dev->phys = "wmi/input0";
> > >>>> -     dell_wmi_input_dev->id.bustype = BUS_HOST;
> > >>>> +     priv->input_dev->name = "Dell WMI hotkeys";
> > >>>> +     priv->input_dev->id.bustype = BUS_HOST;
> > >>>
> > >>> Is not there BUS_WMI, or something like that? (Just asking)
> > >>>
> > >>
> > >>Jiri and/or Dmitry, what is bustype for, anyway?
> > >
> > > The bus type could be used to help further  identifying device if it used same vendor/product for spi and i2c, for example, but there are not many if them. I'm not sure if anyone actually makes decisions based on it, but it is part of abi now.
> > >
> > >>I suppose we could add BUS_PLATFORM.
> > >
> > > What would be the difference from BUS_HOST?
> > >
> > 
> > If BUS_HOST means that the device is part of the host as opposed to
> > being plugged in, then it seems entirely reasonable.
> 
> Yes, it basically means platform-specific interface.
> 

I'm going to leave this as BUS_HOST then. Thanks everyone.

-- 
Darren Hart
VMware Open Source Technology Center
