From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/3] dynamic_hex_dump cleanup
Date: Fri, 28 Apr 2017 15:59:28 -0700
Message-ID: <CAPcyv4hDC1f9xRJJyDK09ezF7Q=qz+fvku5qFP_FCrS2xh=zUA@mail.gmail.com>
References: <149341493336.35578.13631055553267152302.stgit@dwillia2-desk3.amr.corp.intel.com>
 <1493416143.1873.13.camel@perches.com>
 <CAPcyv4iJvjJTd7M5_5saopTvKPStC=sYqq++FbE_qFJwpqmASw@mail.gmail.com>
 <1493417230.1873.15.camel@perches.com>
 <CAPcyv4h=DfkJu6+7by0HoVhUOKtoCJmc4GGg3XNxYURCkX09Tw@mail.gmail.com>
 <CAPcyv4jzMfd8TrFcX0GR+6iz0SaJyO5NzzswrEVm-kNVfgrQFQ@mail.gmail.com>
 <1493418714.1873.18.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <1493418714.1873.18.camel-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>, linux-remoteproc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jason Baron <jbaron-JqFfY2XvxFXQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Apr 28, 2017 at 3:31 PM, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org> wrote:
> On Fri, 2017-04-28 at 15:19 -0700, Dan Williams wrote:
>> On Fri, Apr 28, 2017 at 3:14 PM, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>> > On Fri, Apr 28, 2017 at 3:07 PM, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org> wrote:
>> > > On Fri, 2017-04-28 at 14:52 -0700, Dan Williams wrote:
>> > > > On Fri, Apr 28, 2017 at 2:49 PM, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org> wrote:
>> > > > > On Fri, 2017-04-28 at 14:28 -0700, Dan Williams wrote:
>> > > > > > More than one driver has worked around the fact that
>> > > > > > print_hex_dump_debug() requires CONFIG_DYNAMIC_DEBUG=y to build.
>> > > > >
>> > > > > No it doesn't.  builds work fine.  Output is restricted.
>> > > > >
>> > > > > > Provide a dynamic_hex_dump() so that drivers that want the extra debugging to be
>> > > > > > turned off in the CONFIG_DYNAMIC_DEBUG=n can use dynamic_hex_dump()
>> > > > > > directly.
>> > > > >
>> > > > > I think the concept is unnecessary
>> > > > > .
>> > > > > Just use print_hex_dump with KERN_DEBUG.
>> > > >
>> > > > No, we don't want any possibility of output in the
>> > > > CONFIG_DYNAMIC_DEBUG=n case. This is extra debug that only makes sense
>> > > > in the CONFIG_DYNAMIC_DEBUG case.
>> > >
>> > > No, that doesn't work the same.
>> > >
>> > > Look at your conversion of drivers/acpi/nfit/core.c
>> > >
>> > > dev_dbg outputs always when DEBUG is defined and
>> > > optionally outputs when CONFIG_DYNAMIC_DEBUG is enabled.
>> >
>> > Right, that's what I want dev_dbg() to output at KERN_DEBUG level
>> > always and the hexdump only in the dynamic case.
>>
>> Joe, I'm trying to understand your objection. What you are proposing
>> is that the debug output is present at the KERN_DEBUG level in the
>> CONFIG_DYNAMIC_DEBUG=n case and that's not what either use case wants.
>> What breaks by letting users call dynamic_hex_dump() directly?
>
> Call it hex_dump_dbg and I have no objections.

...but again, hex_dump_dbg() implies to me dev_dbg() behavior, i.e.
that the hexdump happens in the KERN_DEBUG case which I don't want. I
want the call to be compiled out completely when it can't be
enabled/disabled dynamically.

> The "dynamicism" is a side effect of not having DEBUG
> defined.  dev_dbg will emit if DEBUG is declared regardless
> of dynamic_debug.
>
> This new function should have the same behavior.

I think we do need a hex_dump_dbg(), but that does not eliminate the
utility of / need for dynamic_hex_dump().
