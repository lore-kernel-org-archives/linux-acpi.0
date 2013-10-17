From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 3/9] bitops: Introduce a more generic BITMASK macro
Date: Wed, 16 Oct 2013 19:59:09 -0700
Message-ID: <1381978749.22110.76.camel@joe-AO722>
References: <1381935366-11731-1-git-send-email-gong.chen@linux.intel.com>
	 <1381935366-11731-4-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtprelay0069.hostedemail.com ([216.40.44.69]:39300 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1762180Ab3JQC7O (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Oct 2013 22:59:14 -0400
In-Reply-To: <1381935366-11731-4-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, bp@alien8.de, naveen.n.rao@linux.vnet.ibm.com, m.chehab@samsung.com, arozansk@redhat.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Winischhofer <thomas@winischhofer.net>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Wed, 2013-10-16 at 10:56 -0400, Chen, Gong wrote:
> GENMASK is used to create a contiguous bitmask([hi:lo]). It is
> implemented twice in current kernel. One is in EDAC driver, the other
> is in SiS/XGI FB driver. Move it to a more generic place for other
> usage.
[]
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
[]
> @@ -10,6 +10,14 @@
>  #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
>  #endif
>  
> +/*
> + * Create a contiguous bitmask starting at bit position @l and ending at
> + * position @h. For example
> + * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.

ull

> + */
> +#define GENMASK(h, l)		(((U32_C(1) << ((h) - (l) + 1)) - 1) << (l))
> +#define GENMASK_ULL(h, l)	(((U64_C(1) << ((h) - (l) + 1)) - 1) << (l))


Maybe add a

BUILD_BUG_ON(__builtin_constant_p(l) && __builtin_constant_p(h) && \
	     (h) < (l))

