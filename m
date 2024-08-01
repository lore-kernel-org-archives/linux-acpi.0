Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82F613D240;
	Thu,  1 Aug 2024 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722526403; cv=none; b=RrKX10i94INVxIWkO9oocVKgwn2kEWVez054evuiCOH4wpc5bySdVkNrCDZJrA89QF22QCN+UvJkpOMZsTkDMnyRCrqiq1stinZy8YwQvSunHW6dPFMfvql7MDXotqvKEyTGWIoYLwGEKSGknsweNvaVcBjkviIoM5KVESPKIAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722526403; c=relaxed/simple;
	bh=1S1+lncu6UL3HHzSafnl9hYhRAP/+AbnMNs+NLVIqYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lHipSAwghMEJrh1zNbF+bKNbG81TfHYRAQZ36L60jKAS/jEw98r8/oYBmkNP1Mu6bGw3KROIj60rDaBy7c1qKiJYDk5sf6t35exsBqn76kix+aYmU6/E9uNPXe9OXCP3xyMxI+qo++llnevYjrx2+fhvZXUQ6xoru/v6mZoJuOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=N5vZEe7V; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="N5vZEe7V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=a4Rn/
	EJTI2LS3gDhYQPhAGy9OuCknsA+8YIqfgWBvxc=; b=N5vZEe7VGZdfbcpncBFeI
	b4hSunmUajasjKkX8RDbhPB2jKB136HbEuN79IuE7AQpbp+h3tXNFUut9vhbU3hJ
	FEDriY4sM9RsAgrSIzv7NgS09w8WI6OfWWUyrcPWM+NRnGa+w/lAcnK3OQ5m8CVT
	cZBsk9cO+XknD9F4hymiAc=
Received: from nilq-virtual-machine.. (unknown [60.24.209.201])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wD3H6LSqatmzGQsBA--.58175S2;
	Thu, 01 Aug 2024 23:29:24 +0800 (CST)
From: niliqiang <ni_liqiang@126.com>
To: jean-philippe@linaro.org
Cc: Jonathan.Cameron@huawei.com,
	baolu.lu@linux.intel.com,
	devicetree@vger.kernel.org,
	eric.auger@redhat.com,
	guohanjun@huawei.com,
	iommu@lists.linux-foundation.org,
	jacob.jun.pan@linux.intel.com,
	joro@8bytes.org,
	kevin.tian@intel.com,
	lenb@kernel.org,
	linux-accelerators@lists.ozlabs.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	lorenzo.pieralisi@arm.com,
	rjw@rjwysocki.net,
	robh+dt@kernel.org,
	robin.murphy@arm.com,
	shameerali.kolothum.thodi@huawei.com,
	sudeep.holla@arm.com,
	vivek.gautam@arm.com,
	wangzhou1@hisilicon.com,
	will@kernel.org,
	zhangfei.gao@linaro.org,
	zhukeqian1@huawei.com,
	ni.liqiang@zte.com.cn,
	li.zhichao@zte.com.cn
Subject: Re: [PATCH v14 07/10] iommu/arm-smmu-v3: Maintain a SID->device structure
Date: Thu,  1 Aug 2024 23:29:22 +0800
Message-Id: <20240801152922.5605-1-ni_liqiang@126.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20210401154718.307519-8-jean-philippe@linaro.org>
References: <20210401154718.307519-8-jean-philippe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H6LSqatmzGQsBA--.58175S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFW3trW8trW5ZF43XF4Utwb_yoWDGrb_Kr
	nYqFZ7WF4UArs8Jr45KasxW3sxtrZI9w18JrykZwn5WF1DJrZ5Crs7ArWrXayIgr4xCF1k
	trn5KrnxJwnxWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU14lk3UUUUU==
X-CM-SenderInfo: xqlbzxxtld0wa6rslhhfrp/1tbiJBgu5WW-QgjyjAAAsZ

> +static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
> +				  struct arm_smmu_master *master)
> +{
> +	int i;
> +	int ret = 0;
> +	struct arm_smmu_stream *new_stream, *cur_stream;
> +	struct rb_node **new_node, *parent_node = NULL;
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
> +
> +	master->streams = kcalloc(fwspec->num_ids, sizeof(*master->streams),
> +				  GFP_KERNEL);
> +	if (!master->streams)
> +		return -ENOMEM;
> +	master->num_streams = fwspec->num_ids;
> +
> +	mutex_lock(&smmu->streams_mutex);
> +	for (i = 0; i < fwspec->num_ids; i++) {

Hi all experts,

Recently, I have been debugging the smmuv3 code in the Linux kernel,
and I have some questions regarding the `mutex_lock(&smmu->streams_mutex)`
statement in the `arm_smmu_insert_master` function. 
I would like to understand why streams_mutex is being locked here. 
Is it to handle different types of PF under a single EP, each with its own device ID?

Thanks.

