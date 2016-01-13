From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v3 1/2] acpi: Fix proper return code for function acpi_gsi_to_irq
Date: Wed, 13 Jan 2016 08:40:23 +0000
Message-ID: <56960D77.5010805@arm.com>
References: <1446857519-5908-1-git-send-email-lho@apm.com> <1446857519-5908-2-git-send-email-lho@apm.com> <56954D18.1010306@arm.com> <CAGDN=zYVvU9=Qj8_szqYW3qh7G=phr_Bc_dm8+KVO=yhp=YTVQ@mail.gmail.com> <569554D0.2000406@arm.com> <CAGDN=zY5wVwOC=o8f1nmYyUrgo5gdRVgB7W1jsKu0RKyazp+BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39256 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751305AbcAMIk2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Jan 2016 03:40:28 -0500
In-Reply-To: <CAGDN=zY5wVwOC=o8f1nmYyUrgo5gdRVgB7W1jsKu0RKyazp+BA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tuan Phan <tphan@apm.com>
Cc: Loc Ho <lho@apm.com>, dougthompson@xmission.com, Borislav Petkov <bp@alien8.de>, mchehab@osg.samsung.com, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Fu Wei <fu.wei@linaro.org>, rjw@rjwysocki.net, Len Brown <lenb@kernel.org>, Jon Masters <jcm@redhat.com>, patches@apm.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org

On 12/01/16 20:01, Tuan Phan wrote:
> On Tue, Jan 12, 2016 at 11:32 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> > Right. In which case please document this properly in the commit log.
>> >
> Do we need to post a new patch with updated description or wait Rafael's input?

Given that there is quite a few comments on this series already, it
would make sense to update it and repost it.

> -- CONFIDENTIALITY NOTICE: This e-mail message, including any
> attachments, is for the sole use of the intended recipient(s) and
> contains information that is confidential and proprietary to Applied
> Micro Circuits Corporation or its subsidiaries. It is to be used solely
> for the purpose of furthering the parties' business relationship. All
> unauthorized review, use, disclosure or distribution is prohibited. If
> you are not the intended recipient, please contact the sender by reply
> e-mail and destroy all copies of the original message.

And please fix your email setup. By the look of it, I'm not even
supposed to read this.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
