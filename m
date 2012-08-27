From: Athlion <athlion@gmail.com>
Subject: Re: Kernel stops at "PM: Preparing system for mem sleep", never makes
 it to "Freezing user space processes ... "
Date: Mon, 27 Aug 2012 10:59:34 +0300
Message-ID: <CACfp4339RS2BvbdN1RC+V05FWxFW+=1xjGnk0fivQgW98vJqNg@mail.gmail.com>
References: <CACfp4335KJQ8Zjj0TJNj65Va9K-t_iEHLEGEi8QuWyQj5dVT0g@mail.gmail.com>
 <CACfp4313iKrhYQCjvObPnALUN+fV=jD-EkVZiXCnVGVoAcpKVw@mail.gmail.com>
 <CACfp431n1og++vMinpJxFU79FmoqGKpvn0CA3v8cuZ1xM-EEYg@mail.gmail.com> <201208270928.05619.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:64138 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785Ab2H0H7z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Aug 2012 03:59:55 -0400
In-Reply-To: <201208270928.05619.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

On Mon, Aug 27, 2012 at 10:28 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Saturday, August 25, 2012, Athlion wrote:
>> I have managed to track where the kernel stops and generate sort of a backtrace.
>> The result is this (line numbers against linux-3.4.9)
>>
>> drivers/tty/vt/vt_ioctl.c:133: wait_event_interruptible
>> drivers/tty/vt/vt_ioctl.c:1426: vt_waitactive
>> kernel/power/console.c:19: vt_move_to_console
>> kernel/power/suspend.c:98: pm_prepare_console
>> suspend_prepare called
>>
>> Execution stops at wait_event_interruptible. Any ideas why this might be?
>
> Not at the moment, but this is an important data point.
>
> Thanks a lot for tracing this down!
>
> Rafael

Feel free to ask of anything supplementary you might need!
