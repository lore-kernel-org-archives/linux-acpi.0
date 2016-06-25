From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v6 4/5] arm64: add support for ACPI Low Power Idle(LPI)
Date: Sat, 25 Jun 2016 10:05:58 +0200
Message-ID: <576E3B66.2020600@linaro.org>
References: <1465915719-8409-1-git-send-email-sudeep.holla@arm.com>
 <20160622141700.GB2733@red-moon> <576DA047.7080808@linaro.org>
 <15462807.mkANpcI9rV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <15462807.mkANpcI9rV@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org, Vikas Sajjan <vikas.cha.sajjan@hpe.com>, Sunil <sunil.vl@hpe.com>, Prashanth Prakash <pprakash@codeaurora.org>, Al Stone <al.stone@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

On 06/25/2016 12:47 AM, Rafael J. Wysocki wrote:

[ ... ]

>>>> +	if (!acpi_disabled)
>>>> +		return psci_acpi_cpu_init_idle(cpu);
>>
>> Is it possible the case where there is information in both the DT an=
d in
>> ACPI ?
>
> No, it isn't.
>
> It is either-or, never both at the same time.

Ok, thanks for the clarification.

   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
