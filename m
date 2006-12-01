From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] acpi: add backlight support to the sony_acpi driver (v2)
Date: Fri, 1 Dec 2006 13:35:21 +0000
Message-ID: <20061201133520.GC4239@ucw.cz>
References: <20061127174328.30e8856e.alessandro.guido@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48141 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S936464AbWLAQUu
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 1 Dec 2006 11:20:50 -0500
Content-Disposition: inline
In-Reply-To: <20061127174328.30e8856e.alessandro.guido@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alessandro Guido <alessandro.guido@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, linux-acpi@vger.kernel.org, len.brown@intel.com

Hi!

> Enable the sony_acpi driver to use the backlight subsysyem for
> adjusting the monitor brightness. Old way of changing the brightness will be
> still available for compatibility with existing tools.
> 
> Signed-off-by: Alessandro Guido <alessandro.guido@gmail.com>

Looks okay to me. We really want unified interface for backlight.

							Pavel
-- 
Thanks for all the (sleeping) penguins.
