From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v6 5/5] ACPI : enable ACPI_PROCESSOR_IDLE on ARM64
Date: Mon, 27 Jun 2016 17:12:50 +0200
Message-ID: <57714272.7030303@linaro.org>
References: <1465915719-8409-1-git-send-email-sudeep.holla@arm.com>
 <1465915719-8409-6-git-send-email-sudeep.holla@arm.com>
 <5771392B.3080002@linaro.org> <57714043.5020207@arm.com>
 <577140A7.60904@linaro.org> <57714106.2040200@arm.com>
 <5771416E.1040000@linaro.org> <5771423A.1030708@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36374 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbcF0PMw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jun 2016 11:12:52 -0400
Received: by mail-wm0-f45.google.com with SMTP id f126so104688096wma.1
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jun 2016 08:12:51 -0700 (PDT)
In-Reply-To: <5771423A.1030708@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Vikas Sajjan <vikas.cha.sajjan@hpe.com>, Sunil <sunil.vl@hpe.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Prashanth Prakash <pprakash@codeaurora.org>, Al Stone <al.stone@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 06/27/2016 05:11 PM, Sudeep Holla wrote:
>
>
> On 27/06/16 16:08, Daniel Lezcano wrote:
>> On 06/27/2016 05:06 PM, Sudeep Holla wrote:
>
> [...]
>
>>> Ah ok, anyways LPI always starts from index 0. IIUC that was your m=
ain
>>> concern.
>>
>> Do you have a repo where I can see the code ?
>>
>
> Yes, you can get it from [1]

Great. Thanks Sudeep !

> Regards,
> Sudeep
>
> [1] http://git.kernel.org/sudeep.holla/linux/h/for_review/arm64_lpi


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
