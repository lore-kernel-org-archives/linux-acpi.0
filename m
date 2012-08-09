From: Athlion <athlion@gmail.com>
Subject: Re: Kernel stops at "PM: Preparing system for mem sleep", never makes
 it to "Freezing user space processes ... "
Date: Thu, 9 Aug 2012 20:14:43 +0300
Message-ID: <CACfp431RNXmp_453ZU999bQzdBgiU20FEehvLH+DxnZbALAc3A@mail.gmail.com>
References: <CACfp4335KJQ8Zjj0TJNj65Va9K-t_iEHLEGEi8QuWyQj5dVT0g@mail.gmail.com>
 <201208090033.52380.rjw@sisk.pl> <CACfp433snentBjXMaoLLnemD82-xRCZge9aCCRd1Ao=7yhG=RQ@mail.gmail.com>
 <201208091141.58586.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43109 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755611Ab2HIRPE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Aug 2012 13:15:04 -0400
In-Reply-To: <201208091141.58586.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

On Thu, Aug 9, 2012 at 12:41 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Thursday, August 09, 2012, Athlion wrote:
>> Thanks for the swift reply!
>>
>> If I choose processors, I get (among other normal things) this:
>
> What happens if you choose "core"?

Both core and processors always exhibit the same ACPI errors.

>> I do not get these ACPI Error and ACPI Exceptions in a normal run. Is
>> this normal?
>
> No, it is not.
>
>> Does it indicate a problem?
>
> A small one.  It indicates that P-states as defined in the BIOS aren't
> usable to the ACPI cpufreq driver.  There also seems to be a problem with
> the handling of the embedded controller, which may be more serious.

Should I report this to the ACPI list?

>> The dmesg of the pm-suspend after i have
>> # echo "processors" > /sys/power/pm_test
>> can be found here: https://dl.dropbox.com/u/63420/processors.txt
>>
>> The dmesg of a full pm-suspend run is here
>> https://dl.dropbox.com/u/63420/full.txt
>
> That seems to be a clean suspend/resume cycle.  What's the problem, then?

Yes, I'm sorry if it wasn't clear. Since that was a fresh reboot, the
suspend went OK. I posted it because I thought that these ACPI errors
were directly relevant to the problem I'm having. But I am keeping
track of all this info to have when this problem happens again but
since my computer hard locked (this hasn't happened before!) when I
opened the lid just 5 mins ago, and this happens about at 24 hours of
uptime, I will probably have all the info collected by tomorrow. Sorry
for the misunderstanding and thanks for the interest!
