From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: ACPI extras for Fujitsu laptops
Date: Tue, 21 Aug 2007 14:39:59 +0930 (CST)
Message-ID: <200708210509.l7L59xkE027360@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:38619 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751061AbXHUF1B (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Aug 2007 01:27:01 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>

Hi guys

I own a Fujitsu S7020 laptop, and I have noted in the past that Linux was
not able to control the LCD brightness via the standard ACPI-video/backlight
system.  Ordinarily this wouldn't matter except that when coming out of
suspend-to-ram the screen lamp doesn't turn on.  One can manually trigger it
using the keyboard keys, but that's a bit clunky.

Just recently I stumbled across a kernel module written several years ago
which allowed software control of (among other things) the LCD brightness on
Fujitsu laptops.  I grabbed a copy from

  http://tilos.csl.mech.ntua.gr/~apoikos/fujitsu-acpi-2.6.tar.bz2

and tested it against 2.6.22.1 and the brightness control worked as
advertised.

A note on

  http://tilos.csl.mech.ntua.gr/~apoikos/s7020.html

says that "This patch never made it to the mainline kernel source" but it's
unclear to me whether it was ever considered.  In any case, beyond the
obvious integration work what would it take to get this module into the acpi
system?  I would certainly be willing to do the legwork if any was
necessary.  We already have toshiba_acpi and ibm_acpi, so it seems to me
that it's quite reasonable to add fujitsu_acpi.  However, if this is truly
unnecessary and there is a way of manipulating this corner of my laptop's
APCI system with a stock kernel I'm all ears.

Regards
  jonathan
