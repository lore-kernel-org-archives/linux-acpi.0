From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: ACPI vs Device Tree - moving forward
Date: Thu, 22 Aug 2013 00:39:42 +0100
Message-ID: <20130821233942.GA21502@srcf.ucam.org>
References: <20130820192650.GA19470@srcf.ucam.org>
 <CACRpkdaVz28gn-keUC4tTX+bdTKEV2ZrdHxshG=K3oM_NhvroA@mail.gmail.com>
 <20130821160903.GA11908@srcf.ucam.org>
 <6438184.2yT2NMB1CE@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:60188 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943Ab3HUXju (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Aug 2013 19:39:50 -0400
Content-Disposition: inline
In-Reply-To: <6438184.2yT2NMB1CE@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Darren Hart <dvhart@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>

On Thu, Aug 22, 2013 at 01:11:14AM +0200, Rafael J. Wysocki wrote:

> Moreover, even if we are able to instruct everyone interested how to create
> the requisite ACPI tables, there is the little problem of shipping them
> somehow so that they actually can be used by the kernel that needs to be
> addressed too.

I think the expectation in the ACPI ecosystem has to be that devices 
ship their own ACPI tables. I can't see any benefit in using ACPI if the 
aim is to just carry on shipping files with the kernel or install media 
- in that case, just use DT.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
