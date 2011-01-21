From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Occasional (too common) suspend problem
Date: Fri, 21 Jan 2011 14:55:45 -0800
Message-ID: <AANLkTi=_-bMsp1K-thY+4wUMC5wDMVT+8m=fmVEx_wqE@mail.gmail.com>
References: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com>
 <alpine.LFD.2.02.1101211701330.3924@x980> <AANLkTi=cbNWQ4eFiZQxE6BrJrhbj+w1MjDGdSmG8oUPv@mail.gmail.com>
 <201101212342.01646.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55436 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752903Ab1AUW4g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Jan 2011 17:56:36 -0500
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p0LMu6nq008406
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL)
	for <linux-acpi@vger.kernel.org>; Fri, 21 Jan 2011 14:56:06 -0800
Received: by iwn9 with SMTP id 9so2188793iwn.19
        for <linux-acpi@vger.kernel.org>; Fri, 21 Jan 2011 14:56:06 -0800 (PST)
In-Reply-To: <201101212342.01646.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, Jeff Chua <jeff.chua.linux@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>

On Fri, Jan 21, 2011 at 2:42 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>
> Something like this, perhaps. =A0It doesn't blow up my Toshiba test b=
ox, so
> hopefully it won't blow up yours ...

=46ailed suspend on the very first try..

               Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
