From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Re: first shoot for smartbattery
Date: Tue, 4 Jan 2005 11:08:44 +0100
Message-ID: <20050104100844.GA19199@poupinou.org>
References: <41D56002.5060008@mega.ist.utl.pt> <20041231150724.GK19199@poupinou.org> <20041231181628.GL19199@poupinou.org> <20050101082605.GA24896@phys.ethz.ch> <m2acrth375.fsf@phoenix.squirrel.nl> <20050103143902.GQ19199@poupinou.org> <41D97AF3.7000409@arrakis.dhis.org> <41D98251.9020002@arrakis.dhis.org> <20050103180219.GX19199@poupinou.org> <41D9A1F5.1060508@arrakis.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <41D9A1F5.1060508-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
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
Cc: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 03, 2005 at 07:50:13PM +0000, Pedro Venda wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Bruno Ducrot wrote:
> | On Mon, Jan 03, 2005 at 05:35:13PM +0000, Pedro Venda wrote:
> |
> |>-----BEGIN PGP SIGNED MESSAGE-----
> |>Hash: SHA1
> |>
> |>Pedro Venda wrote:
> |>| Bruno Ducrot wrote:
> |>|
> |>| | I think I found was wrong.  Please refetch, or (at your option) 
> replace
> |>| | i2c-acpi-ec.ec with
> |>| |
> |>| 
> http://www.poupinou.org/acpi/smartbatt/smartbatt/i2c-acpi-ec/i2c-acpi-ec.c
> |>| | then redo the sh compile.sh
> |>| | Sorry, it was a stupid bug(tm) requiring that I buy a brown bag...
> |>|
> |>| happens to everyone.
> |>|
> |>| | Something wrong also with rmmod i2c-acpi-ec :( so you have to reboot 
> in
> |>| | order to be able to 'insmod i2c-acpi-ec.ko' again (I'm sure the brown
> |>| | bag will still be helpfull also...).
> |>
> |>ok I made a small patch against your most recent code base:
> |
> |
> | Thanks.
> |
> |
> |>included:
> |>- - a Makefile for the i2c-acpi-ec module
> |>- - a Makefile for the smartbattery program which also calls the
> |>i2c-acpi-ec make
> |>process.
> |>
> |>in the smartbattery directory, one just "make"s and everything gets built.
> |
> |
> | Ok.
> 
> another thing: I changed the current drain from "mA or mWh" to "mAh or mW" 
> in
> smartbattery.c but I'm having some doubts:

It's mAh or mWh, depending of the value of CAPACITY_MODE.  This is a r/w
bit in BatteryMode() word (the 15th).  If this bit is clear (default),
then it is mAh and this is current in mAh.  If this bit is set, this
power, exprimed as 10mWh.

I've fixed this issue.  Hopefully it should be ok now.


-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
