Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50641440651;
	Wed, 19 Aug 2026 20:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787170573; cv=none; b=X+gtwNYYe4DV+YBLVc9FhsvHSjRqvQ69/adtRYgH9mDe8CX8oGvJwzjjdKOo/l9CkUGnB6RMIB4VTpOeGHpre55Q7S/eD1tgiVrdetf/mfi4Yg8klSAMXx8xLobXXGroqkhHXe73Kb2m6c9g5r7k2PjtTRAgO1U3IaXsz97Yl8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787170573; c=relaxed/simple;
	bh=W4jgoq4fQg0H6vcFvyCjP7//GAwNRkRqyJb1iOvsJrY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JH51lVtmVEiK625l93X5KITOSVOMIE4KfPS433I0MdIfZ6Q7tBD4aobSEn/tjsXHqp8/jzhAV9Mxn0JHMBB5/eRc+Bk50wqRL/UB28YgR455qLlNWV6ztZXhi10tFBh4JPqhA6XYFeqtqw1GK/P/QzK2CmgzjajkcwoGgwKRoI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fh3O/9Ic; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fh3O/9Ic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D5F1F000E9;
	Wed, 19 Aug 2026 20:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787170571;
	bh=0akuDUBjXMI/6O3Z4zq1ZUmRU3C7pXTgHVTbkwfW6c4=;
	h=From:To:Cc:Subject:Date;
	b=fh3O/9IcP6CeY4tDOtv1bsboWCSwzN+DdJgIIF0lAbQn1xwaOLuNWsQupIQMPjBtf
	 GoiuWOcJyCdUKw5QfHA44EXqNoBo4JSMlB36HMYyc7/th0MnopKhK3JV831OFaY4pD
	 pZDLmV9/xDHcsQbO0uUNIy8G2HZg33ckm/N19v0Qrv0WAv1NJz5gMcBeK1mZPbkq2/
	 pqYt47SUUNPc7E3SEGn+ONYlXQnlTZi6GjSkcXWQpVQa7ovoLEY52KlA0i+DXxMzeW
	 gfpyDaAmaKvpfnJIepXMMDa9q0+VxPDROdR0Q8qSU9IHsdKylp46trQQHl+/z4fcoS
	 Ss6Pbzn71gX4g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Armin Wolf <w_armin@gmx.de>,
 Colin Ian King <colin.i.king@gmail.com>, acpica-devel@lists.linux.dev,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>
Subject:
 [PATCH v1 0/3] ACPI: Updates related to upstream ACPICA project changes
Date: Wed, 19 Aug 2026 22:11:17 +0200
Message-ID: <7982261.EvYhyI6sBW@rafael.j.wysocki>
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

The upstream ACPICA project is undergoing some changes that require
documentation updates and similar, and hence this series.

Some of that is due to the departure of the long-time upstream ACPICA
developer and maintainer Bob Moore and his immediate successor from
Intel, but there is more.

The project's license has changed (hopefully for the better) and it is
now going to be the BSD-2-Clause-Patent license or the GPL-2.0-only
license (as per the SPDX identifier).

Also, the project will now require Sign-off-by tags from all
contributors which should make it easier to track the provenance of
code changes.

Moreover, the ACPICA repository on GitHub has been relocated, so
basically it has a new URL, even though the old one should just take
you to the new location (at least most of the time), but it is still
the same repository with all pull requests, issues etc.  Nevertheless,
I apologize everyone who may be affected by this change for the
inconvenience.

This series makes updates related to those changes.

The first patch adds a CREDITS entry for Bob Moore, which is well-deserved
in my view.

The second patch updates the ACPICA entry in MAINTAINERS in accordance with
the current state of the upstream ACPICA project.

The last patch updates the upstream ACPICA repository URL in the only document
other than MAINTAINERS in which it is present.

Thanks!



