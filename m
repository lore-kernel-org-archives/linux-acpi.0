From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: new regression in 2.6.25-rc3: no keyboard/lid acpi events on
 thinkpad T61p
Date: Mon, 25 Feb 2008 11:46:11 -0800
Message-ID: <20080225114611.d91791f6.akpm@linux-foundation.org>
References: <8f53421d0802251119q470a79c1p31048ef136271f84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([207.189.120.13]:40152 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755351AbYBYTrk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Feb 2008 14:47:40 -0500
In-Reply-To: <8f53421d0802251119q470a79c1p31048ef136271f84@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Michael S. Tsirkin" <m.s.tsirkin@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Mon, 25 Feb 2008 21:19:24 +0200 "Michael S. Tsirkin" <m.s.tsirkin@gmail.com> wrote:

> On my T61p, 2.6.25-rc2 seems to get acpi events from keypresses
> such as Fn-F4 and lid open/close, prints them in /var/log/acpid
> and reacts accordingly (my acpi scripts suspend on lid close and Fn-F4).

You mean suspend-to-ram works correctly on your t61p?

Mine suspends, then five seconds later magically resumes itself and the
screen is all black.

