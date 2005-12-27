From: "Randy.Dunlap" <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH 1/1] make acpi_path_name() global (v4)
Date: Mon, 26 Dec 2005 19:45:48 -0800
Message-ID: <20051226194548.4a5cc0df.rdunlap@xenotime.net>
References: <20051221120500.0621a7a2.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20051221120500.0621a7a2.randy_d_dunlap-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Randy Dunlap <randy_d_dunlap-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, pcihpd-discuss-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, kristen.c.accardi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi--

You can drop this patch.  With the changes wanted by everyone
(except for Pat Mochel), this just makes acpi_path_name() be
a synonym for acpi_get_name(), so I'll just use acpi_get_name()
directly.


On Wed, 21 Dec 2005 12:05:00 -0800 Randy Dunlap wrote:

> From: Randy Dunlap <randy_d_dunlap-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> 
> Make acpi_path_name() usable by everyone.
> I need this for adding SATA suspend/resume ACPI support.
> 
> v4: Fix enter/exit trace error noted by Matthew Wilcox.
> v3: use EXPORT_SYMBOL_GPL for acpi_path_name.
> v2: use ACPI-CA calling convention for name buffer.

---
~Randy


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
