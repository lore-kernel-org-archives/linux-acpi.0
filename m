From: "Eduard Huguet" <eduardhc@gmail.com>
Subject: Re: Suspend to RAM in an Asus P1-AH2
Date: Tue, 2 Sep 2008 21:42:44 +0200
Message-ID: <617be8890809021242o50564338i1766644534bde0be@mail.gmail.com>
References: <617be8890808270739gdba5c46q6cae8c33668d6bba@mail.gmail.com>
	 <200809021903.24026.rjw@sisk.pl>
	 <617be8890809021058y37c032a2t9e48f113e2b3f1bd@mail.gmail.com>
	 <200809022117.02404.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:54652 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbYIBTmp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Sep 2008 15:42:45 -0400
Received: by gxk9 with SMTP id 9so5615812gxk.13
        for <linux-acpi@vger.kernel.org>; Tue, 02 Sep 2008 12:42:44 -0700 (PDT)
In-Reply-To: <200809022117.02404.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org

I didn't try the direct writing to /sys/power/state. I'll perform a
new battery of tests including this and post the results.

Thanks for your help, :)
  Eduard

2008/9/2 Rafael J. Wysocki <rjw@sisk.pl>:
> On Tuesday, 2 of September 2008, Eduard Huguet wrote:
>> Hi,
>>     Sorry, I misread the previous email. This time I checked the
>> CONFIG_FTRACE option and redone the tests, so anyway that's good
>> because I'm sure that in my previous test it was unset.
>>
>> About how I am suspending to ram, I'm currently using Gentoo
>> 'hibernate-ram' script, which in turn is using s2ram. The options
>> passed to the s2ram are "-f -s -a 3" if I remember correctly (can't
>> check the logs right now). The hibernate-ram script does some stuff
>> before suspending, like unloading some modules, etc...
>>
>> Also, as I'm doing some very basic testing only, before attempting to
>> suspend I issue a 'init 1' command so I go into single-user mode, no
>> X. In some cases I even unload nvidia.ko module by using rmmod, but
>> I'm pretty sure this don't make any difference.
>
> Is there any difference if you do just  'echo mem > /sys/power/state' instead
> of running s2ram?
>
> Did you try to run s2ram manually (ie. without the script from Gentoo)?
>
> Did you try any other combinations of s2ram options?
>
> Thanks,
> Rafael
>
