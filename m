Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC6C2652B2;
	Mon, 28 Sep 2026 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790600758; cv=none; b=dehRSJPbKsa31jx1pdN5w64RAvmymnnXxLVNyYHxlc7GAEUW08LVwZUGLdE6Wr+gFd5PRV9mWzTAiN/A4DkfJ92Dk1X0QeZ4wXND67lsvZitpHi9kVHcEKQzKOpJiadbHwzPAO0PhRNTICJqXMPeolfyISwEG68ieIOnM4A1K9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790600758; c=relaxed/simple;
	bh=d8bbmK/oVnzTlH8czD0/aDae1ZS2ChfTJ8lU6AwPsA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OibR9G53aU/naDcAi1T/acy5q+3pxMI5p1idrhrG83pdzpzedd/9je5mNHqcyAwf8iuhT/v5FUlr3W7l5MWBCLkY+OjmoAgUvg2wGQTLI0aj1M7+CriqNL5k+lg08NTjkyz8VOhAW5mjwzXjz44u2rX+iUSbvRKdf9uzfY6tcQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQmrwUZ9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQmrwUZ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3721F000FF;
	Mon, 28 Sep 2026 13:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790600756;
	bh=VkfJhLqjOEWNYqVuFiE1DZPDqUocEdeEndWTP6Qnuu8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GQmrwUZ9xYW1McRQ2inTkmfOE7Nddf8wRTe9Co580fjFyY6RPsER/8MpwhO5pLV2Y
	 0HpGQTKmUrMxFWyWg1gVYmg+mGXvmKUmYk76IwKTT5xV6yHxQk0/JqfChDl6I+0lnu
	 MWt3P6gOm3XLe6d9OMS8Z4JtCXTCZkA8yclyVySh19hnnmXxCg44QGWBDRrcK5lQ/h
	 I2AbtM8R+2dQdsZMpDCLFeXKKqWCIF79AwXoA7rvJjL82ZNWoxf9wcC8fikrecJqqh
	 TOvizhCVwemA9eP5+gS0BEsHAJPxF1itjvvp0zO/I/rJE+gLdRMFTQV0d/aiD3F7zz
	 u4hRo3Omt4bQg==
Message-ID: <a7099b6b-bd80-4fdd-8d03-ba95107a65e1@kernel.org>
Date: Mon, 28 Sep 2026 08:05:53 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpiolib: acpi: Ignore AC adapter wakeup on ASUS FA507
Content-Language: en-US
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Bartu Alev <bartualev@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <westeri@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260927014212.302743-1-bartualev@gmail.com>
 <20260928094156.GG106095@black.igk.intel.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260928094156.GG106095@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/28/26 04:41, Mika Westerberg wrote:
> Hi,
> 
> On Sun, Sep 27, 2026 at 04:42:12AM +0300, Bartu Alev wrote:
>> The ASUS TUF Gaming A15 FA507 wakes from s2idle whenever the AC
>> adapter is plugged in or unplugged.
>>
>> In the CPMGPIO0 SSDT, GPIO pin 23 (0x0017) is declared in the
>> \_SB.GPIO._AEI resource template as:
>>
>>      GpioInt (Edge, ActiveBoth, ExclusiveAndWake, PullNone, 0x0000,
>>               "\\_SB.GPIO", 0x00, ResourceConsumer, ,)
>>               { 0x0017 }
>>
>> and the corresponding \_SB.GPIO._EVT handler issues a device wake
>> notification for the AC adapter on pin 23 events:
>>
>>      Case (0x17)
>>      {
>>          Notify (\_SB.ACAD, 0x02) // Device Wake
>>          Sleep (0x05)
>>          Notify (\_SB.ACAD, 0x80) // Status Change
>>      }
>>
>> Both AC plug and unplug transitions therefore trigger a spurious
>> wakeup from s2idle. Add an ignore_wake quirk for this pin.
> 
> I would think this is by design like that.
> 
> What is the issue? You unplug the device from AC with lid closed and it
> wakes up? Userspace should put it back to sleep in these cases. In Windows
> and ChromeOS there is something called "dark resume" that deals with this
> but I'm not sure if generic distros have that yet.

I tend to agree with Mika.  If there is dedicated GPIO being triggered 
on AC adapter events with a Notify(0x02) it was OEM intended to wake the 
system.

FWIW I did have a design proposal to systemd for generic distros to add 
some behavior around dark resume.

https://github.com/systemd/systemd/issues/27077

I also had started a PR but didn't really garner interest:

https://github.com/systemd/systemd/pull/37142

As you have a system this can strongly benefit, feel free to take the 
torch on trying to develop a userland solution.
