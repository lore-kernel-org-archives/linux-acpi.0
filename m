From: Pedro Venda <pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
Subject: Re: Re: first shoot for smartbattery
Date: Mon, 03 Jan 2005 17:35:13 +0000
Message-ID: <41D98251.9020002@arrakis.dhis.org>
References: <20041231092156.GA612@phys.ethz.ch> <41D56002.5060008@mega.ist.utl.pt> <20041231150724.GK19199@poupinou.org> <20041231181628.GL19199@poupinou.org> <20050101082605.GA24896@phys.ethz.ch> <m2acrth375.fsf@phoenix.squirrel.nl> <20050103143902.GQ19199@poupinou.org> <41D97AF3.7000409@arrakis.dhis.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040403030507090004040206"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41D97AF3.7000409-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pedro Venda <pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
Cc: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------040403030507090004040206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Pedro Venda wrote:
| Bruno Ducrot wrote:
|
| | I think I found was wrong.  Please refetch, or (at your option) repla=
ce
| | i2c-acpi-ec.ec with
| |
| http://www.poupinou.org/acpi/smartbatt/smartbatt/i2c-acpi-ec/i2c-acpi-e=
c.c
| | then redo the sh compile.sh
| | Sorry, it was a stupid bug(tm) requiring that I buy a brown bag...
|
| happens to everyone.
|
| | Something wrong also with rmmod i2c-acpi-ec :( so you have to reboot =
in
| | order to be able to 'insmod i2c-acpi-ec.ko' again (I'm sure the brown
| | bag will still be helpfull also...).

ok I made a small patch against your most recent code base:

included:
- - a Makefile for the i2c-acpi-ec module
- - a Makefile for the smartbattery program which also calls the i2c-acpi=
-ec make
process.

in the smartbattery directory, one just "make"s and everything gets built=
.

I found out that when draining power from the battery with no AC power, t=
he
value returned should be added to -65535 to result in the correct value.

this puzzles me, because when the battery is being used, the returned val=
ue
seems to be subtracted from 65535  but when the AC is plugged, it seems t=
o come
out ok...

regards,
pedro venda.
- --

Pedro Jo=E3o Lopes Venda
email: pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org
http://arrakis.dhis.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB2YJReRy7HWZxjWERAvBYAKCBMt5O6ZziU1SfS8gSyzNOmD9PQgCeNTtl
KngbkKyfTNqKMxbGXUb3tI0=3D
=3DM+yB
-----END PGP SIGNATURE-----

--------------040403030507090004040206
Content-Type: text/plain;
 name="smartbatt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smartbatt.patch"

diff -rNu smartbatt/Makefile smartbatt-2/Makefile
--- smartbatt/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ smartbatt-2/Makefile	2005-01-03 17:25:49.346995193 +0000
@@ -0,0 +1,19 @@
+CC=gcc
+CFLAGS=-I./include
+DEPS=smartbattery.c
+EFILE=smartbattery
+I2C-ACPI-EC=i2c-acpi-ec/i2c-acpi-ec.ko
+
+default:	$(EFILE) $(I2C-ACPI-EC)
+
+$(EFILE):	$(DEPS)
+	@echo "linking $@ from $<"
+	$(CC) $(CFLAGS) -o $@ $<
+	
+$(I2C-ACPI-EC):	
+	make -C i2c-acpi-ec
+
+.PHONY:	clean
+clean:
+	rm -f smartbattery smartbattery.o
+	make -C i2c-acpi-ec clean
diff -rNu smartbatt/i2c-acpi-ec/Makefile smartbatt-2/i2c-acpi-ec/Makefile
--- smartbatt/i2c-acpi-ec/Makefile	2004-12-31 17:11:54.000000000 +0000
+++ smartbatt-2/i2c-acpi-ec/Makefile	2005-01-03 17:23:26.409880044 +0000
@@ -1 +1,17 @@
+ifneq ($(KERNELRELEASE),)
 obj-m := i2c-acpi-ec.o
+
+else
+KDIR:= /lib/modules/$(shell uname -r)/build
+PWD:= $(shell pwd)
+
+default:
+	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
+	
+.PHONY:	clean
+
+clean:
+	rm -f i2c-acpi-ec.ko i2c-acpi-ec.mod.* i2c-acpi-ec.o .i2c-acpi-ec.*
+	rm -rf .tmp_versions
+
+endif
Files smartbatt/smartbattery and smartbatt-2/smartbattery differ
diff -rNu smartbatt/smartbattery.c smartbatt-2/smartbattery.c
--- smartbatt/smartbattery.c	2004-12-31 19:03:36.000000000 +0000
+++ smartbatt-2/smartbattery.c	2005-01-03 17:21:35.825490452 +0000
@@ -300,8 +300,8 @@
 	time_to_empty = i2c_smbus_read_word_data(file, 0x11);
 	time_to_full = i2c_smbus_read_word_data(file, 0x11);
 
-	printf("current:       %d mA\n", current & 0xffff);
-	printf("remain:        %d mA or mWh\n", remain & 0xffff);
+	printf("current:       %d mA\n", (current & 0xffff));
+	printf("remain:        %d mAh or mW\n", remain & 0xffff);
 	printf("time to empty: %d minutes\n", time_to_empty & 0xffff);
 	printf("time to full:  %d minutes\n", time_to_full & 0xffff);
 	printf("temperature:   %2.1f C\n", ((temp & 0xffff) - 2730) / 10.);

--------------040403030507090004040206--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
