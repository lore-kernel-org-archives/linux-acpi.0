Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DBD377572;
	Tue, 17 Mar 2026 16:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765140; cv=none; b=hq4PjIIaPh/D35Y+9MUKbjLJrE9mSlrVYB107k73HUWVW4yLJMKAw8ilOc33CSYrCrnRh5pY1drpMQSDOqPFyt9G4T6EDDfdmcvGJTfoxpcmaBRsH+d2M4Gg3rtvOYHCCQ69/tMb3FyfxIkb2JffEvHPRPGL2wJnc/JiMIpoMv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765140; c=relaxed/simple;
	bh=8NOEMxfPkcH9K8TEbGismoeO9TvyxCj+fwHnNVOBfM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6GHlAQor1T+yELmfvVAFlp/1Vm7584bU6DD3biGj2nk04YCvNazURcdLBlFPXpn0D8AhleR/vMiFj25GDOxNgRcVEuUYS6B0igw7htp/sdfSNTQOW0egm7r+qDzi/NseqKVMSSllJ/VGZAEj7MedMdSjdROjmqEYvU2gswiY68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNVMmiLc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNVMmiLc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053EDC4CEF7;
	Tue, 17 Mar 2026 16:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773765140;
	bh=8NOEMxfPkcH9K8TEbGismoeO9TvyxCj+fwHnNVOBfM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UNVMmiLcYsv+j82Aqf8MncjQLuPjNA703tmZmA7r0O8/nUE1SAdWoznpgywiH6BMH
	 2Ho7hl8WMV6TXAnXVIEZ1F+eu+B8Qs97Beg6bxkSb7PAc21PfcuGwP9q44Tz9V+pwf
	 aTqbbZiIrXRAAX9X7c3x7pazr4ocpkj66/kqfIYsCdm0CKwzNxR5wD09YgUTdGKnoA
	 9aY3bFKCUPaCqfl5R0ZtayFq53TnBQXli8dhokw9gIptNMnWvMjQ+nRmUV3RRdpM9S
	 DtgvOsEeC0aOzuzv/pzACyhScv8m5ZYSAB/7MjVTGqqMcBHHKrXY+s1rsfxangcPh5
	 HDVEhsXZ8E3IA==
Date: Tue, 17 Mar 2026 16:32:15 +0000
From: Simon Horman <horms@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v1] ptp: vmw: Convert to a platform driver
Message-ID: <20260317163215.GA1753385@horms.kernel.org>
References: <12883468.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12883468.O9o76ZdvQC@rafael.j.wysocki>

On Sat, Mar 14, 2026 at 12:43:33PM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> In all cases in which a struct acpi_driver is used for binding a driver
> to an ACPI device object, a corresponding platform device is created by
> the ACPI core and that device is regarded as a proper representation of
> underlying hardware.  Accordingly, a struct platform_driver should be
> used by driver code to bind to that device.  There are multiple reasons
> why drivers should not bind directly to ACPI device objects [1].
> 
> Overall, it is better to bind drivers to platform devices than to their
> ACPI companions, so convert the PTP VMware ACPI driver to a platform
> one.
> 
> While this is not expected to alter functionality, it changes sysfs
> layout and so it will be visible to user space.
> 
> Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

