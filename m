From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RFC] EC registers - Adding sysfs interface?
Date: Wed, 28 Nov 2007 21:12:37 -0200
Message-ID: <20071128231237.GC22587@khazad-dum.debian.net>
References: <200711131724.31868.carlos@strangeworlds.co.uk> <200711131849.56964.carlos@strangeworlds.co.uk> <4739F2FB.9080800@suse.de> <200711131903.03018.carlos@strangeworlds.co.uk> <1196267304.23251.165.camel@queen.suse.de> <474DB282.4050003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:46571 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755733AbXK1XMl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Nov 2007 18:12:41 -0500
Content-Disposition: inline
In-Reply-To: <474DB282.4050003@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: trenn@suse.de, Carlos Corbacho <carlos@strangeworlds.co.uk>, Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Wed, 28 Nov 2007, Alexey Starikovskiy wrote:
> Having it as /dev/ec0 should not introduce too many problems...

As long as it is with a debugging intent, and not as a place to plug
"userspace" drivers at.  That would be much too dangerous IMO.

> Also, it has much smaller impact than /dev/mem or /dev/ioport...

IMHO, it is just as dangerous.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
