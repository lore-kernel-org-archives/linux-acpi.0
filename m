From: "Satyam Sharma" <satyam.sharma@gmail.com>
Subject: Re: [PATCH][BUTTON] remove procfs-interface
Date: Fri, 13 Jul 2007 00:37:07 +0530
Message-ID: <a781481a0707121207o3497edbye9f89c9f2589f3e5@mail.gmail.com>
References: <4695F726.7030203@nachtwindheim.de>
	 <823A93EED437D048963A3697DB0E35DE7314AB@pdsmsx414.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:27058 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755337AbXGLTHL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jul 2007 15:07:11 -0400
Received: by ug-out-1314.google.com with SMTP id j3so404878ugf
        for <linux-acpi@vger.kernel.org>; Thu, 12 Jul 2007 12:07:09 -0700 (PDT)
In-Reply-To: <823A93EED437D048963A3697DB0E35DE7314AB@pdsmsx414.ccr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: Henne <henne@nachtwindheim.de>, Arjan van de Ven <arjan@infradead.org>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org

On 7/12/07, Zhang, Rui <rui.zhang@intel.com> wrote:
> Well, the ACPI sysfs conversion is not finished yet
> [...]
> I'm not sure if the button sysfs I/F is already finished.
> We'd better make a double check. :)

Ok, this sounds reasonable.

> and some user space tools still use the ACPI procfs.

But this does *not*, IMHO. It quite defeats the whole concept of
feature-removal-schedule.txt. I think that file exists precisely
because we cannot gratuitously break userspace interfaces just
like that, but when something gets put up there with a removal date
that is a good one year in the future, and userspace tools _still_
continue to use it ... then, I suspect something's seriously wrong.

Either the feature-removal-schedule.txt file has become something
that users don't even bother checking, or else, they _know_ that
even if they don't bother keeping up with the pace in kernel-land,
that interface still won't go away (because they're still using it!).
In both the above cases, it appears that file itself has become
irrelevant and a "feature" that could be "removed" ... :-)

> The schedule of removing ACPI procfs I/F will be changed to Jan 08.
> I'm about to send a patch to update it.

Satyam
