From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH] wmi: Set wmi devices' parents
Date: Wed, 25 Nov 2015 17:28:54 -0800
Message-ID: <CALCETrW8SuyZkzogg01gb6SXhPUU__H5_697EavwkEGorG9uJw@mail.gmail.com>
References: <7c58f0a208e0c903008989aec457230e5e58608e.1448306649.git.luto@kernel.org>
 <20151123193709.GZ7413@malice.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:35686 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbbKZB3O (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Nov 2015 20:29:14 -0500
Received: by oige206 with SMTP id e206so39224772oig.2
        for <linux-acpi@vger.kernel.org>; Wed, 25 Nov 2015 17:29:13 -0800 (PST)
In-Reply-To: <20151123193709.GZ7413@malice.jf.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Lutomirski <luto@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org

On Mon, Nov 23, 2015 at 11:37 AM, Darren Hart <dvhart@infradead.org> wrote:
> On Mon, Nov 23, 2015 at 11:25:30AM -0800, Andy Lutomirski wrote:
>> Without this patch, wmi devices are in /sys/virtual/wmi.  They're
>> logically children of the ACPI WMI device, so slot them into the
>> device hierarchy.  With this change, on my laptop, they end up in
>> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C14:00/wmi and
>> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C14:01/wmi.
>>
>> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>
> I'd like to hear from some of the main contributors to this driver:
>
> Matthew?
> Carlos?
> Len?
>
> Any cocnerns on this change?
>
> My initial concern is about changign how we expose this to userspace, but I
> believe where it appears in the /sys/devices FS is NOT part of the
> kernel-userspace interface commitment (per sysfs-rules.txt).


Let's drop this, actually.  I have mostly-working patches to make wmi
into an actual bus driver, and this intermediate step seems like it'll
just confuse people.

Question, though: where do the WMI devices belong?  Multiple choice:

/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C14:01/[GUID]

/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C14:01/wmi/[GUID]

/sys/devices/platform/PNP0C14:01/[GUID]

/sys/devices/platform/PNP0C14:01/wmi/[GUID]

Currently I've implemented the first one because it's the smallest diff.

--Andy
