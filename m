From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: ACPI hotkeys and Panasonic R4
Date: Fri, 7 Apr 2006 10:36:51 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD11906C8@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:18807 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932292AbWDGChB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Apr 2006 22:37:01 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "David J. Wallace" <katana@onetel.com>
Cc: linux-acpi@vger.kernel.org

>On Thursday 06 April 2006 02:16, Yu, Luming wrote:
>> Please try boot option: acpi_generic_hotkey
>> Please don't forget apply patchs mentioned at:
>> http://bugzilla.kernel.org/show_bug.cgi?id=5749#c11
>>
>> For panasonic , the patch just support :
>> echo -n xx > /sys/hotkey/brightness .
>>
>> If you have other question, please feel free to ask.
>>
>> --Luming
>
>Thanks for the info. I didn't realise I needed the patch. I 
>applied the patch 
>and now echo -n xx > /sys/hotkey/brightness allows control of the LCD 
>brightness. Any plans to support any of the other hotkeys?

I need more hands in this area.

>
>Now to define some events in event_config.

It is NOT functional.
If you need real hotkey support, the first thing is
to figure out what kind of event generated upon hitting hotkeys.
