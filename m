From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: Re: New SmartBattery DSDT-based controller
Date: Sun, 30 Jan 2005 10:31:00 -0500
Message-ID: <41FCFDB4.8070307@bartol.udel.edu>
References: <41FBDDE2.1050403@bartol.udel.edu> <1107097154.25905.22.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1107097154.25905.22.camel@tyrosine>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Matthew Garrett wrote:
> On Sat, 2005-01-29 at 14:02 -0500, Rich Townsend wrote:
> 
> 
>>Eventually, the modified DSDTs can be put back into the ACPI4Linux 
>>database; but I'm more interested at the moment in ironing out any 
>>glitches in the code.
> 
> 
> While this is a neat hack, there's no real way that distributions are
> ever going to adopt this approach - DSDTs are copyrighted by the
> vendors, and without permission they're not going to be distributed by
> the Linux vendors. The alternative approach of modifying the user's DSDT
> on the fly is likely to be excessively fragile. The only reasonable
> solution is to provide a mechanism to read the battery directly.
> 

Yeah, this has occurred to me. I'm looking into cooking up some Perl, to 
allow the users to modify their own DSDTs. Of course, this is never 
going to be user friendly, and a long-term solution, as you say, is to 
read the battery directly.

That's what my acpi-sbs module already does, but I'm reluctuant to spend 
much time developing the module further, until some form of uniform 
battery interface for the kernel is designed and implemented. Having two 
seperate /proc/acpi interfaces, one for CM batteries and one for smart 
batteries, is not the way to go.

cheers,

Rich



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
