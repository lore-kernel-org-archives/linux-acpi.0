From: Alex Shi <alex.shi@intel.com>
Subject: Re: [LKP] Commit ac3ebafa81a makes NHM EX/EP machines hung out since
 3.9-rc1
Date: Thu, 28 Mar 2013 09:02:47 +0800
Message-ID: <515396B7.1060909@intel.com>
References: <20130313022759.GA120840@bee> <5152781B.6060603@intel.com> <CAE9FiQUnXev4Q+B1Cww-bhZM8O7bhbvOT=Y5c4SOjFksq1oXEw@mail.gmail.com> <15175142.3Xo9lEvds6@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <15175142.3Xo9lEvds6@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Yinghai Lu <yinghai@kernel.org>, Len Brown <len.brown@intel.com>, Changlong Xie <changlongx.xie@intel.com>, linux-acpi@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, lkp@linux.intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 03/28/2013 08:40 AM, Rafael J. Wysocki wrote:
>> > 
>> > It fixes the problem on my 8 sockets Nehalem-EX that will hang around
>> > ip_auto_config()
>> > 
>> > Tested-by: Yinghai Lu <yinghai@kernel.org>
>> > 
>> > Rafael,
>> > Can you please push this one to Linus tree ?
>> > As the offending patch was via your tree to upstream.
> I will if there's no better way to address this issue before -rc6.

If it can be pushed to upstream, please add:

Reported-by: LKP project <lkp@linux.intel.com>
Reported-by: Xie ChanglongX <changlongx.xie@intel.com>
-- 
Thanks Alex
