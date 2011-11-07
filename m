From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH] Convert width in bits to bytes in __acpi_ioremap_fast()
Date: Sun, 6 Nov 2011 19:28:24 -0800
Message-ID: <987664A83D2D224EAE907B061CE93D53020603095C@orsmsx505.amr.corp.intel.com>
References: <4ea1e75f5296b6c6b@agluck-desktop.sc.intel.com>
	<201110280217.27681.trenn@suse.de>
 <CAJvTdKkrqx1tJ20uzvLb4zqPm8b=orQz_hCwtaeqZ0vKPPOPJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:28991 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752417Ab1KGD20 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Nov 2011 22:28:26 -0500
In-Reply-To: <CAJvTdKkrqx1tJ20uzvLb4zqPm8b=orQz_hCwtaeqZ0vKPPOPJw@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Thomas Renninger <trenn@suse.de>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Huang, Ying" <ying.huang@intel.com>

> What kind of failures are seen with this bug un-patched?
> (and thus, what kind of urgency do distros have to back-port this fix?)

Just noticed it was wrong when reading code - It hadn't caused me a
problem - and in most cases I don't think there is an issue - since
we actually round up all mappings to pages anyway, whether we have
the size in bits or bytes will generally not make any difference.

There might be some issues with addresses near the end of a page,
where using 64 as bytes would mean addr+size overflows onto the
next page, where addr+size/8 doesn't.  But I haven't looked hard
enough to see what would happen in this case.

-Tony
