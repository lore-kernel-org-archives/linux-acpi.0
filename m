Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C830E4AA402;
	Thu, 24 Sep 2026 16:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266029; cv=none; b=k1cCw09URzqcWJgcCxp3Nsj/l1RPEsXf/AoIzCOWe9pAPXuK1YqrDflmjY80S2FFhyRAVSpDuDKQCP7pDw60NKV0S7S/1HpnWusWc1BBICk9N4MbdifJPt490N3MONutonBe4x1xCQQiPVb6Qb66l0SNVfbESw851x3TgNrYN+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266029; c=relaxed/simple;
	bh=lXl6Nd0R/QjR9+3nhjJRhokfXwa/kgcoL2aX7Pp/xSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCal2Ekrqhnwe2TdZdMV9iANcXNJKcplF+g/QkF2Hu+5U5iisnQERAnhH/ZnMS9kXsEeZH7pvR3MPA/Td+V5SZ1XCmznt/DTXu7paDhLk5e68ZGlKRzbPtrtvR7v86ZupVjG7vMBS3CZlY8bE0t8VYeXJI3JEHMR8easgsCgjLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgRoCIE2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgRoCIE2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACD91F000FF;
	Thu, 24 Sep 2026 16:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790266028;
	bh=UQQt5zTm31incgpPNU6yRG9PMJPNleN1QlXN71hH4eE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dgRoCIE2qmrh6A7OlazIDECGB6B7PK1iK+ZENbVSoaqbUZm64tkS/cgNcy2HldiGU
	 Nopce9obSu7P5dapJP88xrCJoNrgFBUYBjgREOdnULW6qKvGc6a0eYBr+j/XnzMGFz
	 oDo2HA6WXhDInySGdkm3aalp0O3cA020pqJ9JbP87ZP1xsN+jdsVt1DU6/OVDT36JF
	 eFnZDOOWDXQw+wpKWC0wECZmtysonFz4wV/mINcvDpi7a8iwg+OIlN7MnvGHWCxQio
	 R8hhQJF4oroUcqF7dzqNVT7ORKFhtOqSvkSxxX/+lA242rRy9UXlKKQoI/hcIxCu+6
	 P+7NkWUxEOZlQ==
Date: Thu, 24 Sep 2026 17:07:04 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Jamie Nguyen <jamien@nvidia.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Dat Mach <dmach@nvidia.com>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] ACPI: arm64: FFH Operation Region support for
 FF-A (offset 2)
Message-ID: <20260924-private-bobcat-from-wonderland-0db8f6@sudeepholla>
References: <20260901192906.133670-1-jamien@nvidia.com>
 <20260922-purring-fennec-of-exercise-bbce5e@sudeepholla>
 <20260922155211.676134-1-jamien@nvidia.com>
 <20260922-exuberant-earwig-of-opportunity-4fecff@sudeepholla>
 <20260923124050.3270801-1-jamien@nvidia.com>
 <20260923-lurking-pony-of-fascination-ac6c49@sudeepholla>
 <20260923173240.3710620-1-jamien@nvidia.com>
 <20260924-tall-oryx-of-attraction-23ada5@sudeepholla>
 <20260924152321.3864148-1-jamien@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924152321.3864148-1-jamien@nvidia.com>

On Thu, Sep 24, 2026 at 08:23:21AM -0700, Jamie Nguyen wrote:
> On Thu, Sep 24, 2026 at 10:39:24AM +0100, Sudeep Holla wrote:
> > Which version of FF-A is being deployed on your platforms?
> 
> We have platforms with FF-A firmware versions 1.1, 1.2 and 1.3. The
> platform I have been using to test offset 2 reports FF-A 1.3.
> 

Thanks, will think a bit on this and see what is the best way to progress.

-- 
Regards,
Sudeep
