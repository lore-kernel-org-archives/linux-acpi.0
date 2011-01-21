From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Occasional (too common) suspend problem
Date: Fri, 21 Jan 2011 14:33:17 -0800
Message-ID: <AANLkTi=cbNWQ4eFiZQxE6BrJrhbj+w1MjDGdSmG8oUPv@mail.gmail.com>
References: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com>
 <alpine.LFD.2.02.1101211550190.3924@x980> <alpine.LFD.2.02.1101211701330.3924@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35429 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750889Ab1AUWe2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Jan 2011 17:34:28 -0500
Received: from mail-iy0-f174.google.com (mail-iy0-f174.google.com [209.85.210.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p0LMXbgC006459
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL)
	for <linux-acpi@vger.kernel.org>; Fri, 21 Jan 2011 14:33:37 -0800
Received: by iyj18 with SMTP id 18so2161282iyj.19
        for <linux-acpi@vger.kernel.org>; Fri, 21 Jan 2011 14:33:37 -0800 (PST)
In-Reply-To: <alpine.LFD.2.02.1101211701330.3924@x980>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Jeff Chua <jeff.chua.linux@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>

On Fri, Jan 21, 2011 at 2:25 PM, Len Brown <lenb@kernel.org> wrote:
>
> I don't know if fixing that symptom will fix the suspend
> problem, but it can't hurt.

Any particular patch/hack you had in mind for me to test? I'm leaving
for LCA tomorrow, I'll happily test anything. Once I'm on the road,
I'll still have access to that thing, but it's pitifully slow and will
be the only computer I have available, so I won't be doing lots of
random testng.

                 Linus
