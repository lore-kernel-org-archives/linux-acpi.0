From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: ACPI: Always return valid 'status' from
	acpi_battery_get_property()
Date: Mon, 19 Nov 2007 16:36:06 -0200
Message-ID: <20071119183606.GE3580@khazad-dum.debian.net>
References: <87640d1wmi.fsf@shaolin.home.digitalvampire.org> <4732C8D3.605@suse.de> <20071108144207.GA8814@khazad-dum.debian.net> <4741858D.9020802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50736 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751210AbXKSSgN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Nov 2007 13:36:13 -0500
Content-Disposition: inline
In-Reply-To: <4741858D.9020802@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Roland Dreier <roland@digitalvampire.org>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Rolf Eike Beer <eike-kernel@sf-tec.de>

On Mon, 19 Nov 2007, Alexey Starikovskiy wrote:
> Henrique de Moraes Holschuh wrote:
>> On Thu, 08 Nov 2007, Alexey Starikovskiy wrote:
>>>> handle explicitly.  There doesn't seem to be any status enum value
>>>> defined that makes more sense than 'unknown' for a battery at a
>>>> critical charge level.
>>
>> Maybe one should be added?
>>   
> There is already "Critical" field for capacity.

Ah, that's ok, then.

> It seems that the state should be limited to only 3 options:
>    charging, discharging, and not charging.

I'd call "not charging", "idle" instead.  After all, discharging IS not
charging as well...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
