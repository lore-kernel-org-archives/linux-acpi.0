Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3222FDC57
	for <linux-acpi@vger.kernel.org>; Tue,  4 Aug 2026 03:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785814731; cv=none; b=FOc5ljEReLwgulrWpDx38CQdTHj/eu5/cCJAVx5fUw4LHh6wvPJRQ5qo/E+Ou7bhTWQlM1fIn72nJx/SV34xdfLrFdxH+OG+gGHOXfhnVLbqBdpxn00my5HieyzAzoThGXxy8OweBf+eI/B2V+pNcW23pPqpvCP5vXA5Br4L2Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785814731; c=relaxed/simple;
	bh=H5pvd+eUzMQaPVwBbnrRs3I0P4w75Sabwf00JMs5UKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ejQ1Z4n5x1TzVnanHoChKf4ClbFrQTWm85pdZdU/YJ2J2NH+pjcSCXgCSMYPw/kFCtrVYbeC2rVjzRzARLohpaPquJGTWxO45Al0FS4YeOjEQ0Yx+Qq7Uv4RgpeGFU3Rz4FiEI5fo9YP+TPSAWip34aQlplMn7m6Jlbuy5mM1Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g9tTyMcG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AS5sqaIK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9tTyMcG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AS5sqaIK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785814729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wNvmfBcFcCTIC1AY1WFodqG2nUyiP6xrqhsC69kDaxg=;
	b=g9tTyMcG8GR6w9mlTWe8H64/DTOOxw4LFu100ID0XtPuEK8b/82ps18d6p9HQhEoFd0MLG
	zsqzWHFRZC4x63eap/1JWeiraNqgAsQqT13JvZtsvw+IZ1WhpAR69JcUWKQQOuuWStq6D5
	OpjHlP01U8IuvjLGh6Y/T+G4mHZUuZg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-NawQ1GVtMbGqRPYWo5jYbA-1; Mon, 03 Aug 2026 23:38:42 -0400
X-MC-Unique: NawQ1GVtMbGqRPYWo5jYbA-1
X-Mimecast-MFC-AGG-ID: NawQ1GVtMbGqRPYWo5jYbA_1785814721
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dc085b0a7so708206a91.2
        for <linux-acpi@vger.kernel.org>; Mon, 03 Aug 2026 20:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785814721; x=1786419521; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wNvmfBcFcCTIC1AY1WFodqG2nUyiP6xrqhsC69kDaxg=;
        b=AS5sqaIKiTScFszdrstO69bIhZJ5gzzn5h4IIV7lQbM7SfsgrWgy/MeTI7vsUyP4gi
         CilMqWhSNcAa6AOJhIjBGRR2oiNrYpTN/cMcRhEY4YYpdMbwGw4BBfGdbkTFhW3c9TF+
         DX7GYNfbAzgE7XxICCwq6B8ojy9uJxkRIQ8azMO1NKWW1rAegHCt5kR+ipVEw+fPTOdA
         LB791Skanz+4Pg4xpYdoTJlS/tg+QhDNM+40CDOYc9Gv648nd9eQRy64gqksrvQ4tkDC
         9F+i7sPXXqaBuQ6NQggzsphVVf4QTaAb4YKBPy8U1culSW84Ly5UQuKubU/KDozQHINA
         mY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785814721; x=1786419521;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wNvmfBcFcCTIC1AY1WFodqG2nUyiP6xrqhsC69kDaxg=;
        b=q4Gj5ClfiC+e+cL5lEe/qyzF1aWNENSmFrL56edBi7mXYYqpsb14fIjgeD4Av55BXL
         7YQMiibrd6+8G5Cen43AEPWC+8rpQrkz1+2MW6HMtePwa3681cYxCQx0HKDqIDL9vkCC
         T6KxifwmuDooUVqJ5b827wWhesJO+RN0G6xgdKTYz35kTyLlrs8NsjsH02ugx44MwGZK
         G6hJ4Oig3hy1TMCSMxZweF2q3dESzdicH9MOLWmDl4300Qco5Kz8TRkdkeKHyZCvxJch
         SoVI6bBWFbA5PcWy/xwV08OAVTMlSom/ujt7NzvL41AqoM2m8db1K5KGrmGSLoiAaR5Q
         duNQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq4Bvoe5dfPpE7LLFsuxrLb5iB6SSjOmsjz7HWLQObSTH1FMPHaUxZq20kd0Qu8FtWPzBKkMaXFt9Uh@vger.kernel.org
X-Gm-Message-State: AOJu0YxBC6ofN7eUSezwqyuUBN1Z2PAZxgIx4GFrNiy1CYMC7TWJjMNQ
	WBP3jRUX/DQ0CgDano+MaQEqr99FP0LPhB/YnPQaeQmX+bBuu1IBdtRPFArg7Fc1lMs0ERJ6YB7
	vWkKDwLhHD8K9dolMey5iJJJ5qqytLI7jJnmDeRWBrWp5EzaEXeH8GR7/HW2xmNc=
X-Gm-Gg: AR+sD11DyUgrb72YG9SCNEm3ek7C+B2TgMjeBEHEnWlAeaZ6bIiu6ALJvABgudVSHnS
	ODYftGPep5MMya4qKB6aIrj7WLVFJSfGDUQBdZOEUe1EH7Fc/Xif8lC9qzZTWrFHmiGJ887ymqH
	lcqnTEu3+ofn3bt9Uzq3LWdAa2t8oUXpzVuvjPGd7jCwTCkjgJs0ybbZyjsy/l2/w3J8SHaPROK
	6orbaENO+D5ofY3uKT/uCS+on/zQJmdWqbhQ7UScPePO6rTwN70E/j/keHhfR80bqtCcqVSsxF1
	GQrTqBfuQqF9eQOxUwdW2B8M6BUDYhriSTK8qi7YagmntPkOrPLCmA7lmp1acnuoFgXEUDUeb8w
	xBjoOJDQBYNGFmMvrsp9U6+Rmsdzz48/6E0CksUa34kk=
X-Received: by 2002:a05:6a20:914a:b0:3c1:b9c:4890 with SMTP id adf61e73a8af0-3c92a5d7954mr12778831637.22.1785814721047;
        Mon, 03 Aug 2026 20:38:41 -0700 (PDT)
X-Received: by 2002:a05:6a20:914a:b0:3c1:b9c:4890 with SMTP id adf61e73a8af0-3c92a5d7954mr12778808637.22.1785814720635;
        Mon, 03 Aug 2026 20:38:40 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab143a7csm33178004c88.4.2026.08.03.20.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 20:38:40 -0700 (PDT)
Message-ID: <ed68844d-458c-4516-9942-db6153acdc6b@redhat.com>
Date: Tue, 4 Aug 2026 13:38:30 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/11] arm_mpam: let low level MSC accessors return an
 error
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
 <20260731170324.2927758-2-andre.przywara@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260731170324.2927758-2-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/26 3:03 AM, Andre Przywara wrote:
> The upcoming MPAM-Fb support does not use MMIO primitives to access an
> MSC, but employs a shared-memory/doorbell based firmware protocol.
> Its complexity means that it must be able to handle errors, whereas we
> always assume an MMIO based MSC access succeeds today.
> 
> Change the __mpam_read_reg() low level accessor function to return the
> requested data through a pointer, and return an error code instead.
> Also change the __mpam_write_reg() accessor function to return an error
> code. At the moment this is always 0, so all error handling paths are
> not exercised at the moment. This will change later when alternative
> MSC access methods like MPAM-Fb are activated.
> 
> Change all direct users of those MSC wrappers to comply with the new
> prototypes, though the errors are not propagated all the way up yet.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> ---
>   drivers/resctrl/mpam_devices.c | 208 +++++++++++++++++++++------------
>   1 file changed, 134 insertions(+), 74 deletions(-)
> 
Reviewed-by: Gavin Shan <gshan@redhat.com>

