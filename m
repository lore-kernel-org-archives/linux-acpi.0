From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi
 driver
Date: Sun, 1 Oct 2006 17:19:12 -0700
Message-ID: <20061001171912.b7aac1d8.akpm@osdl.org>
References: <20060930190810.30b8737f.alessandro.guido@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:47490 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932515AbWJBAT0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 1 Oct 2006 20:19:26 -0400
In-Reply-To: <20060930190810.30b8737f.alessandro.guido@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alessandro Guido <alessandro.guido@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com, jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr

On Sat, 30 Sep 2006 19:08:10 +0200
Alessandro Guido <alessandro.guido@gmail.com> wrote:

> Make the sony_acpi use the backlight subsystem to adjust brightness value
> instead of using the /proc/sony/brightness file.
> (Other settings will still have a /proc/sony/... entry)

umm, OK, but now how do I adjust my screen brightness? ;)

I assume that cute userspace applications for controlling backlight
brightness via the generic backlight driver either exist or are in
progress?  What is the status of that?

Thanks.
