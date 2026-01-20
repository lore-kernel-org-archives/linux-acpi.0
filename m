Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3516344CAD0;
	Tue, 20 Jan 2026 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768923915; cv=none; b=HBCqKCEVSg2R4RkMfQpanLuzuKRR6kbQVDRL/zUnNrHxzl+dKwuvMgOEyD2APmiNDUyvxHgMYimviSlvcxapKpYjfVsFhWWhA9JuCevvtuCVttGFBOVN5YtHKNt7iqdbCm3o7S3oVxgJOKlbNHytGf4W449/psgtSU/HyF741Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768923915; c=relaxed/simple;
	bh=7qWRI5TEMbhJwoDvCA7wEdITDjqQD7+a4DGBF4uDdlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FfFSW42aXyvezk552OPCrjb1GRmlUUaMbB3YgdUNuCUGYKAfTdJNSbTZ55ij0IHKc3qNSTaONEqYm4YH5eNUgBPUOr1m9OkcMMfWrF4TroU0OC5ptaM6lLtiPQnzlM34rYBvBW+Jl3t/yNOEMG/k8YeRIMZKTYHzvjEioK2D/F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eac/fBx6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eac/fBx6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47A1C16AAE;
	Tue, 20 Jan 2026 15:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768923914;
	bh=7qWRI5TEMbhJwoDvCA7wEdITDjqQD7+a4DGBF4uDdlk=;
	h=From:To:Cc:Subject:Date:From;
	b=Eac/fBx659SpDlgJImaVB+pxGBVIEoF3n6gpD7KVsUtXLvLkUo6oNKQcYXkgDqM6U
	 FejaC4LWAV/6tVtnMZm7aVY1d8IZ0DbehbDIUljTgr3dkrfC0VaxcxFm3/S0zr/N4Y
	 +t/IjMi0z/faM/vZGjNr8RT44KcHBvNsBl5v2WviNMKMaJ/KPfpzuLvK0acYWG1vUg
	 dt2p6YewaINw+Hck9CPp2aUfZsGVv4UwPTp7ZdJKjbTGC7YHmnNB5HvKN374m9TsTI
	 1BRK+qNqCaCdsJnVyRWC+Ng/nwgBywR32ORuAC8u6q/aUcKa0Wwpw2apb5K6Boiyv4
	 p2vuelXDuwZ/w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Hans de Goede <hansg@kernel.org>,
 Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Kenneth Chan <kenneth.t.chan@gmail.com>, platform-driver-x86@vger.kernel.org,
 Azael Avalos <coproscefalo@gmail.com>,
 Matthew Garrett <matthew.garrett@nebula.com>
Subject:
 [PATCH v1 0/2] platform/x86: Fixes for leaks in panasonic-laptop and
 toshiba-haps drivers
Date: Tue, 20 Jan 2026 16:42:41 +0100
Message-ID: <3026924.e9J7NaK4W3@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

These are two fixes for leaks in the panasonic-laptop and toshiba-haps drivers,
in the "probe error" and "remove" paths.

Thanks!



