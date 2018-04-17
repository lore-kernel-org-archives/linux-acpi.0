From: "Alex G." <mr.nuke.me@gmail.com>
Subject: Re: [RFC PATCH v2 1/4] EDAC, GHES: Remove unused argument to
 ghes_edac_report_mem_error
Date: Tue, 17 Apr 2018 11:43:11 -0500
Message-ID: <77318fdf-b6a6-9df4-1e1f-540e03357422@gmail.com>
References: <20180416215903.7318-1-mr.nuke.me@gmail.com>
 <20180416215903.7318-2-mr.nuke.me@gmail.com> <20180417093656.GA18640@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180417093656.GA18640@pd.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com, tbaicar@codeaurora.org, will.deacon@arm.com, james.morse@arm.com, shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com, linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com, devel@acpica.org, mchehab@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com
List-Id: linux-acpi@vger.kernel.org



On 04/17/2018 04:36 AM, Borislav Petkov wrote:
> On Mon, Apr 16, 2018 at 04:59:00PM -0500, Alexandru Gagniuc wrote:
> 
> <--- Insert commit message here.
> 
> A possible candidate would be some blurb about what commit removed the
> use of that first arg.

I didn't consider any commit message pork to be necessary when the
summary already explains the triviality of the change. I'll add it in
the next rev.

Thanks,
Alex

>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>> ---
>>  drivers/acpi/apei/ghes.c | 2 +-
>>  drivers/edac/ghes_edac.c | 3 +--
>>  include/acpi/ghes.h      | 5 ++---
>>  3 files changed, 4 insertions(+), 6 deletions(-)
> 
