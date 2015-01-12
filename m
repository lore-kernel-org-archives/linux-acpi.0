From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] acpi-video: Add disable_native_backlight quirk for Dell
 XPS15 L521X
Date: Mon, 12 Jan 2015 10:12:57 +0100
Message-ID: <54B39019.2070501@redhat.com>
References: <1420444624-8313-1-git-send-email-hdegoede@redhat.com> <20150111061602.GA1677@srcf.ucam.org> <54B25280.6010604@redhat.com> <20150112024411.GA6831@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57534 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751859AbbALJNF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Jan 2015 04:13:05 -0500
In-Reply-To: <20150112024411.GA6831@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org

Hi,

On 12-01-15 03:44, Matthew Garrett wrote:
> On Sun, Jan 11, 2015 at 11:37:52AM +0100, Hans de Goede wrote:
>
>> Userspace is writing to the intel_backlight device because it is the
>> only one present under /sys/class/backlight, as we disable acpi-video
>> on win8 ready laptops by default now.
>
> Why is nouveau not providing a backlight device?

I do not know.

>> The commit message may not be 100% accurate, although I believe this is
>> related to the laptop having nvidia graphics, but the code / fix is correct
>> regardless.
>
> I don't think we have enough evidence to know whether this fix is
> correct.

This fix fixes a regression introduced from kernel 3.15 to 3.16, when we
switched video.use_native_brightness's default from 0 to 1, all this patch
does is restore the previous behaviour on this specific model as the new
behaviour is broken.

So this is in essence a model targeted "revert" fixing a regression and as
such most certainly is correct, given the clear no regressions policy the
kernel has.

Might it be good to dive deeper as to why the intel_backlight interface
does not work, yes certainly.

Regards,

Hans
