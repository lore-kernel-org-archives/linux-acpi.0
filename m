From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 1/2] acpi: Fix proper return code for function
 acpi_gsi_to_irq
Date: Tue, 12 Jan 2016 15:36:53 +0100
Message-ID: <20160112143653.GB30558@pd.tnic>
References: <1446857519-5908-1-git-send-email-lho@apm.com>
 <1446857519-5908-2-git-send-email-lho@apm.com>
 <20160110110714.GA22896@pd.tnic>
 <CAGDN=zYa1r23EphdYQTFe2YXRhg_P-RDiaZVms9rdbFA3Y-x3g@mail.gmail.com>
 <20160111221305.GH4665@pd.tnic>
 <CAGDN=zZOr6+q8aAdXB3gnSLfCm6gX-6KLaFPr+A4QMf+TPwR-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:54300 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933622AbcALOhH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Jan 2016 09:37:07 -0500
Content-Disposition: inline
In-Reply-To: <CAGDN=zZOr6+q8aAdXB3gnSLfCm6gX-6KLaFPr+A4QMf+TPwR-w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tuan Phan <tphan@apm.com>
Cc: Loc Ho <lho@apm.com>, dougthompson@xmission.com, mchehab@osg.samsung.com, tomasz.nowicki@linaro.org, fu.wei@linaro.org, rjw@rjwysocki.net, lenb@kernel.org, linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Jon Masters <jcm@redhat.com>, patches@apm.com, Thomas Gleixner <tglx@linutronix.de>

On Mon, Jan 11, 2016 at 02:41:41PM -0800, Tuan Phan wrote:
> It will be problem because irq number can be 0 on X86?

tglx says not really but historically irq 0 has been the timer irq.

How about returning a negative value on error and positive or 0 for an
IRQ?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
