From: Jan Willies <jan@willies.info>
Subject: Re: BenQ S73U - no ACPI
Date: Thu, 10 May 2007 19:56:29 +0200
Message-ID: <46435CCD.5010609@willies.info>
References: <46417D3B.4020305@willies.info> <3877989d0705090228n295a7e86vd66fd0138d9e77e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from metis.intersales.de ([213.133.99.69]:36762 "EHLO
	metis.intersales.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756222AbXEJR4f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 May 2007 13:56:35 -0400
In-Reply-To: <3877989d0705090228n295a7e86vd66fd0138d9e77e4@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Luming Yu <luming.yu@gmail.com>

Luming Yu wrote:
> On 5/9/07, Jan Willies <jan@willies.info> wrote:
>> I got a BenQ S73U and it doesn't support ACPI very well. I got 23
> please describe the problem in detail.
What information are useful? I have put some log-files here:

    http://web746.webbox240.server-home.org/acpi/acpid
    http://web746.webbox240.server-home.org/acpi/acpi.log

There simply is no S{1,2,3,4,5} with this laptop. It won't even 
power-off itself after halt.
>> errors. This is confusing, it should work well cause they are only
>> warnings, not errors!
> warnings when compiling /proc/acpi/dsdt with the iasl-compiler, but no
>
> compile-time working doesn't mean run-time working.
I discovered that, sadly.


- jcw

