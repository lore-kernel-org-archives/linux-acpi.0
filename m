Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1070F41D63F
	for <linux-acpi@vger.kernel.org>; Tue,  4 Aug 2026 03:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785815845; cv=none; b=M3UT3PXv5PzxXBLn+/RKlSo7SjEjqWxkCnesom1QfBuGkcYModun9A/MSQEgqkQ/FvfrHiM0Iad94d5Z2gOc0tAqLnPfw+GLo0DKpWmySvM8p0YnCP/ElpEmDV4Pe7iERjI6pqEzsiNpuI+E0x8eITA6M+qjo3EqHHcZ291I1l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785815845; c=relaxed/simple;
	bh=R7i8fdQPLmSfr8MbLBaSzELLxVHrJdG0Q0d/FHhrhhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DnjHZt961jMb+kHZBIvPSKEIogUkAgsDTqNvRNLTbQW8RF0PrpUYB1bLJp8MP9Lie+m6QWw8WL6nTKSH0UGSAhqq3BpT7R/uqL+Taav83uW43B6dQlteloHV9mZ/1AcIQ2/oGlZ7F+QpzMIoaA7POMw7n11QG+/YDdicxtHpuX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YWKOnVl/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hguSQDux; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YWKOnVl/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hguSQDux"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785815843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r6ueaiU7fBi7DY5TUPY/0MyqJcmKDSVc4RP0ImOk7N0=;
	b=YWKOnVl/gDPHhTKktVfJksRYYDHkT4HT3ND8TWIss9J5qt7Ra+eVN3Zco2i/ge3CzEG831
	mcANUoRMKl1xViNL1YPsr2vomIzO6oK3efE/0sfbWx47XUpx/KN0+ilLvot0mjWwxJWvAB
	xiWDfNot40gC0d95AU0GJp8wUJCT7jw=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-PVZlUZLQM9a0tvVG3_STMA-1; Mon, 03 Aug 2026 23:57:10 -0400
X-MC-Unique: PVZlUZLQM9a0tvVG3_STMA-1
X-Mimecast-MFC-AGG-ID: PVZlUZLQM9a0tvVG3_STMA_1785815830
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ccd1958e8fso62678515ad.2
        for <linux-acpi@vger.kernel.org>; Mon, 03 Aug 2026 20:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785815829; x=1786420629; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r6ueaiU7fBi7DY5TUPY/0MyqJcmKDSVc4RP0ImOk7N0=;
        b=hguSQDuxqpKVtfkuQC/ERV0N7/KGGM3Te30UBZP/ZbTXtsdykMYTBhoHMZxA3srdsw
         7PzJ5ntzQjBOSqq3iq+SOqg50umGKqn6mSJtrmDRjgQbGrdVC6/raNNcJCZ/dFTI4rEh
         u1klNWuTZWZRVwI67IpwjCLxwVc2laAfJYJYU6rWSnuqMT+OpjECW5LAvNjWSxqSYOvA
         DMCP8Y3SYjqDOn4UX16NVkNZzodG/jn4ReHBZVVX17+uV/UEjepArB/l3j0K20R1C4/2
         vKRBwqZ9xDiqoTMzKBJqQj2Me0U2NkLwG2BmEMvsEyv9+zUTrCcsLcqIZxbcJcMOJj+e
         JuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785815829; x=1786420629;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r6ueaiU7fBi7DY5TUPY/0MyqJcmKDSVc4RP0ImOk7N0=;
        b=qM1m0yD6IErOOCuQaJO2LQGfeU/T7uCabrpoX8h9txXz8XeSbkuFWFUTIEJ27x6iek
         g6ctMs45tk09frBDsTZFJDlcOW5a03bMLIsjLkn4DauQiiiD4kMKqkqxRDjG5YKrf29T
         T6iVYQOSnJM1aV5z8RF3Ig1+OJXyDT2Ht8HrKe7HnkXOKc2kTS35tHTuB7dcVATwWxUK
         XglNw+P3cGb/VXGPDh0MQ6NIjKyfNmCExqH1AOA7I+1/TB1weNmXQrFjQWX9oIjiijp0
         NrYLHZU4NOCUnNo6/E2OrjXLA1/G/M1MGd2kI9XdEjO8qMeV+b67hiGIaAkuLAadajKM
         vW3w==
X-Forwarded-Encrypted: i=1; AHgh+RqMskDEhAZ5O+cMmIlEWsS7P3VbBgy7pLD/UyjPc6qGHPiSJZOOT7qtYQ2NFbUxSYp08QLoZSXjEVlV@vger.kernel.org
X-Gm-Message-State: AOJu0Yxaw7nS7/I+xwWKZIhCE8KL0jmo8ckIloyeqpUKHRP+FOSqzwnb
	QyjUELgDnmp9vUHlZuB+5FV08K7smsxs9GcibVlFnA/X+PrHXrt9ovCc8FT6baXlFCclbqgK4JN
	b+hAzzH/M0QcAlqO8m7veW5jKbqefZRbeaFY4/HyBQs9X2N5UoPQD27p/c00zvyA=
X-Gm-Gg: AR+sD11nK5Itssuhg19fD5s6RFHUhyR+ITat7l6HpynRJC50+s0ctQnluQvhMMljypH
	nEcdVZ9lH6FODIUbBK+7PVGHsNyIlUNyIXfpdbMwrRLIBW+uj0CHjlmngLKhC++KEVQE9zWEK1g
	t5rsxVDcqYiWB21Y6NmCHrjgTRcNVXVmINI0XHf1WaEanG+Zi047VxZVjd41nAxaLf2stXbZVee
	edCp+42unJRGgSVWE67F8LW34425fuLXgA+zUUjxPaO3EkRJkgZDE9N3aWFuY1RbraK6XMKQqN3
	77hZkDyTgYQulPzXo3hCyc84l32s70k0onWOWYYSTj9HgYLURvaufwOm1hPor4qiGX2w2oQuZGM
	skL4tzi3+Y1mZ3cwAF9d1yg9ja/N1JWgV6HaVNuGfLJ8=
X-Received: by 2002:a17:903:3c27:b0:2c0:b6c7:227e with SMTP id d9443c01a7336-2d05219f8fcmr129612715ad.5.1785815829616;
        Mon, 03 Aug 2026 20:57:09 -0700 (PDT)
X-Received: by 2002:a17:903:3c27:b0:2c0:b6c7:227e with SMTP id d9443c01a7336-2d05219f8fcmr129612575ad.5.1785815829239;
        Mon, 03 Aug 2026 20:57:09 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b0eb7c3sm46155275ad.54.2026.08.03.20.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 20:57:08 -0700 (PDT)
Message-ID: <3326363d-45e6-405e-ba22-4b7d2c9832c0@redhat.com>
Date: Tue, 4 Aug 2026 13:56:56 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/11] arm_mpam: propagate MSC access errors for
 mpam_reprogram_ris_partid()
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
 <20260731170324.2927758-8-andre.przywara@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260731170324.2927758-8-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/26 3:03 AM, Andre Przywara wrote:
> Allow the mpam_reprogram_ris_partid() function check for and return
> errors, and propagate MSC read and write errors from the lower level up.
> This also covers the callers of this function: mpam_reset_ris() and
> apply_config().
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>   drivers/resctrl/mpam_devices.c | 136 ++++++++++++++++++++++-----------
>   1 file changed, 93 insertions(+), 43 deletions(-)
> 
Reviewed-by: Gavin Shan <gshan@redhat.com>

