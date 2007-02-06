From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [patch 09/13] acpi: add backlight support to the sony_acpi
	driver
Date: Tue, 06 Feb 2007 18:04:29 +0000
Message-ID: <1170785069.5826.91.camel@localhost.localdomain>
References: <200702060010.l160AJMV003745@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tim.rpsys.net ([194.106.48.114]:44671 "EHLO tim.rpsys.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752262AbXBFS3I (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 6 Feb 2007 13:29:08 -0500
In-Reply-To: <200702060010.l160AJMV003745@shell0.pdx.osdl.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, alessandro.guido@gmail.com, stelian@popies.net, akpm@linux-foundation.org

On Mon, 2007-02-05 at 16:09 -0800, akpm@linux-foundation.org wrote:
> From: Alessandro Guido <alessandro.guido@gmail.com>
> 
> Make the sony_acpi use the backlight subsystem to adjust brightness value
> instead of using the /proc/sony/brightness file.  (Other settings will
> still have a /proc/sony/...  entry)
> 
> Signed-off-by: Alessandro Guido <alessandro.guido@gmail.com>
> Cc: Stelian Pop <stelian@popies.net>
> Cc: Richard Purdie <rpurdie@rpsys.net>
Acked-by: Richard Purdie <rpurdie@rpsys.net>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---


