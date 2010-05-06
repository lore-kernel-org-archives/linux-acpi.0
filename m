From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: linux-next: Tree for May 6 (acpi: PM=n)
Date: Thu, 6 May 2010 08:05:38 -0700
Message-ID: <20100506080538.b566f50e.randy.dunlap@oracle.com>
References: <20100506151502.f97afe54.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:62982 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676Ab0EFPHT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 May 2010 11:07:19 -0400
In-Reply-To: <20100506151502.f97afe54.sfr@canb.auug.org.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, linux-pm@lists.linux-foundation.org
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Thu, 6 May 2010 15:15:02 +1000 Stephen Rothwell wrote:

> Hi all,
> 
> Changes since 20100505:


When CONFIG_PM is not set:

drivers/built-in.o: In function `acpi_init':
bus.c:(.init.text+0x2d84): undefined reference to `pm_flags'
bus.c:(.init.text+0x2d91): undefined reference to `pm_flags'

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
