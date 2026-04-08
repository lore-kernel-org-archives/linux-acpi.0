Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05353537FC;
	Wed,  8 Apr 2026 17:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669113; cv=none; b=cG6TVFMHI2QoFvuk9aowckoUghrzTj61ifEl/X6dNKjpcdpVICY5UWQR0wO61K3YoMVucPfTAGxz2sOlrHqdvT4l0nZ5+yuBD+17LDZLWpXCuQOuejM1hiKwkrCxDvlyeZDR4G4JJSkSc9KzDkIm5Bi5HrpEI2hjILWW6XQ6mGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669113; c=relaxed/simple;
	bh=PlRA8QfdMUAitutbdSmBZYJ4KOb7Lyoj5je3W40Rf1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ldl9l5dZOUyvK+y1wQSb5AXX9mqIhH0EnTeMEHDPeaHBVNsgLZHroRSWIwcmdTrhZSQpZ+Y7irP8jjObXIkaeLoGU403vqHvprtK0NVCXVlrdrSjMcaiWkYtIPE36uU2p5ub+MxiPvoStX9PjYaTyX8OHa9Aurc/OFnwWSrSR2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=giFTE8mN; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="giFTE8mN"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49B8F2D95;
	Wed,  8 Apr 2026 10:24:59 -0700 (PDT)
Received: from gaia.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D62F3F641;
	Wed,  8 Apr 2026 10:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775669105; bh=PlRA8QfdMUAitutbdSmBZYJ4KOb7Lyoj5je3W40Rf1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=giFTE8mN0nSUnk3L/Kghd5hCcCRFf7ICkTEYqy4RLQttthDSXVV7LXCDQihrxfr2j
	 9U8ej9kmpzkEC2xuEJWnRu3NTufh6tGa5lYdWF7U7I/DHirnMSGfPTaK/eDxUdqWWM
	 QP5eXyZILG/RZulGqK2AFdecP1icu3bedTpFAODM=
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Will Deacon <will@kernel.org>,
	Haoyu Lu <hechushiguitu666@gmail.com>
Cc: Len Brown <lenb@kernel.org>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ACPI: AGDI: fix missing newline in error message
Date: Wed,  8 Apr 2026 18:24:53 +0100
Message-ID: <177566909299.3319453.9218685711243749152.b4-ty@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407033117.100-1-hechushiguitu666@gmail.com>
References: <20260407033117.100-1-hechushiguitu666@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 07 Apr 2026 11:31:15 +0800, Haoyu Lu wrote:
> Add the missing trailing newline to the dev_err() message
> printed when SDEI event registration fails.
> 
> This keeps the error output as a properly terminated log line.

Applied to arm64 (for-next/acpi), thanks!

[1/1] ACPI: AGDI: fix missing newline in error message
      https://git.kernel.org/arm64/c/b178330b67ab
