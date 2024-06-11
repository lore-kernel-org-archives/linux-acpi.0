Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35485731B
	for <linux-acpi@vger.kernel.org>; Tue, 11 Jun 2024 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124868; cv=none; b=RWaSf9psvwB+zpV1XiTmiRoAkvGliNmNLWO1AHLwiyRrj9Ryn1I2Oy2egVKMiGfVDRs6VugmfjSy3GUlu8OKG4lv2EDvrZ6bu7HsEY8Es4/D6b/bLFyRz/aW5UybFpNicIqmyDjOHQpsPT9c/7te+EmaGDec1ciO2faXRi7JAzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124868; c=relaxed/simple;
	bh=u4C50W0yT/CSW5eCnhZlnqeiSyrMo2CDx61ZBbunIi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHWMtpmBLPCHtpXLcS1zRpZ6UwrgMPry8zZeA3CKWFFaC+jBlGxpyyUBB1TbE6pqYNX4o7afCkV0jd2bYkPftmMZICwtjcCQf4HTXxDLOnrzxw4TtBa8dzirTTUXdwE0Rzr46LyDMvyfhey77iP6hD5d3TzZ8LLW1HNlL1nw5HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DC8C32789;
	Tue, 11 Jun 2024 16:54:26 +0000 (UTC)
Date: Tue, 11 Jun 2024 17:54:24 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH 3/3] arm64: FFH: Move ACPI specific code into
 drivers/acpi/arm64/
Message-ID: <ZmiBQC05N_YUzcYk@arm.com>
References: <20240605131458.3341095-1-sudeep.holla@arm.com>
 <20240605131458.3341095-4-sudeep.holla@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605131458.3341095-4-sudeep.holla@arm.com>

On Wed, Jun 05, 2024 at 02:14:58PM +0100, Sudeep Holla wrote:
> The ACPI FFH Opregion code can be moved out of arm64 arch code as
> it just uses SMCCC. Move all the ACPI FFH Opregion code into
> drivers/acpi/arm64/ffh.c
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
