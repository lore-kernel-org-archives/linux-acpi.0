From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi
 driver
Date: Sat, 30 Sep 2006 19:31:31 +0200 (MEST)
Message-ID: <Pine.LNX.4.61.0609301931160.4615@yvahk01.tjqt.qr>
References: <20060930190810.30b8737f.alessandro.guido@gmail.com>
 <20060930191457.a120ff56.alessandro.guido@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from emailer.gwdg.de ([134.76.10.24]:60620 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751327AbWI3RfW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 30 Sep 2006 13:35:22 -0400
In-Reply-To: <20060930191457.a120ff56.alessandro.guido@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alessandro Guido <alessandro.guido@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com, gelma@gelma.net, ismail@pardus.org.tr


>> Make the sony_acpi use the backlight subsystem to adjust brightness value
>> instead of using the /proc/sony/brightness file.
>> (Other settings will still have a /proc/sony/... entry)
>
>I meant /proc/acpi/sony/brightness and /proc/acpi/sony/...

Hm spicctrl needs to be updated then. (Or maybe not if it does not use 
/proc)


Jan Engelhardt
-- 
