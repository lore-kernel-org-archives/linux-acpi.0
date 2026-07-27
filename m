Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6872275AEB;
	Mon, 27 Jul 2026 22:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785192090; cv=none; b=QW2M8jjzJuHluutryOFxwbyvCUmawYnLBvn48kkJemU6CYNc+n71vyOXU/zCe313joV2M4ZCXV1lvX2bu2CIlCRb9EO5xh7y4fX/azJ4jNXnj/MLYz/RRlG+AuM/oCOqaR1yiyB/qD7MmJ0clkxuiohtxmotueF0Nxcw8DhmdxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785192090; c=relaxed/simple;
	bh=9a/qFKvv4dafl9+LLD1Lmg6hml3Mrpmd96afnuQuaOY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dVjycCR3Qd4ok0JOnrzXPzWluG/9Lgp2pWbtbdume1RGWOAgpQka9SDaGN8NOrEJzKNwM2meazM7hWNh8b7RDbaI9ShaNmfFTg49e/U+4af2m5BW3DEUv8Btd/BTQgFD5FNfVgKOAm16Oxve0sLXHTFBqqzMaWQrDSMhMEbJOVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLNmvOjZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLNmvOjZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898371F000E9;
	Mon, 27 Jul 2026 22:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785192089;
	bh=MhDFgFWw4dRynh3xb8krNzOwzq/udnrrAoiD2bS2QJc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nLNmvOjZoUi5/YfUo7JlIKbjI1XyVnHnVTO3e6w8bzdSQEErx03/maa1MAqXel7Lf
	 +N2MbEmOcsGodpN8t9vl+jUkU6CixqgH5FXRES6zlKgGfc++ZOB7lWDRhKm/anzpKG
	 z4rVymt8iXBobnWuM0Yfu4YT9gzY+DXyH7WvLT67vLyYn4HhFv/DLGrzsSWudHlmsa
	 EfDXLPfFSGotwaf89kw+ksnJESYzQ0NR7hIHtsnbSfiap1VY2PHLfDkTWQ3I0sr3Y3
	 /F/zIDHVxpx92flC99mb92xhubAusVWU7Yl/7BumswBR89Riy8+8aDqAmdh37R4k7P
	 rjcjIKjIKywwg==
Date: Mon, 27 Jul 2026 23:41:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Rafael J
 . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, James Morse
 <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>, Reinette Chatre
 <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>, Srivathsa L
 Rao <srivathsa.rao@oss.qualcomm.com>, Ganapatrao Kulkarni
 <ganapatrao.kulkarni@oss.qualcomm.com>, Trilok Soni <tsoni@quicinc.com>,
 Srinivas Ramana <sramana@qti.qualcomm.com>, Niyas Sait
 <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/10] arm_mpam: propagate MSC access errors for
 msmon helpers
Message-ID: <20260727234124.4834835c@jic23-huawei>
In-Reply-To: <20260723155454.1760823-5-andre.przywara@arm.com>
References: <20260723155454.1760823-1-andre.przywara@arm.com>
	<20260723155454.1760823-5-andre.przywara@arm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 17:54:48 +0200
Andre Przywara <andre.przywara@arm.com> wrote:

> Allow the helper functions for msmon accesses to return an error, and
> propagate read and write errors from the lower level up.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
I'd take another look at this one and consider if a few more blank
lines would help with readability. Otherwise LGTM

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
