Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3B53E49C1;
	Mon, 27 Jul 2026 22:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785192426; cv=none; b=P3dmIKUceoU4sWtfiNQQX6iXCnUGSdHMUDpAKnCeqBw9ed3+MWnaYOL1Oin7ggU7v9SlEvPtZotOQDW5ysFOYL4vUT4/mFayEz5FS/OV+yxXij5/zx4a75RCJri7ZZNu7nWxkMo+9tDptusuPifya2zfLSI2YTRNInOkN4NmOjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785192426; c=relaxed/simple;
	bh=Wb1cOpRF0agru60ac6F+Ho2LBiynNa3VzVOWwwgGSnU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JApAj9Ujq12MqxfesrtNfJRRMWlAkJJ0bK4AA5V7yiVxWo2tNmiO3sYmas+3fiIwPXc8o9pX9k7inLMH1VpcL9X2tVaEfs+OseLEOWhlDUpT8O33kqgi9KYnzrOVQOl3qaKj24uaAhqnuI4Jsv42gR2o1k2N94sbyUIXQ1Rq+i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7Zy0aNh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7Zy0aNh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6474D1F000E9;
	Mon, 27 Jul 2026 22:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785192425;
	bh=/Beq88uOHJ24V0VZGHYge0LPzaDqSYHq/p4rqe8cWWo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G7Zy0aNh/P3V/o/7NKw0az9jiNUeMcABPPk3xNTcd+3hEPAiJ15lYuicdJQLqiIHZ
	 y983eL0hIHIfdT38aIUZCGJ56PAZaMdPx8mP1jcRtj89tiE1QBavx/OME7Z7/cozVk
	 cImCUffiwykKIdJlouZM3U2UtZ5o40DrpEUmtxCraYElyYlc//IuXfu1diZIN1G0av
	 Ak2Plx1N9Eq3+kWRVSeg3QKvA3nL4DoNtc180P0mItgNPRgpBn/4ZkTYVja/ITvhsI
	 AKq+1aYZwBv3tIlMvq0B6EFIkv0p8Re7xHTRTf6nGseUXADX1QUhz3rEB9v9nrUfNs
	 V3NO9t1bAAHqg==
Date: Mon, 27 Jul 2026 23:46:58 +0100
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
Subject: Re: [PATCH v4 06/10] arm_mpam: propagate MSC access errors for
 state saving function
Message-ID: <20260727234658.3568bb4a@jic23-huawei>
In-Reply-To: <20260723155454.1760823-7-andre.przywara@arm.com>
References: <20260723155454.1760823-1-andre.przywara@arm.com>
	<20260723155454.1760823-7-andre.przywara@arm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 17:54:50 +0200
Andre Przywara <andre.przywara@arm.com> wrote:

> Allow the mpam_save_mbwu_state() function to return an error, and
> propagate read and write errors from the lower level up.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
