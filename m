From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [BUGFIX] ACPI, APEI, EINJ Param support is disabled by default
Date: Thu, 21 Jul 2011 06:16:10 +0200
Message-ID: <20110721041610.GL8006@one.firstfloor.org>
References: <1311149369-20624-1-git-send-email-ying.huang@intel.com> <20110721024204.GJ8006@one.firstfloor.org> <4E2794D5.1030104@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4E2794D5.1030104@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Andi Kleen <andi@firstfloor.org>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Luck, Tony" <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jul 21, 2011 at 10:54:13AM +0800, Huang Ying wrote:
> On 07/21/2011 10:42 AM, Andi Kleen wrote:
> >>  
> >> +static bool param_extension;
> >> +module_param(param_extension, bool, 0);
> > 
> > Make it 0644, then it can be changed at runtime. No need to require a reboot.
> 
> Normally, EINJ is compiled as module, so we can change it at load time
> without a reboot.

Ok. 

> 
> Do we need the real runtime switching capability?

I usually do that with modparams when it's possible. After all it's very
simple and doesn't cost anything.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
