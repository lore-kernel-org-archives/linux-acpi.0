Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676B625776;
	Wed,  6 May 2026 05:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778045024; cv=none; b=nSVnMNcvlAfWY7zIkYF8kvR11vaQZood8VIGuoi92qSAhFbeurBLQFQStSR/haLA6ztzLPGxmsInEXqlW486zFivmKvWLl5ooZ7s9bP0o8+gL9vDKVFQI96bMFNfKqaWFwyigtL1gRwQMd2tcbY4sUFBG9FEM0FH9fOW51hnd6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778045024; c=relaxed/simple;
	bh=tY4EHy5704MEG5sQCPiDUbrUl2EdNaX2x/Mjhna3Xao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5HOGE6r3S8YjGY66DXY2NjVI/8aSzXhy+7bSpHVj6Ab0b9vD3d8DOnEuCagro80jX4sErUk6AeO2vPyQAbmQzY1jPADMQV8sJ4xNFCMRzL9R4AcWEQ3XcEAPSU6T1GDZmzpYF9xFZg3eGyUyKhhjy0bm/d0b2kESX8NC/hldPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sakx0gVj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sakx0gVj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF12C2BCB8;
	Wed,  6 May 2026 05:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778045024;
	bh=tY4EHy5704MEG5sQCPiDUbrUl2EdNaX2x/Mjhna3Xao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sakx0gVj9hdA9Reb2n5vGHTXO7jjU3Xp5bPdch4feTwBDgjSrTSReRiuGOL/T0vFD
	 teFw5qEt2xVbvkD+wsLjWHDix4LyB3EQFuDQT58Y6aSc0ZWnI6frcBCZkWLNdJfF2P
	 ts5Dk3hvgjkZ6wX4K5ssy4hz8WeMHnmo0seEfcIc=
Date: Wed, 6 May 2026 07:23:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, skelley@nvidia.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: CPPC: Fix related_cpus inconsistency during CPU
 hotplug
Message-ID: <2026050654-plus-reactive-d67a@gregkh>
References: <20260417040112.3727756-1-ruanjinjie@huawei.com>
 <16c9b1e4-0ae4-4a81-90be-15b03f2ea176@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16c9b1e4-0ae4-4a81-90be-15b03f2ea176@huawei.com>

On Wed, May 06, 2026 at 11:30:03AM +0800, Jinjie Ruan wrote:
> +Cc Greg Kroah-Hartman
> 
> Would it be appropriate to cherry-pick this change into the stable branch?


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
