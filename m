From: "Mattia Dongili" <malattia@linux.it>
Subject: Re: [PATCH] sony-laptop: allow complex per-value input/output  
     validation
Date: Tue, 13 Feb 2007 10:29:08 +0100 (CET)
Message-ID: <50157.85.47.20.193.1171358948.squirrel@picard.linux.it>
References: <20070212210107.GA5577@inferi.kami.home>
    <200702122355.56336.lenb@kernel.org>
    <49660.85.47.20.193.1171356477.squirrel@picard.linux.it>
    <1171357148.6028.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from picard.linux.it ([213.254.12.146]:51230 "EHLO picard.linux.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751231AbXBMJ3K (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 Feb 2007 04:29:10 -0500
In-Reply-To: <1171357148.6028.5.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Tue, February 13, 2007 9:59 am, Richard Purdie said:
> On Tue, 2007-02-13 at 09:47 +0100, Mattia Dongili wrote:
>> On Tue, February 13, 2007 5:55 am, Len Brown said:
>> > On Monday 12 February 2007 16:01, Mattia Dongili wrote:
>> >> allows consistency between the sony-laptop
>> >> specific 'brightness_default' and the backlight subsystem 0-based
>> >> 'brightness'.
>> >
>> > Why do we need to have "sony-laptop specific 'brightness_default'" --
>> > is that a shortcoming of the backlight subsystem?
>>
>> It depends on how do you see it :)
>> brightness_default is the value that brightness will have at the next
>> (and
>> later) reboot and it's currently handled as a platform_device attribute.
>> It would be nice anyway if one such attribute could be added to the
>> backlight subsystem (I'll provide patches - added rpurdie to the Cc
>> list)
>> in order to standardize its behavior/interface.
>
> The backlight class doesn't really have any reason to know anything
> about defaults. The current behaviour is that if you want it at a
> certain 'default' brightness, you set it to this after you register the
> device. Some devices don't want the brightness changed and want to use
> whatever it was set to originally. In the case of some other drivers,
> you can't read the brightness value.

well this is actually hardware driven, the brightness_default in
sony-laptop only exposes a DSDT method to set this value.
So it's actually one more feature, not a software trick :)
I admit the attribute could be better named 'poweron_brightness'.

> With any patches, please keep in mind the changes in
> http://git.o-hand.com/?p=linux-rpurdie-backlight;a=shortlog;h=for-mm as
> I've separated out the ops functions from the actual device specific
> data.

Yep, thanks.
-- 
mattia
:wq!


