From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 0/8] device async action mechanism
Date: Thu, 16 Jul 2009 08:40:20 -0300
Message-ID: <20090716114020.GA11928@khazad-dum.debian.net>
References: <1247643512.26272.74.camel@rzhang-dt>
 <87ocrm6xeq.fsf@basil.nowhere.org>
 <1247710483.26272.170.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:38593 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755286AbZGPLkX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Jul 2009 07:40:23 -0400
Content-Disposition: inline
In-Reply-To: <1247710483.26272.170.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Andi Kleen <andi@firstfloor.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, arjan@linux.intel.com, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>

On Thu, 16 Jul 2009, Zhang Rui wrote:
> the kernel device suspend time is reduced from 3.2s to 2.8s after
> applying this patch set in my test box.

It will give even a bigger boot time saving on ThinkPads, where there is a
Synaptics (or ALPS if you are unlucky) touchpad with the trackpoint behind
it... it takes about 2s to init both devices here.  That's two seconds of
boot time you can shove off if it is being initialized assyncronously :-)

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
