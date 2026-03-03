Received: from cnc.isely.net (cnc.isely.net [192.69.181.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA40137F723;
	Tue,  3 Mar 2026 21:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.69.181.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772572368; cv=none; b=pcbJM3FfngAIzqQYNZXhbGuE2gPSuALyi1Fmdg9kzn6LWSD7xvNOSSxb+LoZcVMb411chbjUiqGyT9xDxQaKhNQgVVq/jW+MsI6xpEArnL+ZL8PX4Bs7iMBoeoKiYMXeq0u9HSfqTP5KNsTPskO9+AAyHll3z+YqAfydPJwh1xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772572368; c=relaxed/simple;
	bh=dRXK6/awjk2Kxgccsg+IJyWo/Jvy8DrhOKp/mAjCAys=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Mime-Version:Content-Type; b=g0rxu9Ymj43y5lR3eNtPi0m7gS7OqtWYLdL2lj6Q0aVKTzpUgXUPxhyu0bN37E/HfvkJUM+vEhCLiiQVmztHdmR4yuikd2OS9sHoXNikg7KEPJBvNAKNJG512cXo1vyjtoUuPnq3A4IpsK9UJvCdKderuiT7aFKL80kBd3rnZ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isely.net; spf=pass smtp.mailfrom=isely.net; dkim=pass (1152-bit key) header.d=isely.net header.i=@isely.net header.b=Aclw0TWO; arc=none smtp.client-ip=192.69.181.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isely.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isely.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1152-bit key) header.d=isely.net header.i=@isely.net header.b="Aclw0TWO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=isely.net; s=deb;
	t=1772572365; bh=widlcjRiMNafN4+/A9h0WgcS9CJFKWAEN3NALlbEnSo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Aclw0TWOeJYwZu2G8pF+V+hVoDu4ubbbTdrLSsdRH98jMCZDHIlIyK/vNU/ce/+56
	 iHNar9IENvB0SlZREf/KZ0jnfHWaIv0p9lFS7i3QNFj/7KY4KwYuBCQg4PK14C7OTn
	 acxy5I3AMKgh/mOYRfXTHMxL+Ax6ZJYFtUNPvW6Gx0ACtXF4GT00jQbaqQFpb
Original-Subject: Re: [PATCH] sofware node: Only the managing device can unreference
 managed software node
Author: Mike Isely <isely@isely.net>
Original-cc: mike.isely@cobaltdigital.com,
  Daniel Scally <djrscally@gmail.com>,
  Heikki Krogerus <heikki.krogerus@linux.intel.com>,
  Sakari Ailus <sakari.ailus@linux.intel.com>,
  linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Received: from ts4-dock4.isely.net (ts4-dock4.isely.net [::ffff:192.168.23.121])
  (AUTH: PLAIN isely, TLS: TLS1.3,256bits,ECDHE_RSA_AES_256_GCM_SHA384)
  by cnc.isely.net with ESMTPSA
  id 00000000000A0006.0000000069A74ECD.00002895; Tue, 03 Mar 2026 15:12:45 -0600
Date: Tue, 3 Mar 2026 15:12:45 -0600 (CST)
From: Mike Isely <isely@isely.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: mike.isely@cobaltdigital.com,
  Daniel Scally <djrscally@gmail.com>,
  Heikki Krogerus <heikki.krogerus@linux.intel.com>,
  Sakari Ailus <sakari.ailus@linux.intel.com>,
  linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sofware node: Only the managing device can unreference
 managed software node
In-Reply-To: <aaabo5LqR3Ors5er@ashevche-desk.local>
Message-ID: <be2cbf7b-c3e6-6980-65e4-eb37167a98b6@isely.net>
References: <20260303052146.1166717-1-mike.isely@cobaltdigital.com> <aaabo5LqR3Ors5er@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


OK, this time for sure...  Patch coming up.

  -Mike

On Tue, 3 Mar 2026, Andy Shevchenko wrote:

> On Mon, Mar 02, 2026 at 11:21:41PM -0600, mike.isely@cobaltdigital.com wrote:
> 
> Can you send it with proper version given (I think v2) and changelog?
> Also in the Subject a typo should be fixed: "software node" is the correct
> spelling.
> 
> 
