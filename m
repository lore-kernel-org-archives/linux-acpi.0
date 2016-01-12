From: Tuan Phan <tphan@apm.com>
Subject: Re: [PATCH v3 1/2] acpi: Fix proper return code for function acpi_gsi_to_irq
Date: Tue, 12 Jan 2016 10:26:04 -0800
Message-ID: <CAGDN=za9Pjm0B0OMJevgesBdkm=XOGyU7jXXfWqk+dLSo7BVtQ@mail.gmail.com>
References: <1446857519-5908-1-git-send-email-lho@apm.com> <1446857519-5908-2-git-send-email-lho@apm.com>
 <20160110110714.GA22896@pd.tnic> <CAGDN=zYa1r23EphdYQTFe2YXRhg_P-RDiaZVms9rdbFA3Y-x3g@mail.gmail.com>
 <20160111221305.GH4665@pd.tnic> <CAGDN=zZOr6+q8aAdXB3gnSLfCm6gX-6KLaFPr+A4QMf+TPwR-w@mail.gmail.com>
 <20160112143653.GB30558@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:35555 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331AbcALS0Y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jan 2016 13:26:24 -0500
Received: by mail-ob0-f178.google.com with SMTP id py5so66548342obc.2
        for <linux-acpi@vger.kernel.org>; Tue, 12 Jan 2016 10:26:24 -0800 (PST)
In-Reply-To: <20160112143653.GB30558@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Loc Ho <lho@apm.com>, dougthompson@xmission.com, mchehab@osg.samsung.com, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Fu Wei <fu.wei@linaro.org>, rjw@rjwysocki.net, Len Brown <lenb@kernel.org>, linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Jon Masters <jcm@redhat.com>, patches@apm.com, Thomas Gleixner <tglx@linutronix.de>

On Tue, Jan 12, 2016 at 6:36 AM, Borislav Petkov <bp@alien8.de> wrote:
> On Mon, Jan 11, 2016 at 02:41:41PM -0800, Tuan Phan wrote:
>> It will be problem because irq number can be 0 on X86?
>
> tglx says not really but historically irq 0 has been the timer irq.
>
> How about returning a negative value on error and positive or 0 for an
> IRQ?
>

That's exactly the patch tries to do:
int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
@@ -56,7 +56,7 @@ int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
         * *irq == 0 means no mapping, that should
         * be reported as a failure
         */
-       return (*irq > 0) ? *irq : -EINVAL;
+       return (*irq > 0) ? 0 : -EINVAL;
 }

So are you good with it?

-- 
CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
for the sole use of the intended recipient(s) and contains information that 
is confidential and proprietary to Applied Micro Circuits Corporation or 
its subsidiaries. It is to be used solely for the purpose of furthering the 
parties' business relationship. All unauthorized review, use, disclosure or 
distribution is prohibited. If you are not the intended recipient, please 
contact the sender by reply e-mail and destroy all copies of the original 
message.
