From: Greg KH <greg@kroah.com>
Subject: Re: 2.6.10-rc1-mm3: ACPI problem due to un-exported hotplug_path
Date: Fri, 5 Nov 2004 12:43:52 -0800
Message-ID: <20041105204352.GB1204@kroah.com>
References: <20041105201012.GA24063@vrfy.org> <20041105123254.A17224@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261192AbUKEUpa@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20041105123254.A17224@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ashok Raj <ashok.raj@intel.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, rml@novell.com, linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>, acpi-devel@lists.sourceforge.net, rusty@rustycorp.com.au.kroah.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 05, 2004 at 12:32:56PM -0800, Ashok Raj wrote:
> On Fri, Nov 05, 2004 at 12:10:12PM -0800, Kay Sievers wrote:
> > 
> >    On Fri, Nov 05, 2004 at 10:05:13AM -0800, Greg KH wrote:
> >    >  >  The  following  error (compin from Linus' tree) is caused by the
> >    fact that
> >    > > hotplug_path is no longer EXPORT_SYMBOL'ed:
> >    > >
> >    > >
> >    > > <--  snip  -->
> >    > >
> >    >  >  if  [  -r  System.map  ];  then  /sbin/depmod  -ae -F System.map
> >    2.6.10-rc1-mm3; fi
> > 
> >    I've  found  it.  This  wants  to introduce a new direct /sbin/hotplug
> >    call,
> >    with "add" and "remove" events, without sysfs support.
> > 
> >    It  should  use  class  support  or kobject_hotplug() instead.  Nobody
> >    should
> >    fake hotplug events anymore, cause every other notification transport
> >    will not get called (currently uevent over netlink).
> > 
> 
> we were discussing this exact thing recently.. we maybe able to clean this up.. here is why
> we are doing this manual thingy...
> 
> When we support physical component hotplug, we want to create the sysfs entries, but that doesnt
> mean the component (i.e CPU or memory) is hotplugged. The reason is for node level hotplug
> there are sequencing requirements, memory needs to be brought up first before cpu, and also
> the error handling/policy requirments which we want the user space to handle it and not from 
> kernel side.
> 
> 
> the sequence is when physical arrival of cpu is seen, we will just create a sysfs entry 
> which will also send an add event (which really is just cpu arrival, and sysfs created). 
> 
> In our model the event is just consumed by the script cpu.agent, which would in turn decide and 
> bring the cpu up by 
> 
> #echo 1> /sys/devices/system/cpu/cpu#/online
> 
> what apps really would care about is the ONLINE (which doesnt exist) event itself, and the 
> OFFLINE. The ADD/REMOVE only indicate sysfs entries appear and disappear.
> 
> I dont know if adding ONLINE/OFFLINE is the right thing, or use the CHANGE notification 
> to inform. 

That's fine.  But call kobject_hotplug() if you want to do that.  Don't
rewrite your own function, or you will loose out on a lot of the hotplug
functionality (sequence numbers, kevent notifications, etc.)

thanks,

greg k-h
