From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Re: first shoot for smartbattery
Date: Thu, 6 Jan 2005 09:51:49 +0100
Message-ID: <20050106085149.GJ19199@poupinou.org>
References: <m2acrth375.fsf@phoenix.squirrel.nl> <20050103143902.GQ19199@poupinou.org> <41D95CDC.8050802@phys.ethz.ch> <41D95F53.5000008@tiscali.be> <41D967B5.7040002@tiscali.be> <Pine.LNX.4.60.0501031751590.5329@frog.athome> <20050103175449.GW19199@poupinou.org> <41D9F7CA.7030408@arrakis.dhis.org> <20050104102424.GC19199@poupinou.org> <41DAB5C7.9040605@arrakis.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <41DAB5C7.9040605-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jan 04, 2005 at 03:27:03PM +0000, Pedro Venda wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Bruno Ducrot wrote:
> |>The way I see it, the i2c-acpi-ec driver allows the creation of the /proc
> |>files
> |>so that userland programs can use them normally. Am I totally wrong and
> |>should
> |>quickly look for the brown bag?
> |
> |
> | I would like to not touch i2c-acpi-ec for this.  It should
> | only provide the smbus access.  All other components should be done
> | elsewhere IMHO.
> 
> Sorry, I didn't understand. Don't we _have_ to use the i2c-acpi-ec to query 
> and
> write information from/to the smart battery system? If so, there is no 
> other way
> than to use it in the ACPI driver that writes the /proc information.
> 

i2c-acpi-ec only provide the smbus access (KISS unix way). More,
there may be other smartbattery systems using different smbus.
Smbus under PIIX4 for older laptop, or smbus via bios come to
mind, though this should apply only for older laptops.
Also, even though there is already support for apple laptops, most
of them seems to have smartbatteries (after reading source code under
linux), so allowing code factoring.

The short term goal which is to mimic the current ACPI Control Method
Battery in order to get compatibility with userspace program should be
finished today or tomorrow.

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
