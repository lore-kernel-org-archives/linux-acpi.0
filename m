From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v5 2/2] acpi: apei: Add SEI notification type support for
 ARMv8
Date: Wed, 18 Oct 2017 11:06:49 +0200
Message-ID: <20171018090649.e7qgdf2dwmr7yxc3@pd.tnic>
References: <1508227341-15651-1-git-send-email-gengdongjiu@huawei.com>
 <1508227341-15651-2-git-send-email-gengdongjiu@huawei.com>
 <20171017170635.qb4sqyrsnndgbuni@pd.tnic>
 <0bcba052-700b-5ee8-88fc-aaf8cc6b1d37@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0bcba052-700b-5ee8-88fc-aaf8cc6b1d37@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gengdongjiu <gengdongjiu@huawei.com>
Cc: tbaicar@codeaurora.org, james.morse@arm.com, will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, mark.rutland@arm.com, kristina.martsenko@arm.com, mingo@kernel.org, punit.agrawal@arm.com, stephen.boyd@linaro.org, kamensky@cisco.com, prarit@redhat.com, shiju.jose@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, Huangshaoyu <huangshaoyu@huawei.com>, Wuquanming <wuquanming@huawei.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 18, 2017 at 01:00:44PM +0800, gengdongjiu wrote:
> SError is System Error, which is a asynchronous exception in the Internal CPU.
> 
> In the ARM RAS Extension, there are mainly two type abort for CPU:
> SEA(Synchronous External Abort)
> SEI(SError Interrupt)

And you're not writing it out as "System Error" because ...?

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
