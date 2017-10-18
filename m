From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v5 1/2] acpi: apei: remove the unused dead-code for
 SEA/NMI notification type
Date: Wed, 18 Oct 2017 12:17:39 +0200
Message-ID: <20171018101722.kce2tcvpd7xdpo46@pd.tnic>
References: <1508227341-15651-1-git-send-email-gengdongjiu@huawei.com>
 <20171017164336.cedso3f35lpeam7f@pd.tnic>
 <642709ec-05d0-2ffd-0e2e-bcdd6b12281b@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43941 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933777AbdJRKRq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 18 Oct 2017 06:17:46 -0400
Content-Disposition: inline
In-Reply-To: <642709ec-05d0-2ffd-0e2e-bcdd6b12281b@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: gengdongjiu <gengdongjiu@huawei.com>
Cc: tbaicar@codeaurora.org, james.morse@arm.com, will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, mark.rutland@arm.com, kristina.martsenko@arm.com, mingo@kernel.org, punit.agrawal@arm.com, stephen.boyd@linaro.org, kamensky@cisco.com, prarit@redhat.com, shiju.jose@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, Wuquanming <wuquanming@huawei.com>, Huangshaoyu <huangshaoyu@huawei.com>

On Wed, Oct 18, 2017 at 11:04:28AM +0800, gengdongjiu wrote:
> ARM does not have ACPI_HEST_NOTIFY_NMI notification, which should only
> used by x86. In the code, I see those guards are never used.

Yeah, I see it now.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
