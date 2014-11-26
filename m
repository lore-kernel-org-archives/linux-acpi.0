From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/3] ACPI / processor: remove incorrect comparison of
 phys_id
Date: Wed, 26 Nov 2014 12:23:43 +0000
Message-ID: <5475C64F.7010603@arm.com>
References: <1416926930-792-1-git-send-email-sudeep.holla@arm.com> <1416926930-792-2-git-send-email-sudeep.holla@arm.com> <27257905.ShLUYyq0Be@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:45652 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbaKZMXs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Nov 2014 07:23:48 -0500
In-Reply-To: <27257905.ShLUYyq0Be@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi Rafael,

On 25/11/14 23:11, Rafael J. Wysocki wrote:
> On Tuesday, November 25, 2014 02:48:48 PM Sudeep Holla wrote:
>> phys_id in acpi_processor structure is unsigned 32-bit integer,
>> comparing it with signed value is incorrect.
>>
>> This patch removes that incorrect comparision in
>> acpi_processor_hotadd_init as the lone user of this function is
>> already checking for correctness of phys_id before calling it.
>>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>
> This one depens on commits I've dropped due to conflicts with the tip
> tree.
>
> They'll need to be rebased on top of current linux-next and resent.
>

I have rebased but will hold off until your response to Hanjun's concern.

> I can take patches [2-3/3], though.

Thanks.

Regards,
Sudeep

