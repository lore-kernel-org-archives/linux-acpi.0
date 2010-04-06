From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Make current GPE changes to be consistent with ACPICA code base
Date: Tue, 6 Apr 2010 23:54:33 +0200
Message-ID: <201004062354.33838.rjw@sisk.pl>
References: <1270537259.3384.50.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:33652 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756135Ab0DFVve (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 6 Apr 2010 17:51:34 -0400
In-Reply-To: <1270537259.3384.50.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Tuesday 06 April 2010, Lin Ming wrote:
> Hi, Rafael
> 
> Bob has ported the major GPE changes into ACPICA code base.
> http://git.moblin.org/cgit.cgi/acpica/commit/?id=45f0b38a921f3b2af7574d553a6c2e557d0567ed
> 
> But Bob's port and your original patch have some differences, so I made
> below patch to make linux acpica code consistent with ACPICA code base.
> 
> I have build and tested it, would you please help to review?
> If everything is OK, I'll include it in the next linux acpica update and
> send it to Len.

While I'm generally fine with the code, it looks like the $subject patch includes
the patches I sent earlier (slightly reworked):
https://patchwork.kernel.org/patch/90471/
https://patchwork.kernel.org/patch/86237/

I'll appreciate it if there's a notice in the changelog that the patch is based
on them.

Also, please add my sign-off to the final submission to indicate that some
changes in the patch are in fact from me.

Thanks,
Rafael
