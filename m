From: "Mitch Davis" <mjd-kernel-org@afork.com>
Subject: Re: bugzilla.kernel.org bug 7988: Resume from RAM on Toshiba A100 fails
Date: Wed, 28 Feb 2007 11:04:23 +1100
Message-ID: <8956d4ca0702271604u39a734k408184477ade88f0@mail.gmail.com>
References: <8956d4ca0702210648v43f99a5el53f5a15b2b99a8d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.249]:31365 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbXB1AE2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Feb 2007 19:04:28 -0500
Received: by an-out-0708.google.com with SMTP id b33so1289116ana
        for <linux-acpi@vger.kernel.org>; Tue, 27 Feb 2007 16:04:28 -0800 (PST)
In-Reply-To: <8956d4ca0702210648v43f99a5el53f5a15b2b99a8d1@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On 2/22/07, Mitch Davis <mjd-kernel-org@afork.com> wrote:
> Hello,
>
> I was inspired by Matthew Garrett's talk at LCA to find out why my
> Toshiba laptop doesn't resume after a suspend.  I did what I could to
> diagnose it, and logged the problem here:
>
>  http://bugzilla.kernel.org/show_bug.cgi?id=7988

In the bug, Rafael J. Wysocki suggested:
>
> Can you try the latest -mm kernel (but please do not compile it with
> CONFIG_PREEMPT set)?

I have now tried 2.6.20-mm2, and the result is exactly the same: The laptop
suspends but never gets to first base on resume.

Please, any ideas?

Mitch.
