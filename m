From: gengdongjiu <gengdongjiu@huawei.com>
Subject: Re: [PATCH v5 1/2] acpi: apei: remove the unused dead-code for
 SEA/NMI notification type
Date: Wed, 18 Oct 2017 20:27:00 +0800
Message-ID: <577d79ad-9357-ea40-63eb-1d2988642710@huawei.com>
References: <1508227341-15651-1-git-send-email-gengdongjiu@huawei.com>
 <20171017164336.cedso3f35lpeam7f@pd.tnic>
 <642709ec-05d0-2ffd-0e2e-bcdd6b12281b@huawei.com>
 <20171018101722.kce2tcvpd7xdpo46@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171018101722.kce2tcvpd7xdpo46@pd.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: tbaicar@codeaurora.org, james.morse@arm.com, will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, mark.rutland@arm.com, kristina.martsenko@arm.com, mingo@kernel.org, punit.agrawal@arm.com, stephen.boyd@linaro.org, kamensky@cisco.com, prarit@redhat.com, shiju.jose@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, Wuquanming <wuquanming@huawei.com>, Huangshaoyu <huangshaoyu@huawei.com>
List-Id: linux-acpi@vger.kernel.org


On 2017/10/18 18:17, Borislav Petkov wrote:
> On Wed, Oct 18, 2017 at 11:04:28AM +0800, gengdongjiu wrote:
>> ARM does not have ACPI_HEST_NOTIFY_NMI notification, which should only
>> used by x86. In the code, I see those guards are never used.
> Yeah, I see it now.

Borislav/Rafael,
  For this patch(the first one), whether it can be firstly applied?
This patch is code clean and not related with the second one.
For the second, I may discuss more with James.
Thanks so much in advance.

> 
> Thx.
> 
> -- 
