From: Pedro Venda <pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
Subject: Re: Re: Smart Battery System driver
Date: Mon, 17 Jan 2005 16:27:21 +0000
Message-ID: <41EBE769.7050107@arrakis.dhis.org>
References: <41E81C2C.8010809@bartol.udel.edu>	<1105747983.7368.3.camel@tyrosine>	<47e0449d05011419037877f931@mail.gmail.com> <m2fz13x8mw.fsf@phoenix.squirrel.nl> <41EA2C1D.3030909@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41EA2C1D.3030909-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
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
Cc: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Rich Townsend wrote:
| Johan Vromans wrote:
|
|> Johannes Kuhlmann <jkuhlmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
|>
|>
|>> I had to put
|>> EXPORT_SYMBOL(acpi_ec_write); and EXPORT_SYMBOL(acpi_ec_read); after
|>> the functions in drivers/acpi/ec.c.

Any chance of permanently fixing the ACPI ec driver with this patch? I'm =
sure
it'll continue to be needed and such change would spare us from patching =
every
kernel every day... just a thought... After all, all it does is exporting=
 some
symbols... care to comment?

|
| Yeah, I'd completely forgotten about the patch, until I went back and
| checked the instructions in Bruno's smartbatt package. D'oh!
|
| I've modified the README file accordingly, and placed a copy of the
| patch in my acpi-sbs package. This is on top of a number of changes &
| additions to the code, which include:

hi rich,

I haven't been very busy, so no time to comment or test your driver.

| *) Fixed scaling bug when capacity is reported in mWh
| *) Added a new module parameter, capacity_info, to alter whether
| capacities are reported in mAh (charge) or mWh (power)
| *) Fixed a number of bugs in the formatting of info/state output
| *) Added support for Smart Battery System Manager (SBSM), Smart Battery
| Selector (SBSEL) and Smart Battery Charge (SBC) subsystems. With the
| code for these in place, the module correctly (I think) enumerates how
| many batteries the system can support, which ones are present, etc.

nice! :-)

| *) Added a new legacy interface for the AC adapter, in
| /proc/acpi/ac_adapter/*/state (where * is typically SBS0).

that'd be nice.

| *) Put in semaphores, so the code *might* now be SMP safe. Of course,
| this may be a purely academic excercise; I've never met the lucky ****
| who has an SMP laptop :)

true. me neither.

|
| The latest copy of the code can be obtained from:
|
| http://shayol.bartol.udel.edu/~rhdt/download/acpi_sbs-20050116.tar.gz

got it. any newer code?

| To move forward from here, I'd appreciate some advice from others on
| this list. In particular
|
| *) I'd like some feedback on the directory structure I've chosen. At th=
e
| moment, the root directory of the Smart Battery System is 'sbs', but
| would something more verbose like 'smart_battery_system' be appropriate=
?
| Also, should various subdirectories, representing subsystems, have more
| descriptive names -- e.g., 'battery_A' instead of 'SB0' (the SBS spec.
| refers to the batteries as 'A', 'B' etc), 'selector' instead of 'SBSL',
| and so on?

my honest not privileged and not acpi/kernel experienced oppinion is:
/proc/acpi/sbs seems sane. also SB?, SBSEL, SBC, etc seems very close to =
the
ACPI standard, which justifies those names.

| *) I'd appreciate feedback from people with systems *other* than Acer
| TravelMater 4x00 laptops, to help check parts of the code that are not
| accessed on these machines (e.g., the Smart Battery System Manager code=
;
| my TM4502 laptop has an older Smart Battery Selector)

I've tried your newer driver. reports are on the bottom of the e-mail.

| *) The code to update the Smart Battery System state from the SMBus is
| terribly slow,

| *) I'm not sure how to go about implmeneting Alarm functionality, not
| only to deal with low-power scenarios, but also to detect asynchronous
| events such as AC on-line/off-line and battery change, without the need
| for polling.

can't help you on any of these questions. lack of knowledge/experience. s=
orry.

The report:

I've tried to load the module and it still has the mutual-exclusion probl=
em with
the acpi AC and battery drivers. How can that be fixed?

With AC built-in the kernel, the module segfaults on insmod...

After removing the AC driver, it loads fine and reports good results.
Appearently looks nice. Tried with and without battery. Both SBSEL, SBC a=
nd SB0
values make sense.

Don't know if it's still relevant, but here's a link for my version of th=
e
smartbattery.c userspace program. just "make" and test it. needs the i2c-=
dev and
i2c-acpi-ec drivers.

http://arrakis.dhis.org/linux/smartbattery/smartbattery-20050117.tar.gz

regards,
pedro venda.
- --

Pedro Jo=E3o Lopes Venda
email: pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org
http://arrakis.dhis.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB6+dpeRy7HWZxjWERAjZ9AKDuRZ3bHn1pQNLsFFhvjXnH7KlSEgCg5nhi
Vq5ovAO0EWiMFWEfg9hHLzI=3D
=3DGCxy
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
