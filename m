From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / EC: Improve busy polling quirk.
Date: Wed, 13 May 2015 15:59:16 +0200
Message-ID: <2001512.mWiNO6mMQt@vostro.rjw.lan>
References: <3b6064b23b148a9c3eed58566e9361a852618556.1430900840.git.lv.zheng@intel.com> <1AE640813FDE7649BE1B193DEA596E8802714BF4@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61268 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932597AbbEMNeF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 May 2015 09:34:05 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E8802714BF4@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wednesday, May 13, 2015 07:25:05 AM Zheng, Lv wrote:
> Hi, Rafael

Hi,

> Since we've implemented register access guarding in the wait polling mode in this commit:
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=9e295ac
> So all udelay() quirks may be no longer necessary and we can remove it.
> I'm asking an original reporter to confirm this:
> https://bugzilla.kernel.org/show_bug.cgi?id=77431
> After removing the udelay() quirk we can turn it to be a special usage model:
> Do busy polling as a non-default behavior using a module param so that it is still useful for debugging.
> 
> This commit cannot reflect all of the above stories and may leave regressions for guarding required platforms.
> Please ignore it and I'll prepare a better patchset for this.

OK, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
