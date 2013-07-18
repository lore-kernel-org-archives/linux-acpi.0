From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] acpi: blacklist win8 OSI for ASUS Zenbok Prime UX31A
Date: Thu, 18 Jul 2013 09:04:03 +0800
Message-ID: <51E73F03.90901@intel.com>
References: <1369037793-1559-1-git-send-email-felipe.contreras@gmail.com> <CAMP44s3M=LtOfPp+AS0dv=eud1rVSzDOjYbkw+cTAQPzLsK2wg@mail.gmail.com> <4224252.tpDZo1Wai9@vostro.rjw.lan> <51CBA54C.6040703@intel.com> <CAMP44s2oq5+H=oCXjik4y_yaLm1YKL6nRgbwKNqfVmP4C8pthg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:35372 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756630Ab3GRBDV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Jul 2013 21:03:21 -0400
In-Reply-To: <CAMP44s2oq5+H=oCXjik4y_yaLm1YKL6nRgbwKNqfVmP4C8pthg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On 07/17/2013 11:42 PM, Felipe Contreras wrote:
> On Wed, Jun 26, 2013 at 9:37 PM, Aaron Lu <aaron.lu@intel.com> wrote:
> 
>> Please reference a similar bug where ACPI video driver can't work for
>> some thinkpad win8 laptops:
>> https://bugzilla.kernel.org/show_bug.cgi?id=51231
>>
>> And the proposed way to fix this issue is for all Win8 systems, the
>> ACPI video backlight interface will be removed, leaving only GPU's
>> backlight interface:
>> https://lkml.org/lkml/2013/6/9/161
> 
> Thanks. I took a look at the thread and the patches, so essentially
> when those patches are applied, I should expect the same behavior as
> acpi_backlight=vendor, right? If so, that doesn't work correctly in
> this laptop. In this laptop intel backlight works through X, but when
> I set the level to 0 everything is black (it works fine in ACPI), and

That sounds a bug in i915's handling of backlight to me, perhaps file a
bug for that? For component, please choose Drivers/DRI-intel.

> the keyboard keys don't work.

I don't see why the backlight hotkey stops working, we have kept ACPI's
event notification handling for Win8 systems. Worth filing a bug too :-)
For components, please choose ACPI/Video.

BTW, what's the situation after you try the following 3 patches:
https://patchwork.kernel.org/patch/2829342/
https://patchwork.kernel.org/patch/2829344/
https://patchwork.kernel.org/patch/2829339/

Thanks,
Aaron
