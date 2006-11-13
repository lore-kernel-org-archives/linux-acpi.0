From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Patch] Adds backlight sysfs support for acpi video driver.
Date: Mon, 13 Nov 2006 22:19:12 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0611132212230.2366@pentafluge.infradead.org>
References: <200611110240.34715.luming.yu@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:16868 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1755375AbWKMWTZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Nov 2006 17:19:25 -0500
In-Reply-To: <200611110240.34715.luming.yu@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yu Luming <luming.yu@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>, len.brown@intel.com, Matt Domsch <Matt_Domsch@dell.com>, Alessandro Guido <alessandro.guido@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr, Richard Hughes <hughsient@gmail.com>


> Adds backlight sysfs support for acpi video driver.
> 
> signed-off-by: Luming Yu <Luming.yu@intel.com>

Ug. Watch out. Right now the backlight code requires framebuffer to be 
enabled. I seen a patch some time ago by Tony the allowed backlight 
support which I need to integrate. 

P.S
	It would be really nice if the acpi backlight could be exposed to 
the VESA framebuffer or any other driver whos backlight is not 
implemented. 
