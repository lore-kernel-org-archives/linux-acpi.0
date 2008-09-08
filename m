From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Problem with ACPI video
Date: Mon, 8 Sep 2008 00:33:27 -0300
Message-ID: <20080908033327.GB26459@khazad-dum.debian.net>
References: <g9n0h0$ru8$1@ger.gmane.org> <48C03A87.5050109@sapo.pt> <1220576561.24775.266.camel@rzhang-dt> <200809080220.10657.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:56316 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752801AbYIHDdc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Sep 2008 23:33:32 -0400
Content-Disposition: inline
In-Reply-To: <200809080220.10657.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Zhang Rui <rui.zhang@intel.com>, Luis Henriques <henrix@sapo.pt>, linux-acpi@vger.kernel.org

On Mon, 08 Sep 2008, Thomas Renninger wrote:
> which is shown by above graphics cards problem and this shows that the ACPI
> proc implementation is broken by design in this respect. Anyway we always came 
> away (and still do if not available dummy graphics devices are ignored, this 
> is what the new patch does) with it. And sysfs will do better anyway.

Not anymore.  Dual GPU laptops are being sold already.  Time to fix that
hideous design bug properly, or just remove that part of the /proc interface
outright.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
