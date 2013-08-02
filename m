From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] acpi: video: fix reversed indexed BQC
Date: Thu, 1 Aug 2013 23:11:12 -0500
Message-ID: <CAMP44s1A+z4=DGJLK1qf5LPc1vbYvtJwjFiMt17vzyZFRU0qmg@mail.gmail.com>
References: <1375400042-989-1-git-send-email-felipe.contreras@gmail.com>
	<51FB137D.7070000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:59583 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777Ab3HBELO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Aug 2013 00:11:14 -0400
In-Reply-To: <51FB137D.7070000@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lwe@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>

On Thu, Aug 1, 2013 at 9:03 PM, Aaron Lu <aaron.lwe@gmail.com> wrote:
> On 08/02/2013 07:34 AM, Felipe Contreras wrote:
>> Commit 1a7c618 (ACPI video: support _BQC/_BCL/_BCM methods that use
>> index values) assumed that bl->levels were not reverted, but at this
>> point they already are, so there's no need to revert them yet again.
>
> When acpi_video_bqc_value_to_level is called, bl->levels is not
> reverted.

This is the code that turns br->flags._BCL_reversed on:

	if (max_level == br->levels[2]) {
		br->flags._BCL_reversed = 1;
		sort(&br->levels[2], count - 2, sizeof(br->levels[2]),
			acpi_video_cmp_level, NULL);
	}

Now tell me how br->flags._BCL_reversed can be on, and the br->levels
*not* reverted.

-- 
Felipe Contreras
