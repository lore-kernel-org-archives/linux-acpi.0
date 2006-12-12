From: Peter Clifton <pcjc2@cam.ac.uk>
Subject: Re: HP nc6400 v.03 or v.05 laptop ACPI fails after reboot, works
	again after booting windows
Date: Tue, 12 Dec 2006 23:42:16 +0000
Message-ID: <1165966936.29844.37.camel@pcjc2lap>
References: <457F37C0.3090003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ppsw-4.csi.cam.ac.uk ([131.111.8.134]:59119 "EHLO
	ppsw-4.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932568AbWLMAIL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Dec 2006 19:08:11 -0500
In-Reply-To: <457F37C0.3090003@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Lincoln Baxter, III" <lincolnbaxter@gmail.com>

On Tue, 2006-12-12 at 18:14 -0500, Lincoln Baxter, III wrote:
> Hi everyone, I recently tried to install gentoo linux on my HP nc6400 
> laptop, and everything works fine except for the following issues.
> 
>    This may be related to:
>    http://marc.theaimsgroup.com/?l=linux-acpi&m=115583434909936&w=2
> 
> Here are the problems:
>   1. After booting gentoo, when I reboot, I can no longer enter the BIOS 
> setup screen by pressing F10.
>   2. After booting gentoo, when I reboot, the ACPI battery file does not 
> update the power status / events.
> 
> Here's how they happen:
>   1. Boot windows: everything works fine.
>   2. Reboot from windows: I can get into setup by pressing F10.
>   3. Boot Gentoo after having booted windows first: power status meter 
> works, files are updated, etc.
>   4. Reboot into Gentoo: I can no longer enter setup via F10.
>   5. Reboot into windows: Everything works again. On next bootup, F10 
> works fine.

Crazy as it seems, add an init script to rmmod psmouse before you
shutdown or reboot linux. Somehow having it loaded when the machine
shuts down causes the BIOS to get upset.

Works on my nc6320 as a workaround, although I've got a few odd issues
still:

Critically, when the lid-switch is pressed, the backlight extinguishes,
but if the touchpad senses any movement, a key is pressed, or for some
random reason, the backlight fires back up again, then doesn't switch
off.

This leaves the laptop very toasty if you shut the lid and it does this.

Does yours do this?


Suspend doesn't work out of box, I've not really tried to diagnose.

Regards,

Peter Clifton


