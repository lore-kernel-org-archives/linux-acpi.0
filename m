From: Athlion <athlion@gmail.com>
Subject: Re: Kernel stops at "PM: Preparing system for mem sleep", never makes
 it to "Freezing user space processes ... "
Date: Sun, 12 Aug 2012 14:01:23 +0300
Message-ID: <CACfp433X1KwvDu+5ytVVOk6K4pc2vzKxMgEZaCsNwLz0o+Mj9Q@mail.gmail.com>
References: <CACfp4335KJQ8Zjj0TJNj65Va9K-t_iEHLEGEi8QuWyQj5dVT0g@mail.gmail.com>
 <CACfp431RNXmp_453ZU999bQzdBgiU20FEehvLH+DxnZbALAc3A@mail.gmail.com>
 <CACfp432=M5XkqRXpKfzstvQo59tytHGoV1_r15DtV3ZhYvGwoA@mail.gmail.com> <201208120008.47633.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:41698 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991Ab2HLLBo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 12 Aug 2012 07:01:44 -0400
In-Reply-To: <201208120008.47633.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

On Sun, Aug 12, 2012 at 1:08 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> This seems to be the last kernel message you've got.
>
> It looks like there's a problem with a power management notifier within
> the kernel.  Perhaps a race condition, since it is not reproducible 100%
> of the time.
>
> Does it happen if you don't use the lid to trigger suspend?
>
> Rafael

No, it does not.

If I don't use the lid, the suspend succeeds 100% of the time (at
least, I have achieved over 4 days of uptime by using the
logout/suspend button of xfce, I never could stand not closing the lid
for more...)

What I don't know exactly is how to begin tracking this problem down.
