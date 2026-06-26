Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D4E37F8DA;
	Fri, 26 Jun 2026 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782489167; cv=none; b=HRBHA75ORbptyFZjIHOd9CfGJ1g8NRWewEi8QK0KWwhmkfdwSGXy9xOQiFkfaTyUfcicpdfhcv1VvBaeeBfdUccTDTcrp/KoOIV9l88WpyZ1NqYz2e2Y3Q8ecVaknnlc7FIbg0bW/0U6GQkSZ+rJJbGQ4c4oyVl5LEdtCWwiw0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782489167; c=relaxed/simple;
	bh=PfWCe/NO2GsQU5t7MQ3fXS7r5G1bpAPU1W46089xVOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hejqjgIuVKed6UpjrH595JfZYJLz/q0dfoGXeJ9X1rZrzDgs3zH2Usf24iAHbb6F1lTZCvW+XTVi9KKdq8SRIDJTuWG1DN3QP9ZGjLKUQ0raWotCR9TC6POO0E/2WYvyyBX4Wkx380IctK4Uc4tKHvN28kUkce1YUWUJs5PEe64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8rli3Fv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8rli3Fv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D502B1F000E9;
	Fri, 26 Jun 2026 15:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782489166;
	bh=Mvy4+9zf8wFjQYHAGd3aAa1rg7mWAsIuMf5ssqpnzEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I8rli3FvlBOmjl5oI/asHCtRLQAHNB9elXbBsHDUMX2/JPe6BLmr+aHM4T3XjMkua
	 B8rN26Ng5Le3VJCnlWI6l5Hc1WtgApBDHPa7eJUic4WoIU9oVWUotQOJgjqdQC63Yd
	 u4N7H6ceAawfbrZHp5sp9iObH/DQrPfK9dwkPUH2Zv4zUrkNFGnhb65iadVTscG2Vu
	 kuusX6bq4s73YmJxvgO/hHZIyMoZDOkiyH8ReswhUE4IwC2QnI5pYf0lyyMB6y25R3
	 KWcYlctwK4hQixpM9mPxOiwiB1sGD8na7F8laofqmsvJkEYXIDBua7QCwy9K7ZEGA4
	 Wyfs8aycy79KQ==
Date: Fri, 26 Jun 2026 16:52:41 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [RFC 00/12] RFC: Devicetree-ACPI hybrid mode
Message-ID: <20260626-friendly-ammonite-of-holiness-aabefb@sudeepholla>
References: <20260623145225.143218-1-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623145225.143218-1-johannes.goede@oss.qualcomm.com>

On Tue, Jun 23, 2026 at 04:52:13PM +0200, Hans de Goede wrote:
> Hi All,
> 
> Currently as soon as the kernel boots with a populated DT provided then
> the arch/arm64 code sets acpi_disabled=1 and the complete ACPI subsystem
> gets disabled. On WoA Snapdragon laptops where the factory Windows OS
> actually boots using these tables this is not necessarily desirable.
> 

I am bit lost reading the very first statement here.

Who is populating DT and why ? It seems that is the source of the problem.

If windows can boot with ACPI tables, why is it causing issues for the
Linux kernel, any specifics?

IOW why is DT populated which creates the problem you are trying to address
here.

-- 
Regards,
Sudeep
