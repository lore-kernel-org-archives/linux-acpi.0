Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2561374170
	for <linux-acpi@vger.kernel.org>; Tue,  4 Aug 2026 03:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785815042; cv=none; b=F7jqHOJmvbJ5mhami3FG/UNFwZ+J+WxiSqRsv3MOnquS3518kSgMt1qPgwZO4llpzuXfdzSZzLyfrf6eQD0c9IXYY7I8r78N/o13YSSzDR55xb0fRP3NNVffUL3SQOcsOkWduGyCOX6Kr+X2TCSBTGnqD6BENLYgQxab4Xi73h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785815042; c=relaxed/simple;
	bh=nOmXqx8X+9qcuzh5X1k3niA/a+XCwYEWV1DuPjTdFtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smauUawXadgXoNyjeMkhcjHlhlNY6/GrNrCEDpT94YNXlGrZC6RAVdZL0t9LyqLRg9hVQPrSoaPViIldRdAUs0pki6D8v/J1mg7nDayR5MGT0Td8QHQD7pClgOsLUz3qs7tdiF489TpmD5cNmukdU4ywgfSZ1BdC9jd8E1d5ajg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YEs98970; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GJK+Xr46; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YEs98970";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJK+Xr46"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785815040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n5+qFiO5eRTgHEGmoW8uQomFkTfaTToj617XVLzFBYk=;
	b=YEs98970056K5oj9JOAcTIZolcfLUxZY6ojs8i5bN0IhGLqywLjO2LgigpzoC7E/k/u2j9
	dcxU5UdIkMdZ5XNnEea3WVQFP/CUL3KH8FotgiEHYSoQq89RNUcYyZpVflrymodofG31wv
	x1qDDUqyBuCrDB4h6Eym4Ll5YjNFEn4=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-nCneSDrTNHuTgOSafvhf-g-1; Mon, 03 Aug 2026 23:43:58 -0400
X-MC-Unique: nCneSDrTNHuTgOSafvhf-g-1
X-Mimecast-MFC-AGG-ID: nCneSDrTNHuTgOSafvhf-g_1785815038
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c860544c077so9852556a12.3
        for <linux-acpi@vger.kernel.org>; Mon, 03 Aug 2026 20:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785815037; x=1786419837; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n5+qFiO5eRTgHEGmoW8uQomFkTfaTToj617XVLzFBYk=;
        b=GJK+Xr46v4rxBev3Yi65a62X4D7YAqpt2iYb9E29aCS0+fZLOTKwMkbZfWrC+hwu3+
         Zd2vsay687R0yg5WfaORTXmxvEBzaXYRr20bMVh3AjhFXXuxaqTMWKK/aRAlSpB56t+W
         FEvlq6VAlR4E6p47cXXoQBihbVkPHo+aOLdOHR5/H6PdN8UsFEXW0wU5YkuqT6iZ1Oiz
         bLLjzGcGod6cR0WiJw3ZkJ9tvDKlfVTDdCYgiur+nvU2PvD39qhC0KNX+JPVrDrEOeJX
         jQvc0oH8oGXXWhLnlVy4XCjiK7S4zcrZDuq8J3em2YOrh93DXJ3yG3hS+AbzOeIykaeY
         U//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785815037; x=1786419837;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n5+qFiO5eRTgHEGmoW8uQomFkTfaTToj617XVLzFBYk=;
        b=ilrcbQekeLHiKJ+cZc/3EiX0vef4qx6IxwKZnDKVBnFRlRR7teeiO9/anr4YUQD/St
         IlleP+Pr5LVMgBovdnwRnNMbuH/QCls/HuTEA9CkNeziV1zgoDJ1PpPYEHZp790KuCDc
         DmKcESruZ/u0pbY8IG8tKZLZHvKgUpRWvpjliyzzE29DNlaivL/TZdMbF/3mTLppI9Qw
         w7RV1jjq/2N3th6WaaPk+grqRwPD3e1czrbQaPMO/YbwGYv06Wcn+dxv2bHmbSSm1vmQ
         WINqE/SxNZyrbNow7va6hNX1l+pCBYZOuFyWDO3aILu8//jyJLC7uzcUOOYLrWO3GJLt
         UUMA==
X-Forwarded-Encrypted: i=1; AHgh+RrNjchYXf8IadU8dg47nvgjmJ0vPYrhMSv2fbPCrHQfJaTew6Bb3lkoZe/xnhCTVYuBBm43ovqfXB2M@vger.kernel.org
X-Gm-Message-State: AOJu0YwVmhdk5tgt30ztiVGi44Wh2TyuaFd1KUu5p23TWCuYzl0ZQk95
	4NVrb1oLQckKBtRfrOnlZUVLqPAM2VhhyYqumTTLeL7vcYp2M1ZIsvuuolZbBJK7LoBhJIWRjZL
	de7YYWSKaPDiXqRTWepx20Msfp9bDVcG5NQj7sB3UCx9NhIpM8pocl5E2DOxtuOU=
X-Gm-Gg: AR+sD13J4WoAAz50MUMlVpHL7njMP8u0u6DBmNsMiq9YI3rlGLICDhkplz0ilUmxAYP
	aosI5zOkrltkcINuB1HgQk0S7352m0Mcy/RtMulqZkUdKlliEEjrYyU4/NjOAS7UZ/jNjyE4CaN
	Cx7A1WpEvP6CKZ2V3fe+TaDFgeRXuFtQ5QjeJpCBnqtrDh9jqnCVnQDSNL6y2aLR6BKlkTNr63d
	e6ICvfsCFjrF9Vn8qkiui9Zxg1SumNXju1oCA3TExP5hfTWJVo/QVM3CSZi55Ln/C7qvAD2btsH
	DwoSJkAxcpHGRnbzWNlE3EFG299PeKDNnGBPtPYQgpr5f2MepUS31l3amkBPB2ZrQrZ7GC7x2Nm
	LWmajyzg4HKC2vcKzprmQuWw1Qdey7xK3MMF141XUEeY=
X-Received: by 2002:a05:6a21:8213:b0:3c4:46ca:3348 with SMTP id adf61e73a8af0-3c92a99a481mr12197373637.73.1785815037655;
        Mon, 03 Aug 2026 20:43:57 -0700 (PDT)
X-Received: by 2002:a05:6a21:8213:b0:3c4:46ca:3348 with SMTP id adf61e73a8af0-3c92a99a481mr12197352637.73.1785815037242;
        Mon, 03 Aug 2026 20:43:57 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd9be04sm41030387eec.9.2026.08.03.20.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 20:43:56 -0700 (PDT)
Message-ID: <b7c5fef1-4d26-49da-bbcd-ba65020949b1@redhat.com>
Date: Tue, 4 Aug 2026 13:43:47 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/11] arm_mpam: propagate MSC access errors for MBWU
 counters
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
 <20260731170324.2927758-4-andre.przywara@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260731170324.2927758-4-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/26 3:03 AM, Andre Przywara wrote:
> Allow the mpam_msc_read_mbwu_l() function to return an error, and
> propagate errors from the lower level up. This also changes the users
> of this function.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> ---
>   drivers/resctrl/mpam_devices.c | 45 +++++++++++++++++++++++-----------
>   1 file changed, 31 insertions(+), 14 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

