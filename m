From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: [RFC/PATCH] Winbond CIR driver for the WPCD376I chip (ACPI/PNP
     id WEC1022)
Date: Thu, 25 Jun 2009 13:46:01 +0200 (CEST)
Message-ID: <461dbc08f8573008440a03b9618bce94.squirrel@www.hardeman.nu>
References: <20090624213645.GA18843@hardeman.nu>
    <20090624151335.0f73907c@jbarnes-g45>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752855AbZFYLqN@vger.kernel.org>
In-Reply-To: <20090624151335.0f73907c@jbarnes-g45>
Sender: linux-kernel-owner@vger.kernel.org
To: Jesse Barnes <jesse.barnes@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, alan@lxorguk.ukuu.org.uk, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, June 25, 2009 00:13, Jesse Barnes wrote:
> On Wed, 24 Jun 2009 14:36:45 -0700
> David H=E4rdeman <david@hardeman.nu> wrote:
>
>> I've written a driver for the
=2E..
>> Winbond WPCD376I chipset
>
> Yay, glad I could get these released for you.  I just did a quick sca=
n
> of the driver (notes below)

Two more things that Intel could provide:

a) Publish the datasheet (I know you mentioned doing this but
   I can't find it on the Intel website)

b) Make the hardware needed to actually use the CIR functionality
   available for purchase. http://www.easy-cir.com seems to be more
   or less dead (which is curious since an ad for the website
   seems to be included with every CIR-enabled Intel motherboard).
   I had to solder my own IR receiver in order to write the driver.

>> I'd appreciate having the driver reviewed...and in addition I have
>> some questions for the list:
>>
>>    1) SuperI/O concurrency
>> ...
>
> Yeah, often multifunction devices like this have higher level "bus
> drivers" that take care of managing the global parts, and drivers tha=
t
> attach to it to manage individual functions.  If you were feeling
> really ambitious you could do that for the superio chip and port any
> sub-drivers... :)

My ambitions are more directed towards some kind of IR-subsystem into t=
he
kernel at the moment :) Besides, the Intel mainboards doesn't actually
seem to use any of the other logical devices (which are mostly supporte=
d
by existing drivers anyway).

>> Where should this driver go in the tree? drivers/platform/x86/?
>
> drivers/char is probably fine.

I'm leaning towards drivers/input/misc now...

>> #define dprintk(fmt, arg...)                                    \
>> do {                                                            \
>>         if (debug)                                              \
>>                 printk(KERN_DEBUG DRVNAME fmt , ## arg);        \
>> } while (0)
>
> Maybe you could use the generic debug functions instead (pr_debug iir=
c)?

Yes

> ...
> There are a few magic numbers above here you could possibly make into
> #defines just to make things more readable.

I'll try

> The key up/down timeout handling seems like a pretty general problem,
> maybe the input layer has some helpers for it?  Dunno.

drivers/media/common/ir-functions.c is the closest thing I could find
while writing the driver. The functions there aren't usable because the=
y
do not properly implement the toggle/repeat handling and it forces the =
use
of a small, fixed-size keymap. The same problem existed when I improved
the IR functionality in drivers/media/dvb/ttpci/budget-ci.c by the way,=
 so
a generic version could probably be added to ir-functions in the future=
=2E

>> static ssize_t
>> wbcir_show_last_scancode(struct device *dev,
>>                             struct device_attribute *attr, char *buf=
)
>> {
>>         struct acpi_device *device =3D container_of(dev, struct
>> acpi_device, dev); struct wbcir_data *data =3D acpi_driver_data(devi=
ce);
>>         return sprintf(buf, "0x%08X\n", data->last_scancode);
>> }
>>
>> static struct device_attribute dev_attr_last_scancode =3D {
>>         .attr =3D {
>>                 .name =3D "last_scancode",
>>                 .mode =3D 0444,
>>         },
>>         .show =3D wbcir_show_last_scancode,
>>         .store =3D NULL,
>>
>> };
>>
>> static struct attribute *wbcir_attributes[] =3D {
>>         &dev_attr_last_scancode.attr,
>>         NULL,
>> };
>>
>> static struct attribute_group wbcir_attribute_group =3D {
>>         .attrs =3D wbcir_attributes,
>> };
>
> Are these just for debugging?  If so, you could put them in debugfs
> instead...

No, they are there to help the user when generating a keymap for an
unknown remote. Press key on remote, read value from
/sys/.../last_scancode, add line saying "0x12345678 =3D KEY_EXPLODE" to
keymap file, repeat...there aren't any user-friendly tools for this yet
though.

(Dropped Terry from the CC, I just saw that he had requested a driver f=
or
this chip earlier but I'm not sure he's that interested in the rest of =
the
discussion)

--=20
David H=E4rdeman
