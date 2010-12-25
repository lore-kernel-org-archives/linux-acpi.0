From: James Cloos <cloos@jhcloos.com>
Subject: Re: [PATCH 0/6] cpufreq: Add sampling window to enhance ondemand governor power efficiency
Date: Fri, 24 Dec 2010 23:24:48 -0500
Message-ID: <m3zkrueaxj.fsf@jhcloos.com>
References: <1293085424-18212-1-git-send-email-youquan.song@intel.com>
	<20101223110020.GC18363@comet.dominikbrodowski.net>
	<20101223173402.GA3821@redhat.com>
	<20101223205148.GB6441@comet.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from eagle.jhcloos.com ([207.210.242.212]:47197 "EHLO
	eagle.jhcloos.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248Ab0LYEy4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Dec 2010 23:54:56 -0500
In-Reply-To: <20101223205148.GB6441@comet.dominikbrodowski.net> (Dominik
	Brodowski's message of "Thu, 23 Dec 2010 21:51:48 +0100")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Dave Jones <davej@redhat.com>, Youquan Song <youquan.song@intel.com>, cpufreq@vger.kernel.org, venki@google.com, arjan@linux.intel.com, lenb@kernel.org, suresh.b.siddha@intel.com, kent.liu@intel.com, chaohong.guo@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Youquan Song <youquan.song@linux.intel.com>

>>>>> "DB" == Dominik Brodowski <linux@dominikbrodowski.net> writes:

DB> AFAICS, we have two in-kernel dynamic frequency scaling governors, one of
DB> which doesn't seem to get much usage (conservative)...

Isn't conservative the recommended choice for AMD processors?

Or has that changed?

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
