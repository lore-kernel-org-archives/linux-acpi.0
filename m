Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5204825BD;
	Wed,  9 Sep 2026 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788993610; cv=none; b=LKoyeEZoaRrotC/7LdG3Ra6yLHa/qg62gDEatgb8aAabHODs1MAEBelu9S3bHgFKSCybKjb2PLST6xg/Onof3amQXoaMh29hJT0mFOLKWrnnGB3r/Eor+zBwZqWt3Kvjh6vMO/j0tOTRDpg60E5EY5wS5GH2thQKrRVz4qR980w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788993610; c=relaxed/simple;
	bh=QlAoEZAKcUkbHSGoc2RVIQ2KKQlJTlsJMoh5x/E+DbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kaFT+SjyBnfnYHN7BzIdWLuA4Oz26Ge59vYT8PEHvT9gwONYWlxGVVBohWeOE0jJ1RwBOkSe56AaoGDJt4I+vT7aru3kN47LSk8Rh+WIoLWrqjAmkRsy1dDC3g3Y7RGBNGjtUmABfOjXJJ6mq/gL42ynQOzkZQqbgP4qv5qGV/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=L3Qzw9zd; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="L3Qzw9zd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788993596; x=1789598396; i=w_armin@gmx.de;
	bh=QlAoEZAKcUkbHSGoc2RVIQ2KKQlJTlsJMoh5x/E+DbA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=L3Qzw9zdwCCYVZqZbNmW3VjVcBFIbSP2hCHHKonjWzqYL2JgJgXDPy2ig+Le/O0X
	 Diwstul1SFetpLgZUhzF5fk9ZgJs9QF0Z4PpY4NBXDzaXgof8quWsZwXDdhg62Xz6
	 De1bgQuFHaFkQ3ynxhp8I8GYYCN96rAZN6K3nvyUxS2C00GW1ZgrvkHpiXVwX1HJn
	 BnXMFvzxrPydLshq43OiGUwJN0D/+RLgDvbqoLoxzI+PtL2Zspg5nzXnaBnzc/LM+
	 ABmipcUiO/SXwDas6HKdSKAgKexYjpX/B+Z5/3JVYmMF5JqDauYR0Mo7wApf6EDww
	 jeseZFtL0PIdxIrPmQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0G1d-1wsQe30oKt-00vxW3; Thu, 10
 Sep 2026 00:39:56 +0200
Message-ID: <d73d4c8c-f80c-428a-823a-f47cb194f0bb@gmx.de>
Date: Thu, 10 Sep 2026 00:39:55 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: battery: Fix bogus cycle count values on systems
 without _BIX
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, wse@tuxedocomputers.com
References: <20260806233817.622975-1-W_Armin@gmx.de>
 <f2f17b0d-22a1-4a57-895b-318bb50456f3@gmx.de>
 <CAJZ5v0j4EAZnrEA3Z7EKX5fdfhTWYbb=f0rOPnLsz5zaEMguGQ@mail.gmail.com>
 <dec5d721-8bc5-4be3-81cf-16b63829cbf0@gmx.de>
 <CAJZ5v0j67n7N-Eogik3njKV92E=FyW33bTvg6FnVfiT_AqwXug@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAJZ5v0j67n7N-Eogik3njKV92E=FyW33bTvg6FnVfiT_AqwXug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ers/iu7q1QkG21AnKcSgm/Wl3w1c/bVEwxPcEUHmmyTf0yZ/Emj
 yUnHZsM3dfq5FrmAhj9OC2ZQy7/IIbqqEtj0ZR6egNr8/hLePDhKLCogx37rg+uRdg3wJDO
 BdQb6rEfX04l7UFbDgxzk9NGJjdSGhbFaL0/SW+qRaggbIA+E8RjuJZURKRgphuWwusr//j
 h7As0OgoYh2gJfVNtB4Dw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:INLhUkN7qiI=;W/p5nfddXrUbEpZTEGjHNYRB/2L
 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
 pewCunqYJfcVjAdwGJairU1+dF9mDsrqwbA==

Am 09.09.26 um 16:27 schrieb Rafael J. Wysocki (Intel):

> On Tue, Sep 1, 2026 at 10:18=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrot=
e:
>> Am 01.09.26 um 22:16 schrieb Rafael J. Wysocki (Intel):
>>
>>> On Tue, Sep 1, 2026 at 10:11=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wr=
ote:
>>>> Am 07.08.26 um 01:38 schrieb Armin Wolf:
>>>>
>>>>> Devices supporting only the legacy _BIF ACPI control method cannot
>>>>> know the cycle count of the associated battery, so cycle_count alway=
s
>>>>> remains 0. Claiming support for POWER_SUPPLY_PROP_CYCLE_COUNT on
>>>>> such devices can thus mislead userspace applications and prevents
>>>>> power supply extensions from supplying correct cycle count values.
>>>>>
>>>>> Fix this by not claiming support for POWER_SUPPLY_PROP_CYCLE_COUNT
>>>>> on devices without _BIX.
>>>> Any thoughts on this? I tested it on my device, and so far everything=
 seems
>>>> to work flawlessly.
>>> It looks good overall, but it is quite substantial, which is why it
>>> didn't make it into 7.3-rc1.
>>>
>>> I'm planning to apply it for 7.4.
>> Alright, that works for me.
> And so applied.
>
> Sashiko has a comment on the _BIX failing case:
>
> https://sashiko.dev/#/patchset/20260806233817.622975-1-W_Armin%40gmx.de
>
> but this can be addressed on top of the current patch IMV.
>
> If you think that it's worth addressing, please send a follow-up one for=
 that.
>
> Thanks!

Thank you :)

I do not think that Sashiko is right in this case, as failures inside _BIX
should _normally_ only be temporary. So i think the current strategy of te=
mporally
falling-back to _BIF if _BIX fails is fine.

Thanks,
Armin Wolf

