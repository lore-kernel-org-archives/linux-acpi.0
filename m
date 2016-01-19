From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4] acpi, apei: add Boot Error Record Table (BERT) support
Date: Tue, 19 Jan 2016 11:05:11 +0100
Message-ID: <20160119100511.GA15503@pd.tnic>
References: <1452260742-13625-1-git-send-email-fu.wei@linaro.org>
 <20160116191604.GE31869@pd.tnic>
 <CADyBb7ueFUUYz_O8-+-FNybJz_dGvMpBh0FdJ-99jNcHikvRSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:48606 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932874AbcASKFf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Jan 2016 05:05:35 -0500
Content-Disposition: inline
In-Reply-To: <CADyBb7ueFUUYz_O8-+-FNybJz_dGvMpBh0FdJ-99jNcHikvRSw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Fu Wei <fu.wei@linaro.org>
Cc: Tony Luck <tony.luck@intel.com>, "Chen, Gong" <gong.chen@intel.com>, Huang Ying <ying.huang@intel.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Tomasz Nowicki <tn@semihalf.com>, tbaicar@codeaurora.org, rruigrok@codeaurora.org, "Abdulhamid, Harb" <harba@qti.qualcomm.com>, G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Jon Masters <jcm@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>, "Chen, Gong" <gong.chen@linux.intel.com>

On Tue, Jan 19, 2016 at 03:09:40PM +0800, Fu Wei wrote:
> My personal opinion is :
> This driver will be used on various platforms, this marker can tell user there
> is some bug in firmware, maybe user can disable BERT next time to avoid
> this noise before develop have chance to fix it.
> And  BIOS vendors also can get info from that, and fix their crap :-)
> 
> If user see this, maybe he should disable BERT on his platform temporary.
> 
> Is that a good reason to keep it?

I guess.

Ok, let's leave it in, we can always remove it later. It's not like the
kernel is BIOS and cannot be changed anymore :-)

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
