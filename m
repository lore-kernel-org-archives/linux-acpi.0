From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH EDAC 07/13] edac: add support for raw error reports
Date: Mon, 18 Feb 2013 14:52:51 +0100
Message-ID: <20130218135251.GC16622@pd.tnic>
References: <cover.1360931635.git.mchehab@redhat.com>
 <e08f797b129a50b4e1b39e8c31bff82904aea65d.1360931635.git.mchehab@redhat.com>
 <20130215141330.GF14387@pd.tnic>
 <20130215132530.4f3b7dab@redhat.com>
 <20130215154123.GH14387@pd.tnic>
 <20130215134929.3909cfa2@redhat.com>
 <20130215160257.GK14387@pd.tnic>
 <20130215162029.3bcbf50a@redhat.com>
 <20130216165748.GC27207@pd.tnic>
 <20130217074404.05786692@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130217074404.05786692@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: linux-acpi@vger.kernel.org, Huang Ying <ying.huang@intel.com>, Tony Luck <tony.luck@intel.com>, Linux Edac Mailing List <linux-edac@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, Feb 17, 2013 at 07:44:04AM -0300, Mauro Carvalho Chehab wrote:
> We could do it for the location. The space for label, however, depends on
> how many DIMMs are in the system, as multiple dimm's may be present, and
> the core will point to all possible affected DIMMs.
> 
> Ok, perhaps we could just allocate one big area for it (like one page), 
> as this would very likely be enough for it, and change the logic to take
> the buffer size into account when filling it.

Or, in the case where ->label is all dimms on the mci, you simply put
"All DIMMs on MCI%d" in there and done. Simple.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
