From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: a question about lid input device
Date: Sun, 4 Jul 2010 18:28:20 -0700
Message-ID: <C5204E20-E9CE-40D7-9398-A32D6E993EE0@gmail.com>
References: <1276412011.19052.19294.camel@rzhang1-desktop> <20100614020127.GA30773@khazad-dum.debian.net> <alpine.LFD.2.00.1006212156140.26824@localhost.localdomain> <20100704083553.GE32427@core.coreip.homeip.net> <1278292140.4537.6088.camel@rzhang1-desktop>
Mime-Version: 1.0 (iPhone Mail 7E18)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42162 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754393Ab0GEB2d (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Jul 2010 21:28:33 -0400
Received: by pwi5 with SMTP id 5so1282573pwi.19
        for <linux-acpi@vger.kernel.org>; Sun, 04 Jul 2010 18:28:33 -0700 (PDT)
In-Reply-To: <1278292140.4537.6088.camel@rzhang1-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Jul 4, 2010, at 6:09 PM, Zhang Rui <rui.zhang@intel.com> wrote:

> On Sun, 2010-07-04 at 16:35 +0800, Dmitry Torokhov wrote:
>> On Mon, Jun 21, 2010 at 09:56:37PM -0400, Len Brown wrote:
>>> Dmitry,
>>> Is there a reason not to simply add a "state" attribute
>>> to a LID input device?
>>>
>>
>> Len,
>>
>> There is no LED input device, there is an input device that happens  
>> to
>> report EV_SW/SW_LID state. If we did that we'd need to add attributes
>> for all types of switches, keys, current values of REL and ABS axis,
>> min/max/fuzz/flat settings of ABS axis and so forth that input device
>> might report. I do not think it is a good idea.
>>
> I agree.
> How about adding a field in uevent file that reports the switch  
> status?
>


I think if you can listen to uevents you can just as easily open /dev/ 
input/eventX and listen to proper input events.

Thanks.

-- 
Dmitry

