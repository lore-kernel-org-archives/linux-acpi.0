Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D85341930C;
	Mon, 27 Jul 2026 13:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159588; cv=none; b=IamiLRCIWt1nd/gztBgF4vWruke8j8cnx/2G7gvFJNEhbCT/iQuTL7zGVprMNEoeU+/nhtuwCwym90Tr76Dqj7xNLygg03/SMwYzethijyhJTb/pOLDe9v8/P1Y9elYmf24tRKeVwpZUBNoZ+/xrSmS/iXWH6fXCB4xQaEl5+3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159588; c=relaxed/simple;
	bh=xETUF9IIL3+ftMMTTgtEotkAfkaiZAvCSchoDQclums=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L+VlZGxwvS5ASg+14dFkRda1BPNXTz8pFXQfzeSkQSrhsQhTFqaviNACh3Ee7Pwv1o5Gn93NlaBItM8fW2n4ANrv2+qcS4DH+1f1RaAb1HmdMBEOE8Th+d/KPzuXhU1ecxkwjcUb/3g5VAbVxKtjtTNLdPqkBcHA1b51jZVQgWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Jxlhdd9g; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Jxlhdd9g"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA9781596;
	Mon, 27 Jul 2026 06:39:41 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E7823F763;
	Mon, 27 Jul 2026 06:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785159585; bh=xETUF9IIL3+ftMMTTgtEotkAfkaiZAvCSchoDQclums=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Jxlhdd9gh7eOXt/XnMupvdkOl7MwBMD8b3edsTMwEOXJpgDteef5HFwLdyotaMnmm
	 AS1IiW9NSDVK7hh6CmTJwswsaeLvivnaUMhb5s83GSSWR3lz2I7bJy5U8NGCjsbk0G
	 34KICvzxy2dXaQj7aZzKOvXW6SQ0h+djpzxWzUac=
Message-ID: <b1d346ad-2bee-4f0d-9ac2-08d4c1bde94e@arm.com>
Date: Mon, 27 Jul 2026 15:39:40 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/10] arm_mpam: detect and enable MPAM-Fb PCC support
To: Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu
 <fenghuay@nvidia.com>, Jonathan Cameron <jic23@kernel.org>,
 Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
 Trilok Soni <tsoni@quicinc.com>, Srinivas Ramana <sramana@qti.qualcomm.com>,
 Niyas Sait <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260723155454.1760823-1-andre.przywara@arm.com>
 <20260723155454.1760823-11-andre.przywara@arm.com>
 <20260724-finicky-knowing-foxhound-df1e56@sudeepholla>
 <amdTr8Sxw9024CN7@lpieralisi>
 <20260727-knowing-bittern-of-tempest-6deb54@sudeepholla>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260727-knowing-bittern-of-tempest-6deb54@sudeepholla>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 7/27/26 15:20, Sudeep Holla wrote:
> On Mon, Jul 27, 2026 at 02:48:47PM +0200, Lorenzo Pieralisi wrote:
>> On Fri, Jul 24, 2026 at 11:18:32AM +0100, Sudeep Holla wrote:
>>> On Thu, Jul 23, 2026 at 05:54:54PM +0200, Andre Przywara wrote:
>>>> The Arm MPAM-Fb specification [1] describes a protocol to access MSC
>>>> registers through a firmware interface. This requires a shared memory
>>>> region to hold the message, and a mailbox to trigger the access.
>>>> For ACPI this is wrapped as a PCC channel, described using existing
>>>> ACPI abstractions.
>>>>
>>>> Add code to parse those PCC table descriptions associated with an MSC,
>>>> and store the parsed information in the MSC struct.
>>>> There can be multiple PCC channels, and each channel can serve multiple
>>>> MSCs, so we need to keep track of the channel usage, using a list and
>>>> a refcount.
>>>> This will be used by the MPAM-Fb access wrapper code.
>>>>
>>>> [1] https://developer.arm.com/documentation/den0144/latest
>>>>
>>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>>> ---
>>>>   drivers/acpi/arm64/mpam.c      |   6 +-
>>>>   drivers/resctrl/mpam_devices.c | 127 ++++++++++++++++++++++++++++++++-
>>>>   2 files changed, 129 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
>>>> index 84963a20c3e7..ca9b8754ae5f 100644
>>>> --- a/drivers/acpi/arm64/mpam.c
>>>> +++ b/drivers/acpi/arm64/mpam.c
>>>> @@ -220,8 +220,8 @@ static struct platform_device * __init acpi_mpam_parse_msc(struct acpi_mpam_msc_
>>>>   	struct platform_device *pdev __free(platform_device_put) =
>>>>   		platform_device_alloc("mpam_msc", tbl_msc->identifier);
>>>
>>> Looks like tbl_msc->identifier is getting stashed as pdev->id...
>>>
>>>
>>>>   	int next_res = 0, next_prop = 0, err;
>>>> -	/* pcc, nrdy, affinity and a sentinel */
>>>> -	struct property_entry props[4] = { 0 };
>>>> +	/* pcc, msc-id, nrdy, affinity and a sentinel */
>>>> +	struct property_entry props[5] = { 0 };
>>>>   	/* mmio, 2xirq, no sentinel. */
>>>>   	struct resource res[3] = { 0 };
>>>>   	struct acpi_device *companion;
>>>> @@ -256,6 +256,8 @@ static struct platform_device * __init acpi_mpam_parse_msc(struct acpi_mpam_msc_
>>>>   	} else if (iface == MPAM_IFACE_PCC) {
>>>>   		props[next_prop++] = PROPERTY_ENTRY_U32("pcc-channel",
>>>>   							tbl_msc->base_address);
>>>> +		props[next_prop++] = PROPERTY_ENTRY_U32("msc-id",
>>>> +							tbl_msc->identifier);
>>>
>>> Why is this needed then as you can fetch it as pdev->id ?
>>
>> I suppose it is to have properties parity between OF and ACPI without
>> having to change the driver property parsing path.

I could claim: "what he said ^^^^", but in truth I simply missed that 
the identifier is also the platform device ID.

> Yes, that was my initial thought as well. However, after looking into it
> further, I could not find any device tree bindings in the upstream tree.
> I am therefore unsure whether MPAM is supported on DT platforms.

No, at the moment MPAM is ACPI only. As you mention, DT bindings have 
been proposed at some point, but apparently there was no real user, so 
this effort was shelved until someone complains, IIUC.

> The use of these device properties appears to have been based on DT bindings
> that may never have been upstreamed. As [1] suggests, the bindings were
> dropped before the initial merge.

Yes, indeed these names already cater for the proposed DT bindings, 
short of inventing some new names, I guess.  But I was wondering how 
much of a problem it is to rename them, for ACPI those names are 
internal only, right? So any potentially deviating DT property name 
would just be a patch to rename the property name here and in the MPAM 
driver, right?

> Although we could rename these properties later to align with any DT bindings
> that are introduced, I think it would be preferable to avoid adding new
> properties unless they are strictly necessary.

I don't really mind, so can do either way, but the MSC identifier is 
clearly defined in the MPAM-Fb protocol, and connected to the number 
used in the ACPI table, so kind of assuming that the platform device ID 
(a more Linux internal thing?) is the same, is a bit fragile.

But as mentioned: whatever you prefer, it looks like we can change it 
anytime.

Thanks,
Andre.

