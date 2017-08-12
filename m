From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 6/7] libnvdimm,
 btt: refactor initial_offset calculations
Date: Fri, 11 Aug 2017 18:39:45 -0700
Message-ID: <CAPcyv4is9O=HCrHPJXoOOW2p2LyUE1n3WCi-5X0AKfU-pNWNPg@mail.gmail.com>
References: <20170809000746.10585-1-vishal.l.verma@intel.com>
 <20170809000746.10585-7-vishal.l.verma@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20170809000746.10585-7-vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Aug 8, 2017 at 5:07 PM, Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> In preparation for BTT error clearing, refactor the initial offset
> calculations. Until now, all callers of arena_{read,write}_bytes assumed
> a relative offset to the arena, and it was later adjusted for the
> initial offset. Until now, every time we calculated a relative offset,
> we passed it to these functions to do reads or writes, and so where the
> offset calculations happened didn't matter.
>
> For error clearing, there will be places where we calculate offsets to
> check for the presence of media errors, and the above scheme becomes
> error prone.
>
> Make the initial_offset calculations explicit for all callers of
> arena_{read,write}_bytes, and provide a helper to do them. The error
> checking/clearing code can then use these same helpers.
>
> Reported-by: Toshi Kani <toshi.kani-ZPxbGqLxI0U@public.gmane.org>
> Signed-off-by: Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/nvdimm/btt.c | 69 ++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 42 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
> index e9dd651..9acf06b 100644
> --- a/drivers/nvdimm/btt.c
> +++ b/drivers/nvdimm/btt.c
> @@ -31,14 +31,17 @@ enum log_ent_request {
>         LOG_OLD_ENT
>  };
>
> +static inline u64 calc_nsoff(struct nd_btt *nd_btt, u64 relative_offset)
> +{
> +       return relative_offset + nd_btt->initial_offset;
> +}
> +
>  static int arena_read_bytes(struct arena_info *arena, resource_size_t offset,
>                 void *buf, size_t n, unsigned long flags)
>  {
>         struct nd_btt *nd_btt = arena->nd_btt;
>         struct nd_namespace_common *ndns = nd_btt->ndns;
>
> -       /* arena offsets may be shifted from the base of the device */
> -       offset += arena->nd_btt->initial_offset;
>         return nvdimm_read_bytes(ndns, offset, buf, n, flags);
>  }
>
> @@ -48,14 +51,13 @@ static int arena_write_bytes(struct arena_info *arena, resource_size_t offset,
>         struct nd_btt *nd_btt = arena->nd_btt;
>         struct nd_namespace_common *ndns = nd_btt->ndns;
>
> -       /* arena offsets may be shifted from the base of the device */
> -       offset += arena->nd_btt->initial_offset;
>         return nvdimm_write_bytes(ndns, offset, buf, n, flags);
>  }

So let's get rid of arena_{read,write}_bytes(). The only point of the
wrapper was to include an arena specific offset, but now we're pushing
all offset calculations to the caller so arena_{read,write}_bytes() is
equivalent to nvdimm_{read,write}_bytes(). However, since many of
these call sites now perform a common offset calculations maybe we can
provide a new helper for that to differentiate it from the error
clearing case? After patch 7 is applied it's no longer clear which
offset calculation is used where and for what reason, there's just too
many offset variables calculations and overload of the word 'offset'
for bugs to hide.

Maybe it's just late on a Friday and my eyes are going cross, but it
seems you have 2 classes of use cases between calc_nsoff and
lba_to_nsoff, perhaps separate read/write wrappers for those 2 cases?
Also, I find something unreadable about calc_nsoff, and reading the
prototype "u64 calc_nsoff(struct nd_btt *nd_btt, u64 relative_offset)"
doesn't help clarify. What is 'relative_offset' relative to? Is it the
base namespace / device offset?
