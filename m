From: Hugh Dickins <hughd@google.com>
Subject: Re: [BUG] rc1 rc2 rc3 not bootable - black screen after kernel
 loading
Date: Sat, 26 Jul 2014 16:19:01 -0700 (PDT)
Message-ID: <alpine.LSU.2.11.1407261615550.14577@eggly.anvils>
References: <53A6E72A.9090000@posteo.de>  <744357E9AAD1214791ACBA4B0B90926301379B97@SHSMSX101.ccr.corp.intel.com>  <53A81BF7.3030207@posteo.de> <1403529246.4686.6.camel@rzhang1-toshiba>  <53A83DC7.1010606@posteo.de> <1403882067.16305.124.camel@rzhang1-toshiba>
  <53ADB359.4010401@posteo.de> <53ADCB24.9030206@posteo.de>  <53ADECDA.60600@posteo.de> <53B11749.3020902@posteo.de>  <1404116299.8366.0.camel@rzhang1-toshiba> <1404116444.8366.1.camel@rzhang1-toshiba> <53B12723.4080902@posteo.de> <53B13E4B.2080603@posteo.de>
 <53D131E7.2090304@posteo.de> <alpine.LSU.2.11.1407241610320.3733@eggly.anvils> <53D22E4D.2060600@posteo.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:41029 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbaGZXUl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 26 Jul 2014 19:20:41 -0400
Received: by mail-pd0-f174.google.com with SMTP id fp1so7604375pdb.5
        for <linux-acpi@vger.kernel.org>; Sat, 26 Jul 2014 16:20:40 -0700 (PDT)
In-Reply-To: <53D22E4D.2060600@posteo.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Martin Kepplinger <martink@posteo.de>
Cc: Hugh Dickins <hughd@google.com>, daniel.vetter@ffwll.ch, Zhang Rui <rui.zhang@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, 25 Jul 2014, Martin Kepplinger wrote:
> Am 2014-07-25 01:20, schrieb Hugh Dickins:
> > 
> > [PATCH] drm/i915: fix freeze with blank screen booting highmem
> 
> yes! thanks Hugh. On top of linus' current tree, that finally fixes my
> problem! I hope it'll be included soon!

I'm glad to hear it, Martin, thanks for letting us know.  It is now
commit 88b98287356762cc16c9ff6cd48116160a5d4dba in Linus's tree for rc7.

Hugh
