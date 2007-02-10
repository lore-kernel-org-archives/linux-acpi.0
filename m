From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.21
Date: Sat, 10 Feb 2007 03:34:24 +0000
Message-ID: <20070210033424.GA16490@srcf.ucam.org>
References: <200702071418.51058.lenb@kernel.org> <20070209230928.GD3949@ucw.cz> <20070209172410.e2c4566b.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:54380 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958AbXBJDfB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Feb 2007 22:35:01 -0500
Content-Disposition: inline
In-Reply-To: <20070209172410.e2c4566b.kristen.c.accardi@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, tony.luck@intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Fri, Feb 09, 2007 at 05:24:10PM -0800, Kristen Carlson Accardi wrote:

> The user interface for the Bay driver is via sysfs - it is a platform
> driver

Though, ideally, in the long run it'll be tied into the PATA/SATA 
interface that it's associated with. That involves a little more magic, 
though :)

-- 
Matthew Garrett | mjg59@srcf.ucam.org
