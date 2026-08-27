Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D4E239E80
	for <linux-acpi@vger.kernel.org>; Thu, 27 Aug 2026 00:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787789407; cv=none; b=TSPuL53rdOgQbD4RjJE3YC7swopODuGb8uDgQ3y3JvVpOJWcjER5awSjzOktCSU2okDBWUT/POjr84/ghSv2dryNVJIvePP7yISuMxaSMm/8bV0q67DYPCJ+yOCr852lsMnjYcD+MFOxAix3TiFX6axNOIRm3oFeRglHQ8PRz60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787789407; c=relaxed/simple;
	bh=CUrmups8zRYwGr8eSo5qvrN5x3TVbRqyxt/Rd7wydgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eF9yD0Bu+kbYfUy9R6vGox4eyUUHweXh81TwKq3PLvBKBP329dRn6G609pI3IBqQ3w5VIO16eLLifI+NPay+l4+Kjn/6dujygACOOxjfLB2nKk0wtL9RkSscA4BI6/n4gV09g2NhqNeaI2FjkQtpvR/FKOukfzrfj0q1QJhj5ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cW4D8Ie8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CAXaz7Sw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cW4D8Ie8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CAXaz7Sw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787789404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P4C9bzIpuuaLAtIJfd/nedrnMHSui02xazThUpELcIQ=;
	b=cW4D8Ie8RV7PZYwbOa4ugOAuJSOeZgqQCRzE+OI1uCugNbaIEF437I7/S+BMNulpTbT2OO
	MGWkxbL1IBVtzJDZZlzCe4SZZPsjdkBgO/JQio08VfkGWr0hWrB933tTpO7SZZQ032vAHk
	sZPY1cYvRhauEIA0zd+rWgiUfpM/aw4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-GNfmearkPkm-8jEocsA2CA-1; Wed, 26 Aug 2026 20:10:01 -0400
X-MC-Unique: GNfmearkPkm-8jEocsA2CA-1
X-Mimecast-MFC-AGG-ID: GNfmearkPkm-8jEocsA2CA_1787789400
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so2324164a91.3
        for <linux-acpi@vger.kernel.org>; Wed, 26 Aug 2026 17:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787789400; x=1788394200; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P4C9bzIpuuaLAtIJfd/nedrnMHSui02xazThUpELcIQ=;
        b=CAXaz7SwWOsJMJmNuFnZ2oZoGDPHuznLI0IhBSteY3KB0la82SgcGOqPwSeK15HCV0
         Ogg4wG8gbTt1wDQoBi1+kD8SpzMkoK/EPmfcDZ5hYBDfhkxI7e6KCXtoQ2a0A7Wo3ZNe
         i0aY4HMhVzC99rdlP0YFT7YqviCH8sWGrYjtuZzcYEs51O1YXC7V7wkj+L7aFUD6bKsR
         0HHGtYIrA2rJORKMUxa29OjxBuB4dG6IFNlOS736lIx6x6L2RSS6GdO+twghyFruPTJ/
         trPG8UU53iUsi8s83loLykbNT9HBgNIX8Wu3pyY6l5WlOb2GhORyBIE2hjy/a21Dh1hv
         yeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787789400; x=1788394200;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P4C9bzIpuuaLAtIJfd/nedrnMHSui02xazThUpELcIQ=;
        b=FX4iMIux3PkBzwri6aTgSjd6dTO3eySV6XU14rwXso5noF5hgM/1LUIsqdf2VPdEgo
         Y+t0bQUmBGb87Css+FQrwncaH9L4kYXluW22aQdCbgNOTpv7qR8NER+Cnju0DvUdEdW3
         WjhhbAx0Im1X3NR03RWmJRQIY2v/sGpqj65rfEqJolJM5AfoM242VEwKHfJ9oCAAe6Li
         EPdska8BQnBgV6EBufsGy6kvYOWY7FaXX3aXkylnMBKh78ZNe8zKocOxiy2lS5Xowxfs
         IxVo6sPq78EO2lirAqTnSlmodqKoXww6cPOntKfrYhPU09DMqYAKOwf1XBoLoNI4VvMJ
         LX4A==
X-Forwarded-Encrypted: i=1; AHgh+RoOlIYprS5AsbChGxuGg0Sl29aR4RhUrKU7wTLZ9JMBdZCsM2YBNYbkbirG8LcDsMX1pPz75gTi5Mzt@vger.kernel.org
X-Gm-Message-State: AFuF++ltuOxyV9lV96RgiZkU27aHvS+gt27EotVWzQQCNW963QutGncb
	8cDcGxGXvogD/ryu6oE3avAQb0FWgfe7QGYYM2YsJ7U0lwjw9Ts+NBUPVvn9wC9yhrW6CYBs/5F
	gU2d1n2tIa3fLeGbTRexCwDqhjqtp1pTvYUqN1gMIQLMs+E/TNg5B142WcwsyxIs=
X-Gm-Gg: AR+sD13DvECD27+qINE00+7RYdKeOowe83spjXK3ZMPeS/YGY3Clr8Z/BRoi0iz+JCJ
	XmDW4yFZgtFMpAE3xs+yLqLP5EPjLHtm9qBKo/RbpHIEqjrk4ZXKkDV1BrgVZTdvpIxLQTDpy8H
	0S/crsX6n46Dap2ENP7ZP01utDl802bneQZ9yNPGaYi0BZM2PvSUTkUuxeh/rfzJ3/5lKRTWLVa
	FUAnAMyLsFq610eHktGNSHuSb7H8IP2ixLOihPJzlJ2nNwnC80T1P6MAz2zA86nf/mcDAun44gh
	F2m+LXpHt9/CFLW4PV6JqsF1/QgoL94KmGtPs08VY/LsvjZ9j62o3oF5INnyeXkNfj7pfVSYkC7
	FEmVnn4V8EeCqInfc2QNMm+2nRra8Nf1k3xDjajf15A==
X-Received: by 2002:a17:90b:4e8f:b0:38e:2517:5d1f with SMTP id 98e67ed59e1d1-3966d4032e5mr24140875a91.9.1787789399981;
        Wed, 26 Aug 2026 17:09:59 -0700 (PDT)
X-Received: by 2002:a17:90b:4e8f:b0:38e:2517:5d1f with SMTP id 98e67ed59e1d1-3966d4032e5mr24140764a91.9.1787789399495;
        Wed, 26 Aug 2026 17:09:59 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a9035ff1sm10395038c88.11.2026.08.26.17.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 17:09:58 -0700 (PDT)
Message-ID: <a2ac5d0f-1fe3-4dc6-92cc-d6aae82a9baa@redhat.com>
Date: Thu, 27 Aug 2026 10:09:49 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 11/12] arm_mpam: change MPAM-Fb error IRQ to use a
 threaded IRQ handler
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
References: <20260807105451.3728284-1-andre.przywara@arm.com>
 <20260807105451.3728284-12-andre.przywara@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260807105451.3728284-12-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/26 8:54 PM, Andre Przywara wrote:
> When an MPAM MSC gets into an error condition, it can trigger an error
> IRQ. We cannot really do much about those errors, but we at least query
> and log the error, then disable MPAM functionality.
> 
> This error report relies on reading the MSC's error status register
> (ESR) in the current hard-IRQ handler, which is not possible for MPAM-Fb
> based MSC accesses, since they involve mailbox routines that might sleep.
> The same is true for clearing the interrupt at the source, which requires
> a (potentially sleeping) MSC access as well.
> 
> Change the error IRQ handler to be a threaded interrupt, but keep the
> handling in the hard-IRQ part for MMIO MSCs. This is needed since the
> CPU affinity check in the MSC accessors requires a non-preemptible
> context.
> When the MSC is using an MPAM-Fb based access, we push the work into the
> threaded part of the handler, where the accessors are allowed to sleep.
> Also forbid per-CPU interrupts (PPIs) for MPAM-Fb, as we cannot use a
> threaded IRQ here.
> 
> The actual IRQ handler learns how to deal with errors. We cannot really
> handle them, but we can try our best to disable the IRQ anyway.
> Should the level IRQ line deactivation fail on the device side, we mask
> the IRQ on the irqchip level, to prevent an interrupt storm.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>   drivers/resctrl/mpam_devices.c | 77 ++++++++++++++++++++++++++++------
>   1 file changed, 65 insertions(+), 12 deletions(-)
> 
Reviewed-by: Gavin Shan <gshan@redhat.com>

