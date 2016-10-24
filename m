From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPICA: arm64: fix compile apci tools fail for arm64
Date: Mon, 24 Oct 2016 14:25:35 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886A257C05@SHSMSX101.ccr.corp.intel.com>
References: <1476402698-40963-1-git-send-email-xieyisheng1@huawei.com>
 <1AE640813FDE7649BE1B193DEA596E886A253666@SHSMSX101.ccr.corp.intel.com>
 <696226b1-7024-a4d6-8bea-ddbf6d08a564@huawei.com>
 <1AE640813FDE7649BE1B193DEA596E886A253FBF@SHSMSX101.ccr.corp.intel.com>
 <c88b5433-fbf0-1a15-11b2-b47c1872d48d@huawei.com>
 <1AE640813FDE7649BE1B193DEA596E886A256324@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E886A256F1E@SHSMSX101.ccr.corp.intel.com>
 <b53fb761-0e7e-7864-2f4f-6aee84a8aba1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b53fb761-0e7e-7864-2f4f-6aee84a8aba1@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yisheng Xie <xieyisheng1@huawei.com>, "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "wmiles@sgl.com" <wmiles@sgl.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "guohanjun@huawei.com" <guohanjun@huawei.com>, "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>
List-Id: linux-acpi@vger.kernel.org

Hi

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Yisheng
> Xie
> Subject: Re: [PATCH] ACPICA: arm64: fix compile apci tools fail for arm64
> 
> 
> 
> On 2016/10/22 3:40, Zheng, Lv wrote:
> > Hi,
> >
> > I generated a solution with tools/power/acpi makefiles.
> > Please give it a try.
> Hi Lv,
> Your patch also works.

Thanks for the test.
I'll send it to the community for review.

Best regards
Lv

> 
> > Sorry for the hackish build includes.
> >
> > Thanks and best regards
> > Lv
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
