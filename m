From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH net-next] drivers/acpi/acpica/utmisc.c: Use printk
 extension %pV
Date: Mon, 19 Jul 2010 22:21:42 -0700
Message-ID: <1279603302.19374.24.camel@Joe-Laptop.home>
References: <1279602367.19374.20.camel@Joe-Laptop.home>
	 <20100719.221630.146073821.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.perches.com ([173.55.12.10]:1976 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752447Ab0GTFVo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jul 2010 01:21:44 -0400
In-Reply-To: <20100719.221630.146073821.davem@davemloft.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org

On Mon, 2010-07-19 at 22:16 -0700, David Miller wrote:
> Joe, I really can't keep merging stuff like this into the networking
> tree.

Oh no worries David.

The patch is more like a preliminary notification that at
some point after the vsprintf stuff gets merged into Linus'
tree after 2.6.36-rc1 that this change to acpi could be useful.

> But you're going to have to find another way to merge uses outside of
> networking that you want integrated.

Hey, I'm a patient guy, there's no hurry.

cheers, Joe

