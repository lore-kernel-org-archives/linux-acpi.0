From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 1/2] ACPI / EC: Fix broken big-endian 64bit platforms
 using 'global_lock'
Date: Wed, 16 Sep 2015 07:29:07 +0530
Message-ID: <20150916015907.GA29235@linux>
References: <9b705747a138c96c26faee5218f7b47403195b28.1442305897.git.viresh.kumar@linaro.org>
 <1515364.kIriLUmZv6@vostro.rjw.lan>
 <2327281.tcr4Ty65Wu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2327281.tcr4Ty65Wu@vostro.rjw.lan>
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lv Zheng <lv.zheng@intel.com>, gregkh@linuxfoundation.org, linaro-kernel@lists.linaro.org, sboyd@codeaurora.org, arnd@arndb.de, stable@vger.kernel.org, Len Brown <lenb@kernel.org>, "open list:ACPI" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 16-09-15, 04:06, Rafael J. Wysocki wrote:
> In any case, please just split the EC-related changes off from your second
> patch and send them separately.

That !! change isn't required anymore, will be dropping it completely.

-- 
viresh
