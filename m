From: Paulo da Silva <pvmagacho78-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: OperationRegion outside scope
Date: Mon, 15 Nov 2004 05:08:29 -0800 (PST)
Message-ID: <20041115130829.23239.qmail@web41113.mail.yahoo.com>
References: <20041112173750.GH31422@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041112173750.GH31422-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hello,

  the version I was using was 20040715. I've tryed
with version 20040427 and the problem seems to have
disapperead. Looking at the compiled file it's
possible to see that the operation regions don't have
zero size anymore. I will try later today to reboot my
computer with the file compiled with version 20040427
to see if everything goes ok. I will post the results
later.
  Thank you for your answer.

Regards,
Paulo

--- Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> wrote:

> On Fri, Nov 12, 2004 at 06:22:16PM +0100, Bruno
> Ducrot wrote:
> > 
> > I would say this is a bug in iasl or else a *lot*
> of DSDT are buggy as
> > well though never got that kind of report
> before...
> > 
> > Which iasl version are you using?  Could you post
> to me the DSDT.aml produced?
> 
> I can reproduce this trouble with current iasl, but
> not with the
> 20040427.  I will send you (privately due to the
> size) the iasl I'm using.
> 
> -- 
> Bruno Ducrot
> 
> --  Which is worse:  ignorance or apathy?
> --  Don't know.  Don't care.
> 



		
__________________________________ 
Do you Yahoo!? 
Check out the new Yahoo! Front Page. 
www.yahoo.com 
 



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
