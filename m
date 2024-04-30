Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07E4175560;
	Tue, 30 Apr 2024 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714493779; cv=none; b=hz1hk3uiyUpzlZwUW1l4wOG9iLotTl9nX2oagvhWAew6sM2V9UC0O8q9z7JxEhCL9+rEF84oxB8QoVNXvnEjd+qC2O0P1xXFJYrR6vCo+I0r9ppuLWBnmP2wERa745Aptvv/U+nogY19chA165VoQH9cIiLQTB08FTF3pgi62tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714493779; c=relaxed/simple;
	bh=cLaj4cEA+dcWsFhapRjcDitwcSh9v3HR49WdmWsq/LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxx31Tudr6a3IeAjMkm5lPjVj9vN34bFEgYysnqxW8MEbbahUfwU03ENDh+/s5XllB9iS4aXKkDSivpcYwVD9tL4tdZKH4p9Edy6+H3UwhusrfIK+7CgfKdrbRcT18Ku9FwiPCMi6N5HEGdQK1TOIYyG94oZmf2cIjBjUg2gm3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36A802F4;
	Tue, 30 Apr 2024 09:16:43 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4DBA3F73F;
	Tue, 30 Apr 2024 09:16:15 -0700 (PDT)
Date: Tue, 30 Apr 2024 17:16:13 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v2] ACPI: scan: Avoid enumerating devices with clearly
 invalid _STA values
Message-ID: <ZjEZTfU-u6m5Fx7a@bogus>
References: <12427278.O9o76ZdvQC@kreacher>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12427278.O9o76ZdvQC@kreacher>

On Tue, Apr 30, 2024 at 06:02:20PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The return value of _STA with the "present" bit unset and the "enabled"
> bit set is clearly invalid as per the ACPI specification, Section 6.3.7
> "_STA (Device Status)", so make the ACPI device enumeration code
> disregard devices with such _STA return values.
> 
> Also, because this implies that status.enabled will only be set if
> status.present is set too, acpi_device_is_enabled() can be modified
> to simply return the value of the former.
>

Nice!

FWIW,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
