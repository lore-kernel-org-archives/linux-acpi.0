From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [2.6.31-rc1] oops in acpi_get_pci_dev
Date: Wed, 24 Jun 2009 17:02:17 +0200
Message-ID: <20090624150217.GD1512@ucw.cz>
References: <5a4c581d0906250325q1dd9ca67na9a8c7ecbffe4897@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41947 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbZF0L0l (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 27 Jun 2009 07:26:41 -0400
Content-Disposition: inline
In-Reply-To: <5a4c581d0906250325q1dd9ca67na9a8c7ecbffe4897@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: linux-kernel@vger.kernel.org, ACPI mailing list <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>

Hi!

I had similar oops here, too, on thinkpad x60. It is interesting: most
breakage seems to happen just before -rc1...

Will configuring out acpi_video help?

									Pavel

> kernel: [<ffffffff8121ef98>] find_video+0x62/0xa2
> kernel: [<ffffffff81233240>] acpi_ns_walk_namespace+0xc4/0x14d
> kernel: [<ffffffff8121ef36>] ? find_video+0x0/0xa2
> kernel: [<ffffffff8121ef36>] ? find_video+0x0/0xa2
> kernel: [<ffffffff81230b0a>] acpi_walk_namespace+0x82/0xd0
> kernel: [<ffffffff8121ecdd>] acpi_video_get_capabilities+0x61/0xe2
> kernel: [<ffffffffa000a060>] ? dell_send_request+0x60/0x82 [dell_laptop]
> kernel: [<ffffffff8121ede9>] acpi_video_backlight_support+0x27/0x64

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
