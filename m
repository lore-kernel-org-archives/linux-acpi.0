From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/3] nfit, libnvdimm: allow an ARS scrub to be
 triggered on demand
Date: Thu, 21 Jul 2016 12:59:37 -0700
Message-ID: <CAPcyv4jEp6qrHUcBHoO2VmauacB7O5wZdnkZCXN-QYiXa=ecWg@mail.gmail.com>
References: <1469065850-32401-1-git-send-email-vishal.l.verma@intel.com>
 <1469065850-32401-3-git-send-email-vishal.l.verma@intel.com>
 <57912512.5060202@hpe.com>
 <CAPcyv4hAb=qG2j+ibKwKGU+a1myq2OBDAAUXMHMT7Res1ZnoWA@mail.gmail.com>
 <1dba81aa-3ca2-a843-7175-6216be8ee4a3@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <1dba81aa-3ca2-a843-7175-6216be8ee4a3-ZPxbGqLxI0U@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Linda Knippers <linda.knippers-ZPxbGqLxI0U@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jul 21, 2016 at 12:55 PM, Linda Knippers <linda.knippers-ZPxbGqLxI0U@public.gmane.org> wrote:
>
>
> On 7/21/2016 3:46 PM, Dan Williams wrote:
>> On Thu, Jul 21, 2016 at 12:40 PM, Linda Knippers <linda.knippers-ZPxbGqLxI0U@public.gmane.org> wrote:
>>> On 07/20/2016 09:50 PM, Vishal Verma wrote:
>>>> Normally, an ARS (Address Range Scrub) only happens at
>>>> boot/initialization time. There can however arise situations where a
>>>> bus-wide rescan is needed - notably, in the case of discovering a latent
>>>> media error, we should do a full rescan to figure out what other sectors
>>>> are bad, and thus potentially avoid triggering an mce on them in the
>>>> future. Also provide a sysfs trigger to start a bus-wide scrub.
>>>
>>> I don't see anything in here that checks to see if the platform actually
>>> supports ARS before setting all this stuff up.  Setting up an MCE handler
>>> and exposing a sysfs trigger for something that is optional and perhaps
>>> not implemented doesn't seem helpful.  Or is there a check that I missed?
>>
>> We'll get -ENOTTY to ars_start(), but you're right it's a good idea to
>> hide the scrub attribute if a platform does not have ars support.
>>
>> Vishal, can you add an is_visible() routine to
>> acpi_nfit_attribute_group() to hide 'scrub' on platforms that do not
>> implement the ARS commands?
>
> It's also possible that a platform might only support ARS at boot time
> so subsequent scrubs would fail or not return any new information.
> I don't think there's a way to know that in advice though.

I would hope a platform like that just marks the "ARS - Start" command
as not supported so that we don't even generate the failure.
