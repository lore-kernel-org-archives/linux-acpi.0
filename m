From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] thinkpad acpi module_exit fix
Date: Wed, 8 Aug 2007 09:16:03 -0300
Message-ID: <20070808121603.GC554@khazad-dum.debian.net>
References: <20070808164334.GA2732@darkstar.te-china.tietoenator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:33078 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753062AbXHHMQH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Aug 2007 08:16:07 -0400
Content-Disposition: inline
In-Reply-To: <20070808164334.GA2732@darkstar.te-china.tietoenator.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Young <hidave.darkstar@gmail.com>
Cc: linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, 08 Aug 2007, Dave Young wrote:
> [This fix is not very good for the global variable, any comments are
> welcome.]
> 
> The thinkpad_acpi module_init fail out entrace is not very properly. if
> failing before register driver or before create sysfs file, the
> module_exit will try to remove nonexist sysfs files, the kernel will
> oops.
> 
> Signed-off-by: Dave Young <hidave.darkstar@gmail.com>

NAK, this is already fixed in Len's tree.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
