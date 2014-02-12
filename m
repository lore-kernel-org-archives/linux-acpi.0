From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] ACPI / video: Add HP EliteBook Revolve 810 to the blacklist
Date: Wed, 12 Feb 2014 10:31:59 +0800
Message-ID: <52FADD1F.90209@intel.com>
References: <1391425156-27821-1-git-send-email-mika.westerberg@linux.intel.com> <52F43716.7020008@intel.com> <20140207102523.GO18029@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:28680 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751933AbaBLCcS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Feb 2014 21:32:18 -0500
In-Reply-To: <20140207102523.GO18029@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org

On 02/07/2014 06:25 PM, Mika Westerberg wrote:
> On Fri, Feb 07, 2014 at 09:29:58AM +0800, Aaron Lu wrote:
>> On 02/03/2014 06:59 PM, Mika Westerberg wrote:
>>> On HP EliteBook Revolve 810 the ACPI backlight device doesn't work as
>>> expected. For example when resuming from system sleep, it seems to lose
>>> backlight settings.
>>>
>>> Forcing Intel driver fixes the problem so add this machine the ACPI
>>> video detect blacklist.
>>
>> For reference's purpose, can you please file a bug to kernel bugzilla
>> under the ACPI/Power-Video category and attach the acpidump and dmesg
>> there? Thanks.
> 
> Done, the bug is here:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=70231
> 
> I noticed that using only the acpi_video0 for tuning backlight works but if
> I use intel_backlight directly, on resume I get values from acpi_video0
> instead. I'm not really familiar how this is supposed to work, though so
> please let me know if I'm missing something.

Thanks for the report, as communicated on the bug page, your system is
already blacklisted for win8 by commit:

commit 2d4054d8422462cb2771fdb4eb1925df55d2b320
Author:	Takashi Iwai <tiwai@suse.de>  Fri Dec 20 00:09:12 2013
Committer:	Rafael J. Wysocki <rafael.j.wysocki@intel.com>  Fri Dec 20 22:50:56 2013

ACPI: Blacklist Win8 OSI for some HP laptop 2013 models

And the fact that acpi_video interface works made it not appropriate to
add your system into the video_detect_dmi_table. You can just use acpi_video
interface and everything should work fine.
