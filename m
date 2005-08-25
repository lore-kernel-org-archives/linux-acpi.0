From: Felix Homann <fexpop-53koH/AXb86i2/dY4+mD5w@public.gmane.org>
Subject: Re: Centrino not scaling to lowest frequency
Date: Thu, 25 Aug 2005 19:30:30 +0200
Message-ID: <200508251930.30874.fexpop@onlinehome.de>
References: <200508152344.11572.fexpop@onlinehome.de> <200508251704.50673.fexpop@onlinehome.de> <20050825153703.GA594@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050825153703.GA594-JwFqNg2GrOVrgjWwlLH9qw@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thursday 25 August 2005 17:37, Dominik Brodowski wrote:
> > BTW, Intel's CPU identifiction utility reports a system bus frequency of
> > 400 MHz when the CPU is reported to work at 600 MHz. Usually the system
> > bus is running at 533 MHz. Is this the effect of "throttling" on top of
> > "CPU frequency scaling" or is this something different?
>
> Uh, this is strange. I know of no implementation on Intel CPUs to scale the
> system bus frequency.
>
> However.... Are you relying on centrino-decode of cpufrequtils? IIRC
> it is broken for the 533 MHz case, so if it reports 400 MHz it actually
> means 600 MHz.  *clicketiclick* Yes, cpufrequtils-0.3 still contains this
> bug; need to release 0.4 soon.
>
> 	Dominik

Sorry, I guess I haven't made myself clear enough in the previous mail. The 
Intel tool I mentioned is a Windows utility available here:

http://support.intel.com/support/processors/tools/piu/

When in Windows my Pentium M 730 is reported to run at 600 MHz the Intel tool 
reports a 400 MHz system bus. When the processor is running at  1.60 GHz it 
reports a 533 MHz system bus.

Is there a really reliable tool to get information on the respective 
frequencies?

Regards,

Felix


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
