From: "Xiao, Hui" <hui.xiao@linux.intel.com>
Subject: Re: [BUGFIX] ACPI, APEI, Avoid too much error reporting in runtime
Date: Wed, 13 Jun 2012 16:03:02 +0800
Message-ID: <4FD84936.5080006@linux.intel.com>
References: <1339471219-4057-1-git-send-email-ying.huang@intel.com> <4FD6C310.3060507@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FD6C310.3060507@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Huang Ying <ying.huang@intel.com>, linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 2012/6/12 12:18, Len Brown wrote:
> applied.
> 
> thanks,
> -Len Brown, Intel Open Source Technology Center
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
Hi all,

I've also encountered the similar bug:
  [Firmware Bug]: APEI: Invalid bit width + offset in GAR [0x1121a5000/64/0/3/0]
during einj test. 

Besides Ying's fix patch, I think its a regression caused by incorrect bit width + offset check condition introduced by commit v3.3-5-g15afae6. I've written a fix patch for it and will send it in a separate mail soon.

Thanks,
-Hui
