From: Dexuan Cui <decui-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>
Subject: RE: [PATCH v2] nfit: add Hyper-V NVDIMM DSM command set to white list
Date: Sat, 2 Feb 2019 01:06:18 +0000
Message-ID: <PU1P153MB0169D661955195EA070E7EF0BF930@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB01690EDA138D3ABDE5B4A482BF970@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4jD1oRWzA4ZiMYZm1uxsbOdgqzbb9raH70-HBDqapcE_g@mail.gmail.com>
 <PU1P153MB0169977604493B82B662A01CBF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4haUouYs_Vfju2SMvjcwc7rqY06zqT8NJ-3uakGMZSu0w@mail.gmail.com>
 <PU1P153MB01694FCAF062E089059CD441BF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4gdWJ8qtiASU9ggz56Mkrm9OXfsO74RM9OOrXFmBw_A9Q@mail.gmail.com>
 <PU1P153MB0169D8F7C6E29C22FE122F3FBF930@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <PU1P153MB0169D8F7C6E29C22FE122F3FBF930-7hHSCQUTt08p9lVGRpUb+2HfQuWdHs3hiGd9ebBGJoev3QGu/rdwKA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Dexuan Cui <decui-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Josh Poulson <jopoulso-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, Stephen Hemminger <sthemmin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>, Haiyang Zhang <haiyangz-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, "driverdev-devel-tBiZLqfeLfOHmIFyCCdPziST3g8Odh+X@public.gmane.org" <driverdev-devel-tBiZLqfeLfOHmIFyCCdPziST3g8Odh+X@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Michael Kelley <mikelley-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, Sasha Levin <Alexander.Levin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ross Zwisler <zwisler-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, KY Srinivasan <kys-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> From: Linux-nvdimm <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org> On Behalf Of
> Dexuan Cui
> Sent: Friday, February 1, 2019 4:34 PM
> > > > ...
> > > > Those reads find a namespace index block
> > > > and a label. Unfortunately the label has the LOCAL flag set and Linux
> > > > explicitly ignores pmem namespace labels with that bit set. The reason
> > > > for that is due to the fact that the original definition of the LOCAL
> > > > bit from v1.1 of the namespace label implementation [1] explicitly
> > > > limited the LOCAL flag to "block aperture" regions. If you clear that
> > > > LOCAL flag I expect it will work. To my knowledge Windows pretends
> > > > that the v1.1 definition never existed.

On the libnvdimm-pending branch, I get this:

root@decui-gen2-u1904:~/nvdimm# ndctl list
root@decui-gen2-u1904:~/nvdimm# ndctl list --idle
[
  {
    "dev":"namespace1.0",
    "mode":"raw",
    "size":0,
    "uuid":"00000000-0000-0000-0000-000000000000",
    "state":"disabled"
  },
  {
    "dev":"namespace0.0",
    "mode":"raw",
    "size":0,
    "uuid":"00000000-0000-0000-0000-000000000000",
    "state":"disabled"
  }
]

With the patch that clears the LOCAL label (BTW, the initial value of flags is 0x3,
meaning a read-only local label) :
@@ -2496,6 +2500,7 @@ static int init_active_labels(struct nd_region *nd_region)
                        if (!label_ent)
                                break;
                        label = nd_label_active(ndd, j);
+                       label->flags &= ~NSLABEL_FLAG_LOCAL;
                        label_ent->label = label;

I get this:

root@decui-gen2-u1904:~/nvdimm# ndctl list
root@decui-gen2-u1904:~/nvdimm# ndctl list --idle
[
  {
    "dev":"namespace1.0",
    "mode":"raw",
    "size":0,
    "uuid":"c258aaab-f72b-e546-bfa5-be5e07761dbc",
    "state":"disabled",
    "name":"Microsoft Hyper-V NVDIMM 1 Label"
  },
  {
    "dev":"namespace0.0",
    "mode":"raw",
    "size":0,
    "uuid":"9f0497a7-4453-7c40-ad35-21a791e00345",
    "state":"disabled",
    "name":"Microsoft Hyper-V NVDIMM 0 Label"
  }
]

The "size" and "mode" still don't look right, but the improvement is that
now I can see a good descriptive "name", which I suppose is retrieved
from Hyper-V.

With Ubuntu 19.04 (4.18.0-11-generic), I get this:
(Note: the "mode" and "size" are correct. The "uuid" is different from
the above "9f0497a7-4453-7c40-ad35-21a791e00345" -- this is weird.) 

root@decui-gen2-u1904:~# ndctl list
[
  {
    "dev":"namespace1.0",
    "mode":"raw",
    "size":137438953472,
    "blockdev":"pmem1"
  },
  {
    "dev":"namespace0.0",
    "mode":"fsdax",
    "map":"dev",
    "size":33820770304,
    "uuid":"35018886-397e-4fe7-a348-0a4d16eec44d",
    "blockdev":"pmem0"
  }
]
 
I'm trying to find out the correct solution. I apprecite your insights!

Thanks,
-- Dexuan
