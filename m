Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F21C1BC2A
	for <linux-acpi@vger.kernel.org>; Thu, 19 Mar 2026 00:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773878892; cv=none; b=QbI7+jsmzo0fJP9jQUvGbVWlRmn1HNGrGGenW4PucFz4+oYX/b2zZIbvCOpvNsJNXD/FB2ekZ5nuerWYYCuqTlL0zl6SuAGq1UO5wX4TqmbBNAdYjLIWZ6PZ6Xp0quGa/mv7VW1ikrhv08iL58QdeJOpRyM9tNSvIzs6mmn88Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773878892; c=relaxed/simple;
	bh=9Lna6RLq1PceWhp4JFSVoi2qGNT1NzgxgPC7c15ur54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjE7EataOIVqLX7TOql3vZeZIShLqlaoEw/tqDjnmQGT/amIUNlMvBPCP1BnJItN3dX0Z2wMgQcY+ylv9CdgV7CnumyQxt/W736J+AksyJTKoXV7rya6VCaswLyIonXtAtjEncUVytlV9ikao+Rq8yJDEeWBS0eT1sP137ojN3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T0fVjXQJ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T0fVjXQJ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b052562254so37375ad.0
        for <linux-acpi@vger.kernel.org>; Wed, 18 Mar 2026 17:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773878891; x=1774483691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AY/dmLi/z8SUAAMZ2gqdSfQxfr35ot2Vi6eYrVHNvEQ=;
        b=T0fVjXQJWsIpWMCo3HClXvxa+7t3/DeRrcHa183/FzrNDvQROdrC9kkPD9N/bVOBCo
         ZrQfI+K7HCqTdg9rsG9wZy2TRwOMd7rNjm1Qa0sIvUgt2YCYNWqvEROy+0mLHByzUIRh
         Jn0+BONOwGrOg5MFeFJQrH9ck4Z9dZ6d3OehYpE1FdUdHhNbEn68eYfgYDBLGlhwtyY8
         q+wWjc/b31J1txHAOD1Rhb/W5xbbdH4wCW6Wqs348mCGfsLh1tJBlzecmqeqhurk3JJT
         2yOYidjaMzJjnQ0e62kVVxI23jtuM+6feCWHXW4inTZFI1Ojht/bTZSf9v/GeW2LpNDw
         67yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773878891; x=1774483691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AY/dmLi/z8SUAAMZ2gqdSfQxfr35ot2Vi6eYrVHNvEQ=;
        b=A6us+oUjeqyDOWwOmyFpLd/U0Br21jGQD3YXxKq/4gyJm0c89XvP/BmEBLaHOXmVIz
         d7KnkgprIZTDzczJkM7XGAIu5A+YsfrTyYqydz9IP6tJVAmXqEYKbN6ogAt2bTLVLgA0
         n3hwDSXVuc/yZNIb1hoYDqGhuMkyI7MCnldJuWhIAUSw/1dhUnDvlQZN3TyFi4lQ03H/
         RZ2kZrSqL5bGTFWujge1uTJjjXBEkOFIsnL07RtrD1Rgm4Ol6Rl0FfMIRhN7v+098Xs+
         5Nh5CQTu6pzIEmtVtd1vAvUI0DLF1aCsRop6zyGNbdbG9niTCx/uYULsWrxJO54hZu2Q
         I4sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUo/uibQKokGInkkhm2RP2H3FgpFjTRLkv4txRVBlf6pjfQ9efnrc7FJmZTwmlNtDi+N47zuUaepVRb@vger.kernel.org
X-Gm-Message-State: AOJu0YxN6nW4MODSlKRhFin5Vs+GoIsZuiXNIgppTC0Mg+FKGyoUw0zA
	M6vmY9lTgUoRuEfEO5dcwUGlsbaJJ4ImTgNAMZywdgqHFT26sR1lzG2/iF4YEu5+ww==
X-Gm-Gg: ATEYQzyKKqmHls7fegmHpD2HctBcJKSozi8NDEtjEja00GXFpX+COlhhvx8K3vj+sTe
	0uC60oY7nppq/S9IzztHQJr1xTdbiElurAVA/T4xFHbpVcTX5DpN1gJziSIir9H3qV3sKGbHpJY
	cNDFMjz4KcEDFt9C3yGxmh5tZh9q7LHeIaMbDpg5e5f9Cm26mOB5le2VL6YfmJKF8yU5MP7kEQ8
	cpy3e45OcioO0EoIzQxlD8XKROGOdAOSiDOgxi9vbalgG1NYAVuZbCu0INWMdPgkqCBEfdcroD/
	DhYoQU3r3p0gv1+iXg1+WOhoWAf91nyAwfmwMHmxTEAjsC0kROz8w8HnRCAL3WelQrYyVFCPGNB
	T5QC+g/hSTVQmDIQi3hNQXRl6mAVE4Sn8ZvtQYqUecae1ypQQ0GO59TYf2CUK3Jal5gCS2jXoqH
	vMSTv+Ll4rn7N7ulhRwjkaluiRhH9Jx2p/VHqngsTl3Q8Pgj2tN39PNFQxQiu6RA==
X-Received: by 2002:a17:903:2ac7:b0:2ae:45cc:aeb6 with SMTP id d9443c01a7336-2b077b4ca86mr1596195ad.6.1773878889199;
        Wed, 18 Mar 2026 17:08:09 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbe6162sm3741880b3a.42.2026.03.18.17.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 17:08:08 -0700 (PDT)
Date: Thu, 19 Mar 2026 00:08:04 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	bhelgaas@google.com, jgg@nvidia.com, rafael@kernel.org, lenb@kernel.org, 
	praan@google.com, baolu.lu@linux.intel.com, xueshuai@linux.alibaba.com, 
	kevin.tian@intel.com, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, 
	vsethi@nvidia.com
Subject: Re: [PATCH v2 4/7] iommu/arm-smmu-v3: Mark ATC invalidate timeouts
 via lockless bitmap
Message-ID: <abs6PudCAh-eVRPA@google.com>
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <0c5525367cc67ccc84a675544d1d9f8462704065.1773774441.git.nicolinc@nvidia.com>
 <absfAT4jgL2f3UfR@google.com>
 <abs0CQCrFlCsV6Ls@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <abs0CQCrFlCsV6Ls@Asurada-Nvidia>

On Wed, Mar 18, 2026 at 04:23:53PM -0700, Nicolin Chen wrote:
>Hi Sami,
>
>On Wed, Mar 18, 2026 at 10:02:32PM +0000, Samiullah Khawaja wrote:
>> On Tue, Mar 17, 2026 at 12:15:37PM -0700, Nicolin Chen wrote:
>> > @@ -895,9 +898,19 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>> >
>> > 	/* 5. If we are inserting a CMD_SYNC, we must wait for it to complete */
>> > 	if (sync) {
>> > +		u32 sync_prod;
>> > +
>> > 		llq.prod = queue_inc_prod_n(&llq, n);
>> > +		sync_prod = llq.prod;
>> > +
>> > 		ret = arm_smmu_cmdq_poll_until_sync(smmu, cmdq, &llq);
>> > -		if (ret) {
>> > +		if (test_and_clear_bit(Q_IDX(&llq, sync_prod),
>> > +				       cmdq->atc_sync_timeouts)) {
>>
>> This will not be set if a software timeout (1 second) occurs. Do you
>> know if the ATC timeout of Arm sMMUv3 is less than the software timeout
>> in the driver?
>
>You brought up a good point!
>
>I think ATC timeout follows the PCI Completion Timeout Value in
>"Device Control 2 Register", which is typically set [50us, 50ms]
>but can be set up to [17s, 64s] according to PCI Base spec.

Agreed.
>
>> If not maybe we can handle the software timeout here also as the cmdlist
>> is already known?
>
>I think it's trickier.
>
>If the software times out first at 1s, it means the CMDQ is still
>pending on wait for the completion of ATC invalidation. Then, the
>caller sees -ETIMEOUT and tries to bisect the ATC batch or update
>the STE directly, either of which involves CMDQ. But CMDQ has not
>recovered yet.
>
>Then, in case of a batch, all the reties could timeout again. So,
>it will fail to identify which device is truly broken. This would
>end badly by blindly disabling all the devices in the batch. Also
>the disabling calls require CMDQ too, so they might fail as well.

Yes, looking at VT-d currently and the queue length is 256 and this
spirals out of control quickly.
>
>Thus, partially to answer the question, in case software timeout,
>I am afraid that we can hardly do anything.. :-/

Agreed.

Do you think we can maybe document this somewhere? Maybe add to the
cover letter?
>
>This means I need to set a different return code for ATC timeouts
>v.s. software timeouts.
>
>Also, there is another problem: when PCI CTO finally reaches, the
>GERROR ISR will set atc_sync_timeouts but nobody will clear it..
>So, before calling arm_smmu_cmdq_issue_cmdlist(), we need to make
>sure there is no dirty bit on the bitmap too.

Yes, Just to confirm, do you think this needs to be handled regardless
whether we handle the software timeout for the ATC invalidation?
Basically to cleanup the bit on bitmap.
>
>Thanks!
>Nicolin
