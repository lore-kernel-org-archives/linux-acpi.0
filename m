Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F65382288
	for <linux-acpi@vger.kernel.org>; Tue, 12 May 2026 21:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778621797; cv=none; b=lZJtf5Y48uJapFnkZQDBDoPMTInoqMLDeBbgnyiszE703ZrTltGYd7fJWt8GobS22NIZ0xAtHMi/6OQw0sPNSz0Z2Ge6L6Wl3SJBxSXT24ZsU6SeOj7blbg4tJb+wQwKhMDbiXPu5D4N4dmDZ/FkQA4ULHnOAgTCiVQlPKXCJgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778621797; c=relaxed/simple;
	bh=0vAP28fh1vXeuE2/nJrsMQ+1H1ysW38QAL3eoe9zj44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ARQH8n62t4NfGuM4P+qbujaUwmgJ31tzKVYWKpv4VNx3c0mCB4AKdX8TijlqSJhsxci/y5ZE1M360Qb05988zZntuJJiO+wL8bys+a++0q9I7k51vz86xJ3lDBv1avnsKqyPesPaeJ3hqcpD5ZMvFTiyoDHMcw2oEVuQdGYQq1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipperpa.ws; spf=pass smtp.mailfrom=flipperpa.ws; dkim=pass (2048-bit key) header.d=flipperpa.ws header.i=@flipperpa.ws header.b=5G8IDFcC; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipperpa.ws
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipperpa.ws
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipperpa.ws header.i=@flipperpa.ws header.b="5G8IDFcC"
Message-ID: <1453fe0d-230c-4655-93ad-3f685b8ab713@flipperpa.ws>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flipperpa.ws;
	s=key1; t=1778621792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FreEy+Htd1nD+3U09B1yurSwA28R+OhBDx0gjRFjvC0=;
	b=5G8IDFcCrb8yzddOb8HveaXflZMc6dpbiNumgTkuKGTGk1LSKsL+Rku6+2X1+Zore/pCOK
	3KORjC3Ouw8t17XUm57/isSQBuEKCtvPLrKXykcEIAzH0VB+r/iqSZpIkHpV4HWyNuI4sM
	y9omTq9SLGJNGJ/GLfz+BJ3b0k1C4O2V0lV0Q2+Gf4aEmOtNpWuKX5z05ACrQliKqjt52f
	TrxnJOQWb8TLsk7kOFxezLDo6c2YVgoAgBhVJ2TBqMEbX3frEaexDQZkuh9iWBnMpfMV3+
	QAHvEtjucSPiCr7CY0cpobCY7YENqk+UFi76oSiOY3vGGw4CZvuvG5fUbuHijQ==
Date: Tue, 12 May 2026 23:36:26 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] i2c: acpi: Add ELAN0678 to
 i2c_acpi_force_100khz_device_ids
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Niels Franke <nielsfranke@gmail.com>
Cc: westeri@kernel.org, linux-i2c@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260418053719.15766-1-nielsfranke@gmail.com>
 <afhkiGREdd50vYNN@ninjato>
Content-Language: en-US, en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Odoben <odoben@flipperpa.ws>
In-Reply-To: <afhkiGREdd50vYNN@ninjato>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,

I have what appears to be the same issue on a ThinkPad X13 Gen 2 with 
Intel i5-1145G7, but with ACPI HID ELAN0676 instead of ELAN0678.

The touchpad is:

ELAN0676:00 04F3:3195 Touchpad

libinput reports:

Id: i2c:04f3:3195

dmesg shows:

i2c_designware.0 -> i2c-ELAN0676:00 -> hid-multitouch

The ACPI table contains:

Package (0x06)
{
0x04F3,
0x3195,
0x15,
One,
One,
"ELAN0676"
}

and the surrounding firmware logic maps the fifth field to speed:

Local5 == Zero -> SPED = 0x000186A0 = 100 kHz
Local5 == One -> SPED = 0x00061A80 = 400 kHz

So this machine also configures the 04F3:3195 ELAN touchpad at 400 
kHz. The symptom is very frequent rubbery/sluggish pointer movement, 
consistent with the excessive smoothing described for ELAN0678.

Would it make sense to include ELAN0676 in the 
same i2c_acpi_force_100khz_device_ids quirk?

Thanks,
Odoben

On 2026-05-04 11:19, Wolfram Sang wrote:
> On Sat, Apr 18, 2026 at 07:37:19AM +0200, Niels Franke wrote:
>> The ELAN0678 touchpad (04F3:3195) found in the Lenovo ThinkPad X13
>> exhibits excessive smoothing when the I2C bus runs at 400KHz, making
>> the touchpad feel sluggish when plugged into AC power. This is the
>> same issue previously fixed for ELAN06FA.
>>
>> The device's ACPI table (Lenovo TP-R22) specifies 0x00061A80 (400KHz)
>> for the I2cSerialBusV2 descriptor. Forcing the bus to 100KHz eliminates
>> the sluggish behavior.
>>
>> Signed-off-by: Niels Franke <nielsfranke@gmail.com>
> Kept the sorting (alphanumeric) and applied to for-current, thanks!
>
