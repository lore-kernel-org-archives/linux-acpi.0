From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v4 18/18] Documentation: ACPI for ARM64
Date: Thu, 18 Sep 2014 07:06:11 +0800
Message-ID: <541A13E3.4010800@linaro.org>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org> <4416582.iOjLNrLDZE@vostro.rjw.lan> <20140917192259.GA18980@srcf.ucam.org> <1628662.T2ReQ4irMm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:54604 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756198AbaIQXGQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Sep 2014 19:06:16 -0400
Received: by mail-pa0-f47.google.com with SMTP id ey11so78745pad.20
        for <linux-acpi@vger.kernel.org>; Wed, 17 Sep 2014 16:06:16 -0700 (PDT)
In-Reply-To: <1628662.T2ReQ4irMm@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>, linaro-acpi@lists.linaro.org, Liviu Dudau <Liviu.Dudau@arm.com>, Lv Zheng <lv.zheng@intel.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, Charles.Garcia-Tobin@arm.com, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org, Graeme Gregory <graeme.gregory@linaro.org>, Randy

On 2014=E5=B9=B409=E6=9C=8818=E6=97=A5 04:11, Rafael J. Wysocki wrote:
> On Wednesday, September 17, 2014 08:22:59 PM Matthew Garrett wrote:
>> On Wed, Sep 17, 2014 at 09:37:42PM +0200, Rafael J. Wysocki wrote:
>>
>>> There are no implied IP issues with using the information there I k=
now of and
>>> if there's any fine print anywhere that may suggest so, please let =
me know.
>> Using the information should be fine, but my understanding of the UE=
=46I=20
>> forum rules is that any submissions to UEFI specs must be from UEFI=20
>> forum members - there are concerns around accidentally including=20
>> patented material.
> The documents in question are not regarded as UEFI specs, however.  T=
hey
> are just hosted by UEFI.
>
>> The easy way around this is just for the bindings to=20
>> be managed outside UEFI.
> Again, there's a difference between UEFI material and the UEFI hostin=
g
> something (but not maintaining it).
>
> In principle, the bindings could be hosted by UEFI, but maintained by
> community members.

Thanks for the clarify, I totally agree with you, that's how things wor=
k now for such doc hosted
by UEFI.

=46or now,  _DSD will use the same binding as DT, is there any chance t=
hat _DSD will introduce
new bindings? if yes, how can we handle it?

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
