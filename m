From: Jack Kelly <jack-list@xlk.org.uk>
Subject: Re: HP laptop: fan off until CPU temp near 105 degrees C
Date: Tue, 9 Oct 2012 11:32:31 +0100
Message-ID: <CALHKqSU7SR+6tJaAE_66diAN6+2FzCnhP-L-8Bgf1TerMw1hgA@mail.gmail.com>
References: <CALHKqSU44q6LakKrBKeNFFu7=xbipAog4URMLT0i5Yturo6w9w@mail.gmail.com>
 <4D68720C2E767A4AA6A8796D42C8EB591C9D47@BGSMSX102.gar.corp.intel.com>
 <CALHKqSXFhf7zoQWMrPDzgS0EGXN5xVxOHLu2j8Ysdtexk5prww@mail.gmail.com>
 <4D68720C2E767A4AA6A8796D42C8EB591C9E51@BGSMSX102.gar.corp.intel.com>
 <CALHKqSXtD_TbGYTxJv+fhXhjqO2=UoDUoeF8dFkEeuuvN36PwQ@mail.gmail.com>
 <CALHKqSWoGMQ9sEP34zWjRxoxOPXAWOjyKd1SC-asW7qypvAPng@mail.gmail.com> <744357E9AAD1214791ACBA4B0B90926322D9A3@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:63979 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754392Ab2JIKcw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Oct 2012 06:32:52 -0400
Received: by mail-vc0-f174.google.com with SMTP id fo13so6205621vcb.19
        for <linux-acpi@vger.kernel.org>; Tue, 09 Oct 2012 03:32:52 -0700 (PDT)
In-Reply-To: <744357E9AAD1214791ACBA4B0B90926322D9A3@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "R, Durgadoss" <durgadoss.r@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Dear Rui,

Many thanks for the reply.  I have uploaded the data you requested to:

http://xlk.org.uk/ext/laptop-data.tar.gz

laptop-data.tar.gz contains 4 text files:

* acpidump.txt

* cool.txt (output of "grep . /sys/class/thermal/*/*" when system is cool)

* overheat.txt (output of "grep . /sys/class/thermal/*/*" when CPU
overheats. I don't think this file contains any temperatures readings
from the CPU though)

* overheat_sensors.txt (output of "sensors" when CPU overheats)

Please do let me know if you need any more info.

(Sorry for the very late reply. I did reply on 1st Oct but it seems
that email didn't get through to the list).

Thanks again for your help,
Jack


On 1 October 2012 15:33, Zhang, Rui <rui.zhang@intel.com> wrote:
>
> Can you attach the acpidump output of this machine?
> Can you attach the output of "grep . /sys/class/thermal/*/*" both when the
> system is cool and overheat?
