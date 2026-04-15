Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2922C08BC;
	Wed, 15 Apr 2026 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776262971; cv=none; b=f1EK6G3hf2z2RY4gudGsCv9QWkGqgJE33XRZBKYj6kdHMwBX1cnWdsi6Y5mx0gcqVO2yLF5HS2NrcugoCLe6DlJuCiQ8nIehaJWEHenuM0dWsK1O+vkavbqsuIGJa0muc/2VCdYlwDLDa6uUjFUSUtzW8H/X+P5j7W24+tTADNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776262971; c=relaxed/simple;
	bh=lNzZik9VPWTUgwK14nf5iEIaHqnRFinwUz96N7sjVzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l4sH4CuaZB/MJmwr9FAFTFhIxKvPB90luPIY4k8I/AIAnTwQ3MwE5XMlkDRPQ5QxZ7Hv8UMjbxWq4ARvGIPYAbcL+V/Ar8RIGoLY0dBSzQfj1SGrvTkAc1StWN/8ZSyHhMJbqiD92topYQLPnZJ8nDG4UiBfXng9JTYSwdrCQa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcC+7ldh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcC+7ldh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20286C19424;
	Wed, 15 Apr 2026 14:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776262971;
	bh=lNzZik9VPWTUgwK14nf5iEIaHqnRFinwUz96N7sjVzY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VcC+7ldhKJgpd3sUmPUZaKymMc4w+CC++VWfdE7X1brjSzlCoC0jGJu677+8y+oMY
	 xftsR84alCr5BWTN/FqCHwreI1kcqH3gtEIzkCGio3HG+jOZq++hDoomWYFLW8vryd
	 hwqZbGfHYTm/2vlhzTp5pmVwrIySRAwFv6yhsfVipH5gUw7T8j3VGsr7l3LtDj8Vf3
	 fZjaI9Qz99UV2opRFcNshankgFi5Yz5F4wB77boeRax4WbbPJ1uZh8+yCcOV7HezU3
	 R+b7qAeCQ+60LDTiVkjXlSjUQKsvj6uT4K8qLKUtGBeoS3rDQXuVr1pNTVYqIgnY3T
	 gQm3/eIeQ+BTw==
Message-ID: <687f1e1a-39d0-4d69-bd22-6f4447afa65c@kernel.org>
Date: Wed, 15 Apr 2026 16:22:45 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Build failure in linux-next: implicit declaration of
 acpi_has_method
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org,
 lenb@kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 luiz.dentz@gmail.com, Ritesh Harjani <riteshh@linux.ibm.com>
References: <ad624e0d-cfd7-4521-ae33-c5c3287b4204@linux.ibm.com>
 <CAJZ5v0g4R+X+JXf1JB=3b_gqAdbyOv0drF242MCKkuNx1n4oow@mail.gmail.com>
 <755caa0d-c574-4c58-a274-ce8f6f04aa9c@linux.ibm.com>
 <CAJZ5v0j8957hN2CzEahNC=rdPsOZK=mCs07-Uhym-8QngMz2nQ@mail.gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <CAJZ5v0j8957hN2CzEahNC=rdPsOZK=mCs07-Uhym-8QngMz2nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 15/04/2026 à 16:13, Rafael J. Wysocki a écrit :
> On Wed, Apr 15, 2026 at 10:35 AM Venkat Rao Bagalkote
> <venkat88@linux.ibm.com> wrote:
>>
>>
>> On 15/04/26 12:50 pm, Rafael J. Wysocki wrote:
>>> On Wed, Apr 15, 2026 at 9:16 AM Venkat Rao Bagalkote
>>> <venkat88@linux.ibm.com> wrote:
>>>> Greetings!!!
>>>>
>>>> IBM CI has reported a build failure on linux-next repo.
>>>>
>>>> Failures:
>>>>
>>>> drivers/bluetooth/btintel_pcie.c: In function
>>>> ‘btintel_pcie_acpi_reset_method’:
> 
> What kernel is this?

linux-next, https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next

$ git grep btintel_pcie_acpi_reset_method next-20260415
next-20260415:drivers/bluetooth/btintel_pcie.c:static int 
btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data)
next-20260415:drivers/bluetooth/btintel_pcie.c: ret = 
btintel_pcie_acpi_reset_method(data);

commit 912a499a7955 ("Bluetooth: btintel_pcie: Support Product level reset")

> 
> I cannot find the function above in the mainline.
> 
>>>> drivers/bluetooth/btintel_pcie.c:2309:14: error: implicit declaration of
>>>> function ‘acpi_has_method’; did you mean ‘acpi_has_watchdog’?
>>>> [-Werror=implicit-function-declaration]
>>>>     2309 |         if (!acpi_has_method(handle, "_PRR")) {
>>>>          |              ^~~~~~~~~~~~~~~
>>>>          |              acpi_has_watchdog
>>>>
>>>>
>>>> The function acpi_has_method() lacks a stub definition in
>>>> include/linux/acpi.h
>>>> for the !CONFIG_ACPI case, unlike other ACPI utility functions.
>>> Code that calls acpi_has_method() clearly depends on ACPI though, so
>>> building it in the !CONFIG_ACPI case is questionable.
>>
>>
>> Thank you so much for the review and explanation!!
>>
>> Adding the stub, would just hide the real issue. I guess, proper fix is
>> to add the ACPI dependency in Kconfig.
>>
>>
>>
>> # git diff
>> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
>> index c5d45cf91f88..fc1b37044a9b 100644
>> --- a/drivers/bluetooth/Kconfig
>> +++ b/drivers/bluetooth/Kconfig
>> @@ -502,7 +502,7 @@ config BT_NXPUART
>>
>>    config BT_INTEL_PCIE
>>           tristate "Intel HCI PCIe driver"
>> -       depends on PCI
>> +       depends on PCI && ACPI
>>           select BT_INTEL
>>           select FW_LOADER
>>           help
>>
>>
>> Can you please confirm, if this the right approach before I submit a
>> formal patch.
> 
> I'm not sure about that.  You need to talk to the driver maintainer.
> 
>> Thank you again for your patience and guidance.
> 
> You're welcome.

