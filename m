From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] GHES: Fix cached error-status
Date: Mon, 26 Oct 2015 05:30:21 +0100
Message-ID: <20151026043021.GA9328@nazgul.tnic>
References: <20151019175554.GB3367@linux-uzut.site>
 <20151023225057.GF27292@linux-uzut.site>
 <3908561D78D1C84285E8C5FCA982C28F32B5DE60@ORSMSX114.amr.corp.intel.com>
 <87611uz56k.fsf@yhuang-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45857 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717AbbJZEa2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Oct 2015 00:30:28 -0400
Content-Disposition: inline
In-Reply-To: <87611uz56k.fsf@yhuang-dev.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Huang, Ying" <ying.huang@linux.intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Huang, Ying" <ying.huang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Oct 26, 2015 at 11:20:35AM +0800, Huang, Ying wrote:
> In ghes_estatus_caches[], for caches with same contents, the cache wi=
th
> biggest (newest) cache->time_in should be the first.  So if we found =
one
> cache with too small (old) cache->time_in, we can say there are no ca=
che
> with same contents and bigger (newer) cache->time_in, so that we can
> make decision (break) earlier.

Well, for starters, this should be documented in the code so that peopl=
e
looking at it would not need to scratch their heads over that break
statement there.

Thanks.

--=20
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.

SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Nort=
on, HRB 21284 (AG N=C3=BCrnberg)
--
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
