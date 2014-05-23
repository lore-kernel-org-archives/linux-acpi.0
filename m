From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: Bug Report - [Acer Aspire V5-122P] Unable to adjust screen brightness
Date: Fri, 23 May 2014 09:34:47 +0800
Message-ID: <537EA5B7.9050509@intel.com>
References: <CADNzsyM9qiWf_KV4uuNDnkcv7JvCSi00qHiNQTWfVN-pZtWqig@mail.gmail.com> <537BFF89.9010806@intel.com> <CADNzsyMn5viCQDc7HXqZiH92BYNp9TZAtMNbuQMAkZXy6hj0Dg@mail.gmail.com> <537C9DC5.5040408@intel.com> <CADNzsyO7gzhtng0WmKA9DGZAreEGVsbAJ+KGdgJu+9zr_LyR8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:59429 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990AbaEWBfV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 May 2014 21:35:21 -0400
In-Reply-To: <CADNzsyO7gzhtng0WmKA9DGZAreEGVsbAJ+KGdgJu+9zr_LyR8g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lewis Toohey <lewis@toohey.co.uk>
Cc: linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

On 05/21/2014 09:02 PM, Lewis Toohey wrote:
> Hi Aaron
> 
> I followed your instructions and can report some limited success. I
> have two interfaces listed in /sys/class/backlight namely:
>   acpi_video0  radeon_bl0
> 
> max_brightness for acpi_video0 is 11. Echo-ing new values to
> brightness appears to have no effect.
> 
> max_brightness for radeon_bl0 is 255. Echo-ing new values to
> brightness does adjust the screen brightness as you would expect.
> 
> Results are the same on both battery and powered.
> 
> I hope that is useful.

I think Hans' patchset should solve your problem, can you please give it
a try? You will need to pass the video.use_native_backlight=1 to kernel
cmdline when testing, thanks.

[PATCH resend 0/4] Make video.use_native_backlight=1 work properly with nouveau
http://www.spinics.net/lists/dri-devel/msg59941.html

-Aaron
