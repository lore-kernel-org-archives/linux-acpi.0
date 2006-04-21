From: Martin Mares <mj@ucw.cz>
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Date: Fri, 21 Apr 2006 13:37:07 +0200
Message-ID: <mj+md-20060421.113628.7147.albireo@ucw.cz>
References: <554C5F4C5BA7384EB2B412FD46A3BAD13787F2@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from albireo.ucw.cz ([84.242.87.5]:21378 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S1751202AbWDULhI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Apr 2006 07:37:08 -0400
Content-Disposition: inline
In-Reply-To: <554C5F4C5BA7384EB2B412FD46A3BAD13787F2@pdsmsx411.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Luming" <luming.yu@intel.com>
Cc: dtor_core@ameritech.net, Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>, Xavier Bestel <xavier.bestel@free.fr>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hello!

> If you define input layer as a universe place to all manual input 
> activity, then I agree to port some type of ACPI event into
> input layer.  But it shouldn't be a fake keyboard scancode,
> My suggestion is to have a separate input event type,e.g. EV_ACPI
> for acpi event layer.

But why should be a ACPI suspend button treated so differently
from a button with the same label on a normal keyboard?

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Linux vs. Windows is a no-WIN situation.
