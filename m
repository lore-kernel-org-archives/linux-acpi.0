From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3 1/2] ACPI / EC: Fix broken big-endian 64bit platforms using 'global_lock'
Date: Wed, 23 Sep 2015 12:29:42 +0200
Message-ID: <62743134.3NjiZY7jHi@wuerfel>
References: <9b705747a138c96c26faee5218f7b47403195b28.1442305897.git.viresh.kumar@linaro.org> <3821285.7cLYDZsCsX@wuerfel> <56027798.7000700@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56027798.7000700@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linaro-kernel@lists.linaro.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, open list <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "open list:ACPI" <linux-acpi@vger.kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday 23 September 2015 10:57:44 Sudeep Holla wrote:
> 
> Also I am not against the $subject patch as such, just added
> clarification so that it shouldn't be assumed that BE + ACPI works on
> ARM64.
> 

Ok, at least we can safely assume that we do not need to backport that
patch to stable then.

	Arnd
