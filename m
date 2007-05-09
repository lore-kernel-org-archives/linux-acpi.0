From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Laptop screen doesn't come on when lid is reopened
Date: Wed, 9 May 2007 19:00:07 -0300
Message-ID: <20070509220007.GC9055@khazad-dum.debian.net>
References: <463E37EE.2060008@gentoo.org> <200705091148.21097.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:42072 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754429AbXEIWAM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 May 2007 18:00:12 -0400
Content-Disposition: inline
In-Reply-To: <200705091148.21097.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Daniel Drake <dsd@gentoo.org>, linux-acpi@vger.kernel.org, luming.yu@intel.com

On Wed, 09 May 2007, Len Brown wrote:
> Assuming that it works on the Dells, hopefully more
> than the Dells, and doesn't break any others...
...
> Then the button driver should take the lid event and
> cause the code in the video driver to be invoked.
> I'm not sure what the best method for inter-driver
> event like this, since both of them can be modules.

It will break all laptops which don't do anything special on lid events
other than report it to the OS, so that we can do whatever we want
(typically tell HAL or some script to suspend if the lid is closed).  Like,
say, thinkpads.

> Finally, the video driver should have suspend/resume methods
> that poke _DSS and that should fix the Dell video on S3.

Yes, that seems like a good idea.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
