From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v5 18/18] Documentation: ACPI for ARM64
Date: Fri, 2 Jan 2015 16:47:51 +0000
Message-ID: <EE1B062D-90AC-491F-90E7-D7EACF1F5B06@arm.com>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org> <1413553034-20956-19-git-send-email-hanjun.guo@linaro.org> <CAJ5Y-eZ5cu9_OhG24yAv+CZq7zKg0vU+eVGekyN+9dDzaz1OhQ@mail.gmail.com> <8fc9550c96a468b3e50d51a37db68a33.squirrel@www.codeaurora.org> <54A3B526.9040903@linaro.org> <20150101200424.GB12770@xora-haswell.xora.org.uk> <54A664AB.3030101@linaro.org>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:36499 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbbABQrz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jan 2015 11:47:55 -0500
In-Reply-To: <54A664AB.3030101@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Graeme Gregory <gg@slimlogic.co.uk>, "ashwinc@codeaurora.org" <ashwinc@codeaurora.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Mark Rutland <Mark.Rutland@arm.com>, "olof@lixom.net" <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Will Deacon <Will.Deacon@arm.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Liviu Dudau <Liviu.Dudau@arm.com>, "lv.zheng@intel.com" <lv.zheng@intel.com>, "robh@kernel.org" <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "al.stone@linaro.org" <al.stone@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "robert.moore@intel.com" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "rric@kernel.org" <rric@kernel.org>, "jason@lakedaemon.net" <jason@lakedaemon.net>, arnd@arndb.de

On 2 Jan 2015, at 09:28, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>>> On 2015=E5=B9=B401=E6=9C=8802=E6=97=A5 04:04, Graeme Gregory wrote:
>>>> On Wed, Dec 31, 2014 at 04:34:46PM +0800, Hanjun Guo wrote:
>>>> On 2014=E5=B9=B412=E6=9C=8831=E6=97=A5 04:13, ashwinc@codeaurora.o=
rg wrote:
>>>> Hi Hanjun,
>>>>=20
>>>> Overall the document looks good to us. Some minor clarifications b=
elow.
>>>>=20
>>>>> ---------- Forwarded message ----------
>>>>> From: Graeme Gregory <graeme.gregory@linaro.org>
>>>>>=20
>>>>> Add documentation for the guidelines of how to use ACPI
>>>>> on ARM64.
>>>>>=20
>>>>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>>>>> Signed-off-by: Al Stone <al.stone@linaro.org>
>>>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>>>> ---
>>>>> Documentation/arm64/arm-acpi.txt |  323
>>>>> ++++++++++++++++++++++++++++++++++++++
>>>>> 1 file changed, 323 insertions(+)
>>>>> create mode 100644 Documentation/arm64/arm-acpi.txt
>>>>=20
>>>> [..]
>>>>=20
>>>>> +Relationship with Device Tree
>>>>> +-----------------------------
>>>>=20
>>>> [..]
>>>>=20
>>>>> +When booting using ACPI tables, the /chosen node in DT will stil=
l be
>>>>> parsed
>>>>> +to extract the kernel command line and initrd path.  No other se=
ction of
>>>>> the
>>>>> +DT will be used.
>>>>=20
>>>> Is this still true?
>>>=20
>>> No, we can booting the ACPI system in EFI stub without dtb. Catalin
>>> also pointed out this issue, I will remove this paragraph.
>>=20
>> The paragraph is still correct, the /chosen node is always present e=
ven
>> if nothing else is.
>=20
> Sorry for the confusing, I mean no dtb needed for the command line if
> ACPI tables are available.
>=20
> efi will create a empty dtb if no dtb found, and add the cmd line int=
o
> the new created dtb, I'm just wondering, can we remove the limitation
> for passing the cmd line in /chosen node in the future?

My point is that on an ACPI based system, we don't really care how EFI_=
STUB passes
the command line to the rest of the kernel. Since UEFI doesn't need to =
know about
such detail and since ACPI is only supported with EFI_STUB, we don't ne=
ed to mention
the chosen node in this document.=20

At some point we may even change the way EFI_STUB passes the command li=
ne to the=20
kernel but this is still irrelevant to ACPI.=20

Catalin

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
