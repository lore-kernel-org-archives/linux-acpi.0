Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04803DB632
	for <linux-acpi@vger.kernel.org>; Thu, 19 Mar 2026 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773931962; cv=none; b=DD8tXEdbHqsE9sWY3nFDqZOS41oe1qRvtvTJmmaRNsyTMZKHJPWvnaf7mOu4vH/lb/4BbdjJzJeq6h/Sd9tJgcgIOMVHcw0280u6GTKb2KERmgW8PUZBOBgw/l+0VKYMentS1Uo5HB+j/OITyYHadPVBz4I506CQICMnYPcU2dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773931962; c=relaxed/simple;
	bh=qxQmWJhWYKD2J5j8db5XT+GAfwb4/UomI/metKo7xkk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Zs6ztgMhtojGCXX2YSvcvIKml+HAytmrhSGrgDVQlsRCyeJD69r8L9mY1l3AETtJwzx+vGaiC9j6CxeAYKOPg1OcKAEnHT8ZGncgZNcLBwiNidXsQ8bjeRTFGubplIrMJvlquObbPwgDYIE5lAccJMLjiHi/AY6avIFfgvl8i9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMaCHoM0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMaCHoM0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D470FC2BCB0
	for <linux-acpi@vger.kernel.org>; Thu, 19 Mar 2026 14:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773931961;
	bh=qxQmWJhWYKD2J5j8db5XT+GAfwb4/UomI/metKo7xkk=;
	h=From:Date:Subject:To:Cc:From;
	b=SMaCHoM0WHt+k8Df3oCxhIVXEuGj3R2eXDF7jTTO7Y4bBLzdRg/in8XzFpUxnhRfq
	 8elzLZOVSI5/MREXWtJpW3D/JOXnj7IyGz7xS4Wfmjpd0AeeDosoelXgzLtm7gWV0O
	 xAvA5V5gHrx3oNyI7xUmiULQiLOyxvE0IfNhCfr9PyRB7aeoZjsMT2X+cpbZm0WxYf
	 q9fFe8d8zyBgNsfxS8fDiM/38/4oB/q4Jiuh+uNbxGvhHMVBlnK6OZ9KtWXD67cA4p
	 1GzE1j1OAn/AYkGiq5CcQsXAu4G3jpMyLbObl2ziB87L+jG5+/5k8Gr0kePLoMJhZ+
	 YwvnHnvXvDs2A==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-41c096fab64so178629fac.1
        for <linux-acpi@vger.kernel.org>; Thu, 19 Mar 2026 07:52:41 -0700 (PDT)
X-Gm-Message-State: AOJu0YzIiL7a1u4efcZBB6glgyZfcbyKCX9HSrFn2hI8fBgFGbQa3NcI
	cJjlg0EEAWY8U34tEeJRXzqAQpUxZK33YSZtJ5O/P0E8HprkiGu3ABo9g5fQur0Cg2wjElE0aEx
	lrd5MlkzhAiRTudatZKvb3Ndes6xqCwQ=
X-Received: by 2002:a05:6871:4186:b0:3ff:46ad:271 with SMTP id
 586e51a60fabf-41befe490d9mr2478912fac.23.1773931960914; Thu, 19 Mar 2026
 07:52:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 19 Mar 2026 15:52:27 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jyDox=qX8=wYyKHJAdc5nZEmUpjAmtoqaL3k-yMc_WgA@mail.gmail.com>
X-Gm-Features: AaiRm52hxhRWYQZItOINMjfCilwvsfX-I7T7ZZq9Dk5cm66nN00mVkWWXdnsOZc
Message-ID: <CAJZ5v0jyDox=qX8=wYyKHJAdc5nZEmUpjAmtoqaL3k-yMc_WgA@mail.gmail.com>
Subject: [GIT PULL] ACPI support fixes for v7.0-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-7.0-rc5

with top-most commit 5cbcd6c0742a2986782a9e2c92aa250d8f5c137d

 Merge branches 'acpica' and 'acpi-bus'

on top of commit f338e77383789c0cae23ca3d48adcc5e9e137e3c

 Linux 7.0-rc4

to receive ACPI support fixes for 7.0-rc5.

These fix an MFD child automatic modprobe issue introduced recently,
an ACPI processor driver issue introduced by a previous fix and an
ACPICA issue causing confusing messages regarding _DSM arguments to
be printed:

 - Update the format of the last argument of _DSM to avoid printing
   confusing error messages in some cases (Saket Dumbre)

 - Fix MFD child automatic modprobe issue by removing a stale check
   from acpi_companion_match() (Pratap Nirujogi)

 - Prevent possible use-after-free in acpi_processor_errata_piix4()
   from occurring by rearranging the code to print debug messages
   while holding references to relevant device objects (Rafael Wysocki)

Thanks!


---------------

Pratap Nirujogi (1):
      ACPI: bus: Fix MFD child automatic modprobe issue

Rafael J. Wysocki (1):
      ACPI: processor: Fix previous acpi_processor_errata_piix4() fix

Saket Dumbre (1):
      ACPICA: Update the format of Arg3 of _DSM

---------------

 drivers/acpi/acpi_processor.c  | 15 ++++++++-------
 drivers/acpi/acpica/acpredef.h |  2 +-
 drivers/acpi/bus.c             |  3 ---
 3 files changed, 9 insertions(+), 11 deletions(-)
