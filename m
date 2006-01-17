From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Strange interpreter behaviour
Date: Tue, 17 Jan 2006 16:47:42 +0100
Message-ID: <20060117154742.GD2154@poupinou.org>
References: <43BFF7DE.1000909@tzi.de> <20060116171932.GF25115@poupinou.org> <43CC0FC0.9090806@tzi.de> <20060117103043.GA2154@poupinou.org> <43CCE603.3010600@tzi.de> <20060117132435.GB2154@poupinou.org> <43CCFF1C.4000309@tzi.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="E39vaYmALEf/7YXx"
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <43CCFF1C.4000309-cGBD8117FJM@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 17, 2006 at 03:28:44PM +0100, Janosch Machowinski wrote:
> >
> >Ok.  Well maybe that little tool attached could give us the
> >information.
> >
> Nope, scotchmobil pmtools # ./a.out
> read: Bad address

Sometimes I'm stupid.  Try this version instead.


-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.

--E39vaYmALEf/7YXx
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="check_io2b.c"

#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>


int main(void)
{
	int fd;
	off_t c;
	unsigned char *p;

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

	p = mmap(NULL, 1024, PROT_READ, MAP_SHARED, fd, 0x1FF50000);
	if (p == MAP_FAILED) {
		perror("mmap");
		exit(1);
	}
	close(fd);
	printf("0x%x\n", ((p[0x64 + 0xf] & 0xff) << 8) | (p[0x64 + 0xe] & 0xff));
	munmap(p, 1024);

	return 0;
}

--E39vaYmALEf/7YXx--
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
