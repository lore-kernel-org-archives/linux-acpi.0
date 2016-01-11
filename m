From: Tuan Phan <tphan@apm.com>
Subject: Re: [PATCH v3 1/2] acpi: Fix proper return code for function acpi_gsi_to_irq
Date: Mon, 11 Jan 2016 14:41:41 -0800
Message-ID: <CAGDN=zZOr6+q8aAdXB3gnSLfCm6gX-6KLaFPr+A4QMf+TPwR-w@mail.gmail.com>
References: <1446857519-5908-1-git-send-email-lho@apm.com> <1446857519-5908-2-git-send-email-lho@apm.com>
 <20160110110714.GA22896@pd.tnic> <CAGDN=zYa1r23EphdYQTFe2YXRhg_P-RDiaZVms9rdbFA3Y-x3g@mail.gmail.com>
 <20160111221305.GH4665@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:36726 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759180AbcAKWmC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Jan 2016 17:42:02 -0500
Received: by mail-ob0-f178.google.com with SMTP id ba1so420612137obb.3
        for <linux-acpi@vger.kernel.org>; Mon, 11 Jan 2016 14:42:01 -0800 (PST)
In-Reply-To: <20160111221305.GH4665@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Loc Ho <lho@apm.com>, dougthompson@xmission.com, mchehab@osg.samsung.com, tomasz.nowicki@linaro.org, fu.wei@linaro.org, rjw@rjwysocki.net, lenb@kernel.org, linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Jon Masters <jcm@redhat.com>, patches@apm.com

On Mon, Jan 11, 2016 at 2:13 PM, Borislav Petkov <bp@alien8.de> wrote:

>That function can be simplified. It should be made to return the irq
>number on success and 0 on failure. No need for that *irq output
>argument.

It will be problem because irq number can be 0 on X86?

-- 
CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
for the sole use of the intended recipient(s) and contains information that 
is confidential and proprietary to Applied Micro Circuits Corporation or 
its subsidiaries. It is to be used solely for the purpose of furthering the 
parties' business relationship. All unauthorized review, use, disclosure or 
distribution is prohibited. If you are not the intended recipient, please 
contact the sender by reply e-mail and destroy all copies of the original 
message.
