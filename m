From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [ACPI] 2.6.12-rc1-mm[1-3]: ACPI battery monitor does not work
Date: Mon, 4 Apr 2005 18:04:56 +0200
Message-ID: <200504041804.57166.rjw@sisk.pl>
References: <200503291156.19112.rjw@sisk.pl> <200504011151.48468.rjw@sisk.pl> <200504041734.23178.luming.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261264AbVDDQEl@vger.kernel.org>
In-Reply-To: <200504041734.23178.luming.yu@intel.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: luming.yu@intel.com
Cc: acpi-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

On Monday, 4 of April 2005 11:34, Yu, Luming wrote:
> Please testing patch filed at
> http://bugzilla.kernel.org/show_bug.cgi?id=3851#c64
> My testing results on toshiba satellite M20 is:
> 
> /proc/acpi/battery/BAT0#time cat state
> present:                 yes
> capacity state:          ok
> charging state:          charging
> present rate:            1500 mA
> remaining capacity:      4064 mAh
> present voltage:         15000 mV
> 
> real    0m0.023s
> user    0m0.000s
> sys     0m0.020s

Here's my result on Asus L5D ("plain" 2.6.12-rc1-mm3 with the patch):

rafael@albercik:/proc/acpi/battery/BAT0> time cat state
present:                 yes
capacity state:          ok
charging state:          charged
present rate:            unknown
remaining capacity:      unknown
present voltage:         unknown

real    0m15.113s
user    0m0.000s
sys     0m0.034s

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
