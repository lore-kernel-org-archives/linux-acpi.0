From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH] bay: Exit if notify handler cannot be installed
Date: Wed, 07 May 2008 09:04:39 +0800
Message-ID: <1210122279.27316.2.camel@sli10-desk.sh.intel.com>
References: <20080505202508.GA3690@homac> <20080506091522.GA4378@homac>
	 <1210065811.12668.1.camel@sli10-desk.sh.intel.com>
	 <20080506151846.GA22828@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:36813 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757371AbYEGBBF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 6 May 2008 21:01:05 -0400
In-Reply-To: <20080506151846.GA22828@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Holger Macht <hmacht@suse.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Accardi, Kristen C" <kristen.c.accardi@intel.com>

On Tue, 2008-05-06 at 12:18 -0300, Henrique de Moraes Holschuh wrote:
> On Tue, 06 May 2008, Shaohua Li wrote:
> > The bay driver is duplicated with libata, I thought we should delete it.
> > See bug http://bugzilla.kernel.org/show_bug.cgi?id=9526
> 
> The bay driver is currently useless, BUT it should handle a lot of stuff
> libata won't, such as bay batteries, bay floppies, and anything else in
> a bay that is not a hard disk.
> 
> The fact that the driver currently looks only after disks is just a bug.
> It should, in fact, bind to any ejectable device not already handled by
> a different driver.
Isn't this the job of acpi dock driver?

