From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [HP Compaq 6715s] Updating kernel renders system unbootable
Date: Mon, 04 Jan 2016 14:12:47 +0100
Message-ID: <2361922.kuCIB6L7YG@vostro.rjw.lan>
References: <CAHii-dEo0D9QkmpXaQoz-XKai8omx_TrGgHcmk3t7AwE8+DZ8Q@mail.gmail.com> <CAHii-dGm27WvZ1iCU-4P6v8SmqZMGKQECmjMA2Yhq2rSCydqWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58964 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752476AbcADMmJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jan 2016 07:42:09 -0500
In-Reply-To: <CAHii-dGm27WvZ1iCU-4P6v8SmqZMGKQECmjMA2Yhq2rSCydqWw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Olle Englund <realdiskdoc@gmail.com>
Cc: lv.zheng@intel.com, rafael.j.wysocki@intel.com, robert.moore@intel.com, linux-acpi@vger.kernel.org

On Monday, January 04, 2016 01:51:16 AM Olle Englund wrote:
> [1] Summary
> 
> [HP Compaq 6715s] Updating kernel renders system unbootable
> 
> [2] Description
> 
> On 4.4.0-040400rc7:
> 
> - Message about loading image.
> - Screen goes black.
> - Fan goes to full speed.
> - HD light lit for about 15 seconds or so, then goes dark.
> 
> Disect:

Bisect?

> between 3.19.0-25.26 and 3.19.0-26.27 in the Ubuntu kernel tree:
> 
> commit 19114b5458510b757cd2801e64094e4062e4067f

This isn't a mainline kernel commit, so it looks like a backport.

Are you able to reproduce the problem with the mainline kernel?

Thanks,
Rafael

