From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: OperationRegion outside scope
Date: Fri, 12 Nov 2004 18:22:16 +0100
Message-ID: <20041112172216.GG31422@poupinou.org>
References: <20041112153216.GF31422@poupinou.org> <20041112170138.35367.qmail@web41129.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041112170138.35367.qmail-PzIyE2qCj7uA/QwVtaZbd3CJp6faPEW9@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Paulo da Silva <pvmagacho78-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On Fri, Nov 12, 2004 at 09:01:38AM -0800, Paulo da Silva wrote:
> 
> Hi,
> 
>   these solutions solves the errors for the
> compilation. However, when using the iasl you will see
> in the compiled file that the operation regions that
> are outside any scope will have zero length. And this
> causes different errors.
>   I put two files on the web.
>   1) http://cern.ch/paulo/before.log
>      this is the message log that is produced by using
> the default dsdt that comes with my bios.
>   2) http://cern.ch/paulo/after.log
>      this is the message log that is produce after I
> introduce the changes needed for compiling the code.
> 

I would say this is a bug in iasl or else a *lot* of DSDT are buggy as
well though never got that kind of report before...

Which iasl version are you using?  Could you post to me the DSDT.aml produced?

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
