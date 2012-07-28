From: Pali =?utf-8?b?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] drm/radeon: add new AMD ACPI header and update relevant code
Date: Sat, 28 Jul 2012 14:39:57 +0000 (UTC)
Message-ID: <loom.20120728T162615-355@post.gmane.org>
References: <1343237889-5220-1-git-send-email-alexdeucher@gmail.com> <20120726125838.GA28853@growl> <CADnq5_Nr8S+kzdKVq9=VL9BVK+4eFeX0egs-rkiv882MAm3bow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:41401 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752401Ab2G1OpG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 28 Jul 2012 10:45:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glad-acpi-devel@m.gmane.org>)
	id 1Sv8GP-0005U5-1J
	for linux-acpi@vger.kernel.org; Sat, 28 Jul 2012 16:45:05 +0200
Received: from ip-88-212-34-237.antik.sk ([88.212.34.237])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sat, 28 Jul 2012 16:45:05 +0200
Received: from pali.rohar by ip-88-212-34-237.antik.sk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sat, 28 Jul 2012 16:45:05 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Alex Deucher <alexdeucher <at> gmail.com> writes:
> 
> On Thu, Jul 26, 2012 at 8:58 AM, Luca Tettamanti wrote:
> > The other missing bit is how to actually change the brightness... Alex,
> > do you know what registers to poke?
> 
> You need to check if the GPU controls the backlight or the system
> does.  I think the attached patches should point you in the right
> direction.
> 
> Alex
> 

Hi, thank you very much for patches. With these patches now I'm able to adjust
brightness on my notebook HP EliteBook 8460p with Radeon 6470M card via file
/sys/class/backlight/radeon_bl/brightness

It has only one problem: When I enable Ambient Ligth Sensor via hp-wmi.ko
driver (echo 1 > /sys/devices/platform/hp-wmi/als which auto adjust some
brightness level based on sensor data on HW level) and I set radeon brightness
to 0 or 255 (min or max value) screen is turned off. Values 1..254 are OK.

What about to disable values 0 and 255 in radeon brightness driver?

