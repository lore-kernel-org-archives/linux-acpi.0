From: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH V2] Change ACPI IPMI support to "default y"
Date: Fri, 21 Feb 2014 07:37:16 -0600
Message-ID: <5307568C.3020701@acm.org>
References: <1392740909-2079-1-git-send-email-matthew.garrett@nebula.com>	 <20140220201458.GA7099@sgi.com> <1392927381.20109.0.camel@x230>	 <20140220204028.GJ17949@sgi.com> <1392929163.20109.5.camel@x230>	 <20140220205901.GM17949@sgi.com> <1392930047.20109.6.camel@x230>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1392930047.20109.6.camel@x230>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <matthew.garrett@nebula.com>, "rja@sgi.com" <rja@sgi.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 02/20/2014 03:00 PM, Matthew Garrett wrote:
> On Thu, 2014-02-20 at 14:59 -0600, Russ Anderson wrote:
>> On Thu, Feb 20, 2014 at 08:46:04PM +0000, Matthew Garrett wrote:
>>> On Thu, 2014-02-20 at 14:40 -0600, Russ Anderson wrote:
>>>
>>>> This is also a problem for systems with functional BMCs.  Our
>>>> large cluster systems do all IPMI traffic (monitoring) through
>>>> a system controller back door.  We do not want the kernel
>>>> doing IPMI commands on those systems.
>>> Why not?
>> Because some customers want to use cpu cycles for their
>> application and let the ipmi monitoring go on through
>> the system controller network.
> Why is it generating any significant amount of CPU load? We're not
> talking about a high-bandwidth interface here.
>

I believe that problem is fixed now, at least the one with kipmid using
lots of CPU.

However, the basic problem is that hardware vendors produce hardware
that sucks and then expect software to fix all the problems.  Most IPMI
interfaces don't have interrupts, so they have to be polled.  Then they
add important interfaces on top of it like firmware upgrade and ACPI and
expect it to perform well.  If vendors would just have an interrupt for
IPMI, 99% of these problems would go away.

If there are still issues with lots of CPU being used, then the problem
is most likely non-compliant or just broken hardware.  I've seen enough
of that.

One thing we can do is remove the default interface probing for IPMI. 
Even though the spec has it, all modern hardware should have it
specified in ACPI or device tree.  That should fix all the slow boot
problems, at least.  If a user wants to add a default interface, they
can use the interface to dynamically add it after boot time.

-corey
