From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Re: first shoot for smartbattery
Date: Tue, 4 Jan 2005 11:24:24 +0100
Message-ID: <20050104102424.GC19199@poupinou.org>
References: <20041231181628.GL19199@poupinou.org> <20050101082605.GA24896@phys.ethz.ch> <m2acrth375.fsf@phoenix.squirrel.nl> <20050103143902.GQ19199@poupinou.org> <41D95CDC.8050802@phys.ethz.ch> <41D95F53.5000008@tiscali.be> <41D967B5.7040002@tiscali.be> <Pine.LNX.4.60.0501031751590.5329@frog.athome> <20050103175449.GW19199@poupinou.org> <41D9F7CA.7030408@arrakis.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <41D9F7CA.7030408-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
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

On Tue, Jan 04, 2005 at 01:56:26AM +0000, Pedro Venda wrote:
> Would the result be the creation of /proc/acpi/battery and 
> /proc/acpi/ac_adapter
> like other batteries?

Something like this.  But only to provide compatibility with existing
programs.  A long term goal would be to design a generic API for battery
stuff (APM, ACPI Control Method Battery, smartbatteries subsystem and
PMU come to mind).

> The way I see it, the i2c-acpi-ec driver allows the creation of the /proc 
> files
> so that userland programs can use them normally. Am I totally wrong and 
> should
> quickly look for the brown bag?

I would like to not touch i2c-acpi-ec for this.  It should
only provide the smbus access.  All other components should be done
elsewhere IMHO.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
