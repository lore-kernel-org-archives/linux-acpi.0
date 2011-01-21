From: Norbert Preining <preining@logic.at>
Subject: Re: regression 2.6.37 -> 2.6.38-rc1: after suspend backlight
	cannot be adjusted
Date: Fri, 21 Jan 2011 15:46:15 +0900
Message-ID: <20110121064614.GA23310@gamma.logic.tuwien.ac.at>
References: <20110121015529.GD9796@gamma.logic.tuwien.ac.at> <1295583107.2613.45.camel@edumazet-laptop> <1295583394.2613.47.camel@edumazet-laptop> <20110121015529.GD9796@gamma.logic.tuwien.ac.at> <1295583107.2613.45.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:43478 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490Ab1AUGqT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Jan 2011 01:46:19 -0500
Content-Disposition: inline
In-Reply-To: <1295583394.2613.47.camel@edumazet-laptop> <1295583107.2613.45.camel@edumazet-laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: linux-kernel@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

Hi Eric, hi all

On Fr, 21 Jan 2011, Eric Dumazet wrote:
> Maybe this is the problem Linus had to bisect, you could try his patch :

> Or just pull linux-2.6, since patch is now committed
> 
> commit 28e58ee8ce1f0e69c207f747b7b9054b071e328d

I am now running on top of 8d99641f6c1a so I have this patch included,
but still see the same problem. Adjustment *before* suspend works,
afterwards does not.

Can someone give me a quick notive how to bisect only those commits
that touch the relevant parts? acpi?

Best wishes

Norbert
------------------------------------------------------------------------
Norbert Preining            preining@{jaist.ac.jp, logic.at, debian.org}
JAIST, Japan                                 TeX Live & Debian Developer
DSA: 0x09C5B094   fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
------------------------------------------------------------------------
POTT SHRIGLEY (n.)
Dried remains of a week-old casserole, eaten when extremely drunk at
two a.m.
			--- Douglas Adams, The Meaning of Liff
