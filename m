From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH]cpuset: add new API to change cpuset top group's cpus
Date: Tue, 19 May 2009 13:27:57 +0200
Message-ID: <8763fxpc1u.fsf@basil.nowhere.org>
References: <20090519073942.GA10864@sli10-desk.sh.intel.com>
	<1242722454.26820.461.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:36581 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbZESL2E (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 May 2009 07:28:04 -0400
In-Reply-To: <1242722454.26820.461.camel@twins> (Peter Zijlstra's message of "Tue, 19 May 2009 10:40:54 +0200")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Shaohua Li <shaohua.li@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, menage@google.com

Peter Zijlstra <peterz@infradead.org> writes:
>
> Furthermore, I object to being able to remove online cpus from the top
> cpuset, that just doesn't make sense.

Note you can already do it at boot time with isolated_cpus=...
So your objection seems to be a few years too late.

Shaohua's patch just makes it work at runtime too.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
