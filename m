From: "Julia Jomantaite" <julia.jomantaite@gmail.com>
Subject: Re: [PATCH] drivers/acpi/video: fix brightness allocation
Date: Fri, 13 Jun 2008 12:05:40 +0100
Message-ID: <8265cb9e0806130405m340a314fm6935f388653e9e6a@mail.gmail.com>
References: <8265cb9e0806120947o4f39f78aqa3ace61a1ec1d6e3@mail.gmail.com>
	 <20080612180006.7cc946b2.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:40070 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870AbYFMLFl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Jun 2008 07:05:41 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2461163rvb.1
        for <linux-acpi@vger.kernel.org>; Fri, 13 Jun 2008 04:05:40 -0700 (PDT)
In-Reply-To: <20080612180006.7cc946b2.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rui.zhang@intel.com

On Fri, Jun 13, 2008 at 2:00 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Thu, 12 Jun 2008 17:47:09 +0100
> "Julia Jomantaite" <julia.jomantaite@gmail.com> wrote:
>
>> ACPI Video Driver module (drivers/acpi/video.c) produces Oops message
>> after pressing one of two Fn+<key> combinations responsible for switching
>> the brightness level on my laptop.
>>
>> The source of this problem is in the function acpi_video_switch_brightness
>> which can access device->brightness when it is not allocated. Function
>> "acpi_video_device_find_cap" which is responsible for allocating
>> device->brightness can leave it unallocated in some cases.
>>
>> Function acpi_video_switch_brightness isn't called if modules's parameter
>> "brightness_switch_enabled" is equal to zero so i've decided to add
>> zeroing of this parameter to the part of the code where unsuccessfull
>> allocation of device->brightness was handled.
>>
>> Also i've moved initialization of brightness to a separate function
>> "acpi_video_init_brightness" to improve readability of the code and
>> to simplify error handling.
>>
>
> (cc's added)
>
> Thanks.  Which kernel version were you running?

This patch is for the latest version of kernel from git  (linux-2.6),
but the similar allocation problem exists on earlier versions of
kernel ( for example 2.6.22 and 2.6.23).

> The patch was a bit wordwrapped.  Here's the fixed up version:

Thank you.
