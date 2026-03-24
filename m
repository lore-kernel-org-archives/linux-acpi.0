Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EDA354AE3;
	Tue, 24 Mar 2026 20:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774385031; cv=none; b=BiIWNtoIQqDa4ffUxyZHZfQjKOX+prnxKjb/bruuKMsc+YlN2MoYoc7NOL0Zx6ysaO/RrwiOtZGOMQbap+f1nEoXVqR7ff/LMRs6V89gk74afXs3GYTNtGeEtU8kgergEAf7UPFYJNAvWjh7xFfgjtSckY4A43SIevAY6wTbRXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774385031; c=relaxed/simple;
	bh=Y3QiclO0lrDyeA+85nw8qvgahOPE+PZvguAY4/Jnfgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9n+eETPweIdafMFtw3ZDNqZ3cZijK2tIvW9sgAssGnBC3sVoXceYZtKV4OAe4Vq3Fbu3gOix3Tzs3vsocGc/0YA+DLSHwwwqW/rxf7XlrFJjvZzAyFgCRJ5Ypvx7oBDZ51c9VfdcrDW8hnUIv2dbpmBPG4iAjgrN/eS+tsOzc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkIjgZku; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkIjgZku"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1C6C19424;
	Tue, 24 Mar 2026 20:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774385031;
	bh=Y3QiclO0lrDyeA+85nw8qvgahOPE+PZvguAY4/Jnfgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DkIjgZkuwepPo4pw68Oo/2XtP7FWF9EVaS35Y+SQETfhfLwlb6KH6xiX+Dj3IZwVE
	 h8uTPCnnB1LXPnUZHjy3g5CTASQE1u3DaCDcz6JXAsyZf9XnS2YhPhLOYhiwTRqH5G
	 oqL67P+hsjjl5j9k/+iO0VWUjCL3NZzuPqyk2g8D1VqbLIzWVQUVn3dnF4kz+iHKyJ
	 owWda+EUT20vP9FdBqtbs+QZCFzxgiAfQUGKYWL1A6lj4ihg9bj0S4iBAywL8fnL/g
	 hRDPBXvG+Yec3RkGui2F06d9IdSQOtIIupfHPoSGYgxtGTxeoYo2UtUiUfY/myoRAg
	 xT/fD375xKiuA==
Date: Tue, 24 Mar 2026 20:43:46 +0000
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Ben Horgan <ben.horgan@arm.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	Sudeep Holla <sudeep.holla@kernel.org>,
	linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v1] ACPI / PPTT: Remove duplicate structure,
 acpi_pptt_cache_v1_full
Message-ID: <20260324-nostalgic-adamant-coucal-7afd8b@sudeepholla>
References: <20260324113300.1002569-1-ben.horgan@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324113300.1002569-1-ben.horgan@arm.com>

On Tue, Mar 24, 2026 at 11:33:00AM +0000, Ben Horgan wrote:
> acpi_pptt_cache_v1_full was initially added as a stop gap until the
> equivalent structure imported from ACPICA, acpi_pptt_v1 in actbl2.h,
> contained all the fields of the Cache Type Structure. Since, commit :
> 091c4af3562d ("ACPICA: ACPI 6.4: PPTT: include all fields in subtable
> type1"), acpi_pptt_v1 contains all these fields making
> acpi_pptt_cache_v1_full redundant.
> 
> Remove acpi_pptt_cache_v1_full.
> 
> No functional change intended.
> 

Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

-- 
Regards,
Sudeep
