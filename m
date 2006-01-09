From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [gpm] Untangling the sleep hotkey mess
Date: Mon, 9 Jan 2006 21:40:50 +0000
Message-ID: <20060109214050.GA19974__22151.6800382689$1138782876$gmane$org@srcf.ucam.org>
References: <3ACA40606221794F80A5670F0AF15F840AA37137@pdsmsx403> <20060109014350.GA672@srcf.ucam.org> <200601091019.01083.luming.yu@intel.com> <20060109023037.GA1316@srcf.ucam.org> <1136801040.19776.34.camel@localhost> <d120d5000601091314g7cef73fk445976b14c549a04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:12421 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1750734AbWAIVlF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 9 Jan 2006 16:41:05 -0500
Content-Disposition: inline
In-Reply-To: <d120d5000601091314g7cef73fk445976b14c549a04@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dtor_core@ameritech.net
Cc: Richard Hughes <hughsient@gmail.com>, Yu Luming <luming.yu@intel.com>, linux-acpi@vger.kernel.org, gnome-power-manager-list@gnome.org, desktop_portables@lists.osdl.org

On Mon, Jan 09, 2006 at 04:14:40PM -0500, Dmitry Torokhov wrote:
> And what do you do if:
> 
> 1. You don't have ACPI available (other platforms)
> 2. APM works better for some reason
> 3. The hotkey (sleep, power, etc) does not come from ACPI?

With most APM machines, pressing the hotkey causes the BIOS to send a 
system suspend event. There's no real way for the OS to tell what's 
caused this (it could be low battery, a closed lid or a sleep key press) 
and so the correct thing to do is to tell userspace that a suspend is 
about to happen and then do it.

But yes, PMU sleep requests are (last time I checked) generally managed 
by keycode 142 being generated and userspace dealing with it. There's no 
equivalent to /proc/acpi/events. This is why I think standardising on 
the input layer is a more sensible approach than trying to turn input 
events into acpi ones.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
