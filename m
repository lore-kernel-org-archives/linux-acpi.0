From: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [PATCH] RTC: Fix CMOS time error after writing /proc/acpi/alarm
Date: Wed, 25 Jun 2008 10:44:16 +0200
Message-ID: <20080625104416.67af4680@i1501.lan.towertech.it>
References: <42DFA526FC41B1429CE7279EF83C6BDC014E42D5@pdsmsx415.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755440AbYFYIof@vger.kernel.org>
In-Reply-To: <42DFA526FC41B1429CE7279EF83C6BDC014E42D5@pdsmsx415.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rtc-linux@googlegroups.com
Cc: huacai.chen@intel.com, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, lenb@kernel.org, p_gortmaker@yahoo.com, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 23 Jun 2008 18:52:21 +0800
"Chen, Huacai" <huacai.chen@intel.com> wrote:

> From: Huacai Chen <huacai.chen@intel.com>
> 
> When writing /proc/acpi/alarm in adjust mode, e.g. 
> 	echo "+0000-00-00 00:00:15" >/proc/acpi/alarm 
> The "century" field should be read and added to "year" field before
> writing, otherwise the CMOS time will go back to 2000 years ago, e.g.
> 	# cat /proc/acpi/alarm
> 	0008-06-21 11:38:46 
> Then the system time may be reset to the date of manufacture after
> rebooting. This patch fixed this issue.
> 
> Signed-off-by: Huacai Chen <huacai.chen@intel.com>
> Acked-by: Pavel Machek <pavel@suse.cz>

 Acked-by: Alessandro Zummo <a.zummo@towertech.it>

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
