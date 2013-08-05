From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] acpi: video: improve quirk check
Date: Mon, 5 Aug 2013 09:41:04 -0500
Message-ID: <CAMP44s0+d2ffXC-k8+kxQ4XCfF8M_VSBZ02M5seDSj99oPkXZw@mail.gmail.com>
References: <1375472229-1563-1-git-send-email-felipe.contreras@gmail.com>
	<1861338.WxIinvfTH6@vostro.rjw.lan>
	<CAMP44s0EwO11to-nfjhKkUidQKe6h=y0o-V7gYmF_mJeKhMRtQ@mail.gmail.com>
	<23723258.099Re4s3PJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:64333 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753303Ab3HEOlG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Aug 2013 10:41:06 -0400
In-Reply-To: <23723258.099Re4s3PJ@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Aaron Lu <aaron.lwe@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>

On Mon, Aug 5, 2013 at 9:04 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:

>> In my machine I think the issue is slightly different, I think _BCM is
>> failing, at least until enabling the _DOS thing, but at the end of the
>> day it's the same thing for the check; _BQC is always returning the
>> same value, and the code above will find that out, regardless of which
>> values are tested.
>>
>> For my particular machine though, I think it's more interesting to
>> find out why _BCM is failing before _DOS, and why efaa14c made it
>> work. If that is actually the case.
>
> That depends on how the BIOS+platform is designed and that may change from
> one system to another quite a bit.

Maybe, but it seems there's at least another ASUS machine with the
same behavior, and it seems a lot of ASUS machines behave very
similarly.

> The only common denominator is what Windows expects (and that unfortunately
> depends on the version of Windows too), because that's the functionality
> which is likely to have been tested.  Anything else is likely to be untested
> and therefore most probably buggy.

Maybe, or maybe we are doing something wrong.

It's worth to try to find that out.

-- 
Felipe Contreras
