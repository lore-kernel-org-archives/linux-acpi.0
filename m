From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [Linaro-acpi] [PATCH v8 00/21] Introduce ACPI for ARM64 based
 on ACPI 5.1
Date: Wed, 04 Feb 2015 17:41:40 +0800
Message-ID: <54D1E954.4050003@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org> <20150203164727.GC32750@leverpostej> <54D108DD.6050509@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:50084 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754353AbbBDJlt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Feb 2015 04:41:49 -0500
Received: by mail-pa0-f52.google.com with SMTP id kx10so1330218pab.11
        for <linux-acpi@vger.kernel.org>; Wed, 04 Feb 2015 01:41:49 -0800 (PST)
In-Reply-To: <54D108DD.6050509@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <al.stone@linaro.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Mark Langsdorf <mlangsdo@redhat.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "wangyijing@huawei.com" <wangyijing@huawei.com>, Rob Herring <robh@kernel.org>, Timur Tabi <timur@codeaurora.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <Marc.Zyngier@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>"Rafael J. Wysocki" <r>

On 2015=E5=B9=B402=E6=9C=8804=E6=97=A5 01:43, Al Stone wrote:
> On 02/03/2015 09:47 AM, Mark Rutland wrote:
>> On Mon, Feb 02, 2015 at 12:45:28PM +0000, Hanjun Guo wrote:
>>> Hi,
>>>
>>> This is the v8 of ACPI core patches for ARM64 based on ACPI 5.1, th=
ere are
>>> some updates since v7:
>>>
>>>   - Add two more documantation to explain why we need ACPI in ARM64=
 servers
>>>     by Grant, and recommendations and prohibitions on the use of th=
e numerous
>>>     ACPI tables and objects by Al Stone.
>>>
>>>   - Add two patches which is need to map acpi tables after acpi_gbl=
_permanent_mmap
>>>     is set
>>>
>>>   - Add another patch "dt / chosen: Add linux,uefi-stub-generated-d=
tb property"
>>>     to address that if firmware providing no dtb, we can try ACPI c=
onfiguration data
>>>     even if no "acpi=3Dforce" is passed in early parameters. (I thi=
nk ACPI for XEN and
>>>     kexec need consider sperately as disscussed, correct me if I'm =
wrong).
>>>
>>>   - Add CC in the patch to the subsystem maintainers and modify the=
 subject
>>>     of the patch to explicitly show the subsystem touched by this p=
atch set,
>>>     please help us to review and ack them if they make sense, thank=
s.
>>>
>>>   - Add Tested-by from Qualcomm and Redhat;
>>>
>>>   - Make ACPI depends on PCI suggested by Catalin;
>>>
>>>   - Clean up SMP init function as Lorenzo suggested, remove physica=
l
>>>     CPU hot-plug code in the patch;
>>>
>>>   - Address some comments from Marc and explicitly state that will
>>>     implment statcked irqdomain and GIC init framework when GICv3 a=
nd
>>>     ITS, GICv2m are implemented;
>>>
>>>   - Rebased on top of 3.19-rc7.
>>>
>>> previous version is here:
>>> v7: https://lkml.org/lkml/2015/1/14/586
>>> v6: https://lkml.org/lkml/2015/1/4/40
>>>
>>> Any comments are welcome :)
>>
>> I note that for ACPI the PMU interrupt information is stored in the =
GICC
>> (as "Performance Interrupt" and "Performance Interrupt Mode"), but I
>> don't see any code for handling that as part of this series.
>>
>> Is anyone currently looking into that?
>
> Yes.  IIRC, it's a pretty small patch that I'll be including in the
> Seattle patches that build on top of this core set.
>
>> For those systems ACPI is being developed on do we know that the GIC=
C
>> information for the PMU interrupts is sane?
>
> Yes.  We know this works for Seattle platforms, using their latest fi=
rmware.
>
>> I'm slightly worried about the prospect of adding support later only=
 to
>> find that the performance interrupt data in contemporary GICC tables=
 is
>> invalid; it's going to be extremely painful to detect that being the
>> case in order to perform any kind of workaround.
>
> That will depend on the error, of course.  It was pretty straightforw=
ard
> when the interrupt value was set to zero in some of the early tables =
we
> used.

If we are not worrying about too much patch in this series, I can
cherry-pick Mark Salter's ACPI PMU patch for Seattle in next version.

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
