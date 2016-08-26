From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] acpi, nfit: add dimm device notification support
Date: Fri, 26 Aug 2016 11:39:23 -0700
Message-ID: <CAPcyv4hdLdGR7LLyHVZsyXK6dNL1+jF927Siqt_D2DfPSifwwA@mail.gmail.com>
References: <147198925154.3136.14739108342311837939.stgit@dwillia2-desk3.amr.corp.intel.com>
 <147198926249.3136.6163137762013359047.stgit@dwillia2-desk3.amr.corp.intel.com>
 <1472235940.1532.23.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <1472235940.1532.23.camel-ZPxbGqLxI0U@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: "Kani, Toshimitsu" <toshi.kani-ZPxbGqLxI0U@public.gmane.org>
Cc: "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Wysocki,
 Rafael J" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Aug 26, 2016 at 11:26 AM, Kani, Toshimitsu <toshi.kani-ZPxbGqLxI0U@public.gmane.org> wrote:
> On Tue, 2016-08-23 at 14:54 -0700, Dan Williams wrote:
>> Per "ACPI 6.1 Section 9.20.3" NVDIMM devices, children of the
>> ACPI0012 NVDIMM Root device, can receive health event notifications.
>>
>> Given that these devices are precluded from registering a
>> notification handler via acpi_driver.acpi_device_ops (due to no
>> _HID), we use acpi_install_notify_handler() directly.
>
> I've confirmed that this ACPI notify handler is called properly.
>
>> The registered handler, acpi_nvdimm_notify(), triggers a poll(2)
>> event on the nmemX/nfit/flags sysfs attribute when a health event
>> notification is received.
>
> This sounds good idea, but should we document that the value of sysfs
> 'flags' itself does not get updated?  User space program will then need
> to call its _DSM to get health status.

Yes, this plus the new scrub attribute behavior need documentation.
I'll prepare a refresh for Documentation/nvdimm/nvdimm.txt.

The need to call a _DSM after a notification event is documented in
the ACPI spec, but you're right, we do need to connect that language
to the Linux specific mechanism.
