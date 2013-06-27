From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] acpi: blacklist win8 OSI for ASUS Zenbok Prime UX31A
Date: Thu, 27 Jun 2013 10:37:00 +0800
Message-ID: <51CBA54C.6040703@intel.com>
References: <1369037793-1559-1-git-send-email-felipe.contreras@gmail.com> <CAMP44s3M=LtOfPp+AS0dv=eud1rVSzDOjYbkw+cTAQPzLsK2wg@mail.gmail.com> <4224252.tpDZo1Wai9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:49974 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751782Ab3F0Cgi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Jun 2013 22:36:38 -0400
In-Reply-To: <4224252.tpDZo1Wai9@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On 06/26/2013 08:42 PM, Rafael J. Wysocki wrote:
> On Wednesday, June 26, 2013 05:41:01 AM Felipe Contreras wrote:
>> On Mon, May 20, 2013 at 3:16 AM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> Otherwise the backlight can't be changed, presumably because the DSDT
>>> contains stub code when in conjunction with Windows 8.
>>>
>>> https://wiki.archlinux.org/index.php/ASUS_Zenbook_Prime_UX31A
>>>
>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>
>> Hello?
>>
>> Is there anything wrong with this patch?
> 
> We're going to fix this issue in a different way.

Hi Felipe,

Please reference a similar bug where ACPI video driver can't work for
some thinkpad win8 laptops:
https://bugzilla.kernel.org/show_bug.cgi?id=51231

And the proposed way to fix this issue is for all Win8 systems, the
ACPI video backlight interface will be removed, leaving only GPU's
backlight interface:
https://lkml.org/lkml/2013/6/9/161

Thanks,
Aaron
