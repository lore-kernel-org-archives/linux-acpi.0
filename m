From: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>
Subject: Re: [PATCH 04/84] misc,acpi,backlight: compal Laptop Extras
Date: Mon, 30 Jun 2008 17:19:41 +0200
Message-ID: <20080630171941.270dbd75@debian>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
	<45fea4a84325d5724ffe480ae6f0d1658d520141.1214631213.git.len.brown@intel.com>
	<20080628145631.GA23803@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:49867 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbYF3PTv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Jun 2008 11:19:51 -0400
Received: by fg-out-1718.google.com with SMTP id 19so770534fgg.17
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jun 2008 08:19:47 -0700 (PDT)
In-Reply-To: <20080628145631.GA23803@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: ak@linux.intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Alexey Starikovskiy <aystarik@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

Dnia 2008-06-28, o godz. 15:56:31
Matthew Garrett <mjg59@srcf.ucam.org> napisa=B3(a):

> On Sat, Jun 28, 2008 at 01:43:08AM -0400, Len Brown wrote:
> > This driver exports a few files in /sys/devices/platform/compal-lap=
top/:
> >  lcd_level - screen brightness: contains a single integer in the ra=
nge 0..7 (rw)
> >  wlan - wlan subsystem state: contains 0 or 1 (rw)
> >  bluetooth - bluetooth subsystem state: contains 0 or 1 (rw)
> >  raw - raw value taken from embedded controller register (ro)
>=20
> Can we make sure this is changed to use rfkill before merging?

I changed already driver to use rfkill. I need some time to test=20
and will send the appropriate patch.=20

--=20
 Cezary
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
