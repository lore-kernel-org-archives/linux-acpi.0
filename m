From: Linda Knippers <linda.knippers-ZPxbGqLxI0U@public.gmane.org>
Subject: Re: [PATCH] acpi, nfit: fix acpi event notifications for nfit
Date: Thu, 18 Aug 2016 15:52:48 -0400
Message-ID: <07af328e-d703-fd80-20be-725f00e54812@hpe.com>
References: <1471546104-28520-1-git-send-email-vishal.l.verma@intel.com>
 <CAPcyv4ixygjD8St5YP2SjfEJnVeWMsAHjqDTF8xxWPvvDWw_bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <CAPcyv4ixygjD8St5YP2SjfEJnVeWMsAHjqDTF8xxWPvvDWw_bw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Xiao Guangrong <guangrong.xiao-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org



On 8/18/2016 3:48 PM, Dan Williams wrote:
> On Thu, Aug 18, 2016 at 11:48 AM, Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>> The nfit driver had an acpi event notification handler, but it never
>> would've worked because we weren't setting the
>> ACPI_DRIVER_ALL_NOTIFY_EVENTS flag in acpi_driver.
> 
> Let's update the changelog to be helpful for someone implementing a
> backport or taking this back to a -stable branch.  Something like:
> 
> Subject: acpi, nfit: fix event notifications
> 
> Commit 209851649dc4 "acpi: nfit: Add support for hot-add" added
> support for _FIT notifications, but it neglected to set the
> ACPI_DRIVER_ALL_NOTIFY_EVENTS flag that acpi_bus_notify() uses to gate
> notification delivery.

While we're at it, should we update the notifier function to explicitly check
for event 0x80 before re-evaluating the _FIT?  I'm thinking about some time
in the future when there might be more than one event.

-- ljk
> 
> Fixes: 209851649dc4 ("acpi: nfit: Add support for hot-add")
> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm
> 
