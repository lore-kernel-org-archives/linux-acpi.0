Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0961552FA;
	Wed, 10 Apr 2024 09:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740981; cv=none; b=rCB7FJw6E7i564ZebG+pk3RL5leO0HTj8d0zapBEfjBc5D33XMb4v8eLd2eHAkLXdD2kgqhhD52GhgVlzW85gutpXIwTpWR4BVpm7BFomGsSHl/x2oXSN3aUHwxsZcvnQqQ1/fITqwRyCAlRbjO0Vr0fu1mq2l4Y1JXjm2EaD1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740981; c=relaxed/simple;
	bh=HO2FnhHrAqQmG6Lr/6jY4JA9h0GmAjWjOy8SP2bF+sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0dPCvO/9LTB5tANYdpq7ul9oRj8oB/niQM7zjGalyrUd4swcZinTm3xwdecu+QCqYsWGVZ0hs/vkHocwEqhOblE4xeB0UUzk5COqcObsbhxkjcSgK2Bu1t77G5FBBpSY1DTRas2nLO+b4Fo2B6Jk4TwDtnGRlTY3aAzBU39NZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1B1E139F;
	Wed, 10 Apr 2024 02:23:29 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B44CE3F6C4;
	Wed, 10 Apr 2024 02:22:58 -0700 (PDT)
Date: Wed, 10 Apr 2024 10:22:56 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Ruidong Tian <tianruidong@linux.alibaba.com>
Cc: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 0/2] ACPICA: AEST: Support AEST V2
Message-ID: <ZhZacAOVpAXK8lDE@bogus>
References: <20240410063602.41540-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410063602.41540-1-tianruidong@linux.alibaba.com>

On Wed, Apr 10, 2024 at 02:36:00PM +0800, Ruidong Tian wrote:
> AEST V2 was published[1], add V2 support based on AEST V1.
> 

Any changes to ACPICA has to get merged in the external ACPICA project.
Refer [1] for details from Rafael. You can also refer [2] in the kernel
docs.

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/all/CAJZ5v0g087vTJmgLHssedyCuhh61F_hR+TP3HQpoTACuzh+0jA@mail.gmail.com
[2] Documentation/driver-api/acpi/linuxized-acpica.rst
