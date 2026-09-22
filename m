Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1ED4A6893;
	Tue, 22 Sep 2026 19:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106012; cv=none; b=MHzkEZmOjKZzIOq3uqgGkVc9jo+vL9MT9b0pm/oKughHyry5SPajLz3UhFCxwE8FV0LmbOqhsrhOxWOhgQ5G8i9enWHpxwsxiOnD/i9yQwfBcC0qkbQiaVAT4R8+LXFdekRZttebFSdLE/bj3wxkDooY51q+qJlQ0vHu/2F9xtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106012; c=relaxed/simple;
	bh=kI9wzxnTnd8LDl6IJ7n+XvQ+xH2oAzp04EfRawdJOt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vFNMAcMy509hTdZWGpWEQrrxZlC6JcOty3h/Ff3cTnF0KSXN/6Ul3yYcgKK5QGJF1kfVVb2Ke7wOqISVw4vW/LDRf1vvNfjTHN4r+V8Gmeku8WyYhTZ0fOmYCQriKZOtd5QGxVKWH3qsPCtGfW/bRYW3sRssSkJJQuQwmeScX94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=f5MExzBY; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="f5MExzBY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790106005; x=1790710805; i=w_armin@gmx.de;
	bh=x4lwUrK2u8zW5UX36D2xKHU48N0ZJHlWWyo5Cl9IZY4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=f5MExzBYvnQKyk9x1RGK9aP+MNLBE5qZqVHQZ/T/slGsFM2crCx/tkHEWXqQR3zU
	 ldcj1JygpYJquyVDKI7pDP+BY0EbWGmRivYVzVfIzNTDEwYdhucitOVXoU/sIdOrL
	 E/GV9PAs63p3pcXoOsTNyCiO/YqAFEQuFrSmoYYL7S21E3tRzDTpj5slykLGEoCr5
	 W1XSuyURzjVQtznYuc/70Udo9lWKEtIglI7a9wvXCtKFOqP+LSyFIb60gulMqA1Br
	 Ppc+U+Sox75nAWbPk1NC+kL41xpORNLJTYeg40WYO7aTZPwrIPDdsOGzs+YQCGH7m
	 3UafCUgT9Vdhi4CRDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McpNo-1wZDZ02oiY-00cBJF; Tue, 22
 Sep 2026 21:40:05 +0200
Message-ID: <50986455-fb18-4c92-9c3b-74d625f3f6fa@gmx.de>
Date: Tue, 22 Sep 2026 21:40:00 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: use IS_ENABLED() to simplify built-in or module
 checks
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
 Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
Cc: "open list:ACPI" <linux-acpi@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260921081411.4819-1-lalitshankarch@gmail.com>
 <CAJZ5v0gvYn3ga6vL3BYt+5GFRheg_sjF8AX_HBXfHaLv+tPGKA@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAJZ5v0gvYn3ga6vL3BYt+5GFRheg_sjF8AX_HBXfHaLv+tPGKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3VMUpDUnFgTl0hvlhI2S0yVak7NqCJeL7U7dfkdRUqnE9v6Ap9i
 4U6pFqGijtQ91V5FVpq4QOMYtvw/Jx2hAxDmiLRgones3Yuw3WURTxgTCrJbuQNig2uytON
 yGcnJh11/KmdbMNFr/m5L2qPNmrlUyCtuXoD9q5cUniNWNd3V2J05J+pS0bJVXuEv6AemzV
 s5V8XNRbThRxkr56kwQjQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yr+4D7HIiBc=;1SWyLv9u97FODLO9RZtHDBpkl30
 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

Am 22.09.26 um 18:43 schrieb Rafael J. Wysocki (Intel):

> +Armin
>
> On Mon, Sep 21, 2026 at 10:14=E2=80=AFAM Lalit Shankar Chowdhury
> <lalitshankarch@gmail.com> wrote:
>> Replace the remaining built-in/module check for CONFIG_ACPI_WMI
>> with IS_ENABLED() macro.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

>> Signed-off-by: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
>> ---
>>   include/linux/acpi.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index ddacac812094..b590f520dc57 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -434,7 +434,7 @@ extern acpi_handle ec_get_handle(void);
>>
>>   extern bool acpi_is_pnp_device(struct acpi_device *);
>>
>> -#if defined(CONFIG_ACPI_WMI) || defined(CONFIG_ACPI_WMI_MODULE)
>> +#if IS_ENABLED(CONFIG_ACPI_WMI)
>>
>>   typedef void (*wmi_notify_handler) (union acpi_object *data, void *co=
ntext);
>>
>> --
>> 2.53.0
>>
>>
