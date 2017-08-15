From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v2] acpi: apei: fix the wrongly iterate generic error
 status block
Date: Tue, 15 Aug 2017 21:12:03 +0200
Message-ID: <20170815191203.dei4agpxrw6hwcy3@pd.tnic>
References: <1502795713-20945-1-git-send-email-gengdongjiu@huawei.com>
 <CAMj-D2CXOurgPGGGbC7qHX-uWZeMYwh9EfLOS3p3hm+=BvPq7w@mail.gmail.com>
 <20170815161342.jxxf4rndqbs7t5rr@pd.tnic>
 <CAMj-D2AHjR70Fy61aBxof7AxnW+Bz_YgJq-5yOdK+VV8uaF3bA@mail.gmail.com>
 <20170815163239.xm5y6w5yeiaakekv@pd.tnic>
 <CAMj-D2C2S=RoZ7TyhnyX598nHH9xwKQt23mV+u=1tV3+YMMVsQ@mail.gmail.com>
 <20170815165551.4cwa344wm6eptj3d@pd.tnic>
 <7921a233-6971-6e3b-9164-01d6176d61c0@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7921a233-6971-6e3b-9164-01d6176d61c0@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Baicar, Tyler" <tbaicar@codeaurora.org>
Cc: gengdongjiu <gengdj.1984@gmail.com>, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, john.garry@huawei.com, shiju.jose@huawei.com, zhengqiang10@huawei.com, wangxiongfeng2@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com, james.morse@arm.com, geliangtang@gmail.com, andriy.shevchenko@linux.intel.com, tony.luck@intel.com, austinwc@codeaurora.org, shameerali.kolothum.thodi@huawei.com, jonathan.cameron@huawei.com, huangdaode@hisilicon.com, wangzhou1@hisilicon.com
List-Id: linux-acpi@vger.kernel.org

On Tue, Aug 15, 2017 at 12:31:14PM -0600, Baicar, Tyler wrote:
> His patch fixes the define for apei_estatus_for_each_section which in turn
> should fix ghes_do_proc(). So my patch should no longer be needed.

I see. We're keeping the macro, of course.

> I'm going to test this out just to verify if fixes the issue I found.

Please.

Thanks.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
