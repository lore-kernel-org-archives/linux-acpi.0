From: Pedro Venda <pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
Subject: Re: Smart Battery System driver
Date: Sat, 15 Jan 2005 00:12:15 +0000
Message-ID: <41E85FDF.3080404@arrakis.dhis.org>
References: <41E81C2C.8010809@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41E81C2C.8010809-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Cc: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Rich Townsend wrote:
| Hi all --
|
| Recently, Bruno Ducrot posted a driver that allows access to smart
| batteries, through the /dev/i2c interface. This came at just the right
| time for me, since I'd recently purchased an Acer TravelMate 4502, and
| had no way to monitor the status of the smart battery.

hi rich,

Bruno also said a working driver was about to be released...

anyway I've tested your driver and have some results to show you:

this is what I get from a modified version of bruno ducrot's smartbattery
userspace program

- -----------------------------------------------------------
archon smartbatt-head # ./smartbattery 5 -a

smart battery manufacturer information

manufacturer name:              SMP-SONY
device name:                    04ZL
manufacture date (yyyy/mm/dd):  2004/8/17
serial number:                  1

smart battery device specs

device chemistry:               LION
design voltage:                 14800 mV
design charge capacity:         4400 mAh

smart battery device state

charger:                        charging (almost full)
relative charge:                99%
full charge capacity:           3687 mAh
remain:                         3667 mAh
current input:                  0 mA
average time to empty:          n/a
average time to full:           n/a
temperature:                    20.8 C
voltage:                        16752 mV
remaining_capacity_alarm:       disabled
charge cycle count:             22
archon smartbatt-head #
- ------------------------------------------------------------

assuming the values are right, let's see:

archon BAT0 # pwd
/proc/acpi/battery/BAT0
archon BAT0 # cat info
present:                 yes
design capacity:         80 mAh
last full capacity:      10 mAh
battery technology:      rechargeable
design voltage:          0 mV
model number:
serial number:           250
battery type:
OEM info:
archon BAT0 #

weird values... maybe something's missing here... or is this something el=
se
other than battery read values?

archon BAT0 # cat state
present:                 yes
capacity state:          ok
charging state:          charged
present rate:            0 mA
remaining capacity:      3667 mAh
present voltage:         16753 mV
archon BAT0 #

this makes sense. It's ok.

archon SBS0 # pwd
/proc/acpi/sbs/SBS0
archon SBS0 # cat info
design voltage:          0 mV
design capacity:         80 mAh
full charge capacity:    10 mAh
remain capacity alarm:   5 mAh
remain time alarm:       0 mAh
charging current:        0 mA
charging voltage:        18 mV
charge reporting error:  0%
specification info:      Smart Battery v4.4
manufacturer name:
manufacture date:        1980- 0- 0
serial number:           250
device name:
device chemistry:
archon SBS0 #

again, none of the values seem to be correct...

archon SBS0 # cat state
charging state:          charged
current:                 0 mA
average current          0 mA
voltage:                 16753 mV
temperature:             21.5 C
relative charge:         99%
absolute charge:         83%
remaining capacity:      3667 mAh
run time to empty:       not discharging
average time to empty:   not discharging
average time to full:    not charging
archon SBS0 #

this is also ok.

I haven't had the time to read the code, but it seems that something's mi=
ssing
in the info files. could you check on that?

also, it's misbehaving when there is no battery present:

archon SBS0 # pwd
/proc/acpi/sbs/SBS0
archon SBS0 # cat state
cat: state: Operation not permitted
archon SBS0 #

archon BAT0 # pwd
/proc/acpi/battery/BAT0
archon BAT0 # cat info
present:                 yes
design capacity:         80 mAh
last full capacity:      10 mAh
battery technology:      rechargeable
design voltage:          0 mV
model number:
serial number:           250
battery type:
OEM info:
archon BAT0 #

archon BAT0 # cat state
cat: state: Operation not permitted
archon BAT0 #

Thanks for the work with the driver. It's damn good work!

Also, the other driver from Bruno Ducrot should be out soon, so I predict=
 we'll
have some work with both. maybe some kind of merge would be possible, bes=
t parts
of one and best parts of the other... just a comment.

regards,
pedro venda.
- --

Pedro Jo=E3o Lopes Venda
email: pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org
http://arrakis.dhis.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB6F/feRy7HWZxjWERAjJFAJ9vQ3jaaE1L30YSjcZPRmA5jK+EzACePq5h
kHp9LlMv5oChkpY52jUWSGI=3D
=3DHCrZ
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
