From: Randy Dunlap <randy_d_dunlap-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 1/2] make acpi_path_name() global (v2)
Date: Mon, 19 Dec 2005 13:19:45 -0800
Message-ID: <20051219131945.3411aea8.randy_d_dunlap@linux.intel.com>
References: <20051219115435.13ea7bed.randy_d_dunlap@linux.intel.com>
	<20051219221925.GA20943@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20051219221925.GA20943-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Patrick Mochel <mochel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, pcihpd-discuss-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, kristen.c.accardi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 19 Dec 2005 14:19:25 -0800
Patrick Mochel <mochel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:

> On Mon, Dec 19, 2005 at 11:54:35AM -0800, Randy Dunlap wrote:
> > From: Randy Dunlap <randy_d_dunlap-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > 
> > Make acpi_path_name() usable by everyone.
> > I need this for adding SATA suspend/resume ACPI support.
> 
> I liked the first one better, and I think it was more appropriate, 
> given its users: 
> 
> It's a function that is used by code outside of drivers/acpi/, so it
> seems that it should use semantics that are common to the rest of the
> kernel, and not expose/require any internal data structures than what is 
> necessary (like struct acpi_buffer). 
> 
> It seems like that is the point of the ACPI OSL - to provide functions
> that are stylistically and semantically familiar to the rest OS for 
> which to interface with the ACPICA. In the case of Linux and this 
> function, that would be more like providing an interface that you did
> before - returning a char * that the caller has to free.
> 
> Note that Kristen made an argument that it's a burden on the caller,
> and a source for memory leak bugs. That's a valid concern, but there
> are many examples of similar interfaces (think strdup(3) or kstrdup()),
> and the effects can be mitigated by proper documentation. For the 
> kernel, one could potentially integrate a check for that type of bad
> programming into sparse.. Besides, making the caller understand 
> enough of the semantics of the ACPICA to initialize and tear down
> the acpi_buffer is arguably a much larger burden than knowing you 
> have to free the string returned..

Thanks for enumerating.

These are all things that I considered in making the first
patch and most of the reasons that I chose to make that patch
as my first choice.  I still consider it to be the more
appropriate patch than the second version.

---
~Randy


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
