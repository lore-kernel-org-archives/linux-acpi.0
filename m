From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Add support of NVDIMM memory error notification in ACPI
 6.2
Date: Thu, 8 Jun 2017 10:34:22 -0700
Message-ID: <CAPcyv4hocL=1Mzqa+nJCdmRz7YgxUc3P1w-nn7F=uQG8wu94KA@mail.gmail.com>
References: <20170607184947.18733-1-toshi.kani@hpe.com>
 <CAPcyv4i7bLU17QEmdUBQrtWP3AZxPRyKK0NN105XrTj8K3nAAQ@mail.gmail.com>
 <1496869051.9288.1.camel@hpe.com>
 <CAPcyv4hwhRc6+JW8m3zVn_tKz__wE9BHOfpjy69RS6OwiqV-PA@mail.gmail.com>
 <1496871186.9288.3.camel@hpe.com>
 <b91c4a7b-3e19-df5d-12e7-61cdf1bc2c84@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <b91c4a7b-3e19-df5d-12e7-61cdf1bc2c84-ZPxbGqLxI0U@public.gmane.org>
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
Cc: "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jun 8, 2017 at 10:30 AM, Linda Knippers <linda.knippers-ZPxbGqLxI0U@public.gmane.org> wrote:
[..]
> Wasn't Dan concerned about how the OS can know whether the FW supports
> that bit in the Start ARS?
>
> The Query ARS Capabilities DSM has a bit that tells the OS whether the
> platform supports the notification and the point of the notification was
> to tell the OS it could do a Start ARS with bit 1 set.  Of course, if
> you get the notification then that means the platform has the capability
> to deliver it, but it might not hurt to check the flag from the Query
> Capabilities bit.

Good point, yes, I think it is safe to assume that a BIOS that claims
to support un-correctable error notification also supports this Start
ARS flag.
