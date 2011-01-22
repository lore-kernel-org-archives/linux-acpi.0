From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Occasional (too common) suspend problem
Date: Sat, 22 Jan 2011 10:22:21 -0800
Message-ID: <AANLkTikSsQUQ5P8=rxmhwV-WmP6zAZt50j+s9EpLj0Pm@mail.gmail.com>
References: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com>
 <AANLkTi=Tkf9MYmSmCX6CZ9Ymgqo8S1HmRkBn+Uvr2KUb@mail.gmail.com>
 <AANLkTikv55eQfNaCGLm-2pA3Ndyi9ZEzb4xn64D3u0ww@mail.gmail.com>
 <201101221110.17786.rjw@sisk.pl> <AANLkTik2sUJb9G5sA_Zr9_Q1=rJdYkgRe-MgTb0zhwc2@mail.gmail.com>
 <AANLkTikJVFEOgD_i+ghFupJksy2X_G1outhMmhPbP1Yd@mail.gmail.com> <AANLkTi=oHRzcK1KFSSziwXdJ1NJyt9oEyyCFDMY4KHc5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42349 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751008Ab1AVSWn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 22 Jan 2011 13:22:43 -0500
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p0MIMgXB008606
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL)
	for <linux-acpi@vger.kernel.org>; Sat, 22 Jan 2011 10:22:42 -0800
Received: by iwn9 with SMTP id 9so2734839iwn.19
        for <linux-acpi@vger.kernel.org>; Sat, 22 Jan 2011 10:22:41 -0800 (PST)
In-Reply-To: <AANLkTi=oHRzcK1KFSSziwXdJ1NJyt9oEyyCFDMY4KHc5@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Chris Wilson <chris@chris-wilson.co.uk>, Jesse Barnes <jbarnes@virtuousgeek.org>, Dave Airlie <airlied@linux.ie>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>

On Sat, Jan 22, 2011 at 9:13 AM, Jeff Chua <jeff.chua.linux@gmail.com> wrote:
>
> How many CPUs do you have? If more than one, try switching offline all
> /sys/devices/system/cpu/cpu*/online before suspend.

It's an Atom with SMT, so it shows up as two CPU's.

That doesn't really explain why a regular "echo mem" works but the
pm-suspend doesn't.

             Linus
