From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: vendor resource descriptors: HowTo?
Date: Tue, 13 Dec 2005 10:23:22 -0700
Message-ID: <200512131023.22718.bjorn.helgaas@hp.com>
References: <200512131424.jBDEO2dl191849@fcbayern.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200512131424.jBDEO2dl191849-ktIYllYL7tqP0FQRY6S+ezlWRnG0fEQ7AL8bYrjMMd8@public.gmane.org>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: John Keller <jpk-sJ/iWh9BUns@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 13 December 2005 7:24 am, John Keller wrote:
> Hello,
>   I've got a question concerning the vendor resource descriptor
> code. 
> 
> Basically it is:
>  
>  What is the recommended way for one to process vendor defined
> descriptors?
> 
> The code in arch/ia64/kernel/acpi-ext.c looks to be exactly
> what I'd need (acpi_find_vendor_resource(), 
> struct acpi_vendor_descriptor, etc). 
> 
> Should I create my own copy of this, or just modify
> arch/ia64/kernel/Makefile to include acpi-ext.c in my build?
> In which case, my only issue would be references to 
> struct acpi_vendor_descriptor.
> 
> Back in Sept, there was some discussion about moving the
> vendor resource code: 
> http://sourceforge.net/mailarchive/message.php?msg_id=12995951
> 
> Best I can tell, this has not happened yet?
> Are there still plans to do this? If so, when?

I have mail from Bob on Nov 14, 2005, saying the new interface
will appear in the next release of ACPICA.  So, in the fullness
of time, I expect it to make its way into Len's ACPI tree and
into the mainstream kernel.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
