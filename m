From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/3] ACPI autoloading of linux specific HIDs
Date: Sat, 8 Dec 2007 01:40:40 -0500
Message-ID: <200712080140.40778.lenb@kernel.org>
References: <1197030019.28990.126.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38318 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751827AbXLHGk7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 8 Dec 2007 01:40:59 -0500
In-Reply-To: <1197030019.28990.126.camel@queen.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: akpm <akpm@linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, fseidel <fseidel@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, Holger Macht <hmacht@suse.de>

Thomas,
Thank you for feeding the SuSE patches back to upstream.

These are now queued on the ACPI test branch for 2.6.25.

-Len

On Friday 07 December 2007 07:20, Thomas Renninger wrote:
> These are fixes which are in OpenSUSE 10.3 for some time already.
> I split patch 1 and 2, which was one originally and fixed a minor bug
> there:
> Fix autloading of dock, video, bay and all linux specific HID drivers
> -> If a video/bay/dock/... device has no HID, do not add the Linux
> specific HID to the list of CIDs, but add it as HID.
> 
> Those should have posted a bit earlier.., but are no critical fixes.
> Len, I expect you don't want to have them in 2.6.24?
> Andrew, can you take them please, then, so that they are not missed on
> the next cycle again...
> 
> Frank, Kay, it is already some time ago when you gave your
> signed-offs..., I made this little adjustment mentioned above and the
> split. As these were only small changes, I kept your signed-offs, hope
> this is ok with you.
> 
> Thanks,
> 
>   Thomas
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
