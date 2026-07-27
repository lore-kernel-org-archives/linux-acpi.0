Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1CC41A549;
	Mon, 27 Jul 2026 13:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159591; cv=none; b=YoQrbx2LdNS5V8h79oZjfyHJHwZXKZar1djO9aoOyA6BllqM+5MIeCBgVNSLoGcVXS3ar19WBMgfG8HnVBEzVn2vRkqPdrv7EXMVGGps/0Majcc9h6JL5etv/KN/PepW33NraqYPOpGIDS9jHs8H/mRp8axJcWq/WK2iBoJMa+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159591; c=relaxed/simple;
	bh=nI5vmrUM6xxtmQqqlRGWsT8K5wS/QAyyejRECgCZNO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUPIunbFoNQE88P/M+oB6Ytmr5zaEw9lwBeFjQw3hdPbuAcyRNFHh9GHs/bV5YD0b5rEqFJSnyXbv9Io6qoG3pD1o7ziSMIUokVWsIlDXwnrCIqENkHSz3M84Z+fOsXiCMCma5B2qYNpi2Ha+ySNgxuR/Ez7RS1VHoGzon2VGCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFO4GhTE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFO4GhTE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291471F000E9;
	Mon, 27 Jul 2026 13:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785159590;
	bh=VwDBQNykuRmYGFu70OonIbUlNhBkjHVpvttegaysgv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TFO4GhTEu55l/gxs6ZO7F5k0XBouUZVcY8Wnv12bbamRwLLNatQPHWATnWdL9HxFd
	 r+VAoaAgTR21b/eHvUDcETfFbIwCWGnUXKje8g4PFPR8/RZ0UpILnp2Hky4wLfbkbw
	 0aWdtUxPsphaMtgoWLvGAZFZwmjICdWz9bHglTwWH05uGMIWVk49BeL4WSsism85SN
	 pwTuRW1HUxX5BU1Qdcso1OIYwny4WZDn/iIptKCZtH1qKcpSwnCXPmrsJT9qIYEswH
	 ZN/Z3DL7PXOWzItQHPt/nRfEq1vBLi9GLZV0I5HRxzO5kY7IvnYyrZ5/LuS7v84ITB
	 Mq4krSTIKuoYQ==
Date: Mon, 27 Jul 2026 14:39:45 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	Ben Horgan <ben.horgan@arm.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
	Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
	Trilok Soni <tsoni@quicinc.com>,
	Srinivas Ramana <sramana@qti.qualcomm.com>,
	Niyas Sait <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/10] arm_mpam: detect and enable MPAM-Fb PCC support
Message-ID: <20260727-apricot-spider-of-jest-7a03dd@sudeepholla>
References: <20260723155454.1760823-1-andre.przywara@arm.com>
 <20260723155454.1760823-11-andre.przywara@arm.com>
 <20260724-finicky-knowing-foxhound-df1e56@sudeepholla>
 <amdTr8Sxw9024CN7@lpieralisi>
 <20260727-knowing-bittern-of-tempest-6deb54@sudeepholla>
 <amdeITt0wL4FG2Am@red-moon>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amdeITt0wL4FG2Am@red-moon>

On Mon, Jul 27, 2026 at 03:33:21PM +0200, Lorenzo Pieralisi wrote:
> On Mon, Jul 27, 2026 at 02:20:02PM +0100, Sudeep Holla wrote:
> > On Mon, Jul 27, 2026 at 02:48:47PM +0200, Lorenzo Pieralisi wrote:

[...]

> > > 
> > > I suppose it is to have properties parity between OF and ACPI without
> > > having to change the driver property parsing path.
> > > 
> > 
> > Yes, that was my initial thought as well. However, after looking into it
> > further, I could not find any device tree bindings in the upstream tree.
> > I am therefore unsure whether MPAM is supported on DT platforms.
> > 
> > The use of these device properties appears to have been based on DT bindings
> > that may never have been upstreamed. As [1] suggests, the bindings were
> > dropped before the initial merge.
> > 
> > Although we could rename these properties later to align with any DT bindings
> > that are introduced, I think it would be preferable to avoid adding new
> > properties unless they are strictly necessary.
> 
> Ah. That makes sense, if DT bindings get published the driver can be
> reworked accordingly (if we want to improve how the code looks), this is
> just Linux kernel internals anyway.
> 
> As it stands the "msc-id" property is churn, that's what you are saying.
> 

Indeed why add more property with names that may need to be changed with
DT bindings in the future especially if we don't need it(IIUC it is already
there in pdev->id unless I am missing something.

-- 
Regards,
Sudeep

> > 
> > [1] https://lore.kernel.org/all/20251107123450.664001-1-ben.horgan@arm.com/

