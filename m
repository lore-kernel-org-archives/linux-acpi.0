From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: Docking support?
Date: Fri, 8 Jun 2007 09:07:33 -0700
Message-ID: <20070608090733.b737c1a1.kristen.c.accardi@intel.com>
References: <20070608104706.GA10553@implementation>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:37233 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965798AbXFHQLE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Jun 2007 12:11:04 -0400
In-Reply-To: <20070608104706.GA10553@implementation>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: linux-acpi@vger.kernel.org

On Fri, 8 Jun 2007 18:47:06 +0800
Samuel Thibault <samuel.thibault@ens-lyon.org> wrote:

> Hi,
> 
> The dock driver seems to work for me for undocking: when I press the
> button on my docking station, kernel prints a message and the button
> turns blank, telling me that I can get my laptop out.
> 
> However, when I put my laptop back on the docking station, nothing seems
> to happen.  Do I need to echo something on /proc or something else?
> Also, I'd really like to receive ACPI docking events in userland for
> triggering video devices configuration for instance.
> 
> Samuel
> 

This should just work without you needing to echo anything.  We also do
send uevents when you dock, so should be able to use this perfectly fine.
Can you give it a try with -mm kernel (to make sure you have all the latest
acpi patches) and send in your dmesg output for docking and undocking? Also,
what kind of laptop are you using - some of them have issues with repeated
docking and undocking. 

Thanks,
Kristen
