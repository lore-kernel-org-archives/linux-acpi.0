From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] gpu/stub: fix acpi_video build error, fix stub kconfig
 dependencies
Date: Wed, 2 Feb 2011 02:35:05 +0100
Message-ID: <20110202013505.GD30557@elte.hu>
References: <20101220200013.df8fbc88.sfr@canb.auug.org.au>
 <20101220085340.7ba098b9.randy.dunlap@oracle.com>
 <20110126114203.GA16754@elte.hu>
 <20110201120323.GA6714@elte.hu>
 <20110201111728.cb786487.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:57359 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751585Ab1BBBfd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Feb 2011 20:35:33 -0500
Content-Disposition: inline
In-Reply-To: <20110201111728.cb786487.randy.dunlap@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Len Brown <lenb@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Luming Yu <luming.yu@intel.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>


* Randy Dunlap <randy.dunlap@oracle.com> wrote:

> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> The comments under "config STUB_POULSBO" are close to correct,
> but they are not being followed.  This patch updates them to reflect
> the requirements for THERMAL.
> 
> This build error is caused by STUB_POULSBO selecting ACPI_VIDEO
> when ACPI_VIDEO's config requirements are not met.
> 
> ERROR: "thermal_cooling_device_register" [drivers/acpi/video.ko] undefined!
> ERROR: "thermal_cooling_device_unregister" [drivers/acpi/video.ko] undefined!
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>

Works fine here - thanks Randy!

Tested-by: Ingo Molnar <mingo@elte.hu>

	Ingo
