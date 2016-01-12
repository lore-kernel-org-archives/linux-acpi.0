From: Tuan Phan <tphan@apm.com>
Subject: Re: [PATCH v3 1/2] acpi: Fix proper return code for function acpi_gsi_to_irq
Date: Tue, 12 Jan 2016 12:01:42 -0800
Message-ID: <CAGDN=zY5wVwOC=o8f1nmYyUrgo5gdRVgB7W1jsKu0RKyazp+BA@mail.gmail.com>
References: <1446857519-5908-1-git-send-email-lho@apm.com> <1446857519-5908-2-git-send-email-lho@apm.com>
 <56954D18.1010306@arm.com> <CAGDN=zYVvU9=Qj8_szqYW3qh7G=phr_Bc_dm8+KVO=yhp=YTVQ@mail.gmail.com>
 <569554D0.2000406@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:36355 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbcALUCD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jan 2016 15:02:03 -0500
Received: by mail-ob0-f180.google.com with SMTP id ba1so445924560obb.3
        for <linux-acpi@vger.kernel.org>; Tue, 12 Jan 2016 12:02:02 -0800 (PST)
In-Reply-To: <569554D0.2000406@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Loc Ho <lho@apm.com>, dougthompson@xmission.com, Borislav Petkov <bp@alien8.de>, mchehab@osg.samsung.com, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Fu Wei <fu.wei@linaro.org>, rjw@rjwysocki.net, Len Brown <lenb@kernel.org>, Jon Masters <jcm@redhat.com>, patches@apm.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org

On Tue, Jan 12, 2016 at 11:32 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Right. In which case please document this properly in the commit log.
>

Do we need to post a new patch with updated description or wait Rafael's input?

-- 
CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
for the sole use of the intended recipient(s) and contains information that 
is confidential and proprietary to Applied Micro Circuits Corporation or 
its subsidiaries. It is to be used solely for the purpose of furthering the 
parties' business relationship. All unauthorized review, use, disclosure or 
distribution is prohibited. If you are not the intended recipient, please 
contact the sender by reply e-mail and destroy all copies of the original 
message.
