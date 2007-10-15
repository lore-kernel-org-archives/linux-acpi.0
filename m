From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: [PATCH] Untested proposal patch: Store video
	capabilities of BIOS globally at ACPI parse time and export it.
Date: Mon, 15 Oct 2007 17:52:46 +0100
Message-ID: <20071015165246.GB5021@srcf.ucam.org>
References: <1192466754.9847.594.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1192466754.9847.594.camel-X8wR35IVlAxolqkO4TVVkw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: linux-acpi <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ibm-acpi-devel <ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Oct 15, 2007 at 06:45:53PM +0200, Thomas Renninger wrote:
> +	if (ACPI_SUCCESS(acpi_get_handle(handle, "_BCM", &h_dummy1)) &&
> +	    ACPI_SUCCESS(acpi_get_handle(handle, "_BCL", &h_dummy2)) &&
> +	    ACPI_SUCCESS(acpi_get_handle(handle, "_BQC", &h_dummy3)))
> +		acpi_video_support |= ACPI_VIDEO_BRIGHTNESS;

Probably want to check for _BCQ as an alternative to _BQC as well.

> +	return 0;

Why return int if you always return 0? Other than that, it looks 
reasonable (and saves us having copy and pasted code in all of the 
hardware-specific drivers)

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
