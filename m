From: Ocean HY1 He <hehy1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>
Subject: RE: [External]  Re: [PATCH] ACPI: nfit: return -ENODEV if fail to
 find NFIT at startup
Date: Mon, 6 Aug 2018 07:15:16 +0000
Message-ID: <HK0PR03MB3170E6D5D62D14B02F39FAE089200@HK0PR03MB3170.apcprd03.prod.outlook.com>
References: <1533289198-11400-1-git-send-email-oceanhehy@gmail.com>
 <1533316299.8557.71.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <1533316299.8557.71.camel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
To: "Verma, Vishal L" <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Williams, Dan J" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "oceanhehy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <oceanhehy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Jiang, Dave" <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Verma, Vishal L <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Sent: Saturday, August 04, 2018 1:12 AM
> To: Williams, Dan J <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org;
> oceanhehy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; Jiang, Dave <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org;
> rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org
> Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org; linux-
> acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Ocean HY1 He <hehy1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>
> Subject: [External] Re: [PATCH] ACPI: nfit: return -ENODEV if fail to find NFIT at
> startup
> 
> 
> On Fri, 2018-08-03 at 05:39 -0400, Ocean He wrote:
> > From: Ocean He <hehy1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>
> >
> > In the beginning of acpi_nfit_add, if fail to find NFIT table then
> > should
> > return -ENODEV, instead of 0.
> >
> > Signed-off-by: Ocean He <hehy1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/acpi/nfit/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> > index 7c47900..1790d7c 100644
> > --- a/drivers/acpi/nfit/core.c
> > +++ b/drivers/acpi/nfit/core.c
> > @@ -3355,7 +3355,7 @@ static int acpi_nfit_add(struct acpi_device
> > *adev)
> >  	if (ACPI_FAILURE(status)) {
> >  		/* This is ok, we could have an nvdimm hotplugged
> > later */
> >  		dev_dbg(dev, "failed to find NFIT at startup\n");
> > -		return 0;
> > +		return -ENODEV;
> 
> Hm, the comment directly above this says this is ok..
> Has this caused any problems in practice?
> 
Thanks for your comments. After going through related codes and some test, I am 
now thinking it's right to keep "return 0" if NFIT not found at boot time.

Per chapter 9.20.2 NVDIMM Root Device in ACPI 6.2 spec:
The NVDIMM root device is represented by an ACPI namespace device with a _HID 
of "ACPI0012". This device allows the OS to trigger enumeration of NVDIMMs 
through NFIT at boot time and re-enumeration at root level via the _FIT method 
during runtime. 

The acpi_nfit_driver is registered to ACPI bus to support "ACPI0012". 
The acpi_nfit_driver.acpi_nfit_add is used to enumerate NVDIMMs through NFIT 
at boot time; The acpi_nfit_driver.acpi_nfit_notify is used to enumerate 
NVDIMMs during runtime.

In my Lenovo ThinkSystem SR630 which support NVDIMMs, If I remove 
all NVDIMMs, the NFIT table is gone after system boot up. If keep "return 0" 
in acpi_nfit_add, then acpi_nfit_driver would still be attached to "ACPI0012". 
Once a NVDIMM is hotplugged into system during runtime, then 
acpi_nfit_driver.acpi_nfit_notify can be called to enumerate NVDIMMs (I could
not do hotplug test because firmware doesn't support). 
Otherwise, "return -ENODEV" would block NVDIMM enumeration during runtime.

How do you think to adjust annotation as following?

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 7c47900..1673161 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3353,7 +3353,13 @@ static int acpi_nfit_add(struct acpi_device *adev)
 
        status = acpi_get_table(ACPI_SIG_NFIT, 0, &tbl);
        if (ACPI_FAILURE(status)) {
-               /* This is ok, we could have an nvdimm hotplugged later */
+               /* The NVDIMM root device allows OS to trigger enumeration of 
+                * NVDIMMs through NFIT at boot time and re-enumeration at 
+                * root level via the _FIT method during runtime.
+                * This is ok to return 0 here, we could have an nvdimm 
+                * hotplugged later and evaluate _FIT method which returns 
+                * data in the format of a series of NFIT Structures.
+                */
                dev_dbg(dev, "failed to find NFIT at startup\n");
                return 0;
        }

Ocean.

> >  	}
> >
> >  	rc = devm_add_action_or_reset(dev, acpi_nfit_put_table,
> > tbl);
