From: "Michael S. Tsirkin" <m.s.tsirkin@gmail.com>
Subject: Re: new regression in 2.6.25-rc3: no keyboard/lid acpi events on thinkpad T61p
Date: Mon, 25 Feb 2008 22:39:42 +0200
Message-ID: <8f53421d0802251239s1f8a3c1fleb50f76e2aa00d8c@mail.gmail.com>
References: <8f53421d0802251119q470a79c1p31048ef136271f84@mail.gmail.com>
	 <20080225114611.d91791f6.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:50831 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759505AbYBYUjn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Feb 2008 15:39:43 -0500
Received: by ug-out-1314.google.com with SMTP id z38so955939ugc.16
        for <linux-acpi@vger.kernel.org>; Mon, 25 Feb 2008 12:39:42 -0800 (PST)
In-Reply-To: <20080225114611.d91791f6.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Mon, Feb 25, 2008 at 9:46 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Mon, 25 Feb 2008 21:19:24 +0200 "Michael S. Tsirkin" <m.s.tsirkin@gmail.com> wrote:
>
>  > On my T61p, 2.6.25-rc2 seems to get acpi events from keypresses
>  > such as Fn-F4 and lid open/close, prints them in /var/log/acpid
>  > and reacts accordingly (my acpi scripts suspend on lid close and Fn-F4).
>
>  You mean suspend-to-ram works correctly on your t61p?
>
>  Mine suspends, then five seconds later magically resumes itself and the
>  screen is all black.
>
>

I see the resume problems too, but they do not seem to be acpi-related
(IOW, there are 2 issues). I just finished bisecting and intend to
report shortly.
