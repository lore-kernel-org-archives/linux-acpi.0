From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 1/2] ACPI / EC: Fix broken big-endian 64bit platforms
 using 'global_lock'
Date: Thu, 24 Sep 2015 16:37:58 -0700
Message-ID: <20150924233758.GB5951@linux>
References: <9b705747a138c96c26faee5218f7b47403195b28.1442305897.git.viresh.kumar@linaro.org>
 <1515364.kIriLUmZv6@vostro.rjw.lan>
 <1AE640813FDE7649BE1B193DEA596E883406510E@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883406510E@SHSMSX101.ccr.corp.intel.com>
Sender: stable-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, "arnd@arndb.de" <arnd@arndb.de>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Len Brown <lenb@kernel.org>, "open list:ACPI" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 23-09-15, 07:52, Zheng, Lv wrote:
> And IMO, if we really want to change global_lock, we should make it bool here.

Yeah, so the second patch in this series is doing just that. Just kept
this patch separate to make more sense. Will resend both and keep you
in cc.

-- 
viresh
