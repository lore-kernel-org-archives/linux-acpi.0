From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 1/4] nvdimm: Add wrapper for IOCTL pass thru.
Date: Wed, 11 Nov 2015 10:47:56 -0500
Message-ID: <x49mvukleqb.fsf@segfault.boston.devel.redhat.com>
References: <cover.1446684001.git.jerry.hoemann@hpe.com>
	<cover.1446684001.git.jerry.hoemann@hpe.com>
	<5411049831df211c8280e3239aaf344af033fa25.1446684001.git.jerry.hoemann@hpe.com>
	<x49d1vhlp34.fsf@segfault.boston.devel.redhat.com>
	<20151110194938.GA47666@tevye.fc.hp.com>
	<x49oaf1k3cx.fsf@segfault.boston.devel.redhat.com>
	<20151111004425.GG47666@tevye.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43377 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752457AbbKKPr6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Nov 2015 10:47:58 -0500
In-Reply-To: <20151111004425.GG47666@tevye.fc.hp.com> (Jerry Hoemann's message
	of "Tue, 10 Nov 2015 17:44:25 -0700")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jerry.Hoemann@hpe.com
Cc: ross.zwisler@linux.intel.com, rjw@rjwysocki.net, lenb@kernel.org, dan.j.williams@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@ml01.01.org

Jerry Hoemann <jerry.hoemann@hpe.com> writes:

> The ndn_pkg.buf struct uses a flexible array definition.  This is in C99.
> An explicit zero length array is a gcc extension that has been around much
> longer.  They behave in a similar fashion, but aren't identical.   In my
> limited use they behave the same.

I could swear I've been bitten by this before, but you are correct.

Thanks,
Jeff
