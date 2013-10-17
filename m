From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 3/9] bitops: Introduce a more generic BITMASK macro
Date: Thu, 17 Oct 2013 01:32:30 -0700
Message-ID: <1381998750.22110.101.camel@joe-AO722>
References: <1381935366-11731-1-git-send-email-gong.chen@linux.intel.com>
	 <1381935366-11731-4-git-send-email-gong.chen@linux.intel.com>
	 <1381978749.22110.76.camel@joe-AO722>
	 <20131017063059.GB14946@gchen.bj.intel.com>
	 <1381993136.22110.95.camel@joe-AO722>
	 <20131017073824.GC14946@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtprelay0181.hostedemail.com ([216.40.44.181]:48568 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752810Ab3JQIcf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Oct 2013 04:32:35 -0400
In-Reply-To: <20131017073824.GC14946@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chen Gong <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, bp@alien8.de, naveen.n.rao@linux.vnet.ibm.com, m.chehab@samsung.com, arozansk@redhat.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Winischhofer <thomas@winischhofer.net>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Thu, 2013-10-17 at 03:38 -0400, Chen Gong wrote:
> the point is we can use GENMASK like GENMASK(end_bit, start_bit) but
> we don't know the value of end_bit/start_bit at compile-time.

True.

The BUILD_BUG_ON idea is just to avoid people using
	GENMASK(1, 2)
instead of
	GENMASK(2, 1)

#define GENMASK(h, l)						\
({								\
	BUILD_BUG_ON(__builtin_constant_p(l) &&			\
		     __builtin_constant_p(h) &&			\
		     (l) > (h));				\
	(((U32_C(1) << ((h) - (l) + 1)) - 1) << (l));		\
})


