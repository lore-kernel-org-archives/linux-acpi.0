From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 2/8] [-mm] ACPI: add ACPI EC sysfs interface
Date: Tue, 20 Mar 2007 12:18:02 -0300
Message-ID: <20070320151802.GC13042@khazad-dum.debian.net>
References: <1174382479.8833.81.camel@localhost.localdomain> <45FFA87A.7040406@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:60306 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933679AbXCTPSH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Mar 2007 11:18:07 -0400
Content-Disposition: inline
In-Reply-To: <45FFA87A.7040406@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, lenb@kernel.org

On Tue, 20 Mar 2007, Alexey Starikovskiy wrote:
> So either make it just a printk (KERN_INFO) at init time or drop it 
> completely.

A printk might be useful for debugging...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
