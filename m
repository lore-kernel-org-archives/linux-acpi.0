From: "Luming Yu" <luming.yu@gmail.com>
Subject: Re: BenQ S73U - no ACPI
Date: Tue, 15 May 2007 09:26:35 +0800
Message-ID: <3877989d0705141826i7e78e5fmc81e8010bb3cf3ea@mail.gmail.com>
References: <46417D3B.4020305@willies.info>
	 <3877989d0705090228n295a7e86vd66fd0138d9e77e4@mail.gmail.com>
	 <46435CCD.5010609@willies.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.228]:49679 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757804AbXEOB0h (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 May 2007 21:26:37 -0400
Received: by nz-out-0506.google.com with SMTP id r28so5650nza
        for <linux-acpi@vger.kernel.org>; Mon, 14 May 2007 18:26:37 -0700 (PDT)
In-Reply-To: <46435CCD.5010609@willies.info>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Willies <jan@willies.info>
Cc: linux-acpi@vger.kernel.org

please enter a bug on bugzilla.kernel.org in ACPI category

On 5/11/07, Jan Willies <jan@willies.info> wrote:
> Luming Yu wrote:
> > On 5/9/07, Jan Willies <jan@willies.info> wrote:
> >> I got a BenQ S73U and it doesn't support ACPI very well. I got 23
> > please describe the problem in detail.
> What information are useful? I have put some log-files here:
>
>     http://web746.webbox240.server-home.org/acpi/acpid
>     http://web746.webbox240.server-home.org/acpi/acpi.log
>
> There simply is no S{1,2,3,4,5} with this laptop. It won't even
> power-off itself after halt.
> >> errors. This is confusing, it should work well cause they are only
> >> warnings, not errors!
> > warnings when compiling /proc/acpi/dsdt with the iasl-compiler, but no
> >
> > compile-time working doesn't mean run-time working.
> I discovered that, sadly.
>
>
> - jcw
>
>
