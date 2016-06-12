From: joeyli <jlee@suse.com>
Subject: Re: [PATCH] libnvdimm, nfit: treat volatile virtual CD region as
 read-only pmem
Date: Sun, 12 Jun 2016 09:58:59 +0800
Message-ID: <20160612015859.GI4558@linux-rxt1.site>
References: <1464938015-5489-1-git-send-email-jlee@suse.com>
 <CAPcyv4iLb9qzXZTLL5z-RH_CRObnRfzx=vGTvVvieJUEwNvtRw@mail.gmail.com>
 <20160604110156.GA4558@linux-rxt1.site>
 <888aeb53-69b4-652b-8f89-822af4622acf@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:45890 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172AbcFLB7T (ORCPT
	<rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
	Sat, 11 Jun 2016 21:59:19 -0400
Content-Disposition: inline
In-Reply-To: <888aeb53-69b4-652b-8f89-822af4622acf@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linda Knippers <linda.knippers@hpe.com>
Cc: Dan Williams <dan.j.williams@intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, Gary Lin <GLin@suse.com>

Hi Linda,=20

Thanks for your review and comments.

On Thu, Jun 09, 2016 at 06:08:17PM -0400, Linda Knippers wrote:
> On 6/4/2016 7:01 AM, joeyli wrote:
> > Hi Dan,=20
> >=20
> > Thanks for your review.
> >=20
> > On Fri, Jun 03, 2016 at 12:27:34PM -0700, Dan Williams wrote:
> >> On Fri, Jun 3, 2016 at 12:13 AM, Lee, Chun-Yi <joeyli.kernel@gmail=
=2Ecom> wrote:
> >>> This patch adds codes to treat a volatile virtual CD region as a
> >>> read-only pmem region, then read-only /dev/pmem* device can be mo=
unted
> >>> with iso9660.
> >>>
> >>> It's useful to work with the httpboot in EFI firmware to pull a r=
emote
> >>> ISO file to the local memory region for booting and installation.
> >>>
> >>> Wiki page of UEFI HTTPBoot with OVMF:
> >>>         https://en.opensuse.org/UEFI_HTTPBoot_with_OVMF
> >>>
> >>> Signed-off-by: Lee, Chun-Yi <jlee@suse.com>
> >>> Cc: Gary Lin <GLin@suse.com>
> >>> Cc: Dan Williams <dan.j.williams@intel.com>
> >>> Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
> >>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >>> ---
> >>>  drivers/acpi/nfit.c          |  8 +++++++-
> >>>  drivers/nvdimm/region_devs.c | 26 +++++++++++++++++++++++++-
> >>>  include/linux/libnvdimm.h    |  2 ++
> >>>  3 files changed, 34 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
> >>> index 2215fc8..b100a17 100644
> >>> --- a/drivers/acpi/nfit.c
> >>> +++ b/drivers/acpi/nfit.c
> >>> @@ -1949,6 +1949,7 @@ static int acpi_nfit_init_mapping(struct ac=
pi_nfit_desc *acpi_desc,
> >>>         switch (nfit_spa_type(spa)) {
> >>>         case NFIT_SPA_PM:
> >>>         case NFIT_SPA_VOLATILE:
> >>> +       case NFIT_SPA_VCD:
> >>>                 nd_mapping->start =3D memdev->address;
> >>>                 nd_mapping->size =3D memdev->region_size;
> >>>                 break;
> >>
> >> Why do we need to distinguish NFIT_SPA_VOLATILE vs NFIT_SPA_VCD, i=
=2Ee.
> >> what happens if something writes to a VCD device?
> >=20
> > Actually I didn't try to write SPA-VCD device before. Every time I =
mount it
> > that the system responses read-only:
> >=20
> > # mount /dev/pmem0 /mnt/
> > mount: /dev/pmem0 is write-protected, mounting read-only
> >=20
> > If it can be written, then I think there have no difference between
> > NFIT_SPA_VOLATILE with NFIT_SPA_VCD region.
>=20
> It's not clear to me what the expectations for this type of device ar=
e, or
> whether they should be read-only.  The ACPI spec is not helpful here.
> The other Disk Region and CD Region types are also unclear.  Anyone
> care to define them?
>

In ACPI spec 6.1, it said "a volatile memory region that contains an IS=
O image":

This GUID defines a RAM Disk supporting a Virtual CD Region =E2=80=93 V=
olatile (a volatile memory
region that contains an ISO image):
{ 0x3D5ABD30,0x4175,0x87CE,0x6D,0x64,0xD2,0xAD,0xE5,0x23,0xC4,0xBB }

I think the behavior that is the same with a volatile memory region but=
 it
contains ISO.

I agree doesn't have any spec that it mentions the type should be read-=
only, I
will remove the code in patch.

I also agree that it doesn't have detail description of those ram disk
types. Do you have any idea or comment that you want to add to spec? Ei=
ther
for ACPI or UEFI?
=20
> > I implemented this patch to treat VCD region as read-only pmem beca=
use the
> > pmem region generates /dev/pmem* device that it can be mounted.
>=20
> I'm a bit worried about this type of device showing up as a "pmem" de=
vice.
> I realize they're described in the NFIT (not sure why but they are) b=
ut do
> any of the operations that we support for other pmem devices work on =
these?
> Do root device DSMs make any sense?  Are there other DSMs?  What will=
 happen
> if someone uses ndctl to reconfigure the device?
>

By using the Ramdisk function in EDK2/OVMF, it only generates a ACPI001=
2 root
device that it contains a empty _STA but no _DSM support:

DefinitionBlock ("ssdt2.aml", "SSDT", 2, "INTEL ", "RamDisk ", 0x000010=
00)
{
    Scope (\_SB)
    {  =20
        Device (NVDR)
        {  =20
            Name (_HID, "ACPI0012")  // _HID: Hardware ID
            Name (_STR, Unicode ("NVDIMM Root Device"))  // _STR: Descr=
iption String
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {  =20
                Return (0x0F)
            }
        }
    }
}

So there have no way to control this root device through _DSM. The ACPI=
0012
root device is used to trigger the nfit driver in acpi.

I will put the above parser result to the patch description in next ver=
sion.


On the other hand, here is the NFIT that it is generated by OVMF:

[000h 0000   4]                    Signature : "NFIT"    [NVDIMM Firmwa=
re Interface Table]
[004h 0004   4]                 Table Length : 00000060
[008h 0008   1]                     Revision : 01
[009h 0009   1]                     Checksum : 0C
[00Ah 0010   6]                       Oem ID : "INTEL "
[010h 0016   8]                 Oem Table ID : "EDK2    "
[018h 0024   4]                 Oem Revision : 00000002
[01Ch 0028   4]              Asl Compiler ID : "    "
[020h 0032   4]        Asl Compiler Revision : 01000013

[024h 0036   4]                     Reserved : 00000000

[028h 0040   2]                Subtable Type : 0000 [System Physical Ad=
dress Range]
[02Ah 0042   2]                       Length : 0038

[02Ch 0044   2]                  Range Index : 0000
[02Eh 0046   2]        Flags (decoded below) : 0000
                   Add/Online Operation Only : 0
                      Proximity Domain Valid : 0
[030h 0048   4]                     Reserved : 00000000
[034h 0052   4]             Proximity Domain : 00000000
[038h 0056  16]           Address Range GUID : 77AB535A-45FC-624B-5560-=
=467B281D1F96E
[048h 0072   8]           Address Range Base : 00000000B6ABD018
[050h 0080   8]         Address Range Length : 0000000005500000
[058h 0088   8]         Memory Map Attribute : 0000000000000000

The "Address Range GUID" is a "Virtual Disk Region =E2=80=93 Volatile" =
but not a VCD
because I used the Ramdisk function in EDK2 to generate the NFIT. When =
using
http boot with a iso file, this GUID will be changed to VCD type.

As the above NFIT, there have "Address Range Base" and "Address Range L=
ength"
but the "Range Index" will be zero. So my patch ignores the "Range Inde=
x"
checking on VCD type.
=20
> I'm especially concerned on systems that might have one of these devi=
ces
> and also have NVDIMMs.  Do all the pmem devices get numbered differen=
t if
> this device comes and goes across reboots?  (I know, we shouldn't rel=
y on
> those names but it will still confuse people.)  Can they be some othe=
r name
> that better represents what they're trying to be?
>=20
> > Maybe I missed. Does NFIT_SPA_VOLATILE region also generate a devic=
e in /dev
> > that it can be mounted with filesystem?=20
>=20
> Yes.
>=20
> -- ljk
>

I checked the NVDIMM driver, there have 3 drivers call register_blkdev(=
) that
may generates "nd_blk", "btt" and "pmem" block devices. But I didn't fi=
nd the
block device that it reflects to volatile memory SPA region. How can I =
mount
a volatile memory region with a filesystem?

I have tried to call nvdimm_volatile_region_create() in my patch when V=
CD
region shows up. But I didn't find any new block device in /dev/devices=
=2E


Thanks a lot!
Joey Lee=20
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
