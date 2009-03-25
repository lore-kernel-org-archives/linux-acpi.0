From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Re: Paravirtualizing bits of acpi access
Date: Tue, 24 Mar 2009 17:45:32 -0700
Message-ID: <49C97EAC.9010107@goop.org>
References: <49C484B7.20100@goop.org>	<0A882F4D99BBF6449D58E61AAFD7EDD60E5E877B@pdsmsx502.ccr.corp.intel.com>	<49C88647.8080404@goop.org>
	<200903241045.19194.bjorn.helgaas@hp.com>	<49C91832.8090300@goop.org>
	<0A882F4D99BBF6449D58E61AAFD7EDD60E5E878B@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <0A882F4D99BBF6449D58E61AAFD7EDD60E5E878B@pdsmsx502.ccr.corp.intel.com>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, Xen-devel <xen-devel@lists.xensource.com>, "Cihula,
	Joseph" <joseph.cihula@intel.com>, the arch/x86 maintainers <x86@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: linux-acpi@vger.kernel.org

Tian, Kevin wrote:
>> Though, come to think of it, perhaps there's no harm in letting the 
>> kernel do its own state-saving.  I'll check.
>>
>>     
>
> Well, I guess it's doable, since do_suspend_lowlevel also needs
> to restore processor context upon S3 failure (function return from
> acpi_enter_sleep_state instead of from wakeup stub). 

 From a quick look, it seems that all the instructions in the restore 
code are ones that Xen will trap and emulate; but with this kind of 
thing, its all in the testing...

    J
