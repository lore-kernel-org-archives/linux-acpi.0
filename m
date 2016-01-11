From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 1/2] acpi: Fix proper return code for function
 acpi_gsi_to_irq
Date: Mon, 11 Jan 2016 23:13:05 +0100
Message-ID: <20160111221305.GH4665@pd.tnic>
References: <1446857519-5908-1-git-send-email-lho@apm.com>
 <1446857519-5908-2-git-send-email-lho@apm.com>
 <20160110110714.GA22896@pd.tnic>
 <CAGDN=zYa1r23EphdYQTFe2YXRhg_P-RDiaZVms9rdbFA3Y-x3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:40240 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758752AbcAKWNS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Jan 2016 17:13:18 -0500
Content-Disposition: inline
In-Reply-To: <CAGDN=zYa1r23EphdYQTFe2YXRhg_P-RDiaZVms9rdbFA3Y-x3g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tuan Phan <tphan@apm.com>
Cc: Loc Ho <lho@apm.com>, dougthompson@xmission.com, mchehab@osg.samsung.com, tomasz.nowicki@linaro.org, fu.wei@linaro.org, rjw@rjwysocki.net, lenb@kernel.org, linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Jon Masters <jcm@redhat.com>, patches@apm.com

On Mon, Jan 11, 2016 at 02:04:52PM -0800, Tuan Phan wrote:
> Hi Boris,
> The same function which is implemented for x86
> (arch/x86/kernel/acpi/boot.c) also returns 0 on success and -1 on
> failure. If we need to change the API, need to change for X86 too
> which we don't have a way to test it.

Well, fortunately, I have an x86 box to test it :-)

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
