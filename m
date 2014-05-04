From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: RFC: changing acpi-video brightness_switch_enabled default to
 0
Date: Sun, 04 May 2014 10:55:07 +0800
Message-ID: <5365AC0B.4010300@intel.com>
References: <5363661F.1050301@redhat.com> <4392622.hgzIWDcxEe@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:14467 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753512AbaEDCyT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 3 May 2014 22:54:19 -0400
In-Reply-To: <4392622.hgzIWDcxEe@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hans de Goede <hdegoede@redhat.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Josh Boyer <jwboyer@fedoraproject.org>

On 05/02/2014 07:56 PM, Rafael J. Wysocki wrote:
> On Friday, May 02, 2014 11:32:15 AM Hans de Goede wrote:
>> Hi All,
>>
>> I was already considering asking for $subject for a while, but I did not see
>> any bug reports caused by it so I didn't ask. Until today I discovered that
>> I'm not seeing any bugs because Fedora is carrying a kernel patch
>> changing the default.
>>
>> A quick google search for brightness_switch_enabled OTOH reveals that for
>> other distros it is a serious problem, see ie:
>> https://bugs.launchpad.net/gnome-settings-daemon/+bug/527157
>> http://askubuntu.com/questions/173921/why-does-my-thinkpad-brightness-control-skip-steps
>>
>> The problem is that acpi-video is unique in that it not only generates
>> brightness up/down keypresses, but also (sometimes) actively changes the
>> brightness itself.
>>
>> This presents an inconsistent kernel interface to userspace, basically there
>> are 2 different scenarios, depending on the laptop model:
>>
>> 1) On some laptops a brightness up/down keypress means: show a brightness osd
>> with the current brightness, iow it is a brightness has changed notification.
>>
>> 2) Where as on (a lot of) other laptops it means a brightness up/down key was
>> pressed, deal with it.
>>
>> Most of the desktop environments interpret any press as in scenario 2, and
>> change the brightness up / down as a response to the key events, causing it
>> to be changed twice, once by acpi-video and once by the DE.
>>
>> With the new default for video.use_native_backlight we will be moving even
>> more laptops over to behaving as in scenario 2. Making the remaining laptops
>> even more of a weird exception. Also note that it is hard to detect scenario
>> 1 properly in userspace, and AFAIK none of the DE-s deasls with it.
>>
>> Therefor I would like to propose to change the brightness_switch_enabled
>> default to 0.
> 
> Aaron, what do you think about that?

Personally, I like this.

Last time I remembered, people who do not use GUI or use a simple GUI which
does not provide handling of backlight events prefer to having this param
default to 1(and they have a working acpi_video interface of course). But I
suppose most people are using a GUI that handles such events and the in
kernel handling of backlight events is indeed unique for acpi_video and
cause in consistence with other backlight control interfaces, I think it is
a good thing to set brightness_switch_enabled to 0 by default.

Thanks,
Aaron
