From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [2.6.30] Kernel bug with dock driver
Date: Thu, 18 Jun 2009 19:12:13 -0300
Message-ID: <20090618221213.GB2979@khazad-dum.debian.net>
References: <200906142100.48621.jplatte@naasa.net> <1245222796.9076.93.camel@rzhang-dt> <200906182326.57887.jplatte@naasa.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54305 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753240AbZFRWMO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 18 Jun 2009 18:12:14 -0400
Content-Disposition: inline
In-Reply-To: <200906182326.57887.jplatte@naasa.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Joerg Platte <jplatte@naasa.net>

On Thu, 18 Jun 2009, Joerg Platte wrote:
> Am Wednesday, 17. June 2009 schrieb Zhang Rui:
> 
> > jplatte,
> > it would be great if you can verify if this is a regression or not.

Something is causing ACPI devices to have NULL for dev_name().  This
broke thinkpad-acpi.  Any ideas?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
