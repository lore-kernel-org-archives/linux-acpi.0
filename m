From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [-mm patch] make drivers/misc/thinkpad_acpi:fan_mutex static
Date: Sun, 29 Apr 2007 01:09:53 -0300
Message-ID: <20070429040953.GA29832@khazad-dum.debian.net>
References: <20070425225716.8e9b28ca.akpm@linux-foundation.org> <20070428191938.GO3468@stusta.de> <20070428195821.GC2392@khazad-dum.debian.net> <20070429025008.GK3468@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:45630 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754552AbXD2EKB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:10:01 -0400
Content-Disposition: inline
In-Reply-To: <20070429025008.GK3468@stusta.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, lenb@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Sun, 29 Apr 2007, Adrian Bunk wrote:
> Forward declarations of static functions (if required) and actual 
> variables (like fan_mutex) belong into the C file, not the header.

Very well.  I will fix the mess for 2.6.23, or, time permitting, 2.6.22.

> > Maybe I should just break the driver into multiple files in a subdirectory?
> > That would certainly make it *much* cleaner...
> 
> But even more in this case, you will not want to have actual variables 
> or prototypes of static functions in the header file.

I would not have to, in that case.  The driver would be much easier to
write, and I will need to break it in two for an alsa module anyway, might
as well break it in one subdriver per file.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
