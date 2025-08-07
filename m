Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A54226D18;
	Thu,  7 Aug 2025 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754576021; cv=none; b=gyuRY794Ac60qjT1UsDP2wCN5d3ilrkb+giYDu8tvzxgtbZtRZTNQbNgzXb/yBqCOGNDqR76nTojL95RBj6/QwrkmbjwL1i1esxv8V/IhPLNXPuAB/Fp2xtDqW/VCeWB6vqAMQDRDtVw7ulTPxFeff8Km0WHQwLQEdBNny1NHnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754576021; c=relaxed/simple;
	bh=E+eLn3f/GeSRUYG+jeYdbBSrHNQ2zA+yH8B43XY2V2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YG0cSFN14Nx1fakSoxI25S2Yx8u43VoxujSHjRTcimjEOHiLd+RI+zbkvw8eUnmkkeYEDeEmWGei+CfCZjhdgeKqUgFtKvt4EyEzrE6it4RjQk8u7Q5ORuVWUvW4Vub7BLvFcshPc9i7cPx0WxfeTfJkYHFGoj2VKFuHvFaXc7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32BC41758;
	Thu,  7 Aug 2025 07:13:31 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2168B3F738;
	Thu,  7 Aug 2025 07:13:37 -0700 (PDT)
Date: Thu, 7 Aug 2025 15:13:35 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Zhen Ni <zhen.ni@easystack.cn>
Cc: <jassisinghbrar@gmail.com>, <linux-acpi@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v5] mailbox: pcc: Add missed acpi_put_table() to fix
 memory leak
Message-ID: <20250807-piquant-dramatic-spaniel-f0f4a0@sudeepholla>
References: <20250805034829.168187-1-zhen.ni@easystack.cn>
 <20250807032831.451863-1-zhen.ni@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807032831.451863-1-zhen.ni@easystack.cn>

On Thu, Aug 07, 2025 at 11:28:31AM +0800, Zhen Ni wrote:
> Fixes a permanent ACPI memory leak in the success path by adding
> acpi_put_table().
> 

NACK as you need to copy all GAS register reference which otherwise would
cause issue as reported to your v4. Sorry I do know I did provide the
Reviewed-by tag as I clearly missed to see this copy of reference to the
GAS registers in the PCCT which is being accessed later which makes it
impossible to drop the table reference unless you copy them to local
structures.

-- 
Regards,
Sudeep
