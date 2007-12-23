From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: brightness control on thinkpad t61p
Date: Sun, 23 Dec 2007 13:16:43 +0100
Message-ID: <200712231316.43514.rjw@sisk.pl>
References: <20071223000057.739d5891.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:55065 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751052AbXLWL5W (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 23 Dec 2007 06:57:22 -0500
In-Reply-To: <20071223000057.739d5891.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

On Sunday, 23 of December 2007, Andrew Morton wrote:
> 
> When I fire up the latest Linus tree on my thinkpad t61p I get:
> 
> thinkpad_acpi: ThinkPad ACPI Extras v0.17
> thinkpad_acpi: http://ibm-acpi.sf.net/
> thinkpad_acpi: ThinkPad BIOS 7LET44WW (1.14 ), EC 7KHT22WW-1.06
> thinkpad_acpi: Lenovo ThinkPad T61p
> thinkpad_acpi: radio switch found; radios are enabled
> ACPI: Lid Switch [LID]
> input: Sleep Button (CM) as /class/input/input6
> ACPI: Sleep Button (CM) [SLPB]
> thinkpad_acpi: standard ACPI backlight interface available, not loading native one...
> 
> 
> 
> and /sys/class/backlight/thinkpad_screen/brightness is no longer present, so
> my `brightness' script no longer works.  That, my friends, is a regression.
> 
> Here's my script:
> 
> (
> 0 sh -c "echo $1 > /proc/acpi/sony/brightness"
> 0 sh -c "echo $1 > /proc/acpi/sony/brightness_default"
> 0 sh -c "echo $1 > /sys/class/backlight/sony/brightness"
> 0 sh -c "echo $1 > /sys/class/backlight/thinkpad_screen/brightness"
> ) 2>/dev/null
> 
> which rather shows how pathetic we are in this area.  Ho hum.
> 
> 
> So I go hunting around and find
> 
> 	/sys/class/backlight/acpi_video0/
> and
> 	/sys/class/backlight/acpi_video1/
> 
> Why are there two of them?
> 
> 
> Both of these have a `brightness' entry which has contents of 100.  When I set
> that to 10, the screen's brightness is not reduced.
> 
> So as far as I can tell, we have lost the ability to alter the brightness of
> the screen on this machine.

FYI, I have created a bugzilla entry for this issue at:
http://bugzilla.kernel.org/show_bug.cgi?id=9625
and added it to the list of known recent regressions.

Thanks,
Rafael
