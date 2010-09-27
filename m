From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 5/5] ACPI, APEI, Fix ERST MOVE_DATA instruction implementation
Date: Mon, 27 Sep 2010 07:31:10 +0200
Message-ID: <20100927053110.GA21952@one.firstfloor.org>
References: <1284865235-29920-1-git-send-email-ying.huang@intel.com> <1284865235-29920-6-git-send-email-ying.huang@intel.com> <20100921124718.GE18991@one.firstfloor.org> <AANLkTi=-LzZSgk9BYg8z6i5QrbRWPVBYtpqdkvsTc_E_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=-LzZSgk9BYg8z6i5QrbRWPVBYtpqdkvsTc_E_@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: huang ying <huang.ying.caritas@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, Huang Ying <ying.huang@intel.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

> In my test machine, MOVE_DATA is not used. So this does not breaks
> serialization of machine checks.

Ok. But we don't know what other systems are doing.
> 
> We can not use kmap_atomic or kmap_atomic_pfn here. Because
> kmap_atomic_xxx needs struct page, but the address provided by BIOS
> may be in E820_RESERVED area, that is, the corresponding page may have
> no struct page. Maybe we need another kmap_atomic implementation for
> E820_RESERVED area.

Yes, at some point that may be needed.

It would be good to have some kind of warning that gets reported
back to us when this happens. This should happen on panicing situations
anyways, so we can printk.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
