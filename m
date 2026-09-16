Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805944D9F71;
	Wed, 16 Sep 2026 18:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584692; cv=none; b=aD0GMQSG4/L6mENJdDUdnnBQnyMIVuhXc4uOGkFJkzNXCVVTx9Fegv+3+ppuknDwB8Uzp4sRFekLYjDc9I52ocpY1oL1xIIM4y9WtRznKBICyO4rKn85yAFEeQFWP6HVFM3b8UlUYvmgOQZ3IuYZJMZ6VRit875Y4FXSMkjYN7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584692; c=relaxed/simple;
	bh=ramL7xdD9jtHGHY2Qorfo6+ZVo3zQdSkyqF8PP/eEQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJVfsERtALX/jK2FGKdmy3vyK9MrVffdG4zGFMY72E4+8Dt9JSo1+OW+YZ47LQiEtt+KRHsXPqHrOZChfv16TVLjMtMA8EVHbg0VpOA0EETRzaZbQoMR/gwxn/eKk2KCG8Zb4eCBdzb9PqTBiVvl/pZ6svQiYaRjWvhS04dvryE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VU4Muq9b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VU4Muq9b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D9D1F000FF;
	Wed, 16 Sep 2026 18:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584677;
	bh=f5WzQErrc+yFxfTGTKnaYzldCdgUA3IU5Oa6rEfLf/I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VU4Muq9bJiTCZC7j0bGisBsW0lFcvfQr1eIT5GbHcOq4ihTYZPT+tEuec5u2HhR/s
	 5sxDYtLwMTzKcJpzF04RmMm1H+qMowq7lu+yqIIc4zDqpsR0MmnkXWIe3wb8O+gMpi
	 8aeUZbCSI0xsDQ+FIVEYJ+TH0coN2thuQ7CIs8VCkL7l+YAx57AtED29VniDEOVcNJ
	 VXuDqeaYWNZHfVvqpTxyXAeC0N9toddqs1P1HZTlOJ7JxPKj7Ftx9RLiYjl8ZFIQeR
	 F8PP9JHEPVbHt75NVJcSFMfe8xJ020rSCaFBsQ+OB3x7qklbH+Nl1ZftVYC8IQrdF4
	 dVgIoKn7c+Ntw==
Message-ID: <77f3693b-9d45-4a1a-b2fb-3b168bc8542e@kernel.org>
Date: Wed, 16 Sep 2026 20:51:14 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] driver core/ACPI: Introduce companion_bus_register()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Driver Core Development <driver-core@lists.linux.dev>
References: <6329043.lOV4Wx5bFT@rafael.j.wysocki>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <6329043.lOV4Wx5bFT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/26 6:41 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The ACPI bus type does not allow drivers to be registered, so the sysfs
> attributes related to drivers created for it and its devices are
> useless, and its drivers/ directory is always empty.  All of that is
> confusing and wasteful.
> 
> To allow skipping the creation of those sysfs attributes, introduce a
> "companion" bus type concept and add a special registration function for
> registering "companion" bus types, companion_bus_register().
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


Reviewed-by: Danilo Krummrich <dakr@kernel.org>

