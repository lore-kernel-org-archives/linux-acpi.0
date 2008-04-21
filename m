From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH] ACPI: Support Fujitsu Lifebook S6410 in fujitsu-laptop
Date: Mon, 21 Apr 2008 09:54:53 +0930 (CST)
Message-ID: <200804210024.m3L0OrBA022537@turbo.physics.adelaide.edu.au>
References: <1208366478.9921.13.camel@earth.gruber.myown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:60264 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751399AbYDUAZB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Apr 2008 20:25:01 -0400
In-Reply-To: <1208366478.9921.13.camel@earth.gruber.myown> from "nokos@gmx.net" at Apr 16, 2008 07:21:18 PM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: nokos@gmx.net
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-acpi@vger.kernel.org

Hi Peter

> ok here is a "not run through indent" version which minimizes the
> whitespace changes. Hope this clears up the patch.

Sorry for the delay.  I have now tested your patch with the S7020 laptop and
made the following observations.

 1) The patches to fujitsu-laptop do not appear to have broken software
    control of the brightness on the S7020 - this continued to work as
    expected.

 2) The changes to fujitsu-laptop now mean that the brightness keys on the
    keyboard generate APCI button press events (not that I use them, but
    others might).  Note that on the S7020 the brightness keys function
    independently of the operating system.  The only advantage in seeing the
    keypress events is probably so brightness applets (if running) get to
    know about brightness changes.

 3) I forced the use of the "alternative" brightness interface to see what
    happens on the S7020.  It doesn't work.  Therefore the hooks used by the
    alternative interface definitely don't exist on the S7020 and the two
    methods of brightness control will probably have to stay (since if I
    recall you mentioned the original method didn't work on the S6410).

 4) The S7020 has a series of 5 "custom" buttons labelled 1, 2, 3, 4 and 
    "enter" at the top of the keyboard.  These are, as I understand it, used 
    to input a security code if thus configured.  With
    fujitsu-laptop-hotkeys loaded these keys were observed to generate
    ACPI keypress events which were seen by xev.  However, there seemed to
    be some kind of FIFO in action - if I pressed a key it would only appear
    after 4 other keypresses had been made.  For example:

      Button sequence: 1, 2, 3, 4, 3, 2, ...
      ACPI response: nothing, nothing, nothing, nothing, 1, 2, ...     

    Any thoughts?  Is this just a delay through the Linux ACPI kernel/daemon
    system?  I don't think so because the brightness key notifications come
    through almost instantly.

  5) The loading of the fujitsu-laptop-hotkeys did not appear to cause
     any breakage of other fujitsu-laptop functions.

I'm particularly interested to know whether you have any thoughts regarding
(4) but for me this isn't a deal-breaker since I have no real use for these
buttons.  In a way the fact that fujitsu-laptop-hotkeys doesn't seem to work
reliably on the S7020 is probably an argument for keeping it separate from
fujitsu-laptop.

A few other comments regarding the patch.  If fujitsu-laptop-hotkeys remains
as a standalone module (which is what I'm leaning towards at present) then
for the sake of clarity the namespace in fujitsu-laptop-hotkeys should be
cleaned up so it doesn't clash with that in fujitsu-laptop.  The clash isn't
technically relevant because no exported names are affected, but to prevent
confusion in future I think it would be good to have separate names.  I
suggest something like

  FUJITSU_DRIVER_VERSION -> FUJITSU_HOTKEYS_DRIVER_VERSION
  fujitsu_t -> fujitsu_hotkeys_t
  acpi_fujitsu_*() -> acpi_fujitsu_hotkeys_*()
  
The version number of fujitsu-laptop should be incremented to 0.4 by this
patch.  I also have to work out whether fujitsu-laptop-hotkeys will take its
version number from fujitsu-laptop or maintain its own version number.  I'm
in two minds about this and want to think it over some more.

Regards
  jonathan
