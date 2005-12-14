From: John Keller <jpk-sJ/iWh9BUns@public.gmane.org>
Subject: Re: vendor resource descriptors: HowTo?
Date: Wed, 14 Dec 2005 10:31:37 -0600 (CST)
Message-ID: <200512141631.jBEGVc1j219262@fcbayern.americas.sgi.com>
References: <971FCB6690CD0E4898387DBF7552B90E03B4F8DC@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <971FCB6690CD0E4898387DBF7552B90E03B4F8DC-sBd4vmA9Se5Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org> from "Moore, Robert" at Dec 13, 2005 09:27:26 AM
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

Any idea when this will happen?
Days, weeks, months???

I'm not that familiar with the process.

Thanks,
John


> 
> This is correct, the code has been released and will appear as Len
> integrates.
> 
> 
> > -----Original Message-----
> > From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> > admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Bjorn Helgaas
> > Sent: Tuesday, December 13, 2005 9:23 AM
> > To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > Cc: John Keller
> > Subject: Re: [ACPI] vendor resource descriptors: HowTo?
> >=20
> > On Tuesday 13 December 2005 7:24 am, John Keller wrote:
> > > Hello,
> > >   I've got a question concerning the vendor resource descriptor
> > > code.
> > >
> > > Basically it is:
> > >
> > >  What is the recommended way for one to process vendor defined
> > > descriptors?
> > >
> > > The code in arch/ia64/kernel/acpi-ext.c looks to be exactly
> > > what I'd need (acpi_find_vendor_resource(),
> > > struct acpi_vendor_descriptor, etc).
> > >
> > > Should I create my own copy of this, or just modify
> > > arch/ia64/kernel/Makefile to include acpi-ext.c in my build?
> > > In which case, my only issue would be references to
> > > struct acpi_vendor_descriptor.
> > >
> > > Back in Sept, there was some discussion about moving the
> > > vendor resource code:
> > > http://sourceforge.net/mailarchive/message.php?msg_id=3D12995951
> > >
> > > Best I can tell, this has not happened yet?
> > > Are there still plans to do this? If so, when?
> >=20
> > I have mail from Bob on Nov 14, 2005, saying the new interface
> > will appear in the next release of ACPICA.  So, in the fullness
> > of time, I expect it to make its way into Len's ACPI tree and
> > into the mainstream kernel.
> >=20
> >=20
> > -------------------------------------------------------
> > This SF.net email is sponsored by: Splunk Inc. Do you grep through log
> > files
> > for problems?  Stop!  Download the new AJAX search engine that makes
> > searching your log files as easy as surfing the  web.  DOWNLOAD
> SPLUNK!
> > http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
