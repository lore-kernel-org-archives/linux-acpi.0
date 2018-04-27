From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH] ACPI / scan: Fix regression related to X-Gene UARTs
Date: Fri, 27 Apr 2018 14:24:44 -0400
Message-ID: <1524853484.5602.32.camel@redhat.com>
References: <20180420032947.23023-1-msalter@redhat.com>
         <CAJZ5v0g5iB1zoz7S0KBvimqj_ZEQLNX_LZ8g3vBoythJ_ZzjaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0g5iB1zoz7S0KBvimqj_ZEQLNX_LZ8g3vBoythJ_ZzjaA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, 2018-04-22 at 11:34 +0200, Rafael J. Wysocki wrote:
> On Fri, Apr 20, 2018 at 5:29 AM, Mark Salter <msalter@redhat.com> wrote:
> > Commit e361d1f85855 ("ACPI / scan: Fix enumeration for special UART
> > devices") caused a regression with some X-Gene based platforms (Mustang
> > and M400) with invalid DSDT.
> 
> I'm not convinced that making changes to the core ACPI device
> enumeration code in order to cover up for firmware bugs is the right
> approach.

It is unfortunate but the firmware bug predates the change which uncovered
it, so previously working systems no longer work.

> 
> > The DSDT makes it appear that the UART
> > device is also a slave device attached to itself. With the above commit
> > the UART won't be enumerated by ACPI scan (slave serial devices shouldn't
> > be). So check for X-Gene UART device and skip slace device check on it.
> > 
> > Signed-off-by: Mark Salter <msalter@redhat.com>
> > ---
> >  drivers/acpi/scan.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index cc234e6a6297..1dcdd0122862 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -1551,6 +1551,14 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
> >              fwnode_property_present(&device->fwnode, "baud")))
> >                 return true;
> > 
> > +       /*
> > +        * Firmware on some arm64 X-Gene platforms will make the UART
> > +        * device appear as both a UART and a slave of that UART. Just
> > +        * bail out here for X-Gene UARTs.
> > +        */
> > +       if (!strcmp(acpi_device_hid(device), "APMC0D08"))
> > +               return false;
> 
> Is the device ID never to be used outside of the broken configurations?
> 
> Even if that's the plan, how are you going to guarantee that anyway?

The device ID will always be used for X-Gene UARTs. Whether the DSDT is
broken or not wouldn't matter because the end result would be the same
(the UART being treated as master rather than a serial bus slave).
The broken firmware looks like this:

        Device (URT0)
        {
            Name (_HID, "APMC0D08")  // _HID: Hardware ID
            ...
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x1C020000,         // Address Base
                    0x00000100,         // Address Length
                    )
                UartSerialBusV2 (0x0001C200, DataBitsEight, StopBitsOne,
                    0x00, LittleEndian, ParityTypeNone, FlowControlNone,
                    0x0010, 0x0010, "URT0",
                    0x00, ResourceConsumer, , Exclusive,
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x0000006D,
                }
            })
            ...
        }

So "URT0" has a UartSerialBusV2 resource which references itself as the bus master.
            

> 
> > +
> >         INIT_LIST_HEAD(&resource_list);
> >         acpi_dev_get_resources(device, &resource_list,
> >                                acpi_check_serial_bus_slave,
> > --
