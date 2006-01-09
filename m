From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [gpm] Untangling the sleep hotkey mess
Date: Mon, 9 Jan 2006 16:52:11 -0500
Message-ID: <d120d5000601091352m19ba5eb0n80c462cba49bd2a6__33878.6203683869$1138784376$gmane$org@mail.gmail.com>
References: <3ACA40606221794F80A5670F0AF15F840AA37137@pdsmsx403>
	 <20060109014350.GA672@srcf.ucam.org>
	 <200601091019.01083.luming.yu@intel.com>
	 <20060109023037.GA1316@srcf.ucam.org>
	 <1136801040.19776.34.camel@localhost>
	 <d120d5000601091314g7cef73fk445976b14c549a04@mail.gmail.com>
	 <20060109214050.GA19974@srcf.ucam.org>
Reply-To: dtor_core@ameritech.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.203]:39656 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750783AbWAIVwM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 9 Jan 2006 16:52:12 -0500
Received: by wproxy.gmail.com with SMTP id i24so2684563wra
        for <linux-acpi@vger.kernel.org>; Mon, 09 Jan 2006 13:52:12 -0800 (PST)
In-Reply-To: <20060109214050.GA19974@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Richard Hughes <hughsient@gmail.com>, Yu Luming <luming.yu@intel.com>, linux-acpi@vger.kernel.org, gnome-power-manager-list@gnome.org, desktop_portables@lists.osdl.org

On 1/9/06, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Mon, Jan 09, 2006 at 04:14:40PM -0500, Dmitry Torokhov wrote:
> > And what do you do if:
> >
> > 1. You don't have ACPI available (other platforms)
> > 2. APM works better for some reason
> > 3. The hotkey (sleep, power, etc) does not come from ACPI?
>
> With most APM machines, pressing the hotkey causes the BIOS to send a
> system suspend event. There's no real way for the OS to tell what's
> caused this (it could be low battery, a closed lid or a sleep key press)
> and so the correct thing to do is to tell userspace that a suspend is
> about to happen and then do it.
>
> But yes, PMU sleep requests are (last time I checked) generally managed
> by keycode 142 being generated and userspace dealing with it. There's no
> equivalent to /proc/acpi/events. This is why I think standardising on
> the input layer is a more sensible approach than trying to turn input
> events into acpi ones.
>

I probably was not clear in my original message. The new input handler
for ACPI would be only used for compatibility with cirrent
installations relying on ACPID. This will allow gradual conversion of
ACPI drivers to use input layer instead of sending events dircetly to
/proc/acpi/events.

OTOH there should probably be anotehr generic power interface
filtering out power-related input events from the stream of all input
events in the system and making them available to userspace without
requiring applications (be it individual applications or HAL) to open
zillion of raw /dev/input/evenX devices.

--
Dmitry
