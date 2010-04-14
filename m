From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [Acpi4asus-user] 1005PE's and backlight controls
Date: Wed, 14 Apr 2010 17:40:30 +0100
Message-ID: <20100414164030.GA14758@srcf.ucam.org>
References: <y2g3b2dfeb01004131934x67e23d80vc73dfd6d5af133fa@mail.gmail.com> <t2i9b2b86521004140923x9c1aaa64p867674329ae158af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:56454 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756318Ab0DNQke (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Apr 2010 12:40:34 -0400
Content-Disposition: inline
In-Reply-To: <t2i9b2b86521004140923x9c1aaa64p867674329ae158af@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Cc: Chris Bagwell <chris@cnpbagwell.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org

On Wed, Apr 14, 2010 at 05:23:22PM +0100, Alan Jenkins wrote:

> I suggest you contact the ACPI video maintainer, Zhang Rui
> <rui.zhang@intel.com>, and attach the output of "dmidecode".  The best
> way would probably be to report the problem on bugzilla.kernel.org (on
> the ACPI video driver).
> 
> I think it will indeed be possible to blacklist your machine, because
> someone has already anticipated this problem :-).

dmi blacklisting is almost certainly wrong. It's more likely that 
eeepc-laptop shouldn't be registering a backlight if 
acpi_video_backlight_support() is true, but we'll then want to 
investigate whether we also need to send the keyboard events through.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
