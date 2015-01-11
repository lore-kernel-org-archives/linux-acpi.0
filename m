From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] acpi-video: Add disable_native_backlight quirk for Dell
 XPS15 L521X
Date: Sun, 11 Jan 2015 11:37:52 +0100
Message-ID: <54B25280.6010604@redhat.com>
References: <1420444624-8313-1-git-send-email-hdegoede@redhat.com> <20150111061602.GA1677@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43812 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751267AbbAKKiD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 11 Jan 2015 05:38:03 -0500
In-Reply-To: <20150111061602.GA1677@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org

Hi,

On 11-01-15 07:16, Matthew Garrett wrote:
> On Mon, Jan 05, 2015 at 08:57:04AM +0100, Hans de Goede wrote:
>> The L521X variant of the Dell XPS15 has integrated nvidia graphics, and
>> backlight control does not work properly when using the native interfaces.
>
> I'm not convinced that the assessment of this bug is correct. Is the
> system using the nvidia graphics device?

I do not know.

> If so, why is userspace writing to the intel backlight device?

Userspace is writing to the intel_backlight device because it is the
only one present under /sys/class/backlight, as we disable acpi-video
on win8 ready laptops by default now.

What this commit does is disable the disabling of acpi-video, and
after that userspace will see an acpi_video0 backlight under
/sys/class/backlight, use that and then things work, this has been
confirmed by the bug reporter.

The commit message may not be 100% accurate, although I believe this is
related to the laptop having nvidia graphics, but the code / fix is correct
regardless.

Regards,

Hans
