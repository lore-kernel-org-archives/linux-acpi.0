From: "Mattia Dongili" <malattia@linux.it>
Subject: Re: [PATCH] sony-laptop: allow complex per-value input/output
     validation
Date: Tue, 13 Feb 2007 09:47:57 +0100 (CET)
Message-ID: <49660.85.47.20.193.1171356477.squirrel@picard.linux.it>
References: <20070212210107.GA5577@inferi.kami.home>
    <200702122355.56336.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from picard.linux.it ([213.254.12.146]:51717 "EHLO picard.linux.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751195AbXBMIr6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 Feb 2007 03:47:58 -0500
In-Reply-To: <200702122355.56336.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>

On Tue, February 13, 2007 5:55 am, Len Brown said:
> On Monday 12 February 2007 16:01, Mattia Dongili wrote:
>> allows consistency between the sony-laptop
>> specific 'brightness_default' and the backlight subsystem 0-based
>> 'brightness'.
>
> Why do we need to have "sony-laptop specific 'brightness_default'" --
> is that a shortcoming of the backlight subsystem?

It depends on how do you see it :)
brightness_default is the value that brightness will have at the next (and
later) reboot and it's currently handled as a platform_device attribute.
It would be nice anyway if one such attribute could be added to the
backlight subsystem (I'll provide patches - added rpurdie to the Cc list)
in order to standardize its behavior/interface.

-- 
mattia
:wq!


