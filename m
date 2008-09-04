From: Luis Henriques <henrix@sapo.pt>
Subject: Re: Problem with ACPI video
Date: Thu, 04 Sep 2008 20:44:07 +0100
Message-ID: <48C03A87.5050109@sapo.pt>
References: <g9n0h0$ru8$1@ger.gmane.org> <1220491149.24775.229.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay6.ptmail.sapo.pt ([212.55.154.26]:33251 "HELO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751996AbYIDToS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Sep 2008 15:44:18 -0400
In-Reply-To: <1220491149.24775.229.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org

Zhang Rui wrote:
>> It seems that acpi_video_bus_add function is invoked twice and, the
>> second time, it fails (maybe it is supposed to be invoked twice...).
>>
> There are two ACPI video bus devices both named "VGA" in the ACPI
> namespace, and each of them tries to create an entry "VGA"
> under /proc/acpi/video/.
> that's why this message is printed out.

Sorry about my ignorance on the topic but... does this mean I do
actually have 2 devices?  If this is true, then I should actually have
"VGA1" and "VGA2" dirs in /proc, right?

>> Please let me know whether you need any additional information to help
>> me solving this problem.
> There is a patch from Matthew that should solve this problem, which has
> already hit the acpi test tree.
> it would be great if you can get the source code and give it a try. :)
> 
> how to get the source code:
>> git-clone git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-acpi-2.6 acpi_test
>> git-branch -r
>> git-branch --track test origin/test
>> git-checkout test


Ok, tried this (or similar...) and it seems to be working just fine.
Or, at least, no more error message from kernel.  Also, in
/proc/acpi/video only one directory 'VGA' is being created.  Here's the
relevante dmesg part:

[   14.657009] ACPI: AC Adapter [ACAD] (on-line)
[   14.661005] acpi device:04: registered as cooling_device2
[   14.664019] input: Video Bus as /class/input/input4
[   14.716892] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)

Thanks!
--
Luis
