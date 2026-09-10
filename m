Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18EC577E3C;
	Thu, 10 Sep 2026 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789063020; cv=none; b=UjPgDYn6ZPlby8t6XXialMc9XrK8aibO6nhdQGOUPDRWxj6GQGXTPKXkdM8Qul9UyC0Xxoypuq55puWeMpqN0WTMi7rGzfJiQYQdqAUyRWOr9wC381Rgw/JVsuGa3GbvwCjat8MUdi/ux2/r1IodhnBfBPD5X/vDITAcZrRJOSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789063020; c=relaxed/simple;
	bh=pkJZvvta6dxLY8IV8bmHXNa/xw+FVYmRhXyBTTZYiNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JWiyyRXjqyMQNGLlcpWLnfNl8PkrCkGm0jlp1B7xBF4ECrkV13IrGVpnLvHVAGmulm9O6/SJAJQKDYjCA2kSB70nxokc3Xhe2WcIX5UaHBce7EwlrOwYbZnbR92xtwvKJIrTfklV1qi9NWxOU8ZVfTsUHy2lrf9tvrfywZPp+Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUFidj9C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUFidj9C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6BA1F000FF;
	Thu, 10 Sep 2026 17:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789063019;
	bh=pkJZvvta6dxLY8IV8bmHXNa/xw+FVYmRhXyBTTZYiNE=;
	h=From:To:Cc:Subject:Date;
	b=HUFidj9CrGAFTybaxWBR6DlS0YzGPJWDn/ZnWaegaiCe0waZOU0X73Ykz7p+gOfmp
	 7laqzKZ1Q1Q6MjxpqalL1Kj4HKDGHcR8qAux+JGN7obXLys3JzM/hfS2Z5FhT2/HsZ
	 242Td2u4dRSJIqQNKyRtULb+uXt3FUP5gDFKQuAek29+4i2F2o3/InaRkaIknUD073
	 pJ6KcsbeOnA9SxYaNO/5K5X8ciJHLQOR0M91+n0OxrwanjX898byIrKoVPcU5Z1ABD
	 d5WAu80hiXFvzoR+z9yxisdJ+d2YcZND6cydCxB/J8Vj4vPAsEZz2+NaHhIq6EzZi1
	 gN1b0A0ZukF+w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/4] ACPI: glue: Three fixes and optimization
Date: Thu, 10 Sep 2026 19:51:10 +0200
Message-ID: <12995802.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

This series fixes three issues in the ACPI code responsible for binding
physical devices to their ACPI companions and adds an optimization to
it.

Please see the changelogs of the patches for details.

Thanks!



