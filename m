From: phutchis-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org
Subject: Re: Information regarding C3 cpu state and bus mastering
 activity
Date: Mon, 12 Dec 2005 18:08:00 -0800
Message-ID: <200512130208.jBD280VU003725@mail.wrs.com>
References: <da5cd1900512111210k626ff691x@mail.gmail.com>
 <439CC549.5060500@tzi.de> <da5cd1900512120122y217541a2h@mail.gmail.com>
 <439D726E.4020704@tzi.de> <da5cd1900512120810v75dd8721t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <da5cd1900512120810v75dd8721t-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: marco.calviani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> Maybe i'm completely out of target but what about, as said here by
> Nate Lawson http://lists.freebsd.org/pipermail/freebsd-acpi/2004-November/000835.html
> , to "power down the USB host controller when idle"?

Might be OK, provided the USB host controller *can* be powered down
*and* we won't need to wake up due to someone touching the USB mouse
or keyboard :)


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
