From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH v2 05/18] x86, acpi: Split acpi_boot_table_init() into
 two parts.
Date: Fri, 02 Aug 2013 17:13:26 +0800
Message-ID: <51FB7836.3040202@cn.fujitsu.com>
References: <1375340800-19332-1-git-send-email-tangchen@cn.fujitsu.com>  <1375340800-19332-6-git-send-email-tangchen@cn.fujitsu.com> <1375399931.10300.36.camel@misato.fc.hp.com> <1AE640813FDE7649BE1B193DEA596E8802437AC8@SHSMSX101.ccr.corp.intel.com> <51FB5948.6080802@cn.fujitsu.com> <1AE640813FDE7649BE1B193DEA596E8802437C47@SHSMSX101.ccr.corp.intel.com> <51FB6DE6.6040200@cn.fujitsu.com> <1AE640813FDE7649BE1B193DEA596E8802437C78@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E8802437C78@SHSMSX101.ccr.corp.intel.com>
Sender: owner-linux-mm@kvack.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Toshi Kani <toshi.kani@hp.com>, "rjw@sisk.pl" <rjw@sisk.pl>, "lenb@kernel.org" <lenb@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@elte.hu" <mingo@elte.hu>, "hpa@zytor.com" <hpa@zytor.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "tj@kernel.org" <tj@kernel.org>, "trenn@suse.de" <trenn@suse.de>, "yinghai@kernel.org" <yinghai@kernel.org>, "jiang.liu@huawei.com" <jiang.liu@huawei.com>, "wency@cn.fujitsu.com" <wency@cn.fujitsu.com>, "laijs@cn.fujitsu.com" <laijs@cn.fujitsu.com>, "isimatu.yasuaki@jp.fujitsu.com" <isimatu.yasuaki@jp.fujitsu.com>, "izumi.taku@jp.fujitsu.com" <izumi.taku@jp.fujitsu.com>, "mgorman@suse.de" <mgorman@suse.de>, "minchan@kernel.org" <minchan@kernel.org>, "mina86@mina86.com" <mina86@mina86.com>, gong.chen@linux.
List-Id: linux-acpi@vger.kernel.org

On 08/02/2013 04:54 PM, Zheng, Lv wrote:
>> From: Tang Chen [mailto:tangchen@cn.fujitsu.com]
>> Sent: Friday, August 02, 2013 4:29 PM
>>
>> On 08/02/2013 04:23 PM, Zheng, Lv wrote:
>> ......
>>>> According to what you've explained, what you didn=E2=80=99t want to be
>> called
>>>> earlier is exactly "acpi initrd table override", please split only thi=
s logic
>> to
>>>> the step 2 and leave the others remained.
>>>> I think you should write a function named as acpi=5Foverride=5Ftables(=
) or
>>>> likewise in tbxface.c to be executed as the OSPM entry of the step 2.
>>>> Inside this function, acpi=5Ftb=5Ftable=5Foverride() should be called.
>> ......
>>
>> OK, I understand what you are suggesting now. It is reasonable.
>> I'll update the patch-set in the next version.
>>
>> But today, I just rebased it to the latest kernel. I'll resend this
>> rebased v2 patch-set so that Tj and other guys can review it.
>>
>> I'll include all of your comments in the v3 patch-set. Thank you very
>> much. :)
>
> If the review process takes longer time, you could also let ACPICA folks =
to do this first in ACPICA, you'll find the commit in the next release cycl=
e.
> In this way, there won't be source code divergences between Linux and ACP=
ICA.

Thank you very much. Will add you and Bob to the cc list.

Thanks.
=

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
