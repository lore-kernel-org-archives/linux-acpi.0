From: Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 0/6] BTT error clearing rework
Date: Tue, 1 Aug 2017 13:56:31 -0600
Message-ID: <20170801195630.GC18006@omniknight.lm.intel.com>
References: <20170726233546.29052-1-vishal.l.verma@intel.com>
 <1501542358.2042.97.camel@hpe.com>
 <1501544000.4405.5.camel@intel.com>
 <1501600767.2042.99.camel@hpe.com>
 <1501614143.2042.101.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1501614143.2042.101.camel-ZPxbGqLxI0U@public.gmane.org>
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
 Rafael J" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On 08/01, Kani, Toshimitsu wrote:
> On Tue, 2017-08-01 at 09:19 -0600, Toshi Kani wrote:
> > On Mon, 2017-07-31 at 23:35 +0000, Verma, Vishal L wrote:
> > > On Mon, 2017-07-31 at 23:15 +0000, Kani, Toshimitsu wrote:
> > > > On Wed, 2017-07-26 at 17:35 -0600, Vishal Verma wrote:
>  :
> > > Thanks for the test Toshi, I will try and reproduce it.
> > > My first guess is - are the injected errors potentially in the BTT
> > > metadata area towards the end?
> > >
> > > ->rw_bytes can only clear errors on properly aligned writes, and
> > > the btt metadata writes will be too small to clear metadata
> > > errors..
> >
> > I picked an injected offset without careful thoughts, so it is
> > possible that I might have stepped into such area.  I just tested
> > with a block device interface with multiple different offsets, and
> > they failed in clearing as well...  I will look into further as well
> > as my test setup.
> 
> The change/hack below takes care of the issue in my setup.  There is a
> discrepancy in offset between the pre-check in btt_write_pg() and the
> actual check in nsio_rw_bytes().
> 
> Thanks,
> -Toshi
> 
> ---
>  drivers/nvdimm/btt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
> index 8a959f8..83ad4c6 100644
> --- a/drivers/nvdimm/btt.c
> +++ b/drivers/nvdimm/btt.c
> @@ -1137,7 +1137,7 @@ static bool btt_is_badblock(struct btt *btt,
> struct arena_info *arena,
>                 u32 postmap)
>  {
>         u64 nsoff = to_namespace_offset(arena, postmap);
> -       sector_t phys_sector = nsoff >> 9;
> +       sector_t phys_sector = (nsoff + arena->nd_btt->initial_offset) >> 9;
> 
>         return is_bad_pmem(btt->phys_bb, phys_sector, arena->internal_lbasize);
>  }

Hey Toshi, that is a great catch (I'm going to look at enhancing the
unit tests too to catch this).

Your patch is correct. Normally whenever we calculate a 'nsoff', we use
that to do arena_{read,write}_bytes, and that takes care of adding the
initial_offset. This was the first instance where we calculated nsoff
and did something other than rw_bytes with it (i.e. is_bad_pmem), and
therefore this nsoff needs the initial_offset adjustment manually..

However just adding that here is inviting future bugs like this, so I'm
going to refactor the initial_offset adjustment into some helpers and
use those across the board. That should prevent this sort of a bug
again.

Thanks for the report and the root cause!

	-Vishal
