From: =?ISO-8859-1?Q?Fran=E7ois_Valenduc?= <fvalenduc-IWqWACnzNjyZIoH1IeqzKA@public.gmane.org>
Subject: Re: first shoot for smartbattery
Date: Tue, 04 Jan 2005 15:33:16 +0100
Message-ID: <41DAA92C.4080605@tiscali.be>
References: <41D56002.5060008@mega.ist.utl.pt> <20041231150724.GK19199@poupinou.org> <20041231181628.GL19199@poupinou.org> <20050101082605.GA24896@phys.ethz.ch> <m2acrth375.fsf@phoenix.squirrel.nl> <20050103143902.GQ19199@poupinou.org> <41D97AF3.7000409@arrakis.dhis.org> <41D98251.9020002@arrakis.dhis.org> <20050103180219.GX19199@poupinou.org> <41D9A1F5.1060508@arrakis.dhis.org> <20050104100844.GA19199@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050104100844.GA19199-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Bruno Ducrot a =E9crit :

>On Mon, Jan 03, 2005 at 07:50:13PM +0000, Pedro Venda wrote:
> =20
>
>>-----BEGIN PGP SIGNED MESSAGE-----
>>Hash: SHA1
>>
>>Bruno Ducrot wrote:
>>| On Mon, Jan 03, 2005 at 05:35:13PM +0000, Pedro Venda wrote:
>>|
>>|>-----BEGIN PGP SIGNED MESSAGE-----
>>|>Hash: SHA1
>>|>
>>|>Pedro Venda wrote:
>>|>| Bruno Ducrot wrote:
>>|>|
>>|>| | I think I found was wrong.  Please refetch, or (at your option)=20
>>replace
>>|>| | i2c-acpi-ec.ec with
>>|>| |
>>|>|=20
>>http://www.poupinou.org/acpi/smartbatt/smartbatt/i2c-acpi-ec/i2c-acpi-e=
c.c
>>|>| | then redo the sh compile.sh
>>|>| | Sorry, it was a stupid bug(tm) requiring that I buy a brown bag...
>>|>|
>>|>| happens to everyone.
>>|>|
>>|>| | Something wrong also with rmmod i2c-acpi-ec :( so you have to reb=
oot=20
>>in
>>|>| | order to be able to 'insmod i2c-acpi-ec.ko' again (I'm sure the b=
rown
>>|>| | bag will still be helpfull also...).
>>|>
>>|>ok I made a small patch against your most recent code base:
>>|
>>|
>>| Thanks.
>>|
>>|
>>|>included:
>>|>- - a Makefile for the i2c-acpi-ec module
>>|>- - a Makefile for the smartbattery program which also calls the
>>|>i2c-acpi-ec make
>>|>process.
>>|>
>>|>in the smartbattery directory, one just "make"s and everything gets b=
uilt.
>>|
>>|
>>| Ok.
>>
>>another thing: I changed the current drain from "mA or mWh" to "mAh or =
mW"=20
>>in
>>smartbattery.c but I'm having some doubts:
>>   =20
>>
>
>It's mAh or mWh, depending of the value of CAPACITY_MODE.  This is a r/w
>bit in BatteryMode() word (the 15th).  If this bit is clear (default),
>then it is mAh and this is current in mAh.  If this bit is set, this
>power, exprimed as 10mWh.
>
>I've fixed this issue.  Hopefully it should be ok now.
>
>
> =20
>
I am afraid it's not ok yet. In fact I get a very strange result: when
the AC adapter is unplugged and knowing my battery is fully loaded, if I
run repeatedly the command smartbattery 0, the "time to empty value" is
sometime increasing, sometime decreasing. I can understand that it
decreases but it's strange that it can also increase ! Last
precision: I did this test with the latest available release (after
having replaced the smartbattery.c file by a new version that Brunot
Ducrot send me this morning to fix compilation errors).




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
