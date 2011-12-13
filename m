From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] [PATCH 5/8] ACPI: add processor driver for Xen
 virtual CPUs.
Date: Tue, 13 Dec 2011 07:45:20 +0000
Message-ID: <4EE710A00200007800067274@nat28.tlf.novell.com>
References: <1322673664-14642-1-git-send-email-konrad.wilk@oracle.com>
 <1322673664-14642-6-git-send-email-konrad.wilk@oracle.com>
 <4ED755D70200007800064987@nat28.tlf.novell.com>
 <20111212172941.GA8619@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111212172941.GA8619@phenom.dumpdata.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: stefan.bader@canonical.com, Ian.Campbell@citrix.com, mike.mcclurg@citrix.com, jeremy@goop.org, ke.yu@intel.com, kevin.tian@intel.com, konrad@kernel.org, lenb@kernel.org, xen-devel@lists.xensource.com, liang.tang@oracle.com, rjw@sisk.pl, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

>>> On 12.12.11 at 18:29, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote:
> On Thu, Dec 01, 2011 at 09:24:23AM +0000, Jan Beulich wrote:
>> >>> On 30.11.11 at 18:21, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote:
>> > --- a/drivers/acpi/Makefile
>> > +++ b/drivers/acpi/Makefile
>> > @@ -66,6 +66,7 @@ obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
>> >  # processor has its own "processor." module_param namespace
>> >  processor-y			:= processor_driver.o processor_throttling.o
>> >  processor-y			+= processor_idle.o processor_thermal.o
>> > +processor-y			+= processor_xen.o
>> 
>> This should minimally be processor-$(CONFIG_XEN), with other things
>> adjusted as necessary.
> 
> I was under the impression that this was required to get the 
> processor_xen.ko
> to be a module. Otherwise it would only compile as built-in.

processor_xen.ko? Why not have all the code go into processor.ko?
(And the original construct didn't aim in that direction either.)

Jan
