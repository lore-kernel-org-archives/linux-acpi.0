From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: ACPI: Always return valid 'status' from	acpi_battery_get_property()
Date: Mon, 19 Nov 2007 21:41:08 +0300
Message-ID: <4741D8C4.7020501@suse.de>
References: <87640d1wmi.fsf@shaolin.home.digitalvampire.org> <4732C8D3.605@suse.de> <20071108144207.GA8814@khazad-dum.debian.net> <4741858D.9020802@gmail.com> <20071119183606.GE3580@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:47813 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751011AbXKSSkx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Nov 2007 13:40:53 -0500
In-Reply-To: <20071119183606.GE3580@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, Roland Dreier <roland@digitalvampire.org>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Rolf Eike Beer <eike-kernel@sf-tec.de>

Henrique de Moraes Holschuh wrote:
> On Mon, 19 Nov 2007, Alexey Starikovskiy wrote:
>> Henrique de Moraes Holschuh wrote:
>>> On Thu, 08 Nov 2007, Alexey Starikovskiy wrote:
>>>>> handle explicitly.  There doesn't seem to be any status enum value
>>>>> defined that makes more sense than 'unknown' for a battery at a
>>>>> critical charge level.
>>> Maybe one should be added?
>>>   
>> There is already "Critical" field for capacity.
> 
> Ah, that's ok, then.
> 
>> It seems that the state should be limited to only 3 options:
>>    charging, discharging, and not charging.
> 
> I'd call "not charging", "idle" instead.  After all, discharging IS not
> charging as well...
> 
There is power_supply interface, and authors already declared this "not charging" 
state, also they already failed to invent "idle".
So, you might send them patch, renaming "not charging" to "idle"...

Regards,
Alex.
