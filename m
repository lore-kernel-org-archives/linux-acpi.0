From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] acpi-video: Filter the BCL table for duplicate brightness
 values
Date: Sat, 15 Feb 2014 09:49:24 +0100
Message-ID: <52FF2A14.1090600@redhat.com>
References: <1392305571-4895-1-git-send-email-hdegoede@redhat.com> <52FDDC3E.1070103@redhat.com> <52FE2DFB.6010901@intel.com> <1711359.oXonO7zNKI@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:18653 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752139AbaBOIte (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 15 Feb 2014 03:49:34 -0500
In-Reply-To: <1711359.oXonO7zNKI@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Hi,

On 02/15/2014 02:00 AM, Rafael J. Wysocki wrote:
> On Friday, February 14, 2014 10:53:47 PM Aaron Lu wrote:
>> On 02/14/2014 05:05 PM, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 02/14/2014 02:16 AM, Aaron Lu wrote:
>>>> On 02/13/2014 11:32 PM, Hans de Goede wrote:
>>>>> Some devices have duplicate entries in there brightness levels table, ie
>>>>> on my Dell Latitude E6430 the table looks like this:
>>>>
>>>> For reference's purpose, can you please file a bug in kernel bugzilla
>>>> under the ACPI/Power-Video category and attach the acpidump there? Thanks.
>>>
>>> Done:
>>>
>>> https://bugzilla.kernel.org/show_bug.cgi?id=70571
>>
>> Thanks, and the patch looks good to me.
>> Reviewed-by: Aaron Lu <aaron.lu@intel.com>
>
> OK, thanks!
>
> Is this stable material?  If so, which stable kernels should it go into?

Not sure if you're asking me or Aaron. I did not think about this before,
but I think adding this to stable makes sense. I'll let Aaron judge
how far it should be backported.

Regards,

Hans
