From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] PM/Sleep, ACPI: Teach acpi_cpu_soft_notify() to handle
 CPU hotplug in suspend/resume path
Date: Mon, 05 Mar 2012 12:03:16 +0530
Message-ID: <4F545E2C.8080408@linux.vnet.ibm.com>
References: <20120228155137.3061.97133.stgit@srivatsabhat.in.ibm.com> <201203042333.18501.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201203042333.18501.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: lenb@kernel.org, deepthi@linux.vnet.ibm.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 03/05/2012 04:03 AM, Rafael J. Wysocki wrote:

> On Tuesday, February 28, 2012, Srivatsa S. Bhat wrote:
>> acpi_cpu_soft_notify handles only CPU_ONLINE and CPU_DEAD events. However,
>> during a system-wide suspend/hibernation operation, CPU_ONLINE_FROZEN and
>> CPU_DEAD_FROZEN events are sent as part of CPU hotplug.
>>
>> Those events are really no different from regular CPU hotplug in this context,
>> and hence acpi shouldn't ignore them. So, teach acpi_cpu_soft_notify() to
>> handle those events as well.
>>
>> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
>> ---
>>
>> I am no ACPI expert! So requesting a thorough review of this patch..
> 
> Well, as far as I can tell, it _looks_ correct.  That said, I don't think
> anyone will really tell you on the basis of code review alone, this requires
> testing.
> 
> Since Len hasn't been very responsive recently, I can take this patch into
> linux-pm/linux-next and see what the feedback is.


That would be great! Thanks a lot!

Regards,

Srivatsa S. Bhat
