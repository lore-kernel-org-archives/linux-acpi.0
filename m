Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E96C392828
	for <linux-acpi@vger.kernel.org>; Mon,  7 Sep 2026 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788792768; cv=none; b=YYFMXop6vv+f63INV910dUpLAqD6t20lQDRwjfw733lLSIYfydynj1SfOJ4b28XJXCm4q0Umlt3JTbyorsWD3SYmMcLtlT6+kGJpU4ONrTP05PParpKzqJG+k8vj+6cmFzPpApcISaH6ZnqGa2GVB/Mt6CSjKmn8EHHjcpx0VW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788792768; c=relaxed/simple;
	bh=/S2OeMB+pVw0IsnX1n74+dfcpu2Keflp/VCkHim9+Cc=;
	h=Message-ID:Date:MIME-Version:Subject:References:To:From:
	 In-Reply-To:Content-Type; b=pBc7ewpEkokE4b98og79kq1PUcGVrkTvwC6fbyNYSMFpmdmxQV97ySqTiTFZ4Vl84FcWyJTMjdu0qAK7RzQ1h1cEmsaMmfkrYVYQTVjIohcXIZm3cpU/JgTVJ3S+dHNsBg+meJAavTx3pRfPk3Rbm86AsdigKRQ+aOdRWE4OBQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnh5wxRU; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnh5wxRU"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-836c8bde2dcso15065547b3.0
        for <linux-acpi@vger.kernel.org>; Mon, 07 Sep 2026 07:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788792738; x=1789397538; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:to
         :content-language:references:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=anfs5eR69uR3hgprcQRCB5kZHsZd0+SXQ4tCOJCunJw=;
        b=fnh5wxRUz3J1D8yRKvAOLlUD0kH2Dy25Nrqgl5ga0JBg+aXaMh7EtOyz1WdVRAy+IE
         CAg4426+d/Iw1GGUDsQXC6YQzR1WPwPLVvJcHEN+uXic6ee3Gt+l2s7iQAzcUInCMyrK
         BnNKmabG8zQkzo5H33W/w4b9tXXceBdZrMvxonOqRtS/z4za5x3U/pXB9niNSntKppNl
         1WB6AXK28fVz7gZLtt5rQmeB5gbNxcWSYcxizngu0ab3VuQ8ePOgsAvYwtnNS/qMGo3o
         2IP+wdyOCVTdrVYdIBRTZVzLfsT58TIl6909+qgTuEiZuAtd66ryblusT9YiZECWjlwt
         etnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788792738; x=1789397538;
        h=content-transfer-encoding:content-type:in-reply-to:from:to
         :content-language:references:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=anfs5eR69uR3hgprcQRCB5kZHsZd0+SXQ4tCOJCunJw=;
        b=G86mnMk5RyC+hLHcGG4mAgHYlP6TXTGYFjh/Jk541cWHxWsDMRYf2VGtcU3fPtUTNi
         Pc0jBuBVcc+rURYqqUu0TJL2JCtfV7IC1mSFIlCwfaylcgLvDXf4bHV0+9GJ1oAIM/ZL
         1iOLQjO+zZK4X1eI/PBY6HE/2yY1NL96wfa1VP0PkZ1ADKdrkrH/HZZtdxUu8k4VOwOg
         rV+s9M0bxGs1P7SXXjw/dlTfqIhQdfU3qiET6VMonEsWHJQ8wUjeJWWfjp9gT6O/9FIV
         61MY3tg+qhS/wpi74Sf6v4DizW6GPoirKL1CDPYIx2w8LJfEwtxkSNTTO22JxTY3rVFa
         ImDA==
X-Forwarded-Encrypted: i=1; AKwUvByoIeieYZfHNpxT+AhbKUHhnSAw6morKPW4UK6qAHZd+SUGJUPOJxDOLdMyXvdtK3y2Ul8Mxb79AIEe@vger.kernel.org
X-Gm-Message-State: AFuF++m1o3ouSgEv973e4+aX+o5OAk+eykqcLP6X78JGMwPact4uhm+/
	dlkQh7iNCtJ/YRUnGQyK8fnwc6iRouIAN4RVBz8zx9hKtJeDU5ogXwNf
X-Gm-Gg: AYBFou1yerxk3/dUTKxa4nFv3HCcMCtkYnMMRT6wJpcHhJwpc15ccqM0A6cdAMN/yot
	g9OzRAj8mYmHXtfqQ9g9llNKEdQMCrFzPo/hkORUddnkkHi6Ohgs9xoIgJiss2TYNC84eciFrDT
	1ebRx/jGWxujvHwQ34cvtIDj/WhY6iMHuArYGGliDvtVSf+t8QZ76nPTMRzkX7COXeQMfUyLXeK
	4hWbvLy+ruhMBETOW72bz4fFKE/l9rXNURFZkidn3brjVyTEpVvp9LhOh9xA4LaicAR5GpHg/wC
	AAzP7xBKjtKnmZgQDaXThvk/FsWXz4qfnhmf9TzS3V5R0+vbiZgnwOrJ1LExeytTW2nq1sdcz28
	mmhNLAy5tV1BzDr9igENZkSeDkP7BRjeF5HlK7ot5H67UBMAiK91GK7RTDoNVvmlVwjAglFDtcd
	mIedjADMGS0V1FItPwTxggHZ2WMflhZ7tYrp0YCZMPExeY6O3prsRt8lWLlSFB7Xleb6cUl7j8o
	N2Wi+5TveL96IodegU7ipxruJx/
X-Received: by 2002:a05:690c:c00f:b0:836:ec4d:bb29 with SMTP id 00721157ae682-87128cc54d5mr72607087b3.34.1788792738337;
        Mon, 07 Sep 2026 07:52:18 -0700 (PDT)
Received: from ?IPV6:2806:10be:d:e8df:57b9:51e0:e022:41c0? ([2806:10be:d:e8df:57b9:51e0:e022:41c0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-87149315162sm72634707b3.12.2026.09.07.07.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 07:52:17 -0700 (PDT)
Message-ID: <f9b29422-5389-4522-83e8-538e5306b3fb@gmail.com>
Date: Mon, 7 Sep 2026 09:52:15 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 02/14] cxl/ras: Fix cxl_rch_get_aer_severity() wrong
 severity register
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-3-terry.bowman@amd.com> <anijY3eTVWSqHLxh@wunner.de>
 <apkxP_fydVjpULaT@wunner.de>
Content-Language: en-US
To: lukas@wunner.de, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
From: Terry Bowman <ktbowman@gmail.com>
In-Reply-To: <apkxP_fydVjpULaT@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/3/26 03:35, Lukas Wunner wrote:
> Hi Terry,
> 
> You've submitted v20 of this series, but the following
> questions haven't been addressed yet AFAICS.  I'd be
> grateful if you could take a look:
> 
> On Sun, Aug 09, 2026 at 05:57:23PM +0200, Lukas Wunner wrote:
>> Am I missing something?  Is a scenario ever conceivable where the RCEC
>> receives a message with different severity than what is inferred from
>> the registers by cxl_rch_get_aer_severity()?
> [...]
>> These so-called Advisory Non-Fatal Errors set one bit in the Correctable
>> Error Status Register (Advisory Non-Fatal Error Status, bit 13) and
>> additionally one or more bits in the Uncorrectable Error Status Register
>> (see the commit for details).
>>
>> cxl_rch_get_aer_severity() is not able to cope with such errors and
>> will incorrectly infer that the severity is AER_NONFATAL.
>>
>> Now I *think* this is not a problem because Advisory Non-Fatal Errors
>> are masked by default and the commit only unmasks them on regular PCI
>> devices, not in the RCRB of a CXL device.  Only once bit 13 in the
>> Correctable Error Mask Register is cleared in the RCRB will
>> cxl_rch_get_aer_severity() fail.  Right?
> 
> Thanks,
> 
> Lukas

Hi Lukas,

I’m sorry for missing your August 9 reply. Also, I am currently on PTO 
this week and don’t have my work laptop, so I am responding from my 
personal email account. I’ll be back in the office Wednesday.

Thanks for pointing out the issue with CE and UCE errors reported
simultaneously. I agree this is a problem and have addressed it in v20.

In v20 I remove the unused `cxl_rch_get_aer_severity()` helper, take a
snapshot of the AER registers before calling `pci_print_aer()`, and now
handle the CE and UCE parts in separate blocks. The UCE status is logged
unconditionally, which prevents a fatal record from being lost under the
advisory‑non‑fatal path. These changes directly address the scenario you
raised for v19 and also cover any other situation where a CE and a UCE
are co‑logged. The patch ishere: <https://lkml.org/lkml/2026/9/2/1629>
(v20 3/9).

Please let me know if you see any remaining concerns or corner cases
that are not yet covered. Thanks again for your review and for pointing
out the issue.

- Terry

