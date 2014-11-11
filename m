From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v10 1/1] Mailbox: Add support for Platform Communication
 Channel
Date: Tue, 11 Nov 2014 18:07:03 +0000
Message-ID: <54625047.2000103@arm.com>
References: <1415371964-4451-1-git-send-email-ashwin.chaugule@linaro.org> <1415371964-4451-2-git-send-email-ashwin.chaugule@linaro.org> <5461E548.2040204@arm.com> <20141111172955.GA3815@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:41726 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbaKKSGr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Nov 2014 13:06:47 -0500
In-Reply-To: <20141111172955.GA3815@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>, "arnd@arndb.de" <arnd@arndb.de>, "patches@linaro.org" <patches@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lv.zheng@intel.com" <lv.zheng@intel.com>

Hi Mark,

On 11/11/14 17:29, Mark Brown wrote:
> On Tue, Nov 11, 2014 at 10:30:32AM +0000, Sudeep Holla wrote:
>> On 07/11/14 14:52, Ashwin Chaugule wrote:
>
>>> +config PCC
>>> +       bool "Platform Communication Channel Driver"
>>> +       depends on ACPI
>
>> I am bit confused here, though I prefer PCC to depend on ACPI, I have
>> seen discussion in this thread about using PCC without ACPI, how will
>> that work ?
>
> We can always remove the dependency when someone adds the code to talk
> to non-ACPI PCC devices.
>

Agreed, Ashwin clarified that, I had not followed previous versions 
closely and was speaking only in the context of this patch.

Regards,
Sudeep

