Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE783E63B2
	for <linux-acpi@vger.kernel.org>; Fri, 31 Jul 2026 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785508472; cv=none; b=ZkKMO+snhpnFK5b149dsGplhYH/hwN2mc+XxDPiz49xaUNu0p3l8V/qXysUN7B83ChOfOgMTBf0ERTJM7V+KZTYpj9l+zAUFdCRdAWk16ocSeb8xMf+Gr+pUwS0LF37DaFRznaWw3ivOctJUVluNpZDW0aJ1ju9CDT3RQltNBNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785508472; c=relaxed/simple;
	bh=Lu9hJWM5FnkOlRaWVWjIRI/RDVl5jUP9oaZX7fCXZhY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=chsduC0taomRdyJ8rid1ksCbgnwSEZfDZc7OuWjulhibSMHzIyr+95XLWUGmYgo/sGYd7r48Tp5uncOusEcGWzA1f4eRkWgsQIzhrmAoLOZdOPzN1ewTq4q4yhg9HB9Hp4oIDmHpBiMoiOFwp6b7m9T5Bqp24xgch81L1DrNME0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+ByasTO; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+ByasTO"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39c62764c7cso15961341fa.0
        for <linux-acpi@vger.kernel.org>; Fri, 31 Jul 2026 07:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785508469; x=1786113269; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cEYf8XWt7uIQNYBnvw5HrwZeU0df85IjOKBJMRJ7Wzw=;
        b=X+ByasTObEzX5fSUAw2i3Y9aVdSdmy4R+Is2Uj0h1R8ZFdcMCEK7ijp3rGrmiO7ZvM
         qW+rIj6ajAqShR3qi9EFIDSOJmBLE4Jtpns8tCVzTH+X9HELyNdtLhNdYA+kv00ANwCU
         KLNnFhObk0PkcFMTw2OrrXFbaTNYyieiNeWja7zXH5qmvZuyHFuDM1IaeELjZP66r0IL
         TRrdBMWEprra6URU2F60Y7I6YYFQ3K0VfwBCK/6oTMz6yswd7KK/ULIJ4qYbwIklJGZx
         r1kHQ5SJZFtM1CludfBx5QwdID//sAmOcKI6/1Jbtz3qK3X5+E6+ofidePRNLk/FhC1i
         yqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785508469; x=1786113269;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cEYf8XWt7uIQNYBnvw5HrwZeU0df85IjOKBJMRJ7Wzw=;
        b=fQQzoKqM8YthfpN+Bkxh0H3d9Ua/J9gtGf2UMLtQE2YTgKu3xp7CmcYIDzHbtFQK5D
         VhgL5H+OqUfMIClooNieKyBnbCSYAAG6OIAwhP7Q0zJmOn96W4Cn51wPGanN3vSGuNdU
         xJXqAVVskL+/KXEAjAIatr9eDDjDTmQ9T647rsox3HJBLDk1fvF7Q5ouNWh7+X9zfu46
         ttnpggkw2pfDh3JB429zuuIrBmQ5j3RaFVVKwwL2QZdBYe12ZlgLfQy0aefXlCxqmkZw
         s85U8c2WDKVoBSZ70MRFhr6CjMdkc0KZ2qYXDErnK6M3OG8FS5yDsDBIxj6ttZ/yq9f6
         7F5g==
X-Gm-Message-State: AOJu0YzY1AEmfkjrTXoGl/sr8ax13WpOzdWkEWw/outyb03aftbhhmqS
	JEaT6wDybdC+3vr7sp8cCHAR/csV8LRMcSMSOBIgupWJQZXUSjBqyAd0
X-Gm-Gg: AR+sD13UFFHGpnl3GrRcLNZKUXptWGtO3Z2u0uSiCjZwYU1F1pEuKaNOJoDmWrsqnfi
	ynMvnHCkGE8q0/y7F7EWr8+Nrla70PnMLqoZdv8iCmhzdnb6JTkzSPvrdp3kP/HBFWYhAHWOJwP
	xxkKiEUmmSNAiXo0hjvObokLW9Hx1yltie0MPrWhrvuCdwf08iLOBufmWeCBRyKdmz89EW/RteD
	06kxQDUaA8zYH+Uy0Tj1Ewr6Q2GK8yfi3R7HjXS8tFr9ZiIkTvI8x/pA4UQe5hg9P07wzk8yiP4
	negthwLUHtkFu+dEEUMucBoQvKzuUu2dV4geaqKhP/xfsQUdv90Jg/LTybrsCq1YuEhko7XTGML
	0ZA9IDVypd64gpVV744n1/K+GLxmYsAWK3lcbHpJC4x7YLoAo6ODxRkQ5j2q/KaDAGdAEbNvRNO
	NJzrnOIDI3ZN4Aqqcxl140uDZfkpGS2Q3MrGr9aYyWh2/4gibinZ9LktXXXF8DD8SWuGYvhMV3
X-Received: by 2002:a05:6512:3d03:b0:5ae:acbd:439c with SMTP id 2adb3069b0e04-5b2e2422d22mr454761e87.23.1785508468894;
        Fri, 31 Jul 2026 07:34:28 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2e2441db4sm332262e87.45.2026.07.31.07.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 07:34:28 -0700 (PDT)
Message-ID: <7855a0c3-29ac-4842-8e07-352fcb535a63@gmail.com>
Date: Fri, 31 Jul 2026 16:34:23 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/16] dt-bindings: usb: mediatek,mtk-xhci: Switch to
 ports for USB connections
From: Konrad Dybcio <konradybcio@gmail.com>
To: Chen-Yu Tsai <wenst@chromium.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
 linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Manivannan Sadhasivam <mani@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260721065413.2306137-1-wenst@chromium.org>
 <20260721065413.2306137-12-wenst@chromium.org>
 <38397324-56b0-41e9-960f-152a16ce8b12@gmail.com>
Content-Language: en-US
In-Reply-To: <38397324-56b0-41e9-960f-152a16ce8b12@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/31/26 4:33 PM, Konrad Dybcio wrote:
> On 7/21/26 8:54 AM, Chen-Yu Tsai wrote:
>> This reverts commit 454a1e3cd36c113341d7b71e8e691c6e47ab4a8a.
>>
>> MediaTek's XHCI implementation supports both USB 2.0 High Speed (HS)
>> and USB 3.x Super Speed (SS). The block can also be synthesized with
>> either HS-only capability or HS+SS capability. The SSUSB controller
>> handles the device or gadget mode. Saying that SSUSB handles the HS
>> portion is wrong.
> 
> [...]
> 
>> +  ports:
>> +    $ref: /schemas/graph.yaml#/properties/ports
>> +
>> +    properties:
>> +      port@1:
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +        description: Super Speed (SS) data bus if SS-capable;
>> +          otherwise High Speed (HS) data bus.
>> +
>> +      port@2:
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +        description: High Speed (HS) data bus if controller is SS-capable.
> 
> FWIW this is opposite vs what the (most common) DWC3 schema defines:

(s/opposite/different to)

Konrad

> 
> 
> (also true for mediatek,mtu3 and renesas,usb3-peri)
> 
> -- Documentation/devicetree/bindings/usb/snps,dwc3-common.yaml
>   ports:
>     $ref: /schemas/graph.yaml#/properties/ports
>     description:
>       Those ports should be used with any connector to the data bus of this
>       controller using the OF graph bindings specified if the "usb-role-switch"
>       property is used.
> 
>     properties:
>       port@0:
>         $ref: /schemas/graph.yaml#/properties/port
>         description: High Speed (HS) data bus.
> 
>       port@1:
>         $ref: /schemas/graph.yaml#/properties/port
>         description: Super Speed (SS) data bus.
> 
> Konrad
