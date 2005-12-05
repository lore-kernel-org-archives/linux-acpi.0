From: Mattia Dongili <malattia-k2GhghHVRtY@public.gmane.org>
Subject: Re: Problem building pacpidump
Date: Mon, 5 Dec 2005 22:21:16 +0100
Message-ID: <20051205212116.GE3609@inferi.kami.home>
References: <200512041212.jB4CCWDC091502@ns.init-main.com> <1133773213.5627.6.camel@gusti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Resent-Message-ID: <20051205214401.GA17966-MEqNC12sBsHxa7XIdbXXog@public.gmane.org>
Resent-To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Content-Disposition: inline
In-Reply-To: <1133773213.5627.6.camel@gusti>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: martin schneebacher <masc-y2ntbsqpbL5kvIbmRjWsil6hYfS7NtTn@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Dec 05, 2005 at 10:00:13AM +0100, martin schneebacher wrote:
[...]
> much more better. download the latest iasl from 
> http://www.intel.com/technology/iapc/acpi/downloads/acpica-unix-20051117.tar.gz
> (in sarge is no iasl-package, they starting from testing), install
> flex-old, go to the compiler directory if acpica-unix and type make. 
> 
> use it with -d to disassemble and with -tc to built the table. 

I did one step further: backported the package to Sarge (easy, all the
necessary stuff is already there so you could just build the same
Etch/Sid source), apt-gettable from:
  deb http://people.debian.org/~malattia/debian binary/

I hope this is useful, I'll try to keep it up-to-date.
-- 
mattia
:wq!


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
