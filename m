From: Loc Ho <lho@apm.com>
Subject: Re: [PATCH v4 1/2] acpi: Fix proper return code for function acpi_gsi_to_irq
Date: Tue, 26 Jan 2016 09:54:27 -0800
Message-ID: <CAPw-ZTkyGZgHD9ba+LGVn3V5u6T=-qKn0-MPLN-FDbA4E6cyQw@mail.gmail.com>
References: <1453335459-3617-1-git-send-email-lho@apm.com>
	<1453335459-3617-2-git-send-email-lho@apm.com>
	<CAPw-ZTnm5F3Kt+_J6HoNCYbx8R7JVkME5yA9V-hAwRtr8ge9ZA@mail.gmail.com>
	<56A72EEB.5040205@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:35144 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965389AbcAZRy3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Jan 2016 12:54:29 -0500
Received: by mail-lb0-f170.google.com with SMTP id bc4so96400381lbc.2
        for <linux-acpi@vger.kernel.org>; Tue, 26 Jan 2016 09:54:28 -0800 (PST)
In-Reply-To: <56A72EEB.5040205@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Borislav Petkov <bp@alien8.de>, Doug Thompson <dougthompson@xmission.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Fu Wei <fu.wei@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-edac <linux-edac@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-acpi@vger.kernel.org, "patches@apm.com" <patches@apm.com>, Tuan Phan <tphan@apm.com>

Hi Marc,

On Tue, Jan 26, 2016 at 12:31 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Loc,
>
> On 25/01/16 21:23, Loc Ho wrote:
>> Hi,
>>
>> On Wed, Jan 20, 2016 at 4:17 PM, Loc Ho <lho@apm.com> wrote:
>>>
>>> The function acpi_gsi_to_irq must return 0 on success as the caller
>>> ghes_probe expects an 0 for success. This change also matches x86
>>> implementation.
>>>
>>> Signed-off-by: Tuan Phan <tphan@apm.com>
>>> Signed-off-by: Loc Ho <lho@apm.com>
>>
>>
>> Any issue with this version? If not, can this be pulled into 4.5?
>
> How is that 4.5 material? Does it fix an observable bug or a regression
> from a previous? If not, then this is probably to be postponed until
> 4.6, together with the code that makes use of it.

Given that this and the other patch are needed for APEI to work with
X-Gene, fine with 4.6. Are we just waiting for Rafael to make the
final call then?

-Loc
