From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: Re: [PATCH] Change spinlock mutex to semaphor in ec.c
Date: Fri, 04 Feb 2005 13:26:49 -0500
Message-ID: <4203BE69.50004@bartol.udel.edu>
References: <4202C0A4.1020700@bartol.udel.edu> <200502040055.53765.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <200502040055.53765.dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>, Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Dmitry Torokhov wrote:
> On Thursday 03 February 2005 19:24, Rich Townsend wrote:
> 
>>Hi all --
>>
>>Attached is a patch against the 2.6.10 kernel, to convert the mutexing 
>>in the embdedded controller driver from a spinlock to a semaphore. The 
>>rationale behind this is to permit sleeping inside the acpi_ec_wait() 
>>polling routine.
>>
> 
> 
> Hi,
> 
> Last time such patch was proposed there were some concerns regarding
> possible interrupt storm, see the follwing thread:
> 
> http://marc.theaimsgroup.com/?l=acpi4linux&m=110055992814866&w=2
> 
> I have an alternative patch that tries to address these concerns,
> unfortunately I do not have a box with EC controller so it is
> completely untested.
> 

I've just tried your patch out on 2.6.11-rc3 (with acpi-dsdt-initrd and 
swsusp2 patches), and it causes a kernel oops when the EC is accessed at 
boot time. Unfortunately, the backtrace is too long to see where the 
oops arises; I'm sure there's a way of capturing the oops output, but I 
don't know it yet (suggestions welcome).

cheers,

Rich


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
