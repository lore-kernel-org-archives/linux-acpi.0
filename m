From: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 1/6] video sysfs support: Add dev argument for
 backlight_device_register.
Date: Thu, 2 Nov 2006 13:29:05 -0800
Message-ID: <20061102132905.79a19a51.akpm@osdl.org>
References: <200611042107.53145.luming.yu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:50868 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752648AbWKBV3X (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Nov 2006 16:29:23 -0500
In-Reply-To: <200611042107.53145.luming.yu@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yu Luming <luming.yu@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, len.brown@intel.com, Matt Domsch <Matt_Domsch@dell.com>, Alessandro Guido <alessandro.guido@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr, Richard Hughes <hughsient@gmail.com>


The second patch throws a decent-sized reject against Len's current tree. 
I was going to fix that but I note that the patches have serious whitespace
issues: multiple-spaces are used in many places where hard tabs should be
used.  Please fix all of that up.

Also, there's no overall description of what these patches *do*.  Just a
bunch of one-liners.  But what is the overall end-result?

