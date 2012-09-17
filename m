From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH V2 1/3] x86,idle: Quickly notice prediction failure for
 repeat mode
Date: Mon, 17 Sep 2012 09:59:45 -0400
Message-ID: <50572CD1.700@redhat.com>
References: <1347933209-25939-1-git-send-email-youquan.song@intel.com> <1347933209-25939-2-git-send-email-youquan.song@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1347933209-25939-2-git-send-email-youquan.song@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Youquan Song <youquan.song@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, arjan@linux.intel.com, lenb@kernel.org, Youquan Song <youquan.song@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On 09/17/2012 09:53 PM, Youquan Song wrote:
> The prediction for future is difficult and when the cpuidle governor prediction
> fails and govenor possibly choose the shallower C-state than it should. How to
> quickly notice and find the failure becomes important for power saving.
>
> cpuidle menu governor has a method to predict the repeat pattern if there are 8
> C-states residency which are continuous and the same or very close, so it will
> predict the next C-states residency will keep same residency time.

Could I convince you to try out my variation on
detect_repeating_intervals? :)

http://people.redhat.com/riel/cstate/cstate-stddev-converge.patch

I suspect that small change might help your code adapt to changed
conditions even faster.

-- 
All rights reversed
