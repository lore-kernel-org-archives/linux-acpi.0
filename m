From: Bruno Ducrot <ducrot@poupinou.org>
Subject: Re: Strange interpreter behaviour
Date: Fri, 20 Jan 2006 20:32:48 +0100
Message-ID: <20060120193248.GD21264@poupinou.org>
References: <43BFF7DE.1000909@tzi.de> <20060116171932.GF25115@poupinou.org> <43CC0FC0.9090806@tzi.de> <20060117103043.GA2154@poupinou.org> <43CCE603.3010600@tzi.de> <20060117132435.GB2154@poupinou.org> <43CCFF1C.4000309@tzi.de> <20060117154742.GD2154@poupinou.org> <43D10176.302@tzi.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from poup.poupinou.org ([195.101.94.96]:40201 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S932082AbWATTcu
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Jan 2006 14:32:50 -0500
Content-Disposition: inline
In-Reply-To: <43D10176.302@tzi.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Janosch Machowinski <scotch@tzi.de>
Cc: linux-acpi@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 20, 2006 at 04:27:50PM +0100, Janosch Machowinski wrote:
> >Sometimes I'm stupid.  Try this version instead.
> >
> Okay, this worked,
> the outprut from your little programm was 0x500,
> but it should be
> GPE0_BLK:         0x00000428
> GPE1_BLK:         0x00000000
> 
> So is this an error in ACPI-CA or in my DSDT ?
> 

>From the ich4-m specification (see
ftp://download.intel.com/design/mobile/datashts/25233701.pdf
)
and the lspci -xxx I've requested, we can look that, for the isa
bridge, we can see that 0x500 is the base address for the GPIO
configuration registers.

The lspci show us:
00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC Interface
Bridge (rev 03)
Flags: bus master, medium devsel, latency 0
00: 86 80 cc 24 0f 01 80 02 03 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 01 04 00 00 10 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 01 05 00 00 10 00 00 00
60: 0b 04 0a 05 90 00 00 00 80 80 80 0a 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: ff fc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 28 03 00 00 00 00 00 00 0d 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 80 02 02 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 02 28 00 00 02 cf 00 00 04 00 00 00 00 00 00 00
e0: 12 00 00 c0 00 00 06 34 33 22 11 00 00 00 67 45
f0: 00 00 01 00 00 00 00 00 60 0f 03 00 00 00 80 02


The GPIO base address is at 0x58-0x5b (see page 305).

>From page 396 (9.10 General Purpose I/O Registers) we'll
learn that the ACPI node INV7 correspond to the
8th bit of the 'GPIO signal invert (GPI_INV)' register.

Therefore actually INV7 control somehow we'll treat
what happens under the GPE0_BLK, but do not modify it.
(I must confess I don't see why the ODM designed
that stuff like this).

At the description of this register, and for bit 8, we'll
see that setting this bit will have no effect if the
corresponding GPIO is set as an output.  We'll therefore
shall check if that is the problem.

Could you please (again, sorry!) run the next tool attached?
This would help to progress a little bit further.

NB: please compile it with -O flags at least:

gcc -O -W -Wall scan_gpio_ctl.c -o scan_gpio_ctl
sudo ./scan_gpio

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.

--YiEDa0DAkWCtVeE4
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="scan_gpio_ctl.c"

#include <stdio.h>
#include <stdlib.h>

#include <sys/io.h>

#define GPIO_BASE	0x0500

int main(void)
{
	int i;
	int gpio_base = GPIO_BASE;

	if (iopl(3)) {
		perror("iopl");
		exit(1);
	}

	printf("     00 01 02 03 04 05 06 07   08 09 0a 0b 0c 0d 0e 0f");
	for (i = 0; i < 64; ++i) {
		switch (i % 16) {
		case 0:
			printf("\n%.4x ", gpio_base + i);
			break;
		case 8:
			printf("  ");
			break;
		default:
			break;
		}
		printf("%.2x ", inb(gpio_base + i));
	}
	printf("\n");

	return 0;
}

--YiEDa0DAkWCtVeE4--
