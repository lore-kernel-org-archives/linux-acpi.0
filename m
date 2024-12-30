Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AEC17C21B;
	Mon, 30 Dec 2024 06:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735541300; cv=none; b=kZCBzMQnuhn+/s/JjgONVt//TEkDlRg4rm7SzmmoOrNWZeOa38RuqiVB4YZYYogg7YuMcyH7u4YBxGUM2ujk3mzJdYm+MCt7X75pld+Mgg+cXEsN+MlKzE6xGKPDmMduloXGkVKFTLdDvvqbh6z1MdOtYgu7fNFq0YC49pEX1xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735541300; c=relaxed/simple;
	bh=BsxPl4ZpFAN9nB/v+/KpNW5TKIq9JqFPHtodUBsUCng=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NGSMd0R1w+Wq7riEccnemxOdRMT2JKUwJCjbKK8v6D6+KLcf9hFV6ZPXTuAJE+cXXMXnX9J6AE56htSMxWdEJ3Aaj+0LdmowCPYn6XLAbgBI2UyICy1ajVVNY8hNO9l+jgdJCyI7v7M9WqAYh89KzSn9sCofdYyKA0SSd+3/Tv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Fo6+nyNp; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Fo6+nyNp"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735541294; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=/AwuAd7NmxHOcLAwF0cZchKI9Q0tAqOE3/y0/huDXSE=;
	b=Fo6+nyNp9eQMZtGoYcDtI4ub0y8EG/pKGBPlJlHnv/EKMf05z10wrsDR5v7ZL6jGGRjzYzLbHHX2j3hG5jwng/Z3UlVAcRLhEk8lZAxxf7wLo0f7LQYkqJmGoXGaEaFGAFsHmZC8L9/MzN9OINCFBSXBOXnwvuFT8PeV8gM/AR8=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WMTFksv_1735541291 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 30 Dec 2024 14:48:12 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: hyeonggon.yoo@sk.com,  kernel_team@skhynix.com,  "rafael@kernel.org"
 <rafael@kernel.org>,  "lenb@kernel.org" <lenb@kernel.org>,
  "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
  "akpm@linux-foundation.org" <akpm@linux-foundation.org>,  =?utf-8?B?6rmA?=
 =?utf-8?B?7ZmN6recKEtJTSBIT05HR1lVKQ==?= System SW <honggyu.kim@sk.com>,
  =?utf-8?B?6rmA65296riwKEtJTSBSQUtJRSk=?= System SW
 <rakie.kim@sk.com>,  "dan.j.williams@intel.com"
 <dan.j.williams@intel.com>,  "Jonathan.Cameron@huawei.com"
 <Jonathan.Cameron@huawei.com>,  "dave.jiang@intel.com"
 <dave.jiang@intel.com>,  "horen.chuang@linux.dev"
 <horen.chuang@linux.dev>,  "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
  "linux-mm@kvack.org" <linux-mm@kvack.org>,  "kernel-team@meta.com"
 <kernel-team@meta.com>
Subject: Re: [External Mail] [RFC PATCH] mm/mempolicy: Weighted interleave
 auto-tuning
In-Reply-To: <Z27JXDwEmplZCDEX@gourry-fedora-PF4VCD3F> (Gregory Price's
	message of "Fri, 27 Dec 2024 10:35:56 -0500")
References: <20241225093042.7710-1-joshua.hahnjy@gmail.com>
	<874j2rp6or.fsf@DESKTOP-5N7EMDA>
	<Z22cwZycFV47wOfX@gourry-fedora-PF4VCD3F>
	<87cyhdhon1.fsf@DESKTOP-5N7EMDA>
	<Z27JXDwEmplZCDEX@gourry-fedora-PF4VCD3F>
Date: Mon, 30 Dec 2024 14:48:10 +0800
Message-ID: <874j2lll91.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gourry@gourry.net> writes:

> On Fri, Dec 27, 2024 at 09:59:30AM +0800, Huang, Ying wrote:
>> Gregory Price <gourry@gourry.net> writes:
>> > This still allows 0 to be a manual "reset specific node to default"
>> > mechanism for a specific node, and gives us a clean override.
>> 
>> The difficulty is that users don't know the default value when they
>> reset a node's weight.  We don't have an interface to show them.  So, I
>> suggest to disable the functionality: "reset specific node to default".
>> They can still use "echo 1 > use_defaults" to reset all nodes to
>> default.
>>
>
> Good point, and agree.  So lets just ditch 0.  Since that "feature"
> wasn't even functional in the current code (it just reset it to 1 at
> this point), it's probably safe to just ditch it.  Worst case scenario
> if someone takes issues, we can just have it revert the weight to 1.

Before implementing the new version, it's better to summarize the user
space interface design first.  So, we can check whether we have some
flaws.

---
Best Regards,
Huang, Ying
