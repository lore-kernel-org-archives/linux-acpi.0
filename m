Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB76828C864
	for <linux-acpi@vger.kernel.org>; Fri,  6 Mar 2026 12:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772800980; cv=none; b=R1KX51425F3maPXEubhECjYWzq18DBg60smVrnVN7vTfeZprKiOBD0vK9NRJOm9F5XdRJjxwgIKYcITDg+z1q4TtgPZSomJAGPXc/U1H8Y2/bQQaP8gDN8MPskQPNPj9cu0SK6fwbOpeDbNeU9JfRBUxMjBE5tZrSUEjw0chvE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772800980; c=relaxed/simple;
	bh=gSmTssy6CNAAgTZVKgwAcfCJxvMXUcM2Ff7OKTcAWos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l363yODH8X8wtPVhb6b8fPD5a/ER+ElN3GuLT0zqdosGDQyGVPwrOXVZDWgZ1tbkAeuH5bY2v4+u0uEm3l14plqScCetPF2H8bjbf+JAhYnDJWOugW6YonTNKlWriF6bcLF1P45k/ArhJ9Uzqm3B/yBGqTsFywKgTzzD84ZOs5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8tp9lUU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8tp9lUU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E647DC4CEF7;
	Fri,  6 Mar 2026 12:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772800980;
	bh=gSmTssy6CNAAgTZVKgwAcfCJxvMXUcM2Ff7OKTcAWos=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l8tp9lUU8gK29/LPrmM/X3xbs/Q/kG0p9AkRk6597v/jWPh9DFc6jtRJbN3RKvvXv
	 qOFN4G+rOzpLisfr6HzzhwNIJL+dwKGf11RDCFLBKmDepUXRM8+1Pwrh7Ga1vamaoW
	 gYaIrlz3XhxIdMSSGS+WSycxKTLiEdMJ16PgGFTI2yiPbIBJYAWJJNi9U0f7r4HQ5t
	 1OsZkjR7SzIOgqijY/2DLLnUq3QY5dBMFGaZWZnKdmDXdNTphpLDGHFL1tPlLABrRE
	 eY+5zO5Jp1qgAYMf5rD3+/QEgQOzDCrJAHT2TABqvCeVwRHM5i7RukypKsZJv3LNUU
	 pQ2IS1pbNs0Pg==
Message-ID: <23a0f5f8-11a6-4f41-9e32-19cb08110bc6@kernel.org>
Date: Fri, 6 Mar 2026 06:42:58 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: video: Don't allow MFD devices to probe
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: mario.limonciello@amd.com, W_Armin@gmx.de,
 Pratap Nirujogi <pnirujog@amd.com>, rafael.j.wysocki@intel.com,
 linux-acpi@vger.kernel.org
References: <20260306025144.604062-1-superm1@kernel.org>
 <CAJZ5v0hVm8Ceut_H74LOU7bHuzWCJERAtQ44q5VT4FY9-BwsNw@mail.gmail.com>
 <CAJZ5v0ihj+DARV3P52LMOn9U+bqwVW=2fQ_QtDsjeVZkR9hFmQ@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0ihj+DARV3P52LMOn9U+bqwVW=2fQ_QtDsjeVZkR9hFmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/6/26 6:17 AM, Rafael J. Wysocki wrote:
> On Fri, Mar 6, 2026 at 11:50 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Fri, Mar 6, 2026 at 3:51 AM Mario Limonciello (AMD)
>> <superm1@kernel.org> wrote:
>>>
>>> After ACPI video was converted into a platform device in
>>> commit 02c057ddefef5 ("ACPI: video: Convert the driver to a platform one")
>>> other devices that are MFD children of LNXVIDEO are being probed.
>>> This isn't intended.
>>>
>>> During probe detect MFD cells and reject them.
>>>
>>> Fixes: 02c057ddefef5 ("ACPI: video: Convert the driver to a platform one")
>>> Reported-by: Pratap Nirujogi <pnirujog@amd.com>
>>> Closes: https://lore.kernel.org/regressions/007e3390-6b2b-457e-83c7-c794c5952018@amd.com/
>>
>> The link is broken, so I can't see what is really happening, but my
>> guess is that MFD devices are created under the video bus device and
>> they get the same device ID (confusingly enough).

Hmm, I just double checked the link and it worked for me.

But you are on the To: list of that thread also.

>>
>>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>>> ---
>>>   drivers/acpi/acpi_video.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
>>> index 3fa28f1abca38..2cb526775ac47 100644
>>> --- a/drivers/acpi/acpi_video.c
>>> +++ b/drivers/acpi/acpi_video.c
>>> @@ -14,6 +14,7 @@
>>>   #include <linux/init.h>
>>>   #include <linux/types.h>
>>>   #include <linux/list.h>
>>> +#include <linux/mfd/core.h>
>>>   #include <linux/mutex.h>
>>>   #include <linux/input.h>
>>>   #include <linux/backlight.h>
>>> @@ -1988,6 +1989,9 @@ static int acpi_video_bus_probe(struct platform_device *pdev)
>>>          int error;
>>>          acpi_status status;
>>>
>>> +       if (mfd_get_cell(pdev))
>>> +               return -ENODEV;
>>
>> If the above is the case, I'd prefer this check
>>
>>          if (!device->pnp.type.backlight)
>>
>> which should also work, but is more general.
> 
> Well, this will not work if the ACPI companion is shared between
> multiple devices.
> 
> However, adding an MFD check here is a "works for me" change rather.
> 
> I think what needs to be done is to extend the duplication check (see
> my patch from yesterday at
> https://lore.kernel.org/linux-acpi/5663583.Sb9uPGUboI@rafael.j.wysocki/)
> to detect the cases when another platform device (not necessarily a
> child of the same parent) sharing the same ACPI companion is probed.
> 

Generally makes sense to me.  But in this particular case it shouldn't 
be a FW_BUG.

Do you want to roll this in your series?  Or would you prefer one of us 
to send a follow up patch?

