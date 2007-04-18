From: Joshua Wise <joshua@joshuawise.com>
Subject: Re: CPU_IDLE prevents resuming from STR [was: Re: 2.6.21-rc6-mm1]
Date: Wed, 18 Apr 2007 19:00:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0704181854150.3859@dashnine.joshuawise.com>
References: <20070408143559.f5014629.akpm@linux-foundation.org>
 <20070413234513.GA2940@inferi.kami.home>  <1176691227.6993.1.camel@sli10-conroe.sh.intel.com>
  <Pine.LNX.4.63.0704162243070.3859@dashnine.joshuawise.com>
 <1176792455.7371.7.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S2992932AbXDRW7D@vger.kernel.org>
In-Reply-To: <1176792455.7371.7.camel@sli10-conroe.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Mattia Dongili <malattia@linux.it>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, 17 Apr 2007, Shaohua Li wrote:
> Looks there is init order issue of sysfs files. The new refreshed patch
> should fix your bug.

Yes, that did fix the hang on resume from STR -- that now works fine.

However:
joshua@rebirth:/sys/devices/system/cpu/cpuidle$ cat available_drivers current_driver

<NULL>
joshua@rebirth:/sys/devices/system/cpu/cpuidle$ cat available_governors current_governor
ladder
ladder

Is this correct? For reference, my config is http://joshuawise.com/config.gz
-- I didn't see any options for cpuidle drivers to access ACPI states...

joshua
