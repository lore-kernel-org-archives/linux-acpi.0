From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Occasional (too common) suspend problem
Date: Fri, 21 Jan 2011 16:56:17 -0800
Message-ID: <AANLkTinBaG27pdtEFh1ufjh85Bk7aMzgwHjzyifz406G@mail.gmail.com>
References: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com>
 <201101220016.46227.rjw@sisk.pl> <AANLkTi=Tkf9MYmSmCX6CZ9Ymgqo8S1HmRkBn+Uvr2KUb@mail.gmail.com>
 <201101220131.11688.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53957 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750927Ab1AVA5K (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Jan 2011 19:57:10 -0500
Received: from mail-iy0-f174.google.com (mail-iy0-f174.google.com [209.85.210.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p0M0ubl1017887
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL)
	for <linux-acpi@vger.kernel.org>; Fri, 21 Jan 2011 16:56:37 -0800
Received: by iyj18 with SMTP id 18so2243701iyj.19
        for <linux-acpi@vger.kernel.org>; Fri, 21 Jan 2011 16:56:37 -0800 (PST)
In-Reply-To: <201101220131.11688.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, Jeff Chua <jeff.chua.linux@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>

On Fri, Jan 21, 2011 at 4:31 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>>
>> Or - and perhaps more likely - it's connected to the lid event, and
>> how that interacts with user space and then eventually triggers the
>> sleep event (which is quite likely - as mentioned, I think I've only
>> ever seen the problem when I'm physically at the machine).
>
> Does opening the lid wake up the machine normally?

No. Closing the lid causes it to suspend (due to the normal Fedora PM
settings), but to actually resume you have to open the lid and then
press a key.

                  Linus
