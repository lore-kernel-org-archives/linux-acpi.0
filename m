From: Pedro Venda <pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
Subject: Re: Re: first shoot for smartbattery
Date: Tue, 11 Jan 2005 10:10:17 +0000
Message-ID: <41E3A609.7000505@arrakis.dhis.org>
References: <41D56002.5060008@mega.ist.utl.pt>	<200501101736.24293.sanskryt@op.pl>	<m27jmlf57y.fsf@phoenix.squirrel.nl>	<200501102341.07731.sanskryt@op.pl> <m2sm58mhzg.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030606040403090203000300"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m2sm58mhzg.fsf-KjnUIgV0B0bak1Ioo/c9IoRWq/SkRNHw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------030606040403090203000300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Johan Vromans wrote:
| "Zdzis=B3aw A. Kaleta" <sanskryt-FWhLrETftxM@public.gmane.org> writes:
|
|
|>So it look like that I realy have the not proper smartbattery.c
|>version. Where I can find proper one?
|
|
| Maybe Pedro Venda <pjvenda-pQd4kjVL+RHfqL7NgpvPWWD2FQJk+8+b@public.gmane.org> (the author) is
| willing to post an updated version?

well, the working version for your program is still the one you're using.=
 I'm
building another and it's nearly done, but when it is, you'll have to rew=
ork
your script.

sneak preview:

archon smartbatt-head # ./smartbattery 5
charger state: discharging
~        estimated time to empty: 47 minutes
battery state: [=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|                          =
  ] 28%
archon smartbatt-head #

don't worry, I'll put a command line switch to make it show verbose infor=
mation.

the smartbattery.c I've previously written (changed) follows attached.

regards,
pedro venda.
- --

Pedro Jo=E3o Lopes Venda
email: pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org
http://arrakis.dhis.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB46YJeRy7HWZxjWERAmxpAKCkLduuHRrmbI2XHt7uhmMfg/BDyQCdF01k
8q85Ceyuy/YzLn1cSVEoWQ8=3D
=3DF8zL
-----END PGP SIGNATURE-----

--------------030606040403090203000300
Content-Type: text/plain;
 name="smartbattery.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smartbattery.c"

/*
    smartbatt.c - a user-space program for debugging smartbattery support

    (C) 2004 Bruno Ducrot, licence same as i2cdump.c since this stuff
    was shamelessly stolen from:

    i2cdump.c - a user-space program to dump I2C registers
    Copyright (C) 2002-2003  Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>, and
                             Mark D. Studebaker <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
    Copyright (C) 2004       The lm_sensors group

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/

#include <errno.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <limits.h>
#include <dirent.h>
#include <fcntl.h>
#include <errno.h>

#include <i2c-dev.h>

/*
   this just prints out the installed i2c busses in a consistent format, whether
   on a 2.4 kernel using /proc or a 2.6 kernel using /sys.
   If procfmt == 1, print out exactly /proc/bus/i2c format on stdout.
   This allows this to be used in a program to emulate /proc/bus/i2c on a
   sysfs system.
*/
void print_i2c_busses(int procfmt)
{
	FILE *fptr;
	char s[100];
	struct dirent *de, *dde;
	DIR *dir, *ddir;
	FILE *f;
	char *border;
	char dev[NAME_MAX], fstype[NAME_MAX], sysfs[NAME_MAX], n[NAME_MAX];
	int foundsysfs = 0;
	int tmp;
	int count=0;


	/* look in /proc/bus/i2c */
	if((fptr = fopen("/proc/bus/i2c", "r"))) {
		while(fgets(s, 100, fptr)) {
			if(count++ == 0 && !procfmt)
				fprintf(stderr,"  Installed I2C busses:\n");
			if(procfmt)
				printf("%s", s);	
			else
				fprintf(stderr, "    %s", s);	
		}
		fclose(fptr);
		goto done;
	}

	/* look in sysfs */
	/* First figure out where sysfs was mounted */
	if ((f = fopen("/proc/mounts", "r")) == NULL) {
		goto done;
	}
	while (fgets(n, NAME_MAX, f)) {
		sscanf(n, "%[^ ] %[^ ] %[^ ] %*s\n", dev, sysfs, fstype);
		if (strcasecmp(fstype, "sysfs") == 0) {
			foundsysfs++;
			break;
		}
	}
	fclose(f);
	if (! foundsysfs) {
		goto done;
	}

	/* Bus numbers in i2c-adapter don't necessarily match those in
	   i2c-dev and what we really care about are the i2c-dev numbers.
	   Unfortunately the names are harder to get in i2c-dev */
	strcat(sysfs, "/class/i2c-dev");
	if(!(dir = opendir(sysfs)))
		goto done;
	/* go through the busses */
	while ((de = readdir(dir)) != NULL) {
		if (!strcmp(de->d_name, "."))
			continue;
		if (!strcmp(de->d_name, ".."))
			continue;

		/* this should work for kernels 2.6.5 or higher and */
		/* is preferred because is unambiguous */
		sprintf(n, "%s/%s/name", sysfs, de->d_name);
		f = fopen(n, "r");
		/* this seems to work for ISA */
		if(f == NULL) {
			sprintf(n, "%s/%s/device/name", sysfs, de->d_name);
			f = fopen(n, "r");
		}
		/* non-ISA is much harder */
		/* and this won't find the correct bus name if a driver
		   has more than one bus */
		if(f == NULL) {
			sprintf(n, "%s/%s/device", sysfs, de->d_name);
			if(!(ddir = opendir(n)))
				continue;       	
			while ((dde = readdir(ddir)) != NULL) {
				if (!strcmp(dde->d_name, "."))
					continue;
				if (!strcmp(dde->d_name, ".."))
					continue;
				if ((!strncmp(dde->d_name, "i2c-", 4))) {
					sprintf(n, "%s/%s/device/%s/name",
					        sysfs, de->d_name, dde->d_name);
					if((f = fopen(n, "r")))
						goto found;
				}
			}
		}

found:
		if (f != NULL) {
			char	x[120];

			fgets(x, 120, f);
			fclose(f);
			if((border = index(x, '\n')) != NULL)
				*border = 0;
			if(count++ == 0 && !procfmt)
				fprintf(stderr,"  Installed I2C busses:\n");
			/* match 2.4 /proc/bus/i2c format as closely as possible */
			if(!strncmp(x, "ISA ", 4)) {
				if(procfmt)
					printf("%s\t%-10s\t%-32s\t%s\n", de->d_name,
					        "dummy", x, "ISA bus algorithm");
				else
					fprintf(stderr, "    %s\t%-10s\t%-32s\t%s\n", de->d_name,
					        "dummy", x, "ISA bus algorithm");
			} else if(!sscanf(de->d_name, "i2c-%d", &tmp)) {
				if(procfmt)
					printf("%s\t%-10s\t%-32s\t%s\n", de->d_name,
					        "dummy", x, "Dummy bus algorithm");
				else
					fprintf(stderr, "    %s\t%-10s\t%-32s\t%s\n", de->d_name,
					        "dummy", x, "Dummy bus algorithm");
			} else {
				if(procfmt)
					printf("%s\t%-10s\t%-32s\t%s\n", de->d_name,
					        "unknown", x, "Algorithm unavailable");
				else
					fprintf(stderr, "    %s\t%-10s\t%-32s\t%s\n", de->d_name,
					        "unknown", x, "Algorithm unavailable");
			}
		}
	}
	closedir(dir);

done:
	if(count == 0 && !procfmt)
		fprintf(stderr,"Error: No I2C busses found!\n"
		               "Be sure you have done 'modprobe i2c-dev'\n"
		               "and also modprobed your i2c bus drivers\n");
}

int open_i2c_dev(const int i2cbus, char *filename)
{
	int file;

	sprintf(filename, "/dev/i2c/%d", i2cbus);
	file = open(filename, O_RDWR);

	if (file < 0 && errno == ENOENT) {
		sprintf(filename, "/dev/i2c-%d", i2cbus);
		file = open(filename, O_RDWR);
	}

	if (file < 0) {
		if (errno == ENOENT) {
			fprintf(stderr, "Error: Could not open file "
			        "`/dev/i2c-%d' or `/dev/i2c/%d': %s\n",
			        i2cbus, i2cbus, strerror(ENOENT));
		} else {
			fprintf(stderr, "Error: Could not open file "
			        "`%s': %s\n", filename, strerror(errno));
			if (errno == EACCES)
				fprintf(stderr, "Run as root?\n");
		}
	}
	
	return file;
}


/*
   We don't use this #define but it was put into i2c.h at the same time as
   i2c_smbus_read_i2c_block_data() was implemented (i2c 2.6.3),
   so we use it as a version check.
*/
#ifdef I2C_FUNC_SMBUS_READ_I2C_BLOCK_2
#define USE_I2C_BLOCK 1
#else
#define USE_I2C_BLOCK 0
#endif

#ifdef I2C_FUNC_SMBUS_BLOCK_DATA_PEC
#define HAVE_PEC 1
#endif

void help(void)
{
	fprintf(stderr, "Syntax: smartbatt I2CBUS\n");
	print_i2c_busses(0);
}

int main(int argc, char *argv[])
{
	char *end;
	int i2cbus, address, file;
	int temp, voltage, current;
	int avg_current, avg_time_to_full, avg_time_to_empty;
	int rel_state_charge , full_charge_cap , design_charge_cap , abs_state_charge;
	int remain;
	int cycle_count;
	int design_voltage;
	int battery_status;
	int battery_mode;

	char filename[20];
	long funcs;

	if (argc < 2) {
		fprintf(stderr, "Error: No i2c-bus specified!\n");
		help();
		exit(1);
	}
	i2cbus = strtol(argv[1], &end, 0);
	if (*end) {
		fprintf(stderr, "Error: First argument not a number!\n");
		help();
		exit(1);
	}
	if (i2cbus < 0 || i2cbus > 0xff) {
		fprintf(stderr, "Error: I2CBUS argument out of range!\n");
		help();
		exit(1);
	}

	if (argc >= 3) {
		address = strtol(argv[2], &end, 0);
	} else
		address = 0xb;

	if (address < 0 || address > 0x7f) {
		fprintf(stderr, "Error: Address out of range!\n");
		help();
		exit(1);
	}


	file = open_i2c_dev(i2cbus, filename);
	if (file < 0) {
		exit(1);
	}

	/* check adapter functionality */
	if (ioctl(file, I2C_FUNCS, &funcs) < 0) {
		fprintf(stderr, "Error: Could not get the adapter "
		        "functionality matrix: %s\n", strerror(errno));
		exit(1);
	}

	if (!(funcs & I2C_FUNC_SMBUS_READ_WORD_DATA)) {
		fprintf(stderr, "Error: Adapter for i2c bus "
			"%d does not have word read "
			"capability\n", i2cbus);
		exit(1);
	}


	/* use FORCE so that we can look at registers even when
	   a driver is also running */
	if (ioctl(file, I2C_SLAVE_FORCE, address) < 0) {
		fprintf(stderr, "Error: Could not set address to %d: %s\n",
		        address, strerror(errno));
		exit(1);
	}

	/* BatteryMode() */
	battery_mode = i2c_smbus_read_word_data(file,0x3);
	/* Temperature() */
	temp = i2c_smbus_read_word_data(file, 0x8);
	/* Voltage() */
	voltage = i2c_smbus_read_word_data(file, 0x9);
	/* Current() */
	current = i2c_smbus_read_word_data(file, 0xa);
	/* AvgCurrent() */
	avg_current = i2c_smbus_read_word_data(file,0xb);
	/* RelativeStateOfCharge() */
	rel_state_charge = i2c_smbus_read_word_data(file,0xd);
	/* AbsoluteStateOfCharge() */
	abs_state_charge = i2c_smbus_read_word_data(file,0xe);
	/* RemainingCapacity() */
	remain = i2c_smbus_read_word_data(file, 0xf);
	/* FullChargeCapacity() */
	full_charge_cap = i2c_smbus_read_word_data(file,0x10);
	/* AverageTimeToEmpty() */
	avg_time_to_empty = i2c_smbus_read_word_data(file, 0x12);
	/* AverageTimeToFull() */
	avg_time_to_full = i2c_smbus_read_word_data(file, 0x13);
	/* BatteryStatus() */
	battery_status = i2c_smbus_read_word_data(file, 0x16);
	/* CycleCount() */
	cycle_count = i2c_smbus_read_word_data(file,0x17);
	/* DesignChargeCapacity() */
	design_charge_cap = i2c_smbus_read_word_data(file,0x18);
	/* DesignVoltage() */
	design_voltage = i2c_smbus_read_word_data(file,0x19);

	/* if current is negative, we need to make the 2' complement
	 * to show the correct decimal value */
	current=current & 0xffff;
	if(current & 0x8000) {
		current=((current^0xffff)+0x0001);
		current*=(-1);
	}
	
	printf("status:\t\t");
	if(battery_status & 0x0010)
		printf("\tfully discharged");
	if(battery_status & 0x0020)
		printf("\tfully charged");
	if(battery_status & 0x0040)
		printf("\tdischarging");
	if(battery_status & 0x0080)
		printf("\tinitialized");
	printf("\n");

	printf("mode:\t\t");
	if(battery_mode & 0x0080)
		printf("\tcondition_flag");
	if(! battery_mode & 0x8000) {
		printf("\tcapacity in mA/mAh");
	} else {
		printf("\tcapacity in 10 mW/mWh");
	}
	printf("\n");

	printf("design voltage:\t\t%d mV\n",design_voltage & 0xffff);
	printf("design charge capacity:\t%d mAh or mWh\n",design_charge_cap & 0xffff);
	printf("absolute charge:\t%d%\n",abs_state_charge & 0xffff);
	printf("full charge capacity:\t%d mAh or mWh\n",full_charge_cap & 0xffff);
	printf("relative charge:\t%d%\n",rel_state_charge & 0xffff);

	
	printf("current:\t\t%d mA\n", current);
	printf("voltage:\t\t%d mV\n", voltage & 0xffff);

	printf("remain:\t\t\t%d mA\n", remain & 0xffff);
	printf("average time to empty:\t%d minutes\n", avg_time_to_empty & 0xffff);
	printf("average time to full:\t%d minutes\n", avg_time_to_full & 0xffff);
	printf("temperature:\t\t%2.1f C\n", ((temp & 0xffff) - 2730) / 10.);
	printf("cycle count:\t\t%d\n",cycle_count & 0xffff);
	
	return 0;
}

--------------030606040403090203000300--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
