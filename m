From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 3/9] bitops: Introduce a more generic BITMASK macro
Date: Wed, 16 Oct 2013 23:58:56 -0700
Message-ID: <1381993136.22110.95.camel@joe-AO722>
References: <1381935366-11731-1-git-send-email-gong.chen@linux.intel.com>
	 <1381935366-11731-4-git-send-email-gong.chen@linux.intel.com>
	 <1381978749.22110.76.camel@joe-AO722>
	 <20131017063059.GB14946@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtprelay0243.hostedemail.com ([216.40.44.243]:49434 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750866Ab3JQG7B (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Oct 2013 02:59:01 -0400
In-Reply-To: <20131017063059.GB14946@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chen Gong <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, bp@alien8.de, naveen.n.rao@linux.vnet.ibm.com, m.chehab@samsung.com, arozansk@redhat.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Winischhofer <thomas@winischhofer.net>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Thu, 2013-10-17 at 02:30 -0400, Chen Gong wrote:
> On Wed, Oct 16, 2013 at 07:59:09PM -0700, Joe Perches wrote:
[]
> > Maybe add a
> > 
> > BUILD_BUG_ON(__builtin_constant_p(l) && __builtin_constant_p(h) && \
> > 	     (h) < (l))
> > 
> No, if so, users can't use variables for this macro.

__builtin_constant_p checks for constants

Built-in Function: int __builtin_constant_p (exp)
        You can use the built-in function __builtin_constant_p to
        determine if a value is known to be constant at compile-time and
        hence that GCC can perform constant-folding on expressions
        involving that value. The argument of the function is the value
        to test. The function returns the integer 1 if the argument is
        known to be a compile-time constant and 0 if it is not known to
        be a compile-time constant. A return of 0 does not indicate that
        the value is not a constant, but merely that GCC cannot prove it
        is a constant with the specified value of the -O option. 
        


