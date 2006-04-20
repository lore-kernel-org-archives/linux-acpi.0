From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Date: Thu, 20 Apr 2006 21:55:50 +0000
Message-ID: <20060420215549.GA2352@ucw.cz>
References: <554C5F4C5BA7384EB2B412FD46A3BAD13787F2@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:55820 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750980AbWDVTQ1
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 22 Apr 2006 15:16:27 -0400
Content-Disposition: inline
In-Reply-To: <554C5F4C5BA7384EB2B412FD46A3BAD13787F2@pdsmsx411.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Luming" <luming.yu@intel.com>
Cc: dtor_core@ameritech.net, Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>, Xavier Bestel <xavier.bestel@free.fr>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi!

> >> > There are keyboards with power/sleep buttons. It makes 
> >sense they have
> >> > the same behavior than ACPI buttons.
> >> Agree, make them behave like ACPI buttons -- remove them 
> >from input stream, as they do not belong there...
> >
> >What if there is no ACPI? What if I want to remap the button to do
> >something else? Input layer is the proper place for them.
> 
> If you define input layer as a universe place to all manual input 
> activity, then I agree to port some type of ACPI event into
> input layer.  But it shouldn't be a fake keyboard scancode,
> My suggestion is to have a separate input event type,e.g. EV_ACPI
> for acpi event layer.

There's nothing fake about it. Power button is just that - a button.
Having EV_ACPI might make sense for thermal/battery events, but not
for normal keys.

-- 
Thanks, Sharp!
