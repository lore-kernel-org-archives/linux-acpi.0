From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 5/5] ACPI: add DMI to enable OSI(Linux) on ThinkPad T61
Date: Thu, 17 Jan 2008 12:46:20 -0200
Message-ID: <20080117144620.GA32346@khazad-dum.debian.net>
References: <a4d865fcfc9913f3d2428bc2b7ab1683227a6096.1200565331.git.len.brown@intel.com> <0bf08de2227cabeb40a6ea72b3fa188a2e325335.1200565331.git.len.brown@intel.com> <20080117122832.GB32133@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:44723 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750847AbYAQOq0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Jan 2008 09:46:26 -0500
Content-Disposition: inline
In-Reply-To: <20080117122832.GB32133@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Thu, 17 Jan 2008, Matthew Garrett wrote:
> On Thu, Jan 17, 2008 at 05:24:50AM -0500, Len Brown wrote:
> 
> > +	{
> > +	.callback = dmi_enable_osi_linux,
> > +	.ident = "Lenovo ThinkPad T61",
> > +	.matches = {
> > +		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> > +		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T61"),
> > +		},
> > +	},
> > +
> 
> If we add it for specific devices, aren't vendors going to assume that 
> future versions of that device will also be able to rely on this 
> behaviour? I'm very reluctant to add whitelisting - I suspect it makes 
> more sense for us to just be compatible with Windows. My experiments 
> with the T61 suggested that it was possible to get everything working 
> without this, but I'll need to go back and check what the behaviour 
> actually was to be sure.

There is interesting data for you about the T61 and X61 in the
linux-thinkpad ML (also available through gmane).

The T61 *latest BIOS* (this can well make a difference):

  without OSI(Linux)
    * Mutes in firmware (but nobody knows HOW or WHAT it mutes)
    * Doesn't propagate the MUTE event through ACPI or Keyboard
    * Mute can be detected throgh NVRAM (probably)
    * Uses Volume UP/DOWN press to unmute in firmware

    * Propagates volume up/down through the keyboard
    * does not change volume up/down in firmware

  with OSI(Linux)
    * Does not mute in firmware
    * Propagates MUTE even through keyboard
    * Propagates volume up/down through the keyboard
    * does not change volume up/down in firmware

And I hear the T61 has some weirdness in the HDA mixer too, but I don't know
what ALSA is doing.  One should also test if the missing ALSA registers are
available with/without OSI(Linux), and do it using a *proper* full alsa
client, like amixer, because the GUI ones can't deal with stuff like two
mute controls in one single channel, etc.  And look at the ALSA code to see
if they are not special-casing the thinkpad in some way that is actually
hurting instead of helping (depending on OSI(Linux) state).

Nobody managed to find how the firmware was muting the sound yet.  Maybe
Lenovo just dumbed down the extra mixer to a mute/unmute thing (it has full
volume control in older thinkpads), instead of just removing it entirely.

The X61 seems to be nearly the same as the T61.

I really, really prefer the old firmware that just *always worked* in the
volume control.  Now Lenovo switched tactics for one reason or another, and
IMHO, the only sane way forward is to try to get to the least surprising
behaviour (which happens to be the one we get with OSI(Linux).

I suggest that any "experiments" be carried out in the open in the
linux-thinkpad mailinglist, requesting input from other people.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
