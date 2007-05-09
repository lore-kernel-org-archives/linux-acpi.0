From: "Luming Yu" <luming.yu@gmail.com>
Subject: Re: BenQ S73U - no ACPI
Date: Wed, 9 May 2007 17:28:51 +0800
Message-ID: <3877989d0705090228n295a7e86vd66fd0138d9e77e4@mail.gmail.com>
References: <46417D3B.4020305@willies.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.234]:60959 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753205AbXEIJ2x (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 May 2007 05:28:53 -0400
Received: by wr-out-0506.google.com with SMTP id 76so143111wra
        for <linux-acpi@vger.kernel.org>; Wed, 09 May 2007 02:28:52 -0700 (PDT)
In-Reply-To: <46417D3B.4020305@willies.info>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Willies <jan@willies.info>
Cc: linux-acpi@vger.kernel.org

On 5/9/07, Jan Willies <jan@willies.info> wrote:
> Hello,
>
> I got a BenQ S73U and it doesn't support ACPI very well. I got 23

please describe the problem in detail.

> warnings when compiling /proc/acpi/dsdt with the iasl-compiler, but no
> errors. This is confusing, it should work well cause they are only
> warnings, not errors!

compile-time working doesn't mean run-time working.

> Anyway, Sebastian Lammermann managed to turn all warnings down by
> rewriting the DSDT, but one. Unfortunately the behavior didn't change,
> shutdown is still not working.
>
> The last unsolved warning:
>
> dsdt.dsl  1164:             Method (_OSC, 5, NotSerialized)
> Warning  1075 -                        ^ Reserved method has too many
> arguments (_OSC requires 4)
>
> If anyone please have a look at the DSDT, it would be very kind! I'm
> really desperate to get this thing working under Linux.
>
> original: http://openwrt.loswillios.de/dsdt.dsl
> modified: http://www.hft-leipzig.de/~s03114/dsdt.dsl

please in details...

>
>
> I mailed BenQ about this problem, they even replied which surprised me a
> bit. They promised to pass the mail to their developers, but I don't
> think it will change something... I reckon I'm not the first one who
> mailed them about that.

That's interesting.. BenQ begins to care about linux?
