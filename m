From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 3/5] thinkpad_acpi: Use
 acpi_video_handles_brightness_key_presses()
Date: Sun, 27 Dec 2015 21:08:12 -0200
Message-ID: <20151227230812.GA8731@khazad-dum.debian.net>
References: <1450807792-4980-1-git-send-email-hdegoede@redhat.com>
 <1450807792-4980-4-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:57353 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754394AbbL0XIS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 27 Dec 2015 18:08:18 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id E74942025E
	for <linux-acpi@vger.kernel.org>; Sun, 27 Dec 2015 18:08:15 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1450807792-4980-4-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Darren Hart <dvhart@infradead.org>, Corentin Chary <corentin.chary@gmail.com>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, ibm-acpi-devel@lists.sourceforge.net

On Tue, 22 Dec 2015, Hans de Goede wrote:
> Use the new acpi_video_handles_brightness_key_presses function to check
> if we should report brightness key-presses.
> 
> This makes the code both easier to read and makes it properly report
> key-presses when acpi-video is not reporting them for reasons other
> then the backlight type being vendor.

If this new function will return false when acpi video is not reporting
keypresses *BUT* still allowing any sort of brightness changes (e.g. through
sysfs), I don't think it is safe in thinkpad-acpi's case.

So, will it return false in any situation whether acpi-video attached to the
backlight class?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
