From: Peter Clifton <pcjc2@cam.ac.uk>
Subject: Re: BIOS update breaks HP2125nr backlight keys
Date: Fri, 17 Aug 2007 12:44:44 +0100
Message-ID: <1187351084.22480.4.camel@localhost>
References: <46C4DF04.6020306@ou.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:54752 "EHLO
	ppsw-8.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbXHQMNv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Aug 2007 08:13:51 -0400
Received: from dsl-217-155-45-158.zen.co.uk ([217.155.45.158]:49590 helo=[192.168.2.8])
	by ppsw-8.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.158]:465)
	with esmtpsa (LOGIN:pcjc2) (SSLv3:DHE-RSA-AES256-SHA:256)
	id 1IM0Fo-00087i-Rf (Exim 4.67) for linux-acpi@vger.kernel.org
	(return-path <pcjc2@cam.ac.uk>); Fri, 17 Aug 2007 12:44:36 +0100
In-Reply-To: <46C4DF04.6020306@ou.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Thu, 2007-08-16 at 18:34 -0500, Ryan May wrote:
> Hi,
> 
> I recently updated the BIOS on my HP Pavilion dv2125nr laptop to F.34
> (to enable the virtualization instructions).  Since I did this, the Fn
> keys to control brightness have failed to work properly under Linux,
> though they work fine before booting (ie. at Grub).  Hitting the Fn keys
> caused the brightness to change to the minimum possible.  In fact,
> /proc/acpi/video/VGA/LCD/brightness would show that the level was set to
> 0 (though 20 was the lowest available).  I was still able to control the
> brightness manually via /proc interface however.
> 
> My investigations seem to indicate that HP, in their wisdom, seem to
> have removed the _BQC method from their BIOS code.  It seems that the
> ACPI code in Linux that handles the key events to change the brightness
> use the _BQC method without checking for success, which explains why the
> level being set was garbage.  However, the /proc interface for
> brightness seems to only use device->brightness->curr to get the current
> level.

Do you happen to see a _BCQ method in the DSDT instead? My HP nc6320 has
that, and last time I looked, it seemed like it could plausibly be a
Microsoft induced rename / typo, as this method is mentioned for getting
brightness on a Windows Vista compatible box.

Did the bios update also mention any fixes for Vista compatibility?

-- 
Peter Clifton

Electrical Engineering Division,
Engineering Department,
University of Cambridge,
9, JJ Thomson Avenue,
Cambridge
CB3 0FA

Tel: +44 (0)7729 980173 - (No signal in the lab!)

