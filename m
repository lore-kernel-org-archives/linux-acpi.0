Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6213B961E;
	Thu,  5 Mar 2026 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772724562; cv=none; b=aTNdbMy8PnOOPIOa2lX+cICtwBvTd3v77X9a6eEJOPMohF4sZYR/h6AWGen+FBn1r/0CC6j9rQDthqzU3//Ko9ZZCprtGNpeKbfynnvx095gZm1QCub+EydYRlLOSaM3jl5W9toxyUCuwmNBmndMZ+a9TABj35ULuzsRWAF6cds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772724562; c=relaxed/simple;
	bh=7frGh7xH75Lkar4AlceGgLFBpHZ3Obgvi//zvnWvAh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHmfknPV1YuJsbWLj0X8BS/cx1A7s4k5iidjBizkDepeRzqU6XobNMBaCq4/vxPF99siRK1x9QZNEExEfQZkCX23YmIZfYCnAramz8b4opZR8z88hu20kh+TSrP9amsNjDzFYv8FyLherXwgFppSIHrxB4iCfCrgYDZgcvbrurI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+UtU1DG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+UtU1DG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729D5C116C6;
	Thu,  5 Mar 2026 15:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772724562;
	bh=7frGh7xH75Lkar4AlceGgLFBpHZ3Obgvi//zvnWvAh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g+UtU1DGdDmQncypT3DC8WE6IOj+sfXEuH7yohHc3A2nFqMFe6r9quGaZ3ooxGxSK
	 nn0vwDysSFqQDQ7Nn4sYqc9uR1p7OLOA+uJXpu6pHavsE4AtlcW75AS6Dk/f+KfulD
	 gY5jYJZIcW7tcC89g3Ddyp0rOBZYBT7Tvv0lsTFsjuzsAlHZks56j/VWlmyEhEHd5s
	 Td6EkW7s5geT49SYr326r6GjzM5nndC5WPcIOsFMumZ4R9QXGDWE/eifJiOZIO8uIe
	 Rq+uI8aVWFJ2eartQ6dEDYVd7itQBA74Z9CCV5wLxRHArtwjjRnpyHc/AeHUUxQCEK
	 gL/PoFncE137A==
Date: Thu, 5 Mar 2026 23:29:17 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: chrome-platform@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Enric Balletbo i Serra <eballetbo@kernel.org>,
	Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject: Re: [PATCH v1 2/6] platform/chrome: chromeos_tbmc: Drop wakeup
 source on remove
Message-ID: <aamgVMoJPXRigcI7@tzungbi-laptop>
References: <2274474.Mh6RI2rZIc@rafael.j.wysocki>
 <1931894.atdPhlSkOF@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1931894.atdPhlSkOF@rafael.j.wysocki>

On Wed, Mar 04, 2026 at 07:43:05PM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> The wakeup source added by device_init_wakeup() in chromeos_tbmc_add()
> needs to be dropped during driver removal, so add a .remove() callback
> to the driver for this purpose.
> 
> Fixes: 0144c00ed86b (platform/chrome: chromeos_tbmc: Report wake events)
                      ^                                                  ^
		      "                                                  "
No need to resend just for these.  I'll fix it as well when applying the
patch.
