From: John Keller <jpk-sJ/iWh9BUns@public.gmane.org>
Subject: vendor resource descriptors: HowTo?
Date: Tue, 13 Dec 2005 08:24:01 -0600 (CST)
Message-ID: <200512131424.jBDEO2dl191849@fcbayern.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
List-Id: linux-acpi@vger.kernel.org

Hello,
  I've got a question concerning the vendor resource descriptor
code. 

Basically it is:
 
 What is the recommended way for one to process vendor defined
descriptors?

The code in arch/ia64/kernel/acpi-ext.c looks to be exactly
what I'd need (acpi_find_vendor_resource(), 
struct acpi_vendor_descriptor, etc). 

Should I create my own copy of this, or just modify
arch/ia64/kernel/Makefile to include acpi-ext.c in my build?
In which case, my only issue would be references to 
struct acpi_vendor_descriptor.

Back in Sept, there was some discussion about moving the
vendor resource code: 
http://sourceforge.net/mailarchive/message.php?msg_id=12995951

Best I can tell, this has not happened yet?
Are there still plans to do this? If so, when?

Thanks for any help,
John



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
