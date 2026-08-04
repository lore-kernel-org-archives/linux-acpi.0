Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F9236B932
	for <linux-acpi@vger.kernel.org>; Tue,  4 Aug 2026 03:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785815635; cv=none; b=XREtWfnFwFzKwyaWYlZ6YQPBs9RGneZvySnYTSG+7idBj03VyDCj7yL+iGhulZZst4y33qgv/TPP1p5T4I5ah6dUxEegYkUaO0SXHmjp+R+pKYknj58Xl8+a+CT5I44LwVcaonhXSht/kRKF5tF9e3k85BcLLKzA9slSW8A1ids=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785815635; c=relaxed/simple;
	bh=5/XjB7GV+HqX+5NTn9lFKhH3QLHIavc16tqMMZYQ880=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qbpxRQEXIKKOn848AZZNibhCWE+LzxZ3ax8NAmfWDxEXY5ld2ePdHaUGDZegF1IDwjlmO2FIgaOzziggK9hHY7Vt/P5giJ4XE3srm62n6DmRuHTDcsyF65U3TRXTqRmz52yW1SDUax5u2ACiOB0Scql9GC8AMYfgB9f/DGYKvCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wh5WlQba; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=i56ewqB+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wh5WlQba";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="i56ewqB+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785815632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pXorBDPuo/cRWoXHPASu+eGhuQQ67Aud1Ob620DARGM=;
	b=Wh5WlQbaDD1ri9vhmt+AXdk5a0LN7humooF703rHR5vzOMlFjLRuwdYV5S/ThmmLMOVAz3
	xZOMGWpGUUDIGu26kLHXbDhua/r5/ERGvvSFW0DoVkwBLTjBbmvxoU6HIF9A3mxap1QDQg
	qDwze2LgBakAfWEdqtm1+XsRaDWa1R4=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-sGqkNP2iNJuq3poUL9TckA-1; Mon, 03 Aug 2026 23:53:46 -0400
X-MC-Unique: sGqkNP2iNJuq3poUL9TckA-1
X-Mimecast-MFC-AGG-ID: sGqkNP2iNJuq3poUL9TckA_1785815625
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c85798977dcso6956873a12.0
        for <linux-acpi@vger.kernel.org>; Mon, 03 Aug 2026 20:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785815625; x=1786420425; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pXorBDPuo/cRWoXHPASu+eGhuQQ67Aud1Ob620DARGM=;
        b=i56ewqB+zBgth1Msv8M9sswu/6wbB/NId5gjMQcmS5lVWMXX7ZMv7mX/mD1Z2nNUEW
         o00pCxWRoXYQeY5Ctmwi3ZqsGIXDpPZ53nmbsFODzNdeNLsuWtbQWlFjmqcENvkZPiDT
         //MkXo9QQfGwrYzZle9XLUgZqC5Gg0h23t3M97/tiF6f6aJsdN21Ta2w2xxHVDOXjRrA
         Q8yb0+aTMZssxv+JA2mhj19dOkWJmOczC4Re/1cjn0ja8LwUx1Wok6kkujH2/VeORGw3
         UvYosxF+Ee38Ap0MVa0va5g9kIKGDkDvIb0NOp43qgoeYm4+WnxdpkcNwqUbul/7qVHI
         aDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785815625; x=1786420425;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pXorBDPuo/cRWoXHPASu+eGhuQQ67Aud1Ob620DARGM=;
        b=Bsmy6n1lNQ5TK80jsd+5ER1QPXU613iHJ7saiqa2jMTXb5N8j8jyiZuAUgFPKRPh+z
         1/5Rotjc97NrYPuUz/1/2j4fEiw3OlXKBBe/5AAxCbwGuvnkae+XDT1wj+wx1A3pCFuw
         2+9TOScIc+jdjYxHi6RYbJgonehAff88dSa6OZbnDU74lz6U3JREbaTObRGJdUopS4KE
         twWDFjKAYR3sH2YDbJZxL2Dh4GSSy7S2y9GMSu5QZx8Kha5yViTkB2pjx7AuPZfrPtfr
         wXBPXdb+UGBcyFERitYYPkR/I/tHaiQUs6w+7nOAhNgfvQywHH3mmXOOAM4AoYTscUbV
         79pg==
X-Forwarded-Encrypted: i=1; AHgh+RrruDuDBRhhaGQ02BBIhfrAiJHnDSqztUqj6AlyO7Tvrg1ndgjokNQj3y0XjQI9YrXGiRMAAdCryMbT@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+2ys/6t9+taj5jnG9JmoSjuuY+Zx2mqY56mfTQmXJ0geaVt8X
	1M9drvzyeieXbeUXqUayKLmFAa8sK+thIDR+gyecMr7+anZHFg0VXkSasEDg3094kFql7Hqw0jF
	A7tfY2k3o78ahtduqepm4WMafdDSZbebECTIpyu4xukS93YwCbKHs6vj9QoznPkg=
X-Gm-Gg: AR+sD135BYopPhI/resOrJo40FiaY7CUUs9aPKFL7cnTZ0UJK/37dEmzI1gPcct8w4e
	rREhgNINH293fRauU3nYY7W9zZ4DlufqVN8r3RNftZSPe0Bj7KcV22Q/M0iioGId48eY95OVsfL
	nov1lS+2d4ZrK39EP+WMDeYtQsMD1RpoVR0Klb7/+51pIch/Wh8KqBchLRW3wPFn0gZVij9aGHk
	BOKWQvtSyBVrrUswq+fntsIu4dlZYuKi6cvK6DNqqTz0TYLTGP+DxrOT5C+83G9cyxkRXFcJ+3S
	1wOmaL9mfo5qfBYoRqSKLcIPo0DEECoTuGBC+oqGzgJSk0n1SwJ2p56Nv4MLaI6/85o2yzxldRS
	F3qhlSIW7ISa7vQYHkepEUD8hfDqgfhk5UufKPjeeTqc=
X-Received: by 2002:a05:6a20:93a1:b0:3c3:83e6:c6e2 with SMTP id adf61e73a8af0-3c92a88906bmr12354732637.50.1785815625250;
        Mon, 03 Aug 2026 20:53:45 -0700 (PDT)
X-Received: by 2002:a05:6a20:93a1:b0:3c3:83e6:c6e2 with SMTP id adf61e73a8af0-3c92a88906bmr12354707637.50.1785815624807;
        Mon, 03 Aug 2026 20:53:44 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe39ea968fsm4426314a12.26.2026.08.03.20.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 20:53:43 -0700 (PDT)
Message-ID: <69b649b9-b7d0-4ccd-a9b7-105bb432d274@redhat.com>
Date: Tue, 4 Aug 2026 13:53:32 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/11] arm_mpam: propagate MSC access errors for state
 saving function
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
 <20260731170324.2927758-7-andre.przywara@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260731170324.2927758-7-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/26 3:03 AM, Andre Przywara wrote:
> Allow the mpam_save_mbwu_state() function to return an error, and
> propagate read and write errors from the lower level up.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> ---
>   drivers/resctrl/mpam_devices.c | 29 ++++++++++++++++++++++-------
>   1 file changed, 22 insertions(+), 7 deletions(-)
> 
Reviewed-by: Gavin Shan <gshan@redhat.com>

