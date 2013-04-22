From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] ACPI: Disable Windows 8 compatibility for some Lenovo
 ThinkPads
Date: Mon, 22 Apr 2013 22:07:32 +0800
Message-ID: <51754424.6040203@intel.com>
References: <1360599681-24781-1-git-send-email-seth.forshee@canonical.com> <9174410.cA7eiWOPcn@vostro.rjw.lan> <5175055F.9000600@intel.com> <1587525.URWXxEIA21@vostro.rjw.lan> <517528E5.7030105@intel.com> <20130422130600.GA31365@thinkpad-t410> <51753DB0.9010703@intel.com> <20130422135651.GB31365@thinkpad-t410>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:55110 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218Ab3DVOHl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Apr 2013 10:07:41 -0400
Received: by mail-pa0-f42.google.com with SMTP id kq13so3644737pab.1
        for <linux-acpi@vger.kernel.org>; Mon, 22 Apr 2013 07:07:41 -0700 (PDT)
In-Reply-To: <20130422135651.GB31365@thinkpad-t410>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Seth Forshee <seth.forshee@canonical.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Ben Jencks <ben@bjencks.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, joeyli <jlee@suse.com>, Matthew Garrett <mjg59@srcf.ucam.org>

On 04/22/2013 09:56 PM, Seth Forshee wrote:
> On Mon, Apr 22, 2013 at 09:40:00PM +0800, Aaron Lu wrote:
>> On 04/22/2013 09:06 PM, Seth Forshee wrote:
>>> On Mon, Apr 22, 2013 at 08:11:17PM +0800, Aaron Lu wrote:
>>>> On 04/22/2013 07:51 PM, Rafael J. Wysocki wrote:
>>>>> I suppose we need to blacklist them to start with.  I wouldn't like to apply
>>>>> any general changes before we know how many different systems are affected by
>>>>> this particular issue.
>>>>
>>>> I totally agree.
>>>
>>> Are you sure that all of these machines have an alternate interface for
>>> userspace to change the brightness? I know that I've got a non-Lenovo
>>> machine with nVidia graphics for which nouveau exposes no backlight
>>
>> What's the problem with this system then? The same as the thinkpads in
>> bug 51231?
>
> There's no problem with that system; it has another working backlight
> interface. I'm only mentioning it to demonstrate that taking away the
> ACPI interface could leave some machines without any backlight control
> mechanism that Linux currently supports.

I think we just need take away the ACPI interface for these known broken
systems for now, that would require: check if we are in win8 mode, if
so, disable acpi video interface for these known broken systems.

I think video_detect_dmi_table is the proper place to do this.

-Aaron
