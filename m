From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [PATCH] fujitsu-laptop: support led-class as module
Date: Wed, 26 Aug 2009 09:23:56 +0100
Message-ID: <9b2b86520908260123l2ba32c5bs804d72ad173f557b@mail.gmail.com>
References: <9b2b86520908250412j61a355aax55110f467c2ec61f@mail.gmail.com>
	 <200908260138.n7Q1cQxW008893@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:62906 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbZHZIX4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Aug 2009 04:23:56 -0400
Received: by fxm17 with SMTP id 17so2693213fxm.37
        for <linux-acpi@vger.kernel.org>; Wed, 26 Aug 2009 01:23:56 -0700 (PDT)
In-Reply-To: <200908260138.n7Q1cQxW008893@turbo.physics.adelaide.edu.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: alan-jenkins@tuffmail.co.uk, linux-acpi@vger.kernel.org, lenb@kernel.org

On 8/26/09, Jonathan Woithe <jwoithe@physics.adelaide.edu.au> wrote:
> Hi
>
>> > Please consider slipping this in to 2.6.31-rc since it's a fairly
>> > trivial
>> > bug fix to ensure that fujitsu-laptop uses the LEDS class even when the
>> > LEDS
>> > class been compiled as a module.  If that's not possible or viewed as
>> > inappropriate then let's go for 2.6.32.
>> > :
>>
>> Don't you need to exclude
>>
>> CONFIG_LEDS_CLASS=m
>> CONFIG_FUJITSU_LAPTOP=y
>
> Hmm, good point.  Admittedly this would be a rare case since most
> distributors would ship with both CONFIG_LEDS_CLASS and
> CONFIG_FUJITSU_LAPTOP set to "m" - a situation which the proposed patch
> at least makes workable.
>
>> I think the Kconfig-fu is "depends on LEDS_CLASS || LEDS_CLASS=n".
>
> So, basically something like this should do the trick:
>
> signed-off-by: Alan Jenkins <sourcejedi.lkml@googlemail.com>
> signed-off-by: Joathan Woithe <jwoithe@physics.adelaide.edu.au>
>
> --- a/drivers/platform/x86/Kconfig	2009-08-26 11:03:20.000000000 +0930
> +++ b/drivers/platform/x86/Kconfig	2009-08-26 11:04:28.000000000 +0930
> @@ -82,6 +82,7 @@
>  	depends on ACPI
>  	depends on INPUT
>  	depends on BACKLIGHT_CLASS_DEVICE
> +	depends on LEDS_CLASS || LEDS_CLASS=n
>  	---help---
>  	  This is a driver for laptops built by Fujitsu:
>
> Regards
>   jonathan

Yeah.  It's a really random scenario, but people do make randconfig
for testing and it's expected to work.

I'd prefer you used my other address

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

Thanks
Alan
