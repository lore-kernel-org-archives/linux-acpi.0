Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FA838AC89;
	Thu, 19 Mar 2026 17:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773942671; cv=none; b=AD/h9z1LK947GCVjerkFlMTFZ1C4WNgUtm28pdt1PJBjbHif/7oNSTY6xq3feyNI1gpKJPlZzN02dLFT/a3bwFde4w2ZhPFjbUSRF+adBtcsNHghZsfjCS3YnleFAOPikU9KV2KFlxN0ZVQT1B4KnKG4/ZnUvL2TuUGPnpAHbX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773942671; c=relaxed/simple;
	bh=P4nEYDIFq57dZDYX3ktkthGpLNQSwZEtxdpf0lSyWuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SeaUXMYoi+OwB8LifMLB5FkwPVfWoSiV7VZnrERIbrBaw3054VABC8K0PbwFXBwNa+k5CwrPOM1FL7LMuenKzSpCzJxLQrCDNhINz1tjoTyL3i5CMHis8R6h4i4//ZJFveH1yt+qUhe6/bKWvhFPv5oVwIHHTk+Ue7DfqYRtFng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFF1sqVu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFF1sqVu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE4FC19424;
	Thu, 19 Mar 2026 17:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773942671;
	bh=P4nEYDIFq57dZDYX3ktkthGpLNQSwZEtxdpf0lSyWuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YFF1sqVu9ayD7RFRYegabF1tVKx6PRxS74YjDAvynIKOWriBanO1cCcMWlF7QNY2m
	 2R+5/Y8bBYaa0hr727MzzIf2pPn0SoxGW1lS+qvmVRdszw6hiiXmz1rNMXwTvQAfF/
	 19va8p/zCf8mk4EyzYsfQWtahMvnpQ9JjijBeyUnaYF1+MSjE/d2JWM3KblU8tT6eX
	 3XCzP4KMs+gRRqtddSeY+JergInfvnRLl5yAlvkDgfZux5UE0mCXlz84Y5aqZ8uJ2N
	 TaP2jFwPVeNa51tQ+jmbTFLjWWRkwiYCDijqK5nzswBGwkUTAZRP9W2nCmOE6mnP4m
	 2D/yaVXCd2Mbw==
Date: Thu, 19 Mar 2026 17:51:06 +0000
From: Simon Horman <horms@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v2] net: fjes: Drop fjes_acpi_driver and rework
 initialization
Message-ID: <20260319175106.GQ1753385@horms.kernel.org>
References: <12857407.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12857407.O9o76ZdvQC@rafael.j.wysocki>

On Wed, Mar 18, 2026 at 02:43:55PM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> The ACPI driver interface used by the Fujitsu Extended Socket (fjes)
> Network Device driver is redundant because its only role is to create
> a platform device the fjes platform driver can bind to, which can be
> done already at the module initialization time.
> 
> Namely, acpi_find_extended_socket_device() looks for the requisite ACPI
> device object anyway and it may as well check its resources, and the
> platform device can be created when the ACPI object in question
> has been found (and it can be freed when the module is unloaded).
> 
> Moreover, as a rule, it is better to avoid binding drivers directly to
> ACPI device objects [1].
> 
> Accordingly, drop fjes_acpi_driver, adjust the module initialization
> and exit code as per the above and set the fwnode for the fjes platform
> device to point to the corresponding ACPI device object as its ACPI
> companion.
> 
> While this is not expected to alter functionality, it changes sysfs
> layout and so it will be visible to user space.
> 
> Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2: Add platform device unregistration to the rollback path in
>    fjes_init_module, as per
> https://lore.kernel.org/linux-acpi/CAJZ5v0g9BinHfQDS6hUvVHdLxDPvbv7ck=m1Bqa=+C3iE+vgxw@mail.gmail.com/

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

