From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/3] dynamic_hex_dump cleanup
Date: Fri, 28 Apr 2017 16:12:29 -0700
Message-ID: <CAPcyv4iqK-3X5ngXs6HjTQhtW0DEu5KsBcgAY1nVJCWPnSagGw@mail.gmail.com>
References: <149341493336.35578.13631055553267152302.stgit@dwillia2-desk3.amr.corp.intel.com>
 <1493416143.1873.13.camel@perches.com>
 <CAPcyv4iJvjJTd7M5_5saopTvKPStC=sYqq++FbE_qFJwpqmASw@mail.gmail.com>
 <1493417230.1873.15.camel@perches.com>
 <CAPcyv4h=DfkJu6+7by0HoVhUOKtoCJmc4GGg3XNxYURCkX09Tw@mail.gmail.com>
 <CAPcyv4jzMfd8TrFcX0GR+6iz0SaJyO5NzzswrEVm-kNVfgrQFQ@mail.gmail.com>
 <1493418714.1873.18.camel@perches.com>
 <CAPcyv4hDC1f9xRJJyDK09ezF7Q=qz+fvku5qFP_FCrS2xh=zUA@mail.gmail.com>
 <1493420656.1873.22.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <1493420656.1873.22.camel-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
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

On Fri, Apr 28, 2017 at 4:04 PM, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org> wrote:
> On Fri, 2017-04-28 at 15:59 -0700, Dan Williams wrote:
>> ...but again, hex_dump_dbg() implies to me dev_dbg() behavior, i.e.
>> that the hexdump happens in the KERN_DEBUG case
>
> I think you are confusing KERN_DEBUG, a logging level, with a
> preprocessor #define of DEBUG.

Indeed I am.

>
>>  which I don't want. I
>> want the call to be compiled out completely when it can't be
>> enabled/disabled dynamically.
>
> dev_dbg is compiled away completely when DEBUG is
> not defined and when CONFIG_DYNAMIC_DEBUG is not
> defined.
>
> This hex_dump facility should behave the same way.
>
>> I think we do need a hex_dump_dbg(), but that does not eliminate the
>> utility of / need for dynamic_hex_dump().
>
> dynamic_hex_dump should only exist when CONFIG_DYNAMIC_DEBUG
> is enabled and should otherwise be invisible to driver code.
>

So, I overlooked that Linus fixed this compile problem a while back with:

cdf17449af1d hexdump: do not print debug dumps for !CONFIG_DEBUG

Which predated the introduction of ACPI_NFIT_DEBUG. So I can just call
print_hex_dump_debug() and call it a day.

Sorry for the noise, Joe!
