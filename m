From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [patch 1/2] acpi: Remove procfs from bay
Date: Fri, 22 Dec 2006 10:03:50 -0800
Message-ID: <20061222100350.09c3299b.kristen.c.accardi@intel.com>
References: <20061216223309.365745735@localhost.localdomain>
	<20061216144027.9765bdd1.kristen.c.accardi@intel.com>
	<20061222114355.GB4268@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:1573 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752578AbWLVSEg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Dec 2006 13:04:36 -0500
In-Reply-To: <20061222114355.GB4268@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 22 Dec 2006 11:43:55 +0000
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> > Remove the procfs related code from the bay driver.
> > 
> > Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
> 
> This changes userland interface... how many apps will it break?
> 
> 							Pavel
> 
> -- 
> Thanks for all the (sleeping) penguins.
> 

None - this code was never upstream - always just in -mm.

Kristen
