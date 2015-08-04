From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v7 3/8] ACPI: Decouple ACPI idle and ACPI processor drivers
Date: Tue, 4 Aug 2015 10:58:25 -0400
Message-ID: <CAJ5Y-eaibuK0c_wSsRjM68vOfuRdRSChRdzR=2qtwVYwQcAzVQ@mail.gmail.com>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org>
	<da1eb99c0e128a4c8160537295045164d8fde00d.1436464513.git.ashwin.chaugule@linaro.org>
	<55AD03F7.60108@arm.com>
	<CAJ5Y-eYqfpdC2EvEO5gRm7zRbzr0+KwhiL4MUY23uXM91y=MJA@mail.gmail.com>
	<55C0D156.9090808@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <55C0D156.9090808@arm.com>
Sender: linux-pm-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
List-Id: linux-acpi@vger.kernel.org

On 4 August 2015 at 10:51, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On 03/08/15 18:40, Ashwin Chaugule wrote:
>>
>> On 20 July 2015 at 10:21, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>> On 09/07/15 19:04, Ashwin Chaugule wrote:
>>>>
>>>
>>> In general, you need to split this series so that initially few patches
>>> deal with all the existing Kconfig fix-ups and then introduce
>>> PCC/PSS/CPPC related stuffs. That would help me rebase and test _LPI
>>> support.
>>
>>
>> Hm. I tried to maintain bisectability and make it easier for you to
>> rebase LPI patchwork too. Let me see if I can revisit now that I'm
>> back from vacation. :)
>>
>
> How about you just drop any idle related changes so that I will handle
> that to keep it simple.

Unfortunately I can't skip idle changes completely since it is tightly
coupled with the acpi_processor driver as well.

Regards,
Ashwin.
