From: joeyli <jlee@suse.com>
Subject: Re: [PATCH 1/2] tools/power/acpi: Introduce ec_access.c - tool to
 access the Embedded Controller (EC) safely for debugging purposes
Date: Fri, 21 Dec 2012 15:20:22 +0800
Message-ID: <1356074422.29771.2.camel@linux-s257.site>
References: <1355591519-44664-1-git-send-email-trenn@suse.de>
	 <1355591519-44664-2-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:46289 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab2LUHVz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Dec 2012 02:21:55 -0500
In-Reply-To: <1355591519-44664-2-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org, rjw@sisk.pl, lenb@kernel.org

=E6=96=BC =E5=85=AD=EF=BC=8C2012-12-15 =E6=96=BC 18:11 +0100=EF=BC=8CTh=
omas Renninger =E6=8F=90=E5=88=B0=EF=BC=9A
> This userspace tool accesses the EC through the ec_sys debug driver
> (through /sys/kernel/debug/ec/ec0/io).
> The EC command/data registers cannot be accessed directly, because th=
ey could
> get accessed by the ACPI interpreter in parallel.
> The ec_sys driver synchronizes userspace (debug) access with the ACPI
> interpreter.
>=20
> Makefile (tool/power/acpi/Makefile) adjustings:
>  - Introduce ec subdir
>  - Make clean and install .PHONY
>=20
>=20
> Signed-off-by: Thomas Renninger <trenn@suse.de>

Tested-by: Lee, Chun-Yi <jlee@suse.com>


Thanks a lot!
Joey lee

> ---
>  tools/power/acpi/Makefile       |   26 +++--
>  tools/power/acpi/ec/Makefile    |   14 +++
>  tools/power/acpi/ec/ec_access.c |  238 +++++++++++++++++++++++++++++=
++++++++++
>  3 files changed, 270 insertions(+), 8 deletions(-)
>  create mode 100644 tools/power/acpi/ec/Makefile
>  create mode 100644 tools/power/acpi/ec/ec_access.c
>=20
> diff --git a/tools/power/acpi/Makefile b/tools/power/acpi/Makefile
> index 6b9cf7a..8650fd8 100644
> --- a/tools/power/acpi/Makefile
> +++ b/tools/power/acpi/Makefile
> @@ -1,18 +1,28 @@
>  PROG=3D acpidump
> -SRCS=3D	acpidump.c
> +SRCS=3D acpidump.c
> +SUBDIRS=3D ec
> +
>  KERNEL_INCLUDE :=3D ../../../include
>  CFLAGS +=3D -Wall -Wstrict-prototypes -Wdeclaration-after-statement =
-Os -s -D_LINUX -DDEFINE_ALTERNATE_TYPES -I$(KERNEL_INCLUDE)=20
> =20
> -all: acpidump
> -$(PROG) : $(SRCS)
> +all: acpidump $(SUBDIRS)
> +$(PROG): $(SRCS)
>  	$(CC) $(CFLAGS) $(SRCS) -o $(PROG)
> =20
> -CLEANFILES=3D $(PROG)
> +.PHONY: clean install $(SUBDIRS)
> +
> +$(SUBDIRS):
> +	$(MAKE) -C $@
> =20
> -clean :=20
> -	rm -f $(CLEANFILES) $(patsubst %.c,%.o, $(SRCS)) *~
> +clean:
> +	rm -f $(PROG) $(patsubst %.c,%.o, $(SRCS)) *~
> +	for dir in $(SUBDIRS); do \
> +		$(MAKE) -C $$dir clean; \
> +	done
> =20
> -install :
> +install:
>  	install acpidump /usr/bin/acpidump
>  	install acpidump.8 /usr/share/man/man8
> -
> +	for dir in $(SUBDIRS); do \
> +		$(MAKE) -C $$dir install; \
> +	done
> diff --git a/tools/power/acpi/ec/Makefile b/tools/power/acpi/ec/Makef=
ile
> new file mode 100644
> index 0000000..abaef3a
> --- /dev/null
> +++ b/tools/power/acpi/ec/Makefile
> @@ -0,0 +1,14 @@
> +PROG=3D ec_access
> +SRCS=3D ec_access.c
> +
> +all: ec_access
> +$(PROG): $(SRCS)
> +	$(CC) $(CFLAGS) $(SRCS) -o $(PROG)
> +
> +.PHONY: clean install
> +
> +clean:
> +	rm -f $(PROG) $(patsubst %.c,%.o, $(SRCS)) *~
> +
> +install:
> +	install ec_access /usr/sbin/ec_access
> diff --git a/tools/power/acpi/ec/ec_access.c b/tools/power/acpi/ec/ec=
_access.c
> new file mode 100644
> index 0000000..6b8aaed
> --- /dev/null
> +++ b/tools/power/acpi/ec/ec_access.c
> @@ -0,0 +1,238 @@
> +/*
> + * ec_access.c
> + *
> + * Copyright (C) 2010 SUSE Linux Products GmbH
> + * Author:
> + *      Thomas Renninger <trenn@suse.de>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.
> + */
> +
> +#include <fcntl.h>
> +#include <err.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <libgen.h>
> +#include <unistd.h>
> +#include <getopt.h>
> +#include <stdint.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +
> +
> +#define EC_SPACE_SIZE 256
> +#define SYSFS_PATH "/sys/kernel/debug/ec/ec0/io"
> +
> +/* TBD/Enhancements:
> +   - Provide param for accessing different ECs (not supported by ker=
nel yet)
> +*/
> +
> +static int read_mode =3D -1;
> +static int sleep_time;
> +static int write_byte_offset =3D -1;
> +static int read_byte_offset =3D -1;
> +static uint8_t write_value =3D -1;
> +
> +void usage(char progname[], int exit_status)
> +{
> +	printf("Usage:\n");
> +	printf("1) %s -r [-s sleep]\n", basename(progname));
> +	printf("2) %s -b byte_offset\n", basename(progname));
> +	printf("3) %s -w byte_offset -v value\n\n", basename(progname));
> +
> +	puts("\t-r [-s sleep]      : Dump EC registers");
> +	puts("\t                     If sleep is given, sleep x seconds,");
> +	puts("\t                     re-read EC registers and show changes"=
);
> +	puts("\t-b offset          : Read value at byte_offset (in hex)");
> +	puts("\t-w offset -v value : Write value at byte_offset");
> +	puts("\t-h                 : Print this help\n\n");
> +	puts("Offsets and values are in hexadecimal number sytem.");
> +	puts("The offset and value must be between 0 and 0xff.");
> +	exit(exit_status);
> +}
> +
> +void parse_opts(int argc, char *argv[])
> +{
> +	int c;
> +
> +	while ((c =3D getopt(argc, argv, "rs:b:w:v:h")) !=3D -1) {
> +
> +		switch (c) {
> +		case 'r':
> +			if (read_mode !=3D -1)
> +				usage(argv[0], EXIT_FAILURE);
> +			read_mode =3D 1;
> +			break;
> +		case 's':
> +			if (read_mode !=3D -1 && read_mode !=3D 1)
> +				usage(argv[0], EXIT_FAILURE);
> +
> +			sleep_time =3D atoi(optarg);
> +			if (sleep_time <=3D 0) {
> +				sleep_time =3D 0;
> +				usage(argv[0], EXIT_FAILURE);
> +				printf("Bad sleep time: %s\n", optarg);
> +			}
> +			break;
> +		case 'b':
> +			if (read_mode !=3D -1)
> +				usage(argv[0], EXIT_FAILURE);
> +			read_mode =3D 1;
> +			read_byte_offset =3D strtoul(optarg, NULL, 16);
> +			break;
> +		case 'w':
> +			if (read_mode !=3D -1)
> +				usage(argv[0], EXIT_FAILURE);
> +			read_mode =3D 0;
> +			write_byte_offset =3D strtoul(optarg, NULL, 16);
> +			break;
> +		case 'v':
> +			write_value =3D strtoul(optarg, NULL, 16);
> +			break;
> +		case 'h':
> +			usage(argv[0], EXIT_SUCCESS);
> +		default:
> +			fprintf(stderr, "Unknown option!\n");
> +			usage(argv[0], EXIT_FAILURE);
> +		}
> +	}
> +	if (read_mode =3D=3D 0) {
> +		if (write_byte_offset < 0 ||
> +		    write_byte_offset >=3D EC_SPACE_SIZE) {
> +			fprintf(stderr, "Wrong byte offset 0x%.2x, valid: "
> +				"[0-0x%.2x]\n",
> +				write_byte_offset, EC_SPACE_SIZE - 1);
> +			usage(argv[0], EXIT_FAILURE);
> +		}
> +		if (write_value < 0 ||
> +		    write_value >=3D 255) {
> +			fprintf(stderr, "Wrong byte offset 0x%.2x, valid:"
> +				"[0-0xff]\n", write_byte_offset);
> +			usage(argv[0], EXIT_FAILURE);
> +		}
> +	}
> +	if (read_mode =3D=3D 1 && read_byte_offset !=3D -1) {
> +		if (read_byte_offset < -1 ||
> +		    read_byte_offset >=3D EC_SPACE_SIZE) {
> +			fprintf(stderr, "Wrong byte offset 0x%.2x, valid: "
> +				"[0-0x%.2x]\n",
> +				read_byte_offset, EC_SPACE_SIZE - 1);
> +			usage(argv[0], EXIT_FAILURE);
> +		}
> +	}
> +	/* Add additional parameter checks here */
> +}
> +
> +void dump_ec(int fd)
> +{
> +	char buf[EC_SPACE_SIZE];
> +	char buf2[EC_SPACE_SIZE];
> +	int byte_off, bytes_read;
> +
> +	bytes_read =3D read(fd, buf, EC_SPACE_SIZE);
> +
> +	if (bytes_read =3D=3D -1)
> +		err(EXIT_FAILURE, "Could not read from %s\n", SYSFS_PATH);
> +
> +	if (bytes_read !=3D EC_SPACE_SIZE)
> +		fprintf(stderr, "Could only read %d bytes\n", bytes_read);
> +
> +	printf("     00  01  02  03  04  05  06  07  08  09  0A  0B  0C  0D=
  0E  0F");
> +	for (byte_off =3D 0; byte_off < bytes_read; byte_off++) {
> +		if ((byte_off % 16) =3D=3D 0)
> +			printf("\n%.2X: ", byte_off);
> +		printf(" %.2x ", (uint8_t)buf[byte_off]);
> +	}
> +	printf("\n");
> +
> +	if (!sleep_time)
> +		return;
> +
> +	printf("\n");
> +	lseek(fd, 0, SEEK_SET);
> +	sleep(sleep_time);
> +
> +	bytes_read =3D read(fd, buf2, EC_SPACE_SIZE);
> +
> +	if (bytes_read =3D=3D -1)
> +		err(EXIT_FAILURE, "Could not read from %s\n", SYSFS_PATH);
> +
> +	if (bytes_read !=3D EC_SPACE_SIZE)
> +		fprintf(stderr, "Could only read %d bytes\n", bytes_read);
> +
> +	printf("     00  01  02  03  04  05  06  07  08  09  0A  0B  0C  0D=
  0E  0F");
> +	for (byte_off =3D 0; byte_off < bytes_read; byte_off++) {
> +		if ((byte_off % 16) =3D=3D 0)
> +			printf("\n%.2X: ", byte_off);
> +
> +		if (buf[byte_off] =3D=3D buf2[byte_off])
> +			printf(" %.2x ", (uint8_t)buf2[byte_off]);
> +		else
> +			printf("*%.2x ", (uint8_t)buf2[byte_off]);
> +	}
> +	printf("\n");
> +}
> +
> +void read_ec_val(int fd, int byte_offset)
> +{
> +	uint8_t buf;
> +	int error;
> +
> +	error =3D lseek(fd, byte_offset, SEEK_SET);
> +	if (error !=3D byte_offset)
> +		err(EXIT_FAILURE, "Cannot set offset to 0x%.2x", byte_offset);
> +
> +	error =3D read(fd, &buf, 1);
> +	if (error !=3D 1)
> +		err(EXIT_FAILURE, "Could not read byte 0x%.2x from %s\n",
> +		    byte_offset, SYSFS_PATH);
> +	printf("0x%.2x\n", buf);
> +	return;
> +}
> +
> +void write_ec_val(int fd, int byte_offset, uint8_t value)
> +{
> +	int error;
> +
> +	error =3D lseek(fd, byte_offset, SEEK_SET);
> +	if (error !=3D byte_offset)
> +		err(EXIT_FAILURE, "Cannot set offset to 0x%.2x", byte_offset);
> +
> +	error =3D write(fd, &value, 1);
> +	if (error !=3D 1)
> +		err(EXIT_FAILURE, "Cannot write value 0x%.2x to offset 0x%.2x",
> +		    value, byte_offset);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int file_mode =3D O_RDONLY;
> +	int fd;
> +
> +	parse_opts(argc, argv);
> +
> +	if (read_mode =3D=3D 0)
> +		file_mode =3D O_WRONLY;
> +	else if (read_mode =3D=3D 1)
> +		file_mode =3D O_RDONLY;
> +	else
> +		usage(argv[0], EXIT_FAILURE);
> +
> +	fd =3D open(SYSFS_PATH, file_mode);
> +	if (fd =3D=3D -1)
> +		err(EXIT_FAILURE, "%s", SYSFS_PATH);
> +
> +	if (read_mode)
> +		if (read_byte_offset =3D=3D -1)
> +			dump_ec(fd);
> +		else if (read_byte_offset < 0 ||
> +			 read_byte_offset >=3D EC_SPACE_SIZE)
> +			usage(argv[0], EXIT_FAILURE);
> +		else
> +			read_ec_val(fd, read_byte_offset);
> +	else
> +		write_ec_val(fd, write_byte_offset, write_value);
> +	close(fd);
> +
> +	exit(EXIT_SUCCESS);
> +}


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
