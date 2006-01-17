From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Strange interpreter behaviour
Date: Tue, 17 Jan 2006 14:24:35 +0100
Message-ID: <20060117132435.GB2154@poupinou.org>
References: <43BFF7DE.1000909@tzi.de> <20060116171932.GF25115@poupinou.org> <43CC0FC0.9090806@tzi.de> <20060117103043.GA2154@poupinou.org> <43CCE603.3010600@tzi.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <43CCE603.3010600-cGBD8117FJM@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 17, 2006 at 01:41:39PM +0100, Janosch Machowinski wrote:
> >>>Sound like \_SB.INV7 is a bit into a GPIO.
> >>>More, the associated OR is defined like that:
> >>>	OperationRegion (GPIO, SystemIO, IO2B, 0x40) 
> >>>
> >>>Note that IO2B is given here:
> >>>  OperationRegion (BIOS, SystemMemory, 0x1FF50064, 0xFF)
> >>>  Field (BIOS, ByteAcc, NoLock, Preserve)
> >>>  {
> >>>      SS1,    1,
> >>>      SS2,    1,
> >>>      SS3,    1,
> >>>      SS4,    1,
> >>>      Offset (0x01),
> >>>      IOST,   16,
> >>>      SPIO,   16,
> >>>      PMBS,   16,
> >>>      PMLN,   8,
> >>>      SMBS,   16,
> >>>      SMLN,   8,
> >>>      IO1B,   16,
> >>>      IO1L,   8,
> >>>      IO2B,   16,
> >>>      IO2L,   8,
> >>>      TOPM,   32,
> >>>      ROMS,   32,
> >>>
> >>>Therefore one think to check is that IO2B is set correctly to point to
> >>>the GPIO's, then look if the GPIO is configured as a GPO (not as a GPI).
> >>>
> >>>For checking if IO2B is correct:
> >>>sudo dd if=/dev/mem bs=1c skip=536150130 count=2 | hexdump
> >>>
> >>
> >>Here it get's strange :
> >>scotchmobil scotch # dd if=/dev/mem bs=1c skip=536150130 count=2
> >>dd: reading `/dev/mem': Bad address
> >>0+0 records in
> >>0+0 records out
> >
> >
> >There is physical 512Mo RAM, isn't there? Or the DSDT have been
> >overriden?
> >How about a 'cat /proc/iomem'?
> >
> Jup, here is 512 MB of RAM, the DSDT hasen't been overidden.
> 
> 
> scotch@scotchmobil ~ $ cat /proc/iomem
> 00000000-0009fbff : System RAM
> 0009fc00-0009ffff : reserved
> 000a0000-000bffff : Video RAM area
> 000c0000-000cffff : Video ROM
> 000f0000-000fffff : System ROM
> 00100000-1ff3ffff : System RAM
>   00100000-004853d6 : Kernel code
>   004853d7-00583193 : Kernel data
> 1ff40000-1ff4ffff : ACPI Tables
> 1ff50000-1fffffff : ACPI Non-volatile Storage
> 30000000-300003ff : 0000:00:1f.1
> 32000000-33ffffff : PCI CardBus #03
> 34000000-35ffffff : PCI CardBus #03
> 36000000-37ffffff : PCI CardBus #07
> 38000000-39ffffff : PCI CardBus #07
> ce900000-de9fffff : PCI Bus #01
>   d0000000-d7ffffff : 0000:01:00.0
>     d0000000-d7ffffff : radeon
> dea00000-deafffff : PCI Bus #02
> e0000000-efffffff : 0000:00:00.0
> ff800000-ff8fffff : PCI Bus #01
>   ff8c0000-ff8dffff : 0000:01:00.0
>   ff8f0000-ff8fffff : 0000:01:00.0
>     ff8f0000-ff8fffff : radeon
> ff900000-ff9fffff : PCI Bus #02
>   ff900000-ff900fff : 0000:02:01.0
>     ff900000-ff900fff : yenta_socket
>   ff901000-ff901fff : 0000:02:01.1
>     ff901000-ff901fff : yenta_socket
>   ff9ee000-ff9eefff : 0000:02:02.0
>   ff9ef800-ff9effff : 0000:02:01.2
>     ff9ef800-ff9effff : ohci1394
>   ff9f0000-ff9fffff : 0000:02:00.0
>     ff9f0000-ff9fffff : tg3
> ffaff400-ffaff4ff : 0000:00:1f.5
>   ffaff400-ffaff4ff : Intel 82801DB-ICH4
> ffaff800-ffaff9ff : 0000:00:1f.5
>   ffaff800-ffaff9ff : Intel 82801DB-ICH4
> ffaffc00-ffafffff : 0000:00:1d.7
>   ffaffc00-ffafffff : ehci_hcd

Ok.  Well maybe that little tool attached could give us the
information.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.

--OXfL5xGRrasGEqWY
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="check_io2b.c"

#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include <sys/types.h>
#include <sys/stat.h>


int main(void)
{
	int fd;
	off_t c;
	unsigned char t[2];

	fd = open("/dev/mem", O_RDONLY);
	if (fd < 0) {
		perror("open /dev/mem");
		exit(1);
	}

	/*
	 * SS1,    1,	<- 0
	 * SS2,    1,
	 * SS3,    1,
	 * SS4,    1,
	 * Offset (0x01),
	 * IOST,   16,	<-   1, 2
	 * SPIO,   16,	<-   3, 4
	 * PMBS,   16,	<-   5, 6
	 * PMLN,   8,	<-   7
	 * SMBS,   16,	<-   8, 9
	 * SMLN,   8,	<-   A
	 * IO1B,   16,	<-   B, C
	 * IO1L,   8,	<-   D
	 * IO2B,   16,	<-   E, F
	 * IO2L,   8,
	 * TOPM,   32,
	 * ROMS,   32,
	 */

	c = lseek(fd, 0x1FF50064 + 0xE, SEEK_SET);
	if (c != 0x1FF50064 + 0xE) {
		perror("lseek");
		exit(1);
	}

	if (read(fd, t, 2) != 2) {
		perror("read");
		close(fd);
		exit(1);
	}
	close(fd);

	printf("0x%x\n", ((t[0] & 0xff) << 8) | (t[1] & 0xff));

	return 0;
}

--OXfL5xGRrasGEqWY--
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
