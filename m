From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v3 3/3] PCC-test: Test driver to trigger PCC commands
Date: Wed, 27 Aug 2014 07:53:17 -0400
Message-ID: <CAJ5Y-eY+9CG8GGwEDguqbC91fSdFXf0_UXQgr--eQWU0qhhL+w@mail.gmail.com>
References: <1409081738-5602-1-git-send-email-ashwin.chaugule@linaro.org>
	<1409081738-5602-4-git-send-email-ashwin.chaugule@linaro.org>
	<20140827103015.GY17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:33019 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932079AbaH0LxT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Aug 2014 07:53:19 -0400
Received: by mail-we0-f171.google.com with SMTP id p10so99792wes.30
        for <linux-acpi@vger.kernel.org>; Wed, 27 Aug 2014 04:53:17 -0700 (PDT)
In-Reply-To: <20140827103015.GY17528@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux acpi <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 27 August 2014 06:30, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Aug 26, 2014 at 03:35:38PM -0400, Ashwin Chaugule wrote:
>
>> echo 2 > /proc/pcc_test [ to get channel base address ]
>>
>> echo 1 > /proc/pcc_test [ to trigger a PCC write ]
>>
>> echo 0 > /proc/pcc_test [ to trigger a PCC read ]
>
> You shouldn't be adding new files to /proc - debugfs is a better home
> for something like this.

True. Didnt intend to upstream this part anyway. I used this only to
test things for myself.

Thanks,
Ashwin
