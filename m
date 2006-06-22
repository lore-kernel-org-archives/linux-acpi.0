From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [Lhms-devel] [RFC] Patch [1/2] for acpi_memhotplug.c
Date: Thu, 22 Jun 2006 14:20:38 +0900
Message-ID: <20060622142038.86ec6472.kamezawa.hiroyu@jp.fujitsu.com>
References: <971FCB6690CD0E4898387DBF7552B90E0378BEE7@orsmsx403.amr.corp.intel.com>
	<437F1766.8090705@jp.fujitsu.com>
	<1150853300.5873.49.camel@keithlap>
	<20060621114334.1b954854.kamezawa.hiroyu@jp.fujitsu.com>
	<1150863525.7865.6.camel@keithlap>
	<20060621194832.37124aae.kamezawa.hiroyu@jp.fujitsu.com>
	<1150915426.5830.21.camel@keithlap>
	<1150932228.9235.6.camel@keithlap>
	<20060622091336.be46e7a6.kamezawa.hiroyu@jp.fujitsu.com>
	<1150940220.10001.11.camel@keithlap>
	<20060622105854.18fa1f16.kamezawa.hiroyu@jp.fujitsu.com>
	<1150942799.10001.30.camel@keithlap>
	<20060622121356.6326e4a2.kamezawa.hiroyu@jp.fujitsu.com>
	<1150948503.10001.60.camel@keithlap>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Thu__22_Jun_2006_14_20_38_+0900_AkNDtYw.7KiHQVzi"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:48270 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030612AbWFVFTR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Jun 2006 01:19:17 -0400
In-Reply-To: <1150948503.10001.60.camel@keithlap>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: kmannth@us.ibm.com
Cc: prarit@redhat.com, linux-acpi@vger.kernel.org, darnok@us.ibm.com, robert.moore@intel.com, lhms-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

--Multipart=_Thu__22_Jun_2006_14_20_38_+0900_AkNDtYw.7KiHQVzi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jun 2006 20:55:02 -0700
keith mannthey <kmannth@us.ibm.com> wrote:
> > Hmm....curious..but no idead..
> > Then, could try this ? 
> 
> I am trying to make the motherboard driver fail with it looks for
> resources and finds node.  The motherboard add function alway returns
> AE_OK which is why the algorithm fails. See attached patch it allows the
> hot-add event to happen. 
> 
> With the event happening and I see 
> 
Um...my concern is
- When notify comes, memory hotplug driver is called.
- but at acpi_bus_add(), PNP0C01 motherboad driver is attached to the device.

I think something is wrong....from your SSDT, ME00 and ME01 memory device has
valid HID, PNP0C80.
==
        Device (ME01)
        {
            Name (_HID, EisaId ("PNP0C80"))
            Name (_CID, 0x010CD041)
==
What I imagine now is.

- acpi_memory_device_init() -> acpi_memory_register_notify_handler()
  installs notify handler for memory hotplug against device handle of memory
  This doesn't check _CID.

- acpi_bus_add() attachs motherboard driver because of CID.
  Above _CID is 32bit compressed EISA-type ID (HID is string but..),
  it is PNP0C01...motherboad driver is called before PNP0C80 driver.
  (to covert 32bit ID to string, see acpi_ex_eisa_id_to_string(),
   I attached program.)

Then what we should do here is...call HID:PNP0C80 driver instead if CID:PNP0C01 driver.
Because it has driver for HID, calling driver for CID looks not good.
(But we have to ask acpi people about this..)

I'll try to write a patch.

-Kame

--Multipart=_Thu__22_Jun_2006_14_20_38_+0900_AkNDtYw.7KiHQVzi
Content-Type: text/x-csrc;
 name="foo.c"
Content-Disposition: attachment;
 filename="foo.c"
Content-Transfer-Encoding: 7bit

#include <stdio.h>

typedef unsigned long u32;
typedef unsigned char u8;

static const char acpi_gbl_hex_to_ascii[] = {
        '0', '1', '2', '3', '4', '5', '6', '7',
        '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'
};

char acpi_ut_hex_to_ascii_char(unsigned long integer, unsigned long position)
{

        return (acpi_gbl_hex_to_ascii[(integer >> position) & 0xF]);
}

u32 acpi_ut_dword_byte_swap(u32 value)
{
        union {
                u32 value;
                u8 bytes[4];
        } out;
        union {
                u32 value;
                u8 bytes[4];
        } in;

        in.value = value;

        out.bytes[0] = in.bytes[3];
        out.bytes[1] = in.bytes[2];
        out.bytes[2] = in.bytes[1];
        out.bytes[3] = in.bytes[0];

        return (out.value);
}


void acpi_ex_eisa_id_to_string(unsigned long numeric_id, char *out_string)
{
        unsigned long eisa_id;

        /* Swap ID to big-endian to get contiguous bits */

        eisa_id = acpi_ut_dword_byte_swap(numeric_id);

        out_string[0] = (char)('@' + (((unsigned long)eisa_id >> 26) & 0x1f));
        out_string[1] = (char)('@' + ((eisa_id >> 21) & 0x1f));
        out_string[2] = (char)('@' + ((eisa_id >> 16) & 0x1f));
        out_string[3] = acpi_ut_hex_to_ascii_char(eisa_id, 12);
        out_string[4] = acpi_ut_hex_to_ascii_char(eisa_id, 8);
        out_string[5] = acpi_ut_hex_to_ascii_char(eisa_id, 4);
        out_string[6] = acpi_ut_hex_to_ascii_char(eisa_id, 0);
        out_string[7] = 0;
}

int main(int argc, char *argv[])
{
	unsigned long id = 0x010CD041;
	char name[16];
	acpi_ex_eisa_id_to_string(id, name);
	printf("%s",name);
}


--Multipart=_Thu__22_Jun_2006_14_20_38_+0900_AkNDtYw.7KiHQVzi--

