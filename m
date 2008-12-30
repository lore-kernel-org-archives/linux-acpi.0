From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: backlight regression on ASUS F6S: inverted brightness control
Date: Tue, 30 Dec 2008 09:37:47 +0800
Message-ID: <1230601067.562.235.camel@rzhang-dt>
References: <200812280611.18320.kel@otaku42.de>
	 <1230512852.562.228.camel@rzhang-dt>  <200812291839.47270.kel@otaku42.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:44751 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751495AbYL3BkO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 29 Dec 2008 20:40:14 -0500
In-Reply-To: <200812291839.47270.kel@otaku42.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kel Modderman <kel@otaku42.de>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, 2008-12-29 at 16:39 +0800, Kel Modderman wrote:
> On Monday 29 December 2008 11:07:32 Zhang Rui wrote:
> > hi,
> > 
> > This is a duplicate of bug
> > http://bugzilla.kernel.org/show_bug.cgi?id=12302
> > please try the patch at
> > http://bugzilla.kernel.org/show_bug.cgi?id=12037#c5
> 
> When patch is applied backlight control returned to normality.
> 
please attach the output of "grep . /proc/acpi/video/*/*/*" both before
and after applying this patch.

thanks,
rui

