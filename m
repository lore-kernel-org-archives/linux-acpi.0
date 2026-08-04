Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F88A331ECF
	for <linux-acpi@vger.kernel.org>; Tue,  4 Aug 2026 03:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785815348; cv=none; b=GBpOF22pyywTIO9o2RyOJa/QK3H6h7Kpxo2LfACxzyrGJ7fK/cwugtIuGt7nuf/0/9g/INrfAvy7tadmt6v2gjcbXxAXqvJ9hbz6KUHsE9c3ODMjDSR2lI52n6EmCZgZiTkQrSHjWiggKiMEoxKqA+1we5q5zc8MkRv+IYx6DsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785815348; c=relaxed/simple;
	bh=C4XgYsuTlZmPdAtr+GeDqb2brRVHr1qtrlvoUybe9Bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KNKO0BRpaC9Rhn+1CfORWIv4TeJW3vIM8Q960EiPpUtWt7nAOPu4Cyq/Pbj5mxBTYAqErPHImP+lSimlRnT8Ev8ZSUXkOHIAAX9g/n1+JxBJDqmISxOPfq+Nmn58Sdis35Rt5Cxp106cZ7YzJIslVXn7Ricycm2+7rzN1QEJ94w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RCiVjQ0f; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HQHEp9f+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RCiVjQ0f";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQHEp9f+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785815346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pwQro0XBY36lk0ceBUE0Egz81FQANnimgQHnfgGBQH4=;
	b=RCiVjQ0fauCM51+bwNn3DyTBCJU/qjZ4jO3O04c+toBXY4LsN35WD/PdX1pz3r+wlcyb9x
	pwEca3vowar2Ak5kyqROgOg8zIhEi2EN/9PHEBvz6IeyhV/1h1M58x6FjvuhY2G3UbkpX/
	YFLm7aFH41FbI9pQFeOAYaESdcpT2rA=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-ePRI2FxrPlmfLvqgEj7PVw-1; Mon, 03 Aug 2026 23:49:03 -0400
X-MC-Unique: ePRI2FxrPlmfLvqgEj7PVw-1
X-Mimecast-MFC-AGG-ID: ePRI2FxrPlmfLvqgEj7PVw_1785815342
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbb467e56aaso5115929a12.1
        for <linux-acpi@vger.kernel.org>; Mon, 03 Aug 2026 20:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785815342; x=1786420142; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pwQro0XBY36lk0ceBUE0Egz81FQANnimgQHnfgGBQH4=;
        b=HQHEp9f+HfN0gT90uRJ11/OInRB19uLZ2Ox+HBirnHtQnVJHOuzaIrXGmt1uy2N07U
         dGUcmd2KNX2fWhXBAn+pTsUrv/r4MCHthXLWfsNsRRXodYXK9ejPfS2RMjocp8jXS7QN
         AF4Gf0qaHbiiYbXSipp9IABZii3A2YVaV0bnGym4iwapHzaVT1mEk+xO+Dut1T65gKdo
         KKIN3a4MP/3Hdl9t6cMzDVXQrLrDW20WpTamrF3JMofDokmhq9GGGBm/2bBBW32Pz7oZ
         NOwWpk4RmHQK/1as+mgT4C7G3nDvKrwcHICz3RN9Nx9xEHOaPcbsLKt2zrMFKgnpe6r5
         RN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785815342; x=1786420142;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pwQro0XBY36lk0ceBUE0Egz81FQANnimgQHnfgGBQH4=;
        b=em3uxoq8xYVnAj3WwBdpdrAJoO0Xn7t9Ulw6as9fAIiyvO1i+IVaPMYtuIdv1Vkvzl
         aEWnVe797VG2hdFBRSRXMtmWyDLXhPjbd8MnTFA4QAJXIOLa7ApyNLEJLe6m6u1E3iG1
         iH5Qavcn66HMEDRgmIhjapE79zK7sjiGYWmhvRgwkpt4kRL3wMR4sGP+GC7s6C/C0SAx
         MuHLQDA02lTpJC+/1u04UFp8S18jYeGsVj5ck36VRsRh40vxFJyQOX4nrwGJQyMdhgqG
         XEG9Amk/E3dM3BI7MddQVORi1tlun4Qpv7zhmlhNvgwAW/Y2n1RS7bAT1urs+D3Yvpfz
         pCng==
X-Forwarded-Encrypted: i=1; AHgh+RqcdaFZkZpDzwRCXyqIl3iK7vwwE+F8MU6S6AV2TosaMfpr4C8iXpojHa7NqPxui+UAX8ztCbnhZ19U@vger.kernel.org
X-Gm-Message-State: AOJu0YwCan2MlFOEoXbf42V+kVpHygDVSeuPXH57SINcbEReruNb7uTr
	yG5FWxnuBx6Q7RyVHKBUgcQTaZp5Rs2TIi0P5YWsJ/8FoB+quzAwNrnoHT+1hYO43TVe66lzFGS
	Iorl8BT86CzGUPGcNVuWi7U8apI1zxnRIPBPqkihSQsKV7PewYp6UgACVypIBjy4=
X-Gm-Gg: AR+sD13ghFKuoNOUPtuqFqdQ0a6k7To5MQNncD1zHiAHbBzRfQE7CtHlKF+OWETI/cF
	lsbETpvRimxWHnFv3qhryfKGn6AtHyzpdpiwWG87v+txYGC0OvVmhutFFmg6XWx5dxoCFvdSlyN
	8PA6Jsd1jtVv3qjc3dqMkqFHSfmXdAsyjUeU8bo9gOu4iSzJSeCuGgoVOtjpoD3oPEE0D4HGx6F
	e+WdDn1r2c9uRVK3fyHb9yBQ6q2BviHMMkzfUvjFcX7R2ZXW8qYUg1IfhSvY9Wbhuz1phtHJjNG
	EYgXQvWOrL22i1gAXPUZxzAj6mUDiEZB+KDr3SNiR3/v9TjCm2LNc5WN0vE/5IVs5O5m6ziTRLN
	15E4eVT7crNmiBmP0zRUW5KsKpTZMuP93CCQc8lNot2E=
X-Received: by 2002:a05:6a21:7a4c:b0:3c3:834e:89bc with SMTP id adf61e73a8af0-3c92a864c8emr12489408637.50.1785815341982;
        Mon, 03 Aug 2026 20:49:01 -0700 (PDT)
X-Received: by 2002:a05:6a21:7a4c:b0:3c3:834e:89bc with SMTP id adf61e73a8af0-3c92a864c8emr12489378637.50.1785815341553;
        Mon, 03 Aug 2026 20:49:01 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd4f197sm45501799eec.6.2026.08.03.20.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 20:49:00 -0700 (PDT)
Message-ID: <9feb5366-1955-411e-8a8c-278e201cd2eb@redhat.com>
Date: Tue, 4 Aug 2026 13:48:50 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/11] arm_mpam: propagate MSC access errors for msmon
 helpers
To: Andre Przywara <andre.przywara@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
 Trilok Soni <tsoni@quicinc.com>, Srinivas Ramana <sramana@qti.qualcomm.com>,
 Niyas Sait <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
 Ritwick Sharma <ritwick.sharma@arm.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260731170324.2927758-1-andre.przywara@arm.com>
 <20260731170324.2927758-5-andre.przywara@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260731170324.2927758-5-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/26 3:03 AM, Andre Przywara wrote:
> Allow the helper functions for msmon accesses to return an error, and
> propagate read and write errors from the lower level up.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> ---
>   drivers/resctrl/mpam_devices.c | 72 ++++++++++++++++++++++------------
>   1 file changed, 47 insertions(+), 25 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

