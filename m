From: Pedro Venda <pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
Subject: Re: first shoot for smartbattery (was Re: Re: i2c-acpi-ec.c)
Date: Sun, 09 Jan 2005 12:04:32 +0000
Message-ID: <41E11DD0.2090809@arrakis.dhis.org>
References: <20041231092156.GA612@phys.ethz.ch> <41D56002.5060008@mega.ist.utl.pt> <20041231150724.GK19199@poupinou.org> <20041231181628.GL19199@poupinou.org> <41E0A01C.6060607@paranoici.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000303090805070101070901"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41E0A01C.6060607-XtQPfPCVGG7srOwW+9ziJQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ultrakorne <ultrakorne-XtQPfPCVGG7srOwW+9ziJQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------000303090805070101070901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

ultrakorne wrote:
| Bruno Ducrot wrote:
|
|> On Fri, Dec 31, 2004 at 04:07:24PM +0100, Bruno Ducrot wrote:
|>
|>> I'm polishing i2c-acpi-ec right now.  Stay tunned.
|>
|>
|>
|> It's not yet really polished as I wanted, but well I don't have
|> time to finish this due to, huh, ..., private stuff this night.
|>
|> its should give people rough idea what will happens.
|>
|> You can find this at http://www.poupinou.org/acpi/smartbatt/
|> Take one of the smartbatt.tar.{gz,bz2} and follow the README after
|> unpacking it, and hopefully a ./smartbatt will give you correct batter=
y
|> informations (who knows).
|>
|> happy new year!
|>
| thx a lot ^^ seems to work fine for me
|
| ultra@doom:~/acpi/smartbatt $ sudo ./smartbattery 1
| status: discharging
| current:       968 mA
| time to empty:  222 minutes
| remain:        3629 mAh
| temperature:   19.9 C
| voltage:       15986 mV
|
| % i think is better than minuts (both is better :D)

the battery can return that too. use this patch.

regards,
pedro venda.
- --

Pedro Jo=E3o Lopes Venda
email: pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org
http://arrakis.dhis.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB4R3QeRy7HWZxjWERAsB7AKDLrNGL2nKRgOLDs/rDFuGdZDMzHgCgtDqB
lSI47vFmV5OJZ02ho3HpDPk=3D
=3DNBkI
-----END PGP SIGNATURE-----

--------------000303090805070101070901
Content-Type: text/plain;
 name="sbatt-percent.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sbatt-percent.patch"

Files smartbatt-original/smartbattery and smartbatt/smartbattery differ
diff -urN smartbatt-original/smartbattery.c smartbatt/smartbattery.c
--- smartbatt-original/smartbattery.c	2005-01-04 10:06:51.000000000 +0000
+++ smartbatt/smartbattery.c	2005-01-09 12:01:23.101616089 +0000
@@ -234,6 +234,7 @@
 	int i2cbus, address, file;
 	int temp, volt, tmp_current, remain, time_to_full, time_to_empty;
 	int unit;
+	int rel_state_charge;
 	short current;
 	int charging, discharging;
 	char filename[20];
@@ -301,6 +302,10 @@
 	temp = i2c_smbus_read_word_data(file, 0x8);
 	volt = i2c_smbus_read_word_data(file, 0x9);
 	tmp_current = i2c_smbus_read_word_data(file, 0xa);
+
+	/* RelativeStateOfCharge() */
+	rel_state_charge = i2c_smbus_read_word_data(file,0xd);
+		
 	remain = i2c_smbus_read_word_data(file, 0xf);
 	time_to_empty = i2c_smbus_read_word_data(file, 0x12);
 	time_to_full = i2c_smbus_read_word_data(file, 0x13);
@@ -329,6 +334,8 @@
 		printf("remain:        %.1f mWh\n", (remain & 0xffff)/10.);
 	else
 		printf("remain:        %d mAh\n", (remain & 0xffff));
+	
+	printf("charge state:  %d\%\n",(rel_state_charge & 0xffff));
 
 	printf("temperature:   %2.1f C\n", ((temp & 0xffff) - 2730) / 10.);
 	printf("voltage:       %d mV\n", volt & 0xffff);

--------------000303090805070101070901--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
