From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v5 18/18] Documentation: ACPI for ARM64
Date: Wed, 31 Dec 2014 16:34:46 +0800
Message-ID: <54A3B526.9040903@linaro.org>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>    <1413553034-20956-19-git-send-email-hanjun.guo@linaro.org>    <CAJ5Y-eZ5cu9_OhG24yAv+CZq7zKg0vU+eVGekyN+9dDzaz1OhQ@mail.gmail.com> <8fc9550c96a468b3e50d51a37db68a33.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:52051 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbaLaIfA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Dec 2014 03:35:00 -0500
Received: by mail-pd0-f172.google.com with SMTP id y13so20574341pdi.17
        for <linux-acpi@vger.kernel.org>; Wed, 31 Dec 2014 00:34:59 -0800 (PST)
In-Reply-To: <8fc9550c96a468b3e50d51a37db68a33.squirrel@www.codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ashwinc@codeaurora.org, catalin.marinas@arm.com, rjw@rjwysocki.net, mark.rutland@arm.com, olof@lixom.net, grant.likely@linaro.org, will.deacon@arm.com
Cc: linaro-acpi@lists.linaro.org, Liviu.Dudau@arm.com, lv.zheng@intel.com, robh@kernel.org, Lorenzo.Pieralisi@arm.com, al.stone@linaro.org, daniel.lezcano@linaro.org, robert.moore@intel.com, linux-acpi@vger.kernel.org, Charles.Garcia-Tobin@arm.com, rric@kernel.org, jason@lakedaemon.net, arnd@arndb.de, marc.zyngier@arm.com, jcm@redhat.com, broonie@kernel.org, "bhelgaas@google.com." <linux-arm-kernel@lists.infradead.org>, graeme.gregory@linaro.org, Kangkang.Shen@huawei.com, rdunlap@infradead.org, linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com

On 2014=E5=B9=B412=E6=9C=8831=E6=97=A5 04:13, ashwinc@codeaurora.org wr=
ote:
> Hi Hanjun,
>
> Overall the document looks good to us. Some minor clarifications belo=
w.
>
>> ---------- Forwarded message ----------
>> From: Graeme Gregory <graeme.gregory@linaro.org>
>>
>> Add documentation for the guidelines of how to use ACPI
>> on ARM64.
>>
>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   Documentation/arm64/arm-acpi.txt |  323
>> ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 323 insertions(+)
>>   create mode 100644 Documentation/arm64/arm-acpi.txt
>>
>
> [..]
>
>> +Relationship with Device Tree
>> +-----------------------------
>
> [..]
>
>> +When booting using ACPI tables, the /chosen node in DT will still b=
e
>> parsed
>> +to extract the kernel command line and initrd path.  No other secti=
on of
>> the
>> +DT will be used.
>
> Is this still true?

No, we can booting the ACPI system in EFI stub without dtb. Catalin
also pointed out this issue, I will remove this paragraph.

>
>
>> +Programmable Power Control Resources
>> +------------------------------------
>> +Programmable power control resources include such resources as
>> voltage/current
>> +providers (regulators) and clock sources.
>> +
>> +The kernel assumes that power control of these resources is represe=
nted
>> with
>> +Power Resource Objects (ACPI section 7.1).  The ACPI core will then
>> handle
>> +correctly enabling and disabling resources as they are needed.  In =
order
>> to
>> +get that to work, ACPI assumes each device has defined D-states and=
 that
>> these
>> +can be controlled through the optional ACPI methods _PS0, _PS1, _PS=
2, and
>> _PS3;
>> +in ACPI, _PS0 is the method to invoke to turn a device full on, and=
 _PS3
>> is for
>> +turning a device full off.
>> +
>> +The kernel ACPI code will also assume that the _PS? methods follow =
the
>> normal
>> +ACPI rules for such methods:
>> +
>> +   -- If either _PS0 or _PS3 is implemented, then the other method =
must
>> also
>> +      be implemented.
>> +
>> +   -- If a device requires usage or setup of a power resource when =
on,
>> the ASL
>> +      should organize that it is allocated/enabled using the _PS0 m=
ethod.
>> +
>> +   -- Resources allocated or enabled in the _PS0 method should be
>> disabled
>> +      or de-allocated in the _PS3 method.
>> +
>> +   -- Firmware will leave the resources in a reasonable state befor=
e
>> handing
>> +      over control to the kernel.
>> +
>
> We found this section could be improved a bit by explicitly calling o=
ut
> the options for handling device PM. Platform vendor has two choices.
> Resources can be managed in _PSx routine which gets called on entry t=
o Dx.
>   Or they can be declared separately as power resources with their ow=
n _ON
> and _OFF methods.  They are then tied back to D-states for a particul=
ar
> device via _PRx which specifies which power resources a device needs =
to be
> on while in Dx.  Kernel then tracks number of devices using a power
> resource and calls _ON/_OFF as needed.

Good point, this exactly what ACPI spec says, we need to update this
paragraph a little bit.

>
>> +Such code in _PS? methods will of course be very platform specific.=
  But,
>> +this allows the driver to abstract out the interface for operating =
the
>> device
>> +and avoid having to read special non-standard values from ACPI tabl=
es.
>> Further,
>> +abstracting the use of these resources allows the hardware to chang=
e over
>> time
>> +without requiring updates to the driver.
>> +
>
> I think its been mentioned in the past and you planned to add it here=
: we
> should explicitly state that with ACPI, the kernel clock/vreg framewo=
rk
> are not expected to be used at all.
>
>> +
>> +Clocks
>> +------
>> +ACPI makes the assumption that clocks are initialized by the firmwa=
re --
>> +UEFI, in this case -- to some working value before control is hande=
d over
>> +to the kernel.  This has implications for devices such as UARTs, or=
 SoC
>> +driven LCD displays, for example.
>> +
>> +When the kernel boots, the clock is assumed to be set to reasonable
>> +working value.  If for some reason the frequency needs to change --=
 e.g.,
>> +throttling for power management -- the device driver should expect =
that
>> +process to be abstracted out into some ACPI method that can be invo=
ked
>
> Exception to this is CPU clocks where CPPC provides a much richer
> interface than just blindly invoking some method.
>
>> +(please see the ACPI specification for further recommendations on
>> standard
>> +methods to be expected).  If is not, there is no direct way for ACP=
I to
>> +control the clocks.
>> +
>> +
>
> [..]
>
>> +ASWG
>> +----
>> +The following areas are not yet fully defined for ARM in the 5.1 ve=
rsion
>> +of the ACPI specification and are expected to be worked through in =
the
>> +UEFI ACPI Specification Working Group (ASWG):
>> +
>> +   -- ACPI based CPU topology
>> +   -- ACPI based Power management
>
> Should clarify this to idle management rather than generic power mana=
gement.

and I think it is CPU idle specific here, right?

>
>> +   -- CPU idle control based on PSCI
>> +   -- CPU performance control (CPPC)
>
> There is no ongoing work on CPPC. Additional enhancements may be expl=
ored
> in the future, but spec is viable as is.

will remove it.

Thanks for reviewing it!

Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
