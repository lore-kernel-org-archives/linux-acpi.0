From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: ACPI: Always return valid 'status' from
	acpi_battery_get_property()
Date: Thu, 8 Nov 2007 12:42:07 -0200
Message-ID: <20071108144207.GA8814@khazad-dum.debian.net>
References: <87640d1wmi.fsf@shaolin.home.digitalvampire.org> <4732C8D3.605@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50691 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754105AbXKHOmM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Nov 2007 09:42:12 -0500
Content-Disposition: inline
In-Reply-To: <4732C8D3.605@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Roland Dreier <roland@digitalvampire.org>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Thu, 08 Nov 2007, Alexey Starikovskiy wrote:
>> handle explicitly.  There doesn't seem to be any status enum value
>> defined that makes more sense than 'unknown' for a battery at a
>> critical charge level.

Maybe one should be added?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
