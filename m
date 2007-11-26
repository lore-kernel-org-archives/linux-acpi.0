From: Zhenyu Wang <zhenyu.z.wang@intel.com>
Subject: Re: No blacklight Re: [patch] remove debug info in acpi video
Date: Mon, 26 Nov 2007 09:20:40 +0800
Message-ID: <20071126012040.GA5493@zhen-devel.sh.intel.com>
References: <20071113005047.GA27837@zhen-devel.sh.intel.com> <1194921410.2969.1.camel@localhost.localdomain> <1195950110.813.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:45114 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758602AbXKZBct (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 25 Nov 2007 20:32:49 -0500
Content-Disposition: inline
In-Reply-To: <1195950110.813.1.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

On 2007.11.25 00:21:50 +0000, Sergio Monteiro Basto wrote:
> Since I begging to see this message on dmesg ,
   
My patch just trys to remove that obvious debug printk, which
keeps showing up on one HP laptop. Someone may rework acpi 
debug level support in acpi video driver.

> when i press lid button , I don't have black light  
> 

No idea how could my simple patch cause your problem...
