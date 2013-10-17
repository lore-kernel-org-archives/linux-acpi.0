From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 3/9] bitops: Introduce a more generic BITMASK macro
Date: Thu, 17 Oct 2013 11:13:31 -0700
Message-ID: <1382033611.22110.131.camel@joe-AO722>
References: <1381935366-11731-1-git-send-email-gong.chen@linux.intel.com>
	 <1381935366-11731-4-git-send-email-gong.chen@linux.intel.com>
	 <1381978749.22110.76.camel@joe-AO722>
	 <20131017063059.GB14946@gchen.bj.intel.com>
	 <1381993136.22110.95.camel@joe-AO722>
	 <20131017073824.GC14946@gchen.bj.intel.com>
	 <1381998750.22110.101.camel@joe-AO722> <20131017084014.GD5036@pd.tnic>
	 <1382000112.22110.103.camel@joe-AO722>
	 <CA+8MBbLDVJgY9WWTY6vPeY7+L04-xDPofJ9eLwh7dJipBBh51w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtprelay0124.hostedemail.com ([216.40.44.124]:58391 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759087Ab3JQSNf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Oct 2013 14:13:35 -0400
In-Reply-To: <CA+8MBbLDVJgY9WWTY6vPeY7+L04-xDPofJ9eLwh7dJipBBh51w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tony Luck <tony.luck@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, Chen Gong <gong.chen@linux.intel.com>, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, m.chehab@samsung.com, arozansk@redhat.com, linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Winischhofer <thomas@winischhofer.net>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Thu, 2013-10-17 at 09:10 -0700, Tony Luck wrote:
> On Thu, Oct 17, 2013 at 1:55 AM, Joe Perches <joe@perches.com> wrote:
> > It's cost free to add the BUILD_BUG_ON
> > and perhaps you underestimate the runtime
> > bug checking effort,
> 
> This looks OK to me.  Gong: This doesn't stop people from using variables
> as arguments ... they just won't get a check for (h) < (l).

Another possibility is to swap high and low if necessary and
maybe warn when either is negative or too large for the bit width.

#define GENMASK(h, l)							\
({									\
	size_t high = h;						\
	size_t low = l;							\
	BUILD_BUG_ON(__builtin_constant_p(l) &&				\
		     __builtin_constant_p(h) &&				\
		     (l) > (h));					\
	BUILD_BUG_ON(__builtin_constant_p(l) &&				\
		     __builtin_constant_p(h) &&				\
		     ((l) >= BITS_PER_LONG ||				\
		      (h) >= BITS_PER_LONG));				\
	WARN_ONCE((!__builtin_constant_p(l) &&				\
		   ((l) < 0 || (l) > BITS_PER_LONG)) ||			\
		  (!__builtin_constant_p(h) &&				\
		   ((h) < 0 || (h) > BITS_PER_LONG)) ||			\
		  (l) > (h),						\
		  "GENMASK: invalid mask values: l: %u, h: %d\n",	\
		  (l), (h));						\
	if (low > high)							\
		swap(low, high);					\
	(((U32_C(1) << (high - low + 1)) - 1) << low);			\
})

And maybe this should be renamed something like
#define BIT_MASK_RANGE(h, l)
or
#define BIT_MASK_SHIFTED(h, l)


